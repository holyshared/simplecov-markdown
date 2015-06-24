# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simplecov-markdown/version'

Gem::Specification.new do |spec|
  spec.name          = "simplecov-markdown"
  spec.version       = SimpleCov::Formatter::MarkdownFormatter::VERSION
  spec.authors       = ["Noritaka Horio"]
  spec.email         = ["holy.shared.design@gmail.com"]
  spec.summary       = "Markdown formatter for simplecov"
  spec.description   = "Markdown formatter for simplecov"
  spec.homepage      = "https://github.com/holyshared/simplecov-markdown"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'simplecov'

  spec.add_development_dependency "rspec-temp_dir", "~> 0.0.3"
  spec.add_development_dependency "bundler", "~> 1.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "simplecov-console"
end
