# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cucumber/persona/version'

Gem::Specification.new do |spec|
  spec.name          = "cucumber-persona"
  spec.version       = Cucumber::Persona::VERSION
  spec.authors       = ["Jonathan Kirst"]
  spec.email         = ["jskirst@gmail.com"]

  spec.summary       = %q{Easily create data models for use in testing and development.}
  spec.description   = %q{Cucumber Persona makes BDD easier by allowing you to define Personas that match real life user data.}
  spec.homepage      = "https://github.com/starfighterheavy/cucumber-persona"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "cucumber", "~> 3.1"
  spec.add_development_dependency "rake", "~> 12.3"
end
