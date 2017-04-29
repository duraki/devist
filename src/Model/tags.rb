# tags.rb:Marray
#
# This is the helper class that allows us to
# recreate a multidimensional array.
class Marray < Array
  def [](i)
    super.nil? ? self[i] = Marray.new : super
  end
end

# tags.rb
# This file is a part of the devist package.
# Halis Duraki <duraki.halis@nsoft.ba>
#
# Model class `tags` is dynamic object that have parent
# `version` and is made of version tag info.
class Tag

  def initialize
    @list = %w[added fixed removed improved]
    @change = Marray.new(@list.count)
  end

  def add (type, change)
    @change[@list.index(type)][@change[@list.index(type)].count] = change
  end

  def get
    @change
  end

end
