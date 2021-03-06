# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: validator_public_keys.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("validator_public_keys.proto", :syntax => :proto3) do
    add_message "types.ValidatorPublicKeys" do
      optional :account_address, :bytes, 1
      optional :consensus_public_key, :bytes, 2
      optional :network_signing_public_key, :bytes, 3
      optional :network_identity_public_key, :bytes, 4
    end
  end
end

module Types
  ValidatorPublicKeys = Google::Protobuf::DescriptorPool.generated_pool.lookup("types.ValidatorPublicKeys").msgclass
end
