require "test_helper"

class MnemonicTest < Minitest::Test
  def test_mnemonic
  	data = "7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f"
  	mnemonic = Libra::Mnemonic.to_mnemonic(data)
  	#assert_equal mnemonic, "legal winner thank year wave sausage worth useful legal winner thank year wave sausage worth useful legal will"
   	#assert_equal Libra::Mnemonic.recover(mnemonic), data
  end


  
end
