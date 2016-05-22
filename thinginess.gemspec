# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'thinginess/version'

Gem::Specification.new do |s|
  s.name        = 'thinginess'
  s.version     = Thinginess::VERSION
  s.authors     = ['Patrick Gleeson']
  s.email       = ['hello@patrickgleeson.com']
  s.homepage    = 'https://github.com/boffinism/thinginess'
  s.summary     = 'A global thing register and manipulator methods'
  s.description = 'Thinginess lets you traverse and alter hierarchies of things easily'
  s.license     = 'GNU GPL v3'

  s.rubyforge_project = 'thinginess'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_development_dependency 'rspec', '~> 3.0', '>= 3.0.0'
end