Gem::Specification.new do |s|
  s.name        = 'passw'
  s.version     = '0.0.1'
  s.date        = '2019-04-06'
  s.summary     = 'Passw is a simple, customizable password generator for Ruby'
  s.description = 'Passw is a simple, customizable password generator for Ruby that allows you to generate secure passwords easily'
  s.authors     = ['Sean Nieuwoudt']
  s.email       = 'sean@isean.co.za'
  s.files       = ['lib/passw.rb']
  s.license     = 'GPL-3.0'
  s.homepage    = 'https://github.com/SeanNieuwoudt/passw'
  s.executables << 'passw'

  s.add_development_dependency 'minitest', '~> 5.7', '>= 5.7.0'
  s.add_development_dependency 'rake', '~> 10.4', '>= 10.4.2'
end
