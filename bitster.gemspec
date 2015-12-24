# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bitster/version'

Gem::Specification.new do |spec|
  spec.name          = "bitster"
  spec.version       = Bitster::VERSION
  spec.authors       = ["J.K.Valk"]
  spec.email         = ["jkvalk@mail.ru"]

  spec.summary       = %q{Experimental/educational cryptography/math library.}
  spec.description   = "Experimental/educational cryptography/math library."
  spec.homepage      = "https://github.com/jkvalk/bitster"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.license = "MIT"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  #spec.add_development_dependency "coveralls"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "awesome_print"


  spec.add_dependency "json"

end
