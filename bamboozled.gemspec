# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bamboozled/version'

Gem::Specification.new do |spec|
  spec.name          = "bamboozled"
  spec.version       = Bamboozled::VERSION
  spec.authors       = ["Mark Rickert"]
  spec.email         = ["mjar81@gmail.com"]
  spec.summary       = "A Ruby Wrapper for the BambooHR API http://www.bamboohr.com/"
  spec.description   = "Bamboozled wraps the BambooHR API without the use of Rails dependencies."
  spec.homepage      = "http://github.com/Skookum/bamboozled"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0'

  spec.add_runtime_dependency('httparty')
  spec.add_runtime_dependency('json')
end
