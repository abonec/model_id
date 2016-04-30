# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'model_id/version'

Gem::Specification.new do |spec|
  spec.name          = "model_id"
  spec.version       = ModelId::VERSION
  spec.authors       = ["abonec"]
  spec.email         = ["abonec@gmail.com"]
  spec.summary       = %q{gem add support for id instances of your model}
  spec.description   = %q{gem add support for id instances of your model and find instances across your model}
  spec.homepage      = "https://github.com/abonec/model_id"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 11.1"
  spec.add_development_dependency "rspec", '~>3.4'
end
