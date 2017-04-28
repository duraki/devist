require './Lib/parser.rb'
require '../src/Lib/compiler.rb'

class Devist

  #
  # @project:  stacklog/devist
  # @author:   Halis Duraki <duraki.halis@nsoft.ba>
  # @homepage: https://github.com/stacklog/devist
  #

  def initialize(filename)
    @parser = Parser.new
    @filename = filename
  end

  def decompile
    p @parser.parse_data(@filename)
    p @parser.project
  end

  def recompile
    @compiler = Compiler.new(@parser.project, @parser.changelog)
    p @compiler.compile_data
  end

  def parser
    @parser
  end

  def compiler
    @compiler
  end

end

devist = Devist.new(Dir.pwd + "/TEST.md")
devist.decompile
devist.recompile
