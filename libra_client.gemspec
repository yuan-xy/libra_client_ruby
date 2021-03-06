
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "libra/version"

Gem::Specification.new do |spec|
  spec.name          = "libra_client"
  spec.version       = Libra::VERSION
  spec.authors       = ["yuan xinyu"]
  spec.email         = ["yuanxinyu.hangzhou@gmail.com"]

  spec.summary       = %q{A ruby client for Libra network.}
  spec.description   = %q{A ruby client for Libra network.}
  spec.homepage      = "https://github.com/yuan-xy/libra_client_ruby.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/yuan-xy/libra_client_ruby.git"
    spec.metadata["changelog_uri"] = "https://github.com/yuan-xy/libra_client_ruby.git"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "byebug", "~> 11.0"
  spec.add_development_dependency "grpc-tools", "~> 1.23"

  spec.add_dependency "grpc", "~> 1.23"
  spec.add_dependency "canoser", "~> 0.2.1"
  spec.add_dependency "rest-client", "~> 2.0"
  #spec.add_dependency "openssl", "~> 3.0.0" #not ready, need SHA3 support.

end
