# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: mempool.proto

require 'google/protobuf'

require 'transaction_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("mempool.proto", :syntax => :proto3) do
    add_message "network.MempoolSyncMsg" do
      optional :peer_id, :bytes, 1
      repeated :transactions, :message, 2, "types.SignedTransaction"
    end
  end
end

module Network
  MempoolSyncMsg = Google::Protobuf::DescriptorPool.generated_pool.lookup("network.MempoolSyncMsg").msgclass
end