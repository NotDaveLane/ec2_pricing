# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ec2_pricing/version'

Gem::Specification.new do |spec|
  spec.name          = "ec2_pricing"
  spec.version       = Ec2Pricing::VERSION
  spec.authors       = ["Dave Lane"]
  spec.email         = ["dclane@gmail.com"]
  spec.summary       = "Provides pricing information for Amazon EC2 instances."
  spec.description   = "Retrieves up-to-date pricing information for all types of Amazon EC2 instances."
  spec.homepage      = "https://github.com/NotDaveLane/ec2_pricing"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
