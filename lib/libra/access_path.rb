# Suppose we have the following data structure in a smart contract:
#
# struct B {
#   Map<String, String> mymap;
# }
#
# struct A {
#   B b;
#   int my_int;
# }
#
# struct C {
#   List<int> mylist;
# }
#
# A a;
# C c;
#
# and the data belongs to Alice. Then an access to `a.b.mymap` would be translated to an access
# to an entry in key-value store whose key is `<Alice>/a/b/mymap`. In the same way, the access to
# `c.mylist` would need to query `<Alice>/c/mylist`.
#
# So an account stores its data in a directory structure, for example:
#   <Alice>/balance:   10
#   <Alice>/a/b/mymap: {"Bob" => "abcd", "Carol" => "efgh"}
#   <Alice>/a/myint:   20
#   <Alice>/c/mylist:  [3, 5, 7, 9]
#
# If someone needs to query the map above and find out what value associated with "Bob" is,
# `address` will be set to Alice and `path` will be set to "/a/b/mymap/Bob".
#
# On the other hand, if you want to query only <Alice>/a/*, `address` will be set to Alice and
# `path` will be set to "/a" and use the `get_prefix()` method from statedb


module Libra
  class AccessPath
	attr_accessor :address
	attr_accessor :path

	def initialize(address_hex, path)
		@address = AccountAddress.new(address_hex)
		@path = path
	end

	def to_proto
		Types::AccessPath.new(address: address.addr, path: path)
	end

  end
end
