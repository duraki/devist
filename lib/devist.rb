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
  @default_search = %w[CHANGELOG RELEASES NEWS]

  # Init
  def initialize(filename, theme = 'default')
  
    @parser = Parser.new
    @filename = filename + ".md"
    @themename = "_" + theme + ".html.erb"

    # Theme directory is absolute dirpath + subs
    theme_dir = __dir__ + "/devist/export/html/"

    # Check if both theme and filename exists
    print "  * Location '#{@filename}' ...\n"
    if File.file?(@filename) 
      print "  * File '#{@filename}' exists; continuing ...\n"
    else
      print "  * File '#{@filename}' does NOT exists; exit ...\n"
      exit
    end

    print "  * Theme dir '#{theme_dir} ...\n"
    if File.file?(theme_dir + @themename)
      print "  * Theme '#{@themename}' exists; continuing ...\n"
    else
      print "  * Theme '#{@themename}' does NOT exists; exit ...\n"
      exit
    end

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
