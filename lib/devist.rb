# Base class initializing kernel and CLI utilities. Provides default
# value for compiler.
#
# @author Halis Duraki
class Devist

  attr_reader :parser, :compiler
  attr_reader :logfile, :theme

  # Register default files to search for.
  @@default_search = %w[CHANGELOG RELEASES NEWS]

  # Initialize Devist command line interface. 
  #
  # @param [String] filename
  # @param [String] theme 
  # @return [void]
  def initialize(filename, theme = 'default')
    @parser = Parser.new

    is_changelog?("#{filename}.md")
    is_theme?("#{theme}")
  end

  # Autosearch default & get first available logfiles in a working directory.
  #
  # @return [String] logfile 
  def available
    @@default_search.each do |filename|
      if File.file?("#{filename}.md")
        print "  * Found possible logfile `#{filename.downcase}.md` in directory.\n"
        return filename
      end
    end
  end

  # Decompile markdown file to raw data.
  #
  # @return [Object] project data
  def decompile
    @parser.parse_data(@logfile)
    @parser.project
  end

  # Recompile markdown file to exported static HTML output.
  #
  # @return [Object] compiler 
  def recompile
    @compiler = Compiler.new(@parser.project, @parser.changelog, @theme)
    @compiler.compile_data
  end

  # Get theme directory, an absolute devist gem path plus theme prefix.
  #
  # @return [String] theme directory
  def theme_dir
    "#{__dir__}/devist/export/html"
  end

  # Build theme and add sufix to absolute theme directory and filename.
  #
  # @param [String] name
  # @return [String] absolute theme file
  def theme_name(name)
    "#{theme_dir}/_#{name}.html.erb"
  end

  # Check if given argument is changelog file. Search for additional changelogs
  # if non is found.
  #
  # @param [String] filename
  # @return [String] logfile
  def is_changelog?(filename)
    if !File.file?(filename)
      print "  * Changelog '#{@filename}' does NOT exists; exit ...\n"
      print "  > Do you want to allow devist to search the file for you? #{@@default_search} (y\/N) ".green
      devist_as = STDIN.gets.chomp

      exit if !devist_as.downcase.eql?("y")

      print "  * Searching for changelog data ...\n"

      if logfile = available
        print "  * Try to run with command: `devist #{logfile}`\n".blue
        exit
      end
    end

    @logfile = filename
  end

  # Check if given argument is theme file. Search for theme and prepare for ERB
  # ops.
  #
  # @param [String] filename
  # @return [String] themefile
  def is_theme?(filename)
    if File.file?(theme_name(filename))
      print "  * Theme '#{theme_name(filename)}' exists; continuing ...\n"
      @theme = theme_name(filename)
    else
      print "  * Theme '#{theme_name(filename)}' does NOT exists; exit ...\n"
      exit
    end
  end

end

require 'devist/helper'
require 'devist/parser'
require 'devist/compiler'
require 'devist/version'
