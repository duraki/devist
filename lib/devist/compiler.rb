require 'erb'

# Abstract compiler class takes argumented input of project data and export
# theme. Object consists of version listing, save operations, binding and
# export. 
#
# @author Halis Duraki
class Devist::Compiler

  # Initialize compiler instance with given arguments.
  #
  # @param [String] project name 
  # @param [Object] changelog model 
  # @param [String] export theme
  def initialize(project, changelog, theme)
    @project = project
    @changelog = changelog
    @theme = theme
  end

  # Compile & save changelog set to static html using erb.
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

  # Compile given changelog by version and save file. 
  #
  # @return #{save}
  def compile_data
    @changelog.each do |version|
      print "  * Found version #{version.version}; registered ...\n"
    end

    save
  end

end
