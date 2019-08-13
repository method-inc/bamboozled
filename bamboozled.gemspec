# coding: utf-8
lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bamboozled/version"

Gem::Specification.new do |spec|
  spec.name          = "bamboozled"
  spec.version       = Bamboozled::VERSION
  spec.authors       = ["Mark Rickert"]
  spec.email         = ["mjar81@gmail.com"]
  spec.summary       = "A Ruby wrapper for the BambooHR API http://www.bamboohr.com/"
  spec.description   = "Bamboozled wraps the BambooHR API without the use of Rails dependencies."
  spec.homepage      = "http://github.com/Skookum/bamboozled"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.0"

  spec.add_development_dependency "bundler", ">= 1.10"
  spec.add_development_dependency "rake", "~> 10.4"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "webmock", "~> 1.20"

  spec.add_dependency "httparty", "~> 0.17"
  spec.add_dependency "json", "~> 2"
end
