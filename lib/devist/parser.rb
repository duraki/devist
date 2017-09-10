require 'date'

# Base class for extracting raw markdown file. Provides a method for extraction
# project info and changelog dataset. Checks for a proper devist format
# structure.
#
# @author Halis Duraki
# @!attribute [r] count
#     @return project [Object] project model data
#     @return changelog [Object] changelog model data
#     @return format [String] changelog format (devist|keepachangelog)
class Devist::Parser

  attr_reader :project, :changelog, :format

  # Guess file changelog format
  # Compare against devist and keepachangelog
  #
  # @return [String] format
  def guess_format(file_name)
    File.foreach(file_name) do |line|
      case line
      when /### [+/
        format = 'keepachangelog'
      when /### V+/
        format = 'devist'
      end
    end

    self.format = format
    format
  end

  # Build and extract project details by front-matter.
  #
  # @param [String] line to cmp to
  # @return [String] project detail
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

  # Build changelog version and changetags.
  #
  # @param [String] line to cmp to
  # @return [Object] built changelog
  def build_changelog(line)
    build_version(line)
    build_tags(line)
  end

  # Build changelog tags and changes.
  #
  # @param [String] line to cmp to
  # @return [Object] changelog tag
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

  # Build changelog version.
  #
  # @param [String] line to cmp to
  # @return [Object] changelog version
  def build_version(line)
    case line
      when /### Version+/
      @date = Date.parse(line) # Extract version date
      @version += 1 # Increment version
      @changelog[@version] = Devist::Version.new (Devist::Extractor.extract_version line), @date
    end
  end

  # Check for proper devist file structure.
  #
  # @param [String] file to validate
  # @return [Bool] proper file structure
  #
  # @deprecated devist is now being built to guess file structure based on
  # keepachangelog or devist format, whichever the end user prefer
  def devist?(file_name)
    is_devist = File.open(file_name).to_a

    if is_devist.last.equal?("")
      is_devist.pop is_devist.last
    end

    print "  * Checking if changelog is devist configured ...\n"
    if is_devist.last.chomp != '.devist'
      print "  * The file is not configured for devist. Are you missing .devist at the end of the file?\n"
      print "  * Skipping ...\n"
    end

    print "  * Found .devist signature.\n"
  end

  # Parse given line and detect linechange.
  #
  # @param [String] file to parse
  # @return [Object] changelog data
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
