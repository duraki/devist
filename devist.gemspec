Gem::Specification.new do |s|
  s.name        = 'devist'
  s.version     = '1.1.3'
  s.executables = ['devist']
  s.summary     = 'Generate beautiful changelogs!'
  s.description = 'A Ruby gem that will help you export your Markdown changelog into beautiful HTML pages.'
  s.authors     = ['Halis Duraki']
  s.email       = 'duraki.halis@nosft.ba'
  s.files       = ['lib/devist.rb', 'lib/devist/compiler.rb', 'lib/devist/extractor.rb', 'lib/devist/parser.rb', 'lib/devist/models/project.rb', 'lib/devist/models/tags.rb', 'lib/devist/models/version.rb', 'lib/devist/export/html/_default.html.erb', 'lib/devist/export/html/_polar.html.erb']
  s.homepage    =
    'https://github.com/stacklog/devist'
  s.license     = 'MIT'

  # Deps
  s.add_development_dependency "coveralls", "~> 0.7"
  s.add_development_dependency "bundler", "~> 1.3"
end
