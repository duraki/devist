Gem::Specification.new do |s|
  s.name        = 'devist'
  s.version     = '1.1.4'
  s.executables = ['devist']
  s.summary     = 'Keep proper changelog'
  s.description = 'A Ruby gem that keeps track of your changelog. Support keepachangelog format and offers HTML export.'
  s.authors     = ['Halis Duraki']
  s.email       = 'duraki@linuxmail.org'
  s.files       = ['lib/devist/helper.rb', 'lib/devist/version.rb', 'lib/devist.rb', 'lib/devist/compiler.rb', 'lib/devist/extractor.rb', 'lib/devist/parser.rb', 'lib/devist/models/project.rb', 'lib/devist/models/tags.rb', 'lib/devist/models/version.rb', 'lib/devist/export/html/_default.html.erb', 'lib/devist/export/html/_polar.html.erb']
  s.homepage    =
    'https://devist.io'
  s.license     = 'MIT'

  # Deps
  s.add_dependency "colorize", "~> 0.8.1"

  # Devdeps
  s.add_development_dependency "coveralls", "~> 0.7"
  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake", "~> 12.0"
end
