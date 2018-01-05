# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fetcher_dsl/version'

Gem::Specification.new do |spec|
  spec.name          = "fetcher_dsl"
  spec.version       = FetcherDsl::VERSION
  spec.authors       = ["Jiri Kubicek"]
  spec.email         = ["jiri@kubicek.cz"]

  spec.summary       = %q{DSL for defining simple data fetchers}
  spec.description   = %q{Define new data fetchers with simple DSL and results publishing to redis}
  spec.homepage      = "https://github.com/cryptoclock/fetcher_dsl"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_runtime_dependency "redis"
end
