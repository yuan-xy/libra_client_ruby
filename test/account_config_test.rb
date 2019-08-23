require "test_helper"

class AccountConfigTest < Minitest::Test
  def test_path
  	path = [1, 33, 125, 166, 198, 179, 225, 159, 24, 37, 207, 178, 103, 109, 174, 204, 227, 191, 61, 224, 60, 242, 102, 71, 199, 141, 240, 11, 55, 27, 37, 204, 151]
  	assert_equal LibraClient::AccountConfig::ACCOUNT_RESOURCE_PATH.bytes, path
  end
end
