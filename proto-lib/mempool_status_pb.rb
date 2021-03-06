# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: mempool_status.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("mempool_status.proto", :syntax => :proto3) do
    add_message "mempool.MempoolAddTransactionStatus" do
      optional :code, :enum, 1, "mempool.MempoolAddTransactionStatusCode"
      optional :message, :string, 2
    end
    add_enum "mempool.MempoolAddTransactionStatusCode" do
      value :Valid, 0
      value :InsufficientBalance, 1
      value :InvalidSeqNumber, 2
      value :MempoolIsFull, 3
      value :TooManyTransactions, 4
      value :InvalidUpdate, 5
    end
  end
end

module Mempool
  MempoolAddTransactionStatus = Google::Protobuf::DescriptorPool.generated_pool.lookup("mempool.MempoolAddTransactionStatus").msgclass
  MempoolAddTransactionStatusCode = Google::Protobuf::DescriptorPool.generated_pool.lookup("mempool.MempoolAddTransactionStatusCode").enummodule
end
