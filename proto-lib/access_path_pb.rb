# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: access_path.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("access_path.proto", :syntax => :proto3) do
    add_message "types.AccessPath" do
      optional :address, :bytes, 1
      optional :path, :bytes, 2
    end
  end
end

module Types
  AccessPath = Google::Protobuf::DescriptorPool.generated_pool.lookup("types.AccessPath").msgclass
end
