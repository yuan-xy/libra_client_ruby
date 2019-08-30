require "test_helper"

class AccessPathTest < Minitest::Test
  def test_path
  	address_hex = "000000000000000000000000000000000000000000000000000000000a550c18"
  	path = Libra::AccountConfig.account_sent_event_path
	access_path0 = Libra::AccessPath.new(address_hex, path).to_proto
	address = Libra::AccountAddress.hex_to_bytes(address_hex)
	access_path1 = Types::AccessPath.new(address: address, path: path)
	assert_equal access_path0.class, access_path1.class
	assert_equal access_path0.address, access_path1.address
  end
end
