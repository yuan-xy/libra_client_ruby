
module Libra
  class AccountState < Canoser::Struct
  	define_field :blob, {}
  end

  EVENT_KEY_LENGTH = 32

  class EventHandle < Canoser::Struct
    define_field :count, Canoser::Uint64
    define_field :key, [Canoser::Uint8] #EVENT_KEY_LENGTH
  end


  class AccountResource < Canoser::Struct
  	define_field :authentication_key, [Canoser::Uint8]
  	define_field :balance, Canoser::Uint64
    define_field :delegated_key_rotation_capability, Canoser::Bool
  	define_field :delegated_withdrawal_capability, Canoser::Bool
  	define_field :received_events, EventHandle
  	define_field :sent_events, EventHandle
  	define_field :sequence_number, Canoser::Uint64
  end
end
