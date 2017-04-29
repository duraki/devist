require './Model/tags.rb'

# version.rb
# This file is a part of the devist package.
# Halis Duraki <duraki.halis@nsoft.ba>
#
# Model class `version` is dynamic object that creates a
# new changelog version instance with appropriate tag(s)
# data.
class Version

  attr_accessor :version, :tags

  def initialize(version)
    @version = version
    @tags = Tag.new
  end

  # Create a new tag.
  def tag (type, change)
    @tags.add(type, change)
  end

end
