
module LibraClient
  class AccountConfig
	# LibraCoin
	COIN_MODULE_NAME = "LibraCoin";
	COIN_STRUCT_NAME = "T";

	# Account
	ACCOUNT_MODULE_NAME = "LibraAccount";
	ACCOUNT_STRUCT_NAME = "T";

	# Hash
	HASH_MODULE_NAME = "Hash";

	# /// Return the path to the Account resource. It can be used to create an AccessPath for an
	# /// Account resource.
	# pub fn account_resource_path() -> Vec<u8> {
	#     AccessPath::resource_access_vec(
	#         &StructTag {
	#             address: core_code_address(),
	#             module: ACCOUNT_MODULE_NAME.to_string(),
	#             name: ACCOUNT_STRUCT_NAME.to_string(),
	#             type_params: vec![],
	#         },
	#         &Accesses::empty(),
	#     )
	# }
  	ACCOUNT_RESOURCE_PATH = [1, 33, 125, 166, 198, 179, 225, 159, 24, 37, 207, 178, 103, 109, 174, 204, 227, 191, 61, 224, 60, 242, 102, 71, 199, 141, 240, 11, 55, 27, 37, 204, 151]

	#ACCOUNT_STATE_PATH = bytes.fromhex("01217da6c6b3e19f1825cfb2676daecce3bf3de03cf26647c78df00b371b25cc97")

	def self.account_sent_event_path
		path = ACCOUNT_RESOURCE_PATH + "/sent_events_count/".bytes
		path.pack('C*')
	end

	def self.account_received_event_path
		path = ACCOUNT_RESOURCE_PATH + "/received_events_count/".bytes
		path.pack('C*')
	end

	def self.association_address
		AccountAddress.new("000000000000000000000000000000000000000000000000000000000a550c18")
	end

  end
end
