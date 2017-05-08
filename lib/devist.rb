# devist.rb
# This file is a part of the devist package.
# Halis Duraki <duraki.halis@nsoft.ba>
#
# This is the place where the ep action is being taken.
# Devist check if setup is ok and proceed with parsing
# and creating the static export.
class Devist

  #
  # @project:  stacklog/devist
  # @author:   Halis Duraki <duraki.halis@nsoft.ba>
  # @homepage: https://github.com/stacklog/devist
  #

  attr_reader :parser, :compiler

  # Default files to look for
  @@default_search = %w[CHANGELOG RELEASES NEWS]

  # Init
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

  # Auto-search for available changelog
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

  # Decompile .md file.
  def decompile
    @parser.parse_data(@filename)
    @parser.project
  end

  # Recompile .md file.
  def recompile
    @compiler = Compiler.new(@parser.project, @parser.changelog, @themename)
    @compiler.compile_data
  end

end

require 'devist/parser'
require 'devist/compiler'
