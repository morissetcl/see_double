# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
# Maintain your gem's version:
require "see_double/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "see_double"
  s.version     = SeeDouble::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Clement Morisset"]
  s.email       = ["morissetcl87@gmail.com"]
  s.summary     = "Monitor your Rspec test occurence."
  s.homepage    = "https://github.com/morissetcl/see_double"

  s.description = "A small tool CLI, for Rspec lover, to monitoring your FEATURE specs and check your duplication.
  SeeDouble go through all your specs and count the number of occurence of your 'expect'
   and 'result'."
  s.license     = "MIT"
  s.executables << "see_double"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.add_dependency "rails", ">= 5.1.4"
  s.add_development_dependency "rspec", "~> 3.2"
  s.add_dependency 'colorize', '~> 0.8.1'
  s.add_development_dependency "sqlite3"
end
