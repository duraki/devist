# Create a project instance model. Allow reuse of project information and other
# front-matter tags. Not mandatory for Devist normal usage.
#
# @author Halis Duraki
# @!attribute [r] count
#     @return name [String] project name
#     @return author [String] project author
#     @return homepage [String] project homepage 
class Devist::Project

  attr_accessor :name, :author, :homepage

end
