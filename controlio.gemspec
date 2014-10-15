# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'controlio/version'

Gem::Specification.new do |spec|
  spec.name          = "controlio"
  spec.version       = Controlio::VERSION
  spec.authors       = ["Yasyf Mohamedali"]
  spec.email         = ["yasyfm@gmail.com"]
  spec.summary       = "Control your computer through SMS! "
  spec.homepage      = "https://github.com/yasyf/controlio"
  spec.required_ruby_version = ">= 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency 'activesupport', '~> 4.1.6'
  spec.add_runtime_dependency 'daemons', '~> 1.1.9'
  spec.add_runtime_dependency 'rest_client', '~> 1.7.3'
end
