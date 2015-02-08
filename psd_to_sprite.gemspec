# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'psd_to_sprite/version'

Gem::Specification.new do |spec|
  spec.name          = "psd_to_sprite"
  spec.version       = PsdToSprite::VERSION
  spec.authors       = ["Carl Furrow"]
  spec.email         = ["carl.furrow@gmail.com"]
  spec.summary       = %q{Convert a PSD with layers to a single sprite sheet for animations}
  spec.description   = %q{Take a psd with layers, one for each frame, and output to a single png file with each frame placed next to the other in order of the layers in the psd.}
  spec.homepage      = "http://github.com/cfurrow/psd_to_sprite"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]


  spec.add_dependency "rmagick", "~> 2.13"
  spec.add_dependency "psd", "~> 3.2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
