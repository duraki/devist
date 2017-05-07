require 'erb'

# compiler.rb
# This file is a part of the devist package.
# Halis Duraki <duraki.halis@nsoft.ba>
#
# This is the main compiler class. It takes arguments
# project (model), changelog (model), and theme name.
# Object offers a version listing plus save operation
# and binding to the theme erb.
class Devist::Compiler

  # Init.
  def initialize(project, changelog, theme)
    @project = project
    @changelog = changelog
    @theme = theme
  end

  # Save compiled.
  def save
    print "  -\n"
    print "  * Trying to compile set ...\n"

    print "  * Creating new export from erb ...\n"
    asset = "#{__dir__}/export/html/#{@theme}"
    erb = ERB.new(File.open(asset).read, 0, '>')

    print "  * Injecting parsed results to the erb ...\n"
    erb.result binding

    print "  * Writing compiled data to changelog file ...\n"
    File.open("#{Dir.pwd}/changelog.html", 'w') do |f|
      f.write erb.result binding
    end

    print "  -\n"
    print "  ** All done! Check changelog.html file in your browser :)\n"
  end

  # Compile data.
  def compile_data
    @changelog.each do |version|
      print "  * Found version #{version.version}; registered ...\n"
    end

    save
  end

end
