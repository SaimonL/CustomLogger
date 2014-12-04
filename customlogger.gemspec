# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'customlogger/version'

Gem::Specification.new do |spec|
  spec.name          = 'customlogger'
  spec.version       = Customlogger::VERSION
  spec.authors       = ['Saimon Lovell']
  spec.email         = ['staysynchronize@gmail.com']
  spec.summary       = %q{Log output in to a seperate html file.}
  spec.description   = %q{Have you ever wished that you could debug an output to a html nicely colored page? Now you can log all you need in to a nice html format colored page.
                          For more information please visit: https://github.com/SaimonL/CustomLogger}
  spec.homepage      = 'https://github.com/SaimonL/CustomLogger'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 1.6'
  spec.add_development_dependency 'rake', '>= 10.0'
  spec.add_development_dependency 'rspec', '>= 3.0'
end
