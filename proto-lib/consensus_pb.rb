# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: consensus.proto

require 'google/protobuf'

require 'ledger_info_pb'
require 'transaction_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("consensus.proto", :syntax => :proto3) do
    add_message "network.ConsensusMsg" do
      oneof :message do
        optional :proposal, :message, 1, "network.Proposal"
        optional :vote, :message, 2, "network.Vote"
        optional :request_block, :message, 3, "network.RequestBlock"
        optional :respond_block, :message, 4, "network.RespondBlock"
        optional :timeout_msg, :message, 5, "network.TimeoutMsg"
        optional :sync_info, :message, 6, "network.SyncInfo"
      end
    end
    add_message "network.Proposal" do
      optional :proposed_block, :message, 1, "network.Block"
      optional :sync_info, :message, 2, "network.SyncInfo"
    end
    add_message "network.PacemakerTimeout" do
      optional :round, :uint64, 1
      optional :author, :bytes, 2
      optional :signature, :bytes, 3
      optional :vote, :message, 4, "network.Vote"
    end
    add_message "network.TimeoutMsg" do
      optional :sync_info, :message, 1, "network.SyncInfo"
      optional :pacemaker_timeout, :message, 2, "network.PacemakerTimeout"
      optional :signature, :bytes, 3
    end
    add_message "network.SyncInfo" do
      optional :highest_quorum_cert, :message, 1, "network.QuorumCert"
      optional :highest_ledger_info, :message, 2, "network.QuorumCert"
      optional :highest_timeout_cert, :message, 3, "network.PacemakerTimeoutCertificate"
    end
    add_message "network.PacemakerTimeoutCertificate" do
      optional :round, :uint64, 1
      repeated :timeouts, :message, 2, "network.PacemakerTimeout"
    end
    add_message "network.Block" do
      optional :id, :bytes, 1
      optional :parent_id, :bytes, 2
      optional :payload, :bytes, 3
      optional :round, :uint64, 4
      optional :height, :uint64, 5
      optional :timestamp_usecs, :uint64, 6
      optional :quorum_cert, :message, 7, "network.QuorumCert"
      optional :author, :bytes, 8
      optional :signature, :bytes, 9
    end
    add_message "network.QuorumCert" do
      optional :vote_data, :message, 1, "network.VoteData"
      optional :signed_ledger_info, :message, 2, "types.LedgerInfoWithSignatures"
    end
    add_message "network.VoteData" do
      optional :block_id, :bytes, 1
      optional :round, :uint64, 2
      optional :executed_state_id, :bytes, 3
      optional :version, :uint64, 4
      optional :parent_block_id, :bytes, 5
      optional :parent_block_round, :uint64, 6
      optional :grandparent_block_id, :bytes, 7
      optional :grandparent_block_round, :uint64, 8
    end
    add_message "network.Vote" do
      optional :vote_data, :message, 1, "network.VoteData"
      optional :author, :bytes, 2
      optional :ledger_info, :message, 3, "types.LedgerInfo"
      optional :signature, :bytes, 4
    end
    add_message "network.RequestBlock" do
      optional :block_id, :bytes, 1
      optional :num_blocks, :uint64, 2
    end
    add_message "network.RespondBlock" do
      optional :status, :enum, 1, "network.BlockRetrievalStatus"
      repeated :blocks, :message, 2, "network.Block"
    end
    add_enum "network.BlockRetrievalStatus" do
      value :SUCCEEDED, 0
      value :ID_NOT_FOUND, 1
      value :NOT_ENOUGH_BLOCKS, 2
    end
  end
end

module Network
  ConsensusMsg = Google::Protobuf::DescriptorPool.generated_pool.lookup("network.ConsensusMsg").msgclass
  Proposal = Google::Protobuf::DescriptorPool.generated_pool.lookup("network.Proposal").msgclass
  PacemakerTimeout = Google::Protobuf::DescriptorPool.generated_pool.lookup("network.PacemakerTimeout").msgclass
  TimeoutMsg = Google::Protobuf::DescriptorPool.generated_pool.lookup("network.TimeoutMsg").msgclass
  SyncInfo = Google::Protobuf::DescriptorPool.generated_pool.lookup("network.SyncInfo").msgclass
  PacemakerTimeoutCertificate = Google::Protobuf::DescriptorPool.generated_pool.lookup("network.PacemakerTimeoutCertificate").msgclass
  Block = Google::Protobuf::DescriptorPool.generated_pool.lookup("network.Block").msgclass
  QuorumCert = Google::Protobuf::DescriptorPool.generated_pool.lookup("network.QuorumCert").msgclass
  VoteData = Google::Protobuf::DescriptorPool.generated_pool.lookup("network.VoteData").msgclass
  Vote = Google::Protobuf::DescriptorPool.generated_pool.lookup("network.Vote").msgclass
  RequestBlock = Google::Protobuf::DescriptorPool.generated_pool.lookup("network.RequestBlock").msgclass
  RespondBlock = Google::Protobuf::DescriptorPool.generated_pool.lookup("network.RespondBlock").msgclass
  BlockRetrievalStatus = Google::Protobuf::DescriptorPool.generated_pool.lookup("network.BlockRetrievalStatus").enummodule
end
