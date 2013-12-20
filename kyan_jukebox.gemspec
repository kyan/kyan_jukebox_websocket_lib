# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kyan_jukebox/version'

Gem::Specification.new do |spec|
  spec.name          = "kyan_jukebox"
  spec.version       = KyanJukebox::VERSION
  spec.authors       = ["Duncan Robertson"]
  spec.email         = ["duncan@kyan.com"]
  spec.description   = %q{A library for the Kyan jukebox websocket API}
  spec.summary       = %q{Kyan jukebox websocket API}
  spec.homepage      = "http://jukebox.local"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
end
