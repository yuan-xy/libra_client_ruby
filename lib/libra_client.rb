protolib = File.expand_path(File.dirname(__FILE__) + '/../proto-lib')
$LOAD_PATH.unshift(protolib) if File.directory?(protolib) && !$LOAD_PATH.include?(protolib)

require 'grpc'
require 'admission_control_services_pb'

LIBRA_TESTNET_HOST = "ac.testnet.libra.org:8000"
FAUCET_HOST = "http://faucet.testnet.libra.org"
#ACCOUNT_STATE_PATH = bytes.fromhex("01217da6c6b3e19f1825cfb2676daecce3bf3de03cf26647c78df00b371b25cc97")

ACCOUNT_RESOURCE_PATH = [1, 33, 125, 166, 198, 179, 225, 159, 24, 37, 207, 178, 103, 109, 174, 204, 227, 191, 61, 224, 60, 242, 102, 71, 199, 141, 240, 11, 55, 27, 37, 204, 151]
ACCOUNT_SENT_EVENT_PATH = [1, 33, 125, 166, 198, 179, 225, 159, 24, 37, 207, 178, 103, 109, 174, 204, 227, 191, 61, 224, 60, 242, 102, 71, 199, 141, 240, 11, 55, 27, 37, 204, 151, 47, 115, 101, 110, 116, 95, 101, 118, 101, 110, 116, 115, 95, 99, 111, 117, 110, 116, 47]
ASSOCIATION_ADDRESS = "000000000000000000000000000000000000000000000000000000000a550c18"


module LibraClient

def self.get_latest_transaction_version
	stub = AdmissionControl::AdmissionControl::Stub.new("ac.testnet.libra.org:8000",:this_channel_is_insecure)
	resp = stub.update_to_latest_ledger(Types::UpdateToLatestLedgerRequest.new())
	resp.ledger_info_with_sigs.ledger_info.version
end

def self.get_latest_transaction
	stub = AdmissionControl::AdmissionControl::Stub.new("ac.testnet.libra.org:8000",:this_channel_is_insecure)
	resp = stub.update_to_latest_ledger(Types::UpdateToLatestLedgerRequest.new())
	resp.ledger_info_with_sigs
end

def self.update_to_latest_ledger(requested_items)
	request = Types::UpdateToLatestLedgerRequest.new(client_known_version: 3747, requested_items: requested_items)
	stub = AdmissionControl::AdmissionControl::Stub.new("ac.testnet.libra.org:8000",:this_channel_is_insecure)
	response = stub.update_to_latest_ledger(request)
	# [:response_items, :ledger_info_with_sigs, :validator_change_events]
	response
end

def self.get_account_state(address)
	address = [address].pack('H*')
	query = Types::GetAccountStateRequest.new(address: address)
	item = Types::RequestItem.new(get_account_state_request: query)
	resp = update_to_latest_ledger([item])
	state = resp.response_items[0].get_account_state_response.account_state_with_proof
	state
end

def self.get_transactions(start_version, limit=1, fetch_events=false)
	query = Types::GetTransactionsRequest.new(start_version: start_version, limit: limit, fetch_events: fetch_events)
	item = Types::RequestItem.new(get_transactions_request: query)
	resp = update_to_latest_ledger([item])
	txn_list_with_proof = resp.response_items[0].get_transactions_response.txn_list_with_proof
	#[:transactions, :infos, :events_for_versions, :first_transaction_version, :proof_of_first_transaction, :proof_of_last_transaction]
	txn_list_with_proof.transactions
end

def self.get_transaction(start_version)
	#Types::SignedTransaction [:raw_txn_bytes, :sender_public_key, :sender_signature]
	get_transactions(start_version)[0]
end

def self.get_account_transaction(address, sequence_number, fetch_events=true)
	address = [address].pack('H*')
	query = Types::GetAccountTransactionBySequenceNumberRequest.new(account: address, sequence_number: sequence_number, fetch_events: fetch_events)
	item = Types::RequestItem.new(get_account_transaction_by_sequence_number_request: query)
	resp = update_to_latest_ledger([item])
	transaction = resp.response_items[0].get_account_transaction_by_sequence_number_response.signed_transaction_with_proof
	#Types::SignedTransactionWithProof [:version, :signed_transaction, :proof, :events]
	transaction
end

def self.get_events(address, start_sequence_number, ascending=true, limit=1)
	address = [address].pack('H*')
	path = ACCOUNT_SENT_EVENT_PATH.map{|x| x.chr}.join("")
	access_path = Types::AccessPath.new(address: address, path: path)
	query = Types::GetEventsByEventAccessPathRequest.new(access_path: access_path, start_event_seq_num: start_sequence_number, ascending: ascending, limit: limit)
	item = Types::RequestItem.new(get_events_by_event_access_path_request: query)
	resp = update_to_latest_ledger([item])
	resp.response_items[0].get_events_by_event_access_path_response.events_with_proof
end


end
