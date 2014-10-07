# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'transit/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "transit-rails"
  spec.version       = Transit::Rails::VERSION
  spec.authors       = ["Joshua Davey"]
  spec.email         = ["josh@joshuadavey.com"]
  spec.summary       = %q{Transit format helpers for Rails}
  spec.description   = %q{Transit format helpers for Rails. See Cognitect's transit-format for more info.}
  spec.homepage      = "https://github.com/jgdavey/transit-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "transit-ruby", "~> 0.8", ">= 0.8.467"

  spec.add_development_dependency "bundler", "~> 1.6"
end
