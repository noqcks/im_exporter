# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'im_porter/version'

Gem::Specification.new do |spec|
  spec.name          = "im_porter"
  spec.version       = IM_Porter::VERSION
  spec.authors       = ["Ben Visser"]
  spec.email         = ["theodore.r.visser@gmail.com"]
  spec.summary       = %q{iMessage Exporter}
  spec.description   = %q{Export iMessage conversations into TXT or PDF files}
  spec.homepage      = "https://github.com/noqcks/im_porter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["im_porter"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'commander', '~> 4.3', '>= 4.3.3'
  spec.add_runtime_dependency 'sqlite3', '~> 1.3.10', '>= 1.3.10'
  spec.add_runtime_dependency 'prawn', '~> 2.0.1', '>= 2.0.1'
  spec.add_runtime_dependency 'etc', '~> 0.2.0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
