require 'date'

# Base class for extracting raw markdown file. Provides a method for extraction
# project info and changelog dataset. Checks for a proper devist format
# structure.
#
# @author Halis Duraki
class Devist::Parser

  # @return [Object] Project instance
  attr_reader :project

  # @return [Object] Changelog instance
  attr_reader :changelog

  # @return [Object] Change indexes
  attr_reader :indexes 

  TAGS = ["ADDED", "CHANGED", "FIXED", "REMOVED", "DEPRECATED", "SECURITY"]

  def initialize
    @indexes = {}
  end

  # Build and extract project details by fmm.
  #
  # @param [String] line to cmp to
  # @return [String] project detail
  def build_info(line)
    case line
    when /@project:+/
      @project.name = Devist::Extractor.extract_info(line) 
      print "  * Extracting project name       ...   [#{@project.name.strip!}]\n"
    when /@author:.+/
      @project.author = Devist::Extractor.extract_info(line)
      print "  * Extracting project author     ...   [#{@project.author.strip!}]\n"
    when /@homepage:.+/
      @project.homepage = Devist::Extractor.extract_info(line)
      print "  * Extracting project homepage   ...   [#{@project.homepage.strip!}]\n"
    end
  end

  # Build changelog version and changetags.
  #
  # @param [String] line to cmp to
  # @return [Object] built changelog
  def build_changelog(line, index)
    build_version(line)
    build_tags(line)
    build_tags_kac(line, index)
  end

  def read_change_of_index(i, type)
    i += 1 # => Always add index to /###/ match
    f = File.readlines(@filename).to_a

    while i.to_i < f.count.to_i
      return if f.at(i).to_s.match(/###.+/) # => Return match on next known tag
      next if f.at(i).to_s.empty? # => Return match on empty change
      @changelog[@version].tag type, Devist::Extractor.extract_change_kac(f.at(i.to_i))
      i+=1
    end
  end

  # Build changelog tags and changes index based on gnu/kac format.
  #
  # @param [String] line to cmp to
  # @param [Integer] line index
  # @return [Void] 
  def build_tags_kac(line, i)
    case line
    when /### Added/, /### Add/
      @indexes.store("added", i)
      read_change_of_index(@indexes["added"], 'added')
    when /### Changed/, /### Change/
      @indexes.store("changed", i)
      read_change_of_index(@indexes["changed"], 'changed')
    when /### Fixed/, /### Fix/
      @indexes.store("fixed", i)
      read_change_of_index(@indexes["fixed"], 'fixed')
    when /### Removed/, /### Remove/
      @indexes.store("removed", i)
      read_change_of_index(@indexes["removed"], 'removed')
    when /### Deprecated/, /### Deprecate/
      @indexes.store("deprecated", i)
      read_change_of_index(@indexes["deprecated"], 'deprecated')
    when /### Security/
      @indexes.store("security", i)
      read_change_of_index(@indexes["security"], 'security')
    end

    puts @indexes.sort_by {|_key, v| v}.to_h
  end

  def read_changes_from_to(i_start, i_stop)
    puts @filename 
    exit
  end

  # Build changelog tags and changes.
  #
  # @param [String] line to cmp to
  # @return [Object] changelog tag
  def build_tags(line)
    case line
    when /#added.+/ # => todo: /### Added/
      @changelog[@version].tag 'added', Devist::Extractor.extract_change(line)
    when /#changed.+/ 
      @changelog[@version].tag 'added', Devist::Extractor.extract_change(line)
    when /#fixed.+/
      @changelog[@version].tag 'fixed', Devist::Extractor.extract_change(line)
    when /#removed.+/
      @changelog[@version].tag 'removed', Devist::Extractor.extract_change(line)
    when /#deprecated.+/
      @changelog[@version].tag 'deprecated', Devist::Extractor.extract_change(line)
    when /#security.+/
      @changelog[@version].tag 'security', Devist::Extractor.extract_change(line)
    end
  end

  # Build changelog version.
  #
  # @param [String] line to cmp to
  # @return [Object] changelog version
  def build_version(line)
    case line
      when /\[[0-9]+.[0-9]+.[0-9]+]/ # => improved from: \[*.+]
      @date = Date.parse(line)
      @version += 1
      @changelog[@version] = Devist::Version.new (Devist::Extractor.extract_version_kac line), @date

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
  # @deprecated devist is now being built to guess file structure
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
    @filename = file_name

    devist?(file_name) # Check if file is configured for usage

    print "  * Building model from file data ...\n"

    File.foreach(file_name).each_with_index do |line, i|
      build_info(line) # Build project info
      build_changelog(line, i) # Build changelog data
    end

    #puts @changelog[@version].inspect
    #l = File.open(@filename).to_a
    #puts l.at(@indexes[:added])
    #exit

    #@indexes.each_with_index do |t, j|
      #puts t,j
    #end
    #read_changes_from_to

    @changelog
  end

end

require 'devist/extractor'
require 'devist/models/project'
require 'devist/models/tags'
require 'devist/models/version'
