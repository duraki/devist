# project.rb
# This file is a part of the devist package.
# Halis Duraki <duraki.halis@nsoft.ba>
#
# Create a project instance model. This allows us to reuse
# project name, author and homepage whenever we want. The
# object is not necessary to be created.
class Devist::Project

  attr_accessor :name, :author, :homepage

end
