# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: storage.proto for package 'storage'
# Original file comments:
# Copyright (c) The Libra Core Contributors
# SPDX-License-Identifier: Apache-2.0
#

require 'grpc'
require 'storage_pb'

module Storage
  module Storage
    # -----------------------------------------------------------------------------
    # ---------------- Service definition for storage
    # -----------------------------------------------------------------------------
    class Service

      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'storage.Storage'

      # Persist transactions. Called by Execution when either syncing nodes or
      # committing blocks during normal operation.
      rpc :SaveTransactions, SaveTransactionsRequest, SaveTransactionsResponse
      # Read APIs.
      #
      # Used to get a piece of data and return the proof of it. If the client
      # knows and trusts a ledger info at version v, it should pass v in as the
      # client_known_version and we will return the latest ledger info together
      # with the proof that it derives from v.
      rpc :UpdateToLatestLedger, Types::UpdateToLatestLedgerRequest, Types::UpdateToLatestLedgerResponse
      # When we receive a request from a peer validator asking a list of
      # transactions for state synchronization, this API can be used to serve the
      # request. Note that the peer should specify a ledger version and all proofs
      # in the response will be relative to this given ledger version.
      rpc :GetTransactions, GetTransactionsRequest, GetTransactionsResponse
      rpc :GetAccountStateWithProofByVersion, GetAccountStateWithProofByVersionRequest, GetAccountStateWithProofByVersionResponse
      # Returns information needed for libra core to start up.
      rpc :GetStartupInfo, GetStartupInfoRequest, GetStartupInfoResponse
    end

    Stub = Service.rpc_stub_class
  end
  # Write APIs.
end