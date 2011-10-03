$:.push File.expand_path("../lib", __FILE__)
require "rbrc/version"

Gem::Specification.new do |s|
  s.name        = "rbrc"
  s.version     = Rbrc::VERSION
  s.authors     = ["Mike Bannister"]
  s.email       = ["mikebannister@gmail.com"]
  s.homepage    = "https://github.com/mikebannister/rbrc"
  s.summary     = "App config helpers for ruby apps."
  s.description = "App config helpers for ruby apps."

  s.files = Dir["lib/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "parseconfig", "~> 0.5.2"
  s.add_dependency "activesupport", "~> 3.1.0"
  s.add_dependency "i18n", "~> 0.6.0"

  s.add_development_dependency "rspec", "~> 2.6.0"
  s.add_development_dependency "guard-rspec", "~> 0.4.5"
  s.add_development_dependency "fakefs", "~> 0.4.0"
  s.add_development_dependency "mocha", "~> 0.10.0"
end
