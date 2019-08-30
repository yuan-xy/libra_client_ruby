# A struct that represents an account address.
# Currently Public Key is used.

module Libra
  class AccountAddress
	ADDRESS_LENGTH = 32;

	SHORT_STRING_LENGTH = 4;

	LIBRA_NETWORK_ID_SHORT = "lb";

	attr_accessor :addr
	attr_accessor :hex

	def initialize(hex_literal)
		@hex = hex_literal
		@addr = [hex_literal].pack('H*')
  	end

	def self.hex_to_bytes(hex_literal)
		[hex_literal].pack('H*')
	end

	def self.from_public_key
		#TODO
	end

  end
end
