# version.rb
# This file is a part of the devist package.
# Halis Duraki <duraki.halis@nsoft.ba>
#
# Model class `version` is dynamic object that creates a
# new changelog version instance with appropriate tag(s)
# data.
class Devist::Version

  attr_accessor :version, :date, :tags

  def initialize(version, date)
    @version = version
    @date = date
    @tags = Tag.new
  end

  # Create a new tag.
  def tag (type, change)
    @tags.add(type, change)
  end

end

require 'devist/models/tags'
