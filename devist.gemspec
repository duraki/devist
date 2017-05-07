Gem::Specification.new do |s|
  s.name        = 'devist'
  s.version     = '1.0.0'
  s.executables = ['devist']
  s.date        = '2017-07-05'
  s.summary     = 'Generate beautiful changelogs!'
  s.description = 'A Ruby gem that will help you export your Markdown changelog into beautiful HTML pages.'
  s.authors     = ['Halis Duraki']
  s.email       = 'duraki.halis@nosft.ba'
  s.files       = ['lib/devist.rb', 'lib/devist/compiler.rb', 'lib/devist/extractor.rb', 'lib/devist/parser.rb', 'lib/devist/models/project.rb', 'lib/devist/models/tags.rb', 'lib/devist/models/version.rb']
  s.homepage    =
    'https://github.com/stacklog/devist'
  s.license     = 'MIT'
end
