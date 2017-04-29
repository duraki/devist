require_relative '../Model/version.rb'
require_relative '../Model/project.rb'
require_relative 'extractor.rb'

class Parser

  def parse_data(file_name)

    @project = Project.new
    @changelog = []
    version = -1 # Start from 0

    isdevist = File.open(file_name).to_a
    p isdevist.last

    if isdevist.last != ".devist"
      abort("The file is not a devist configured. Are you missing .devist at the end of the file?")
      exit
    end

    File.foreach(file_name) do |line|

      case line
        # Project info builder
        when /@project.+/
          @project.name = Extractor.extract_info(line)
          next
        when /@author.+/
          @project.author = Extractor.extract_info(line)
          next
        when /@homepage.+/
          @project.homepage = Extractor.extract_info(line)
          next

        # Changelog builder
        when /### Version.+/
          version += 1 # Increment version
          @changelog[version] = Version.new (Extractor.extract_version(line))
          next

        when /#added.+/
          @changelog[version].tag 'added', Extractor.extract_change(line)
          next

        when /#fixed.+/
          @changelog[version].tag 'fixed', Extractor.extract_change(line)
          next

        when /#removed.+/
          @changelog[version].tag 'removed', Extractor.extract_change(line)
          next

        when /#improved.+/
          @changelog[version].tag 'improved', Extractor.extract_change(line)
          next
      end

    end

    @changelog

  end

  def changelog
    @changelog
  end

  def project
    @project
  end

end
