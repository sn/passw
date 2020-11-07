Gem::Specification.new do |s|
  s.name        = 'passw'
  s.version     = '1.0.2'
  s.date        = '2020-07-11'
  s.summary     = 'Passw is a simple, customizable password generator for Ruby'
  s.description = 'Passw is a simple, customizable password generator for Ruby that allows you to generate secure passwords easily'
  s.authors     = ['Sean Nieuwoudt']
  s.email       = 'sean@isean.co.za'
  s.files       = ['lib/passw.rb']
  s.license     = 'GPL-3.0'
  s.homepage    = 'https://github.com/sn/passw'
  s.executables << 'passw'

  s.add_development_dependency 'minitest', '~> 5.7', '>= 5.7.0'
  s.add_development_dependency 'rake', '~> 13.0'
end
