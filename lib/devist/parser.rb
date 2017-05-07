require 'date'

# parser.rb
# This file is a part of the devist package.
# Halis Duraki <duraki.halis@nsoft.ba>
#
# Parser will allow a building routine for the given
# changelog by investigating every line in the file.
# The Parser created project info, and build changelog,
# but it also check if the given file is proper devist
# format.
class Devist::Parser

  attr_reader :project, :changelog

  # Project builder.
  def build_info(line)
    case line
    when /@project:+/
      @project.name = Devist::Extractor.extract_info(line)
      print "  * Extracting project name ... [#{@project.name.chomp.strip!}]\n"
    when /@author:.+/
      @project.author = Devist::Extractor.extract_info(line)
      print "  * Extracting project author ... [#{@project.author.chomp.strip!}]\n"
    when /@homepage:.+/
      @project.homepage = Devist::Extractor.extract_info(line)
      print "  * Extracting project homepage ... [#{@project.homepage.chomp.strip!}]\n"
    end
  end

  # Changelog builder.
  def build_changelog(line)
    build_version(line)
    build_tags(line)
  end

  # Build tags.
  def build_tags(line)
    case line
    when /#added.+/
      @changelog[@version].tag 'added', Devist::Extractor.extract_change(line)
    when /#fixed.+/
      @changelog[@version].tag 'fixed', Devist::Extractor.extract_change(line)
    when /#removed.+/
      @changelog[@version].tag 'removed', Devist::Extractor.extract_change(line)
    when /#improved.+/
      @changelog[@version].tag 'improved', Devist::Extractor.extract_change(line)
    end
  end

  # Build version.
  def build_version(line)
    case line
      when /### Version+/
      @date = Date.parse(line) # Extract version date
      @version += 1 # Increment version
      @changelog[@version] = Devist::Version.new (Devist::Extractor.extract_version line), @date
    end
  end

  # Is file devist configured.
  def devist?(file_name)
    is_devist = File.open(file_name).to_a

    if is_devist.last.equal?("")
      is_devist.pop is_devist.last
    end

    print "  * Checking if changelog is devist configured ...\n"
    if is_devist.last.chomp != '.devist'
      abort('  * The file is not configured for devist. Are you missing .devist at the end of the file?')
      exit
    end

    print "  * Found .devist signature.\n"
  end

  # Line parser.
  def parse_data(file_name)
    @project = Devist::Project.new
    @changelog = []
    @version = -1 # Start from 0

    devist?(file_name) # Check if file is configured for usage

    print "  * Building model from file data ...\n"

    File.foreach(file_name) do |line|
      build_info(line) # Build project info
      build_changelog(line) # Build changelog data
    end

    @changelog
  end

end

require 'devist/extractor'
require 'devist/models/project'
require 'devist/models/tags'
require 'devist/models/version'
