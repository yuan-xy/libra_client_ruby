protolib = File.expand_path(File.dirname(__FILE__) + '/../proto-lib')
$LOAD_PATH.unshift(protolib) if File.directory?(protolib) && !$LOAD_PATH.include?(protolib)

require 'grpc'
require 'admission_control_services_pb'
require 'canoser'
require 'rest_client'

require "libra/version"
require 'libra/account_address'
require 'libra/account_config'
require 'libra/access_path'
require 'libra/account_resource'
require 'libra/mnemonic'


module Libra
  class LibraError < StandardError; end

  module  BinaryExtensions
    # bin-to-hex
    def bin2hex; unpack("H*")[0]; end
    # hex-to-bin
    def hex2bin; [self].pack("H*"); end
  end

  class ::String
    include Libra::BinaryExtensions
  end

  NETWORKS = {
	testnet:{
		host: "ac.testnet.libra.org:8000",
		faucet_host: "faucet.testnet.libra.org"
	}
  }


  class Client

  	def initialize(network="testnet")
  		raise LibraError.new("only support testnet now.") unless network.to_s == "testnet"
  		@host = NETWORKS[network.to_sym][:host]
  		@faucet_host = NETWORKS[network.to_sym][:faucet_host]
  	end

    def get_latest_transaction_version
      stub = AdmissionControl::AdmissionControl::Stub.new(@host,:this_channel_is_insecure)
      resp = stub.update_to_latest_ledger(Types::UpdateToLatestLedgerRequest.new())
      resp.ledger_info_with_sigs.ledger_info.version
    end

    def update_to_latest_ledger(requested_items)
      request = Types::UpdateToLatestLedgerRequest.new(client_known_version: 0, requested_items: requested_items)
      stub = AdmissionControl::AdmissionControl::Stub.new(@host,:this_channel_is_insecure)
      response = stub.update_to_latest_ledger(request)
      # [:response_items, :ledger_info_with_sigs, :validator_change_events]
      response
    end

    def get_sequence_number(address)
      state = get_account_state(address)
      state.sequence_number
    end

    def get_balance(address)
      state = get_account_state(address)
      state.balance
    end

    def get_account_state(address)
      query = Types::GetAccountStateRequest.new(address: AccountAddress.hex_to_bytes(address))
      item = Types::RequestItem.new(get_account_state_request: query)
      resp = update_to_latest_ledger([item])
      state = resp.response_items[0].get_account_state_response.account_state_with_proof
      map = Libra::AccountState.deserialize(state.blob.blob).blob
      resource = map[AccountConfig::ACCOUNT_RESOURCE_PATH]
      Libra::AccountResource.deserialize(resource.pack('C*'))
    end

    def get_transactions(start_version, limit=1, fetch_events=false)
      query = Types::GetTransactionsRequest.new(start_version: start_version, limit: limit, fetch_events: fetch_events)
      item = Types::RequestItem.new(get_transactions_request: query)
      resp = update_to_latest_ledger([item])
      txn_list_with_proof = resp.response_items[0].get_transactions_response.txn_list_with_proof
      #[:transactions, :infos, :events_for_versions, :first_transaction_version, :proof_of_first_transaction, :proof_of_last_transaction]
      txn_list_with_proof.transactions
    end

    def get_transaction(start_version)
      #Types::SignedTransaction [:raw_txn_bytes, :sender_public_key, :sender_signature]
      get_transactions(start_version)[0]
    end

    def get_account_transaction(address, sequence_number, fetch_events=true)
      addr = AccountAddress.hex_to_bytes(address)
      query = Types::GetAccountTransactionBySequenceNumberRequest.new(account: addr, sequence_number: sequence_number, fetch_events: fetch_events)
      item = Types::RequestItem.new(get_account_transaction_by_sequence_number_request: query)
      resp = update_to_latest_ledger([item])
      transaction = resp.response_items[0].get_account_transaction_by_sequence_number_response.signed_transaction_with_proof
      #Types::SignedTransactionWithProof [:version, :signed_transaction, :proof, :events]
      transaction
    end

    # Returns events specified by `access_path` with sequence number in range designated by
    # `start_seq_num`, `ascending` and `limit`. If ascending is true this query will return up to
    # `limit` events that were emitted after `start_event_seq_num`. Otherwise it will return up to
    # `limit` events in the reverse order. Both cases are inclusive.
    def get_events(address_hex, path, start_sequence_number, ascending=true, limit=1)
      access_path = AccessPath.new(address_hex, path).to_proto
      query = Types::GetEventsByEventAccessPathRequest.new(access_path: access_path, start_event_seq_num: start_sequence_number, ascending: ascending, limit: limit)
      item = Types::RequestItem.new(get_events_by_event_access_path_request: query)
      resp = update_to_latest_ledger([item])
      resp.response_items[0].get_events_by_event_access_path_response.events_with_proof
    end

    def get_events_sent(address_hex, start_sequence_number, ascending=true, limit=1)
      path = AccountConfig.account_sent_event_path
      get_events(address_hex, path, start_sequence_number, ascending, limit)
    end

    def get_events_received(address_hex, start_sequence_number, ascending=true, limit=1)
      path = AccountConfig.account_received_event_path
      get_events(address_hex, path, start_sequence_number, ascending, limit)
    end

    def get_latest_events_sent(address_hex, limit=1)
      get_events_sent(address_hex, 2**64-1, false, limit)
    end

    def get_latest_events_received(address_hex, limit=1)
      get_events_received(address_hex, 2**64-1, false, limit)
    end

    def mint_coins_with_local_faucet_account
    end

    def mint_coins_with_faucet_service(receiver, num_coins, is_blocking)
      resp = RestClient.post "http://#{@faucet_host}?amount=#{num_coins}&address=#{receiver}", {}
      if resp.code != 200
        raise LibraError.new("Failed to query remote faucet server[status=#{resp.code}]: #{resp.body}")
      end
      sequence_number = resp.body.to_i
      if is_blocking
        puts AccountConfig.association_address.hex
        self.wait_for_transaction(AccountConfig.association_address.hex, sequence_number);
      end
    end

    def wait_for_transaction(account, sequence_number)
      max_iterations = 500
      puts("waiting ")
      while (max_iterations > 0 )do
        $stdout.flush
        max_iterations -= 1;
        transaction = get_account_transaction(account, sequence_number - 1, true)
        if transaction && transaction.events
          puts "transaction is stored!"
          if transaction.events.events.size == 0
            puts "no events emitted"
          end
          return
        else
          print(".")
          sleep(0.01)
        end
      end
      puts "wait_for_transaction timeout"
    end

  end

end
