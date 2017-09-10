# Base class initializing kernel and CLI utilities. Provides default
# value for compiler.
#
# @author Halis Duraki
# @!attribute [r] count
#     @return parser [Object] module for parsing data init 
#     @return compiler [Object] module for compiling data init
class Devist

  attr_reader :parser, :compiler

  # Register default files to search for.
  @@default_search = %w[CHANGELOG RELEASES NEWS]

  # Initialize Devist command line interface. 
  #
  # @param [String] changelog file
  # @param [String] export/html theme style 
  # @return self
  def initialize(filename, theme = 'default')
  
    @parser = Parser.new
    @filename = filename + ".md"
    @themename = "_" + theme + ".html.erb"

    # Theme directory is absolute dirpath + subs
    theme_dir = __dir__ + "/devist/export/html/"

    # Check if both theme and filename exists
    if File.file?(@filename) 
      print "  * File '#{@filename}' exists; continuing ...\n"
    else
      print "  * File '#{@filename}' does NOT exists; exit ...\n"
      print "  > Do you want to allow devist to search the file for you? (y\/N) "
      devist_as = STDIN.gets.chomp
      
      # Search for changelogs automatically
      if devist_as.downcase.eql?("y")
          print "  * Searching for changelog data ...\n"
          available

          if @@available.count > 0
            print "  * Try to run with filename #{@@available_list}\n"
          end
      end
          
      exit
    end

    if File.file?(theme_dir + @themename)
      print "  * Theme '#{@themename}' exists; continuing ...\n"
    else
      print "  * Theme '#{@themename}' does NOT exists; exit ...\n"
      exit
    end

  end

  # Autosearch default & available changelog in working directory.
  #
  # @return [Integer] found logfile 
  def available
    @@available = []
    @@available_list = String.new 

    @@default_search.each do |filename|
      filename.concat(".md")
      if File.file?(filename)
        @@available_list.concat(filename + " ")
        @@available.push(filename)   
      end
    end

    print "  * Found #{@@available.count} results.\n"

    @@available.count
  end

  # Stupid guesser based on fileline
  #
  # @return [String] Format frame
  def get_format
    @parser.guess_format(@file_name)
  end

  # Decompile markdown file to raw data.
  #
  # @return [Object] project data
  def decompile
    @parser.parse_data(@filename)
    @parser.project
  end

  # Recompile markdown file to exported static HTML output.
  #
  # @return [Object] compiler 
  def recompile
    @compiler = Compiler.new(@parser.project, @parser.changelog, @themename)
    @compiler.compile_data
  end

end

require 'devist/helper'
require 'devist/parser'
require 'devist/compiler'
require 'devist/version'
