lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sign/version'

Gem::Specification.new do |spec|
  spec.name          = 'sign'
  spec.version       = Sign::VERSION
  spec.authors       = ['miraks']
  spec.email         = ['a@vldkn.net']
  spec.summary       = %q{Optional type signatures for ruby methods}
  spec.description   = %q{Gives you ability to specify type signature of ruby method}
  spec.homepage      = 'https://github.com/miraks/sign'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0.0.beta2'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'coveralls'
end
