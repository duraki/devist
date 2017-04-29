require './Lib/parser.rb'
require '../src/Lib/compiler.rb'

class Devist

  #
  # @project:  stacklog/devist
  # @author:   Halis Duraki <duraki.halis@nsoft.ba>
  # @homepage: https://github.com/stacklog/devist
  #

  # Default files by priority
  @default_search = [ 'RELEASES', 'NEWS', 'CHANGELOG' ]

  # Init.
  def initialize(filename)
    @parser = Parser.new
    @filename = filename
  end

  # Decompile .md file.
  def decompile
    p @parser.parse_data(@filename)
    p @parser.project
  end

  # Recompile .md file.
  def recompile
    @compiler = Compiler.new(@parser.project, @parser.changelog)
    p @compiler.compile_data
  end

  # Return parser
  def parser
    @parser
  end

  # Return compiler
  def compiler
    @compiler
  end

end

devist = Devist.new(Dir.pwd + "/TEST.md")
devist.decompile
devist.recompile
