require "test_helper"

class AccountAddressTest < Minitest::Test
  def test_transform
  	association_address = "000000000000000000000000000000000000000000000000000000000a550c18"
    ad = Libra::AccountAddress.new(association_address)
    assert_equal ad.addr.size, Libra::AccountAddress::ADDRESS_LENGTH
    bytes = "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\nU\f\x18"
    assert_equal ad.addr, bytes
    assert_equal bytes, Libra::AccountAddress.hex_to_bytes(association_address)
  end
end
