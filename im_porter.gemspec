# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'im_exporter/version'

Gem::Specification.new do |spec|
  spec.name          = 'im_exporter'
  spec.version       = IMExporter::VERSION
  spec.authors       = ['Ben Visser']
  spec.email         = 'theodore.r.visser@gmail.com'
  spec.summary       = 'iMessage Exporter'
  spec.description   = 'Export iMessage conversations into TXT or PDF files'
  spec.homepage      = 'https://github.com/noqcks/im_exporter'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'commander', '~> 4.3', '>= 4.3.3'
  spec.add_runtime_dependency 'sqlite3', '~> 1.3.10', '>= 1.3.10'
  spec.add_runtime_dependency 'prawn', '~> 2.0.1', '>= 2.0.1'
  spec.add_runtime_dependency 'etc', '~> 0.2.0',  '>= 0.2.0'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'flog'
  spec.add_development_dependency 'flay'
  spec.add_development_dependency 'roodi'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'inch'
end
