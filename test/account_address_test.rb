require "test_helper"

class AccountAddressTest < Minitest::Test
  def test_transform
  	association_address = "000000000000000000000000000000000000000000000000000000000a550c18"
    ad = LibraClient::AccountAddress.new(association_address)
    assert_equal ad.addr.size, LibraClient::AccountAddress::ADDRESS_LENGTH
    bytes = "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\nU\f\x18"
    assert_equal ad.addr, bytes
    assert_equal bytes, LibraClient::AccountAddress.hex_to_bytes(association_address)
  end
end
