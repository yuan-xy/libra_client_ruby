require "test_helper"

class AccountConfigTest < Minitest::Test
  def test_path
  	path = [1, 33, 125, 166, 198, 179, 225, 159, 24, 37, 207, 178, 103, 109, 174, 204, 227, 191, 61, 224, 60, 242, 102, 71, 199, 141, 240, 11, 55, 27, 37, 204, 151, 47, 115, 101, 110, 116, 95, 101, 118, 101, 110, 116, 115, 95, 99, 111, 117, 110, 116, 47]
  	assert_equal Libra::AccountConfig.account_sent_event_path.unpack("C*"), path
  end
end
