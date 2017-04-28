require 'erb'

class Compiler

  def initialize(project, changelog)
    @project = project
    @changelog = changelog
  end

  def compile_info
    asset = "#{__dir__}/../Export/html/_changelog.html.erb"
    erb = ERB.new(File.open(asset).read, 0, '>')
    p erb.result binding

    File.open('/tmp/out.html', 'w') do |f|
      f.write erb.result binding
    end
  end

  def compile_data
    compile_info

    @changelog.each do |version|

      p "Compiling version " + version.version + " ..."

      # added
      version.tags.get[0].each do |change|
        p change
      end

      # fixed
      version.tags.get[1].each do |change|
        p change
      end

      # removed
      version.tags.get[2].each do |change|
        p change
      end

      # improved
      version.tags.get[3].each do |change|
        p change
      end

    end
  end

end