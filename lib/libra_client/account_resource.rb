
module LibraClient
  class AccountState < Canoser::Struct
  	define_field :blob, {} 
  end

# pub struct AccountResource {
#     balance: u64,
#     sequence_number: u64,
#     authentication_key: ByteArray,
#     delegated_withdrawal_capability: bool,
#     sent_events: EventHandle,
#     received_events: EventHandle,
# }

# impl CanonicalSerialize for AccountResource {
#     fn serialize(&self, serializer: &mut impl CanonicalSerializer) -> Result<()> {
#         // TODO(drussi): the order in which these fields are serialized depends on some
#         // implementation details in the VM.
#         serializer
#             .encode_struct(&self.authentication_key)?
#             .encode_u64(self.balance)?
#             .encode_bool(self.delegated_withdrawal_capability)?
#             .encode_struct(&self.received_events)?
#             .encode_struct(&self.sent_events)?
#             .encode_u64(self.sequence_number)?;
#         Ok(())
#     }
# }  
  class AccountResource < Canoser::Struct
  	define_field :authentication_key, [Canoser::Uint8]
  	define_field :balance, Canoser::Uint64
  	define_field :delegated_withdrawal_capability, Canoser::Bool
  	define_field :received_events_count, Canoser::Uint64
  	define_field :sent_events_count, Canoser::Uint64
  	define_field :sequence_number, Canoser::Uint64
  end  
end
