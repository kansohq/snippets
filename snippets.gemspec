$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'snippets/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'snippets'
  s.version     = Snippets::VERSION
  s.authors     = ['Kanso']
  s.email       = ['team@kanso.io']
  s.homepage    = 'http://kanso.io'
  s.summary     = 'A locale management Rails engine'
  s.description = 'A Rails engine for managing locales from the DB'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'draper', '~> 1.3.0'
  s.add_dependency 'haml-rails', '~> 0.5.0'
  s.add_dependency 'kaminari', '~> 0.16.0'
  s.add_dependency 'rails', '~> 4.1.0'
  s.add_dependency 'redis', '>= 3.0.0'
  s.add_dependency 'simple_form', '~> 3.1.0.rc'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails', '~> 3.0.0'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'machinist'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'simplecov'
end
