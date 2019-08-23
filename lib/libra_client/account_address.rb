# A struct that represents an account address.
# Currently Public Key is used.

module LibraClient
  class AccountAddress
	ADDRESS_LENGTH = 32;

	SHORT_STRING_LENGTH = 4;

	LIBRA_NETWORK_ID_SHORT = "lb";

	attr_accessor :address

	def initialize(hex_literal)
		@address = [hex_literal].pack('H*')
  	end

	def self.hex_to_bytes(hex_literal)
		self.new(hex_literal).address
	end

	def self.from_public_key
		#TODO
	end

  end
end
