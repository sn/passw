Gem::Specification.new do |s|
  s.name        = 'passw'
  s.version     = '1.0.3'
  s.date        = '2024-02-11'

  s.summary     = 'Customizable Ruby library for secure password generation with character and strength options.'
  s.description = 'Passw is a Ruby library for generating secure passwords, supporting length, character types, exclusions, and entropy-based strength assessment.'
  s.authors     = ['Sean Nieuwoudt']
  s.email       = 'sean@isean.co.za'

  s.files       = Dir['lib/**/*.rb'] # Dynamic file listing for easy expansion
  s.executables << 'passw'
  s.homepage    = 'https://github.com/sn/passw'
  s.license     = 'GPL-3.0-or-later'
  s.required_ruby_version = '>= 2.7'

  # Development dependencies
  s.add_development_dependency 'minitest', '~> 5.25'
  s.add_development_dependency 'rake', '~> 13.2.1'

  # Optional metadata for RubyGems
  s.metadata = {
    'changelog_uri'   => "#{s.homepage}/blob/main/CHANGELOG.md",
    'documentation_uri' => "#{s.homepage}#readme"
  }
end
