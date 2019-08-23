# LibraClient

LibraClient is an unofficial client for [Libra blockchain](http://libra.org). The library allows Ruby program to interact with Libra nodes with [protobuf](https://developers.google.com/protocol-buffers/) message through [grpc](https://grpc.io/). 


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'libra_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install libra_client

## Usage


```ruby
require 'libra_client'
LibraClient.get_transaction(0) #get the genesis transaction
LibraClient.get_transaction(1) #get the first transaction
version = LibraClient.get_latest_transaction_version
LibraClient.get_transaction(version) #get the latest transaction

LibraClient.get_account_state(ASSOCIATION_ADDRESS)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yuanxinyu/libra_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
