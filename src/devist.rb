require './Lib/parser.rb'
require '../src/Lib/compiler.rb'

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

  # Default files by priority
  @default_search = %w[RELEASES NEWS CHANGELOG]

  # Init.
  def initialize(filename, theme = 'default')
    @parser = Parser.new
    @filename = filename + ".md"
    @themename = "_" + theme + ".html.erb"

    # Theme directory is absolute dirpath + subs
    theme_dir = __dir__ + "/Export/html/"

    # Check if both theme and filename exists
    if File.file?(@filename)
      print "  * File '#{@filename}' exists; continuing ...\n"
    else
      print "  * File '#{@filename}' does NOT exists; exit ...\n"
      exit
    end

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

