# -*- encoding: utf-8 -*-
require File.expand_path('../lib/torrentz/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Albert Llop"]
  gem.email         = ["mrsimo@gmail.com"]
  gem.description   = %q{torrentz.eu ruby client to search and download torrentz & magnets}
  gem.summary       = %q{torrentz.eu ruby client to search and download torrentz & magnets}
  gem.homepage      = "https://github.com/mrsimo/ruby-torrentz"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "torrentz"
  gem.require_paths = ["lib"]
  gem.version       = Torrentz::VERSION

  gem.add_dependency "rack"
  gem.add_dependency "nokogiri"
  gem.add_dependency "addressable"

  gem.add_development_dependency "text"
  gem.add_development_dependency "typhoeus"
  gem.add_development_dependency "torrent-ruby"
end
