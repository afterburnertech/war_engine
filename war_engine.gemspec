$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "war_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "war_engine"
  s.version     = WarEngine::VERSION
  s.authors     = "Brandon Campbell"
  s.email       = ["brandon@afterburnertechnologies.com"]
  s.homepage    = "www.afterburnerinsight.com"
  s.summary     = "TODO: Summary of WarEngine."
  s.description = "TODO: Description of WarEngine."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_development_dependency 'rspec-rails', '2.14.0'
  s.add_development_dependency 'capybara', '2.1.0'
  s.add_development_dependency 'bundler', '1.3.5'  

  s.add_development_dependency "sqlite3"
end
