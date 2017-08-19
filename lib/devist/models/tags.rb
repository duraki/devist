class Marray < Array
  def [](i)
    super.nil? ? self[i] = Marray.new : super
  end
end

# Dynamic model class for change tags with a parent version system. Consist of
#  change information and enumurated changetag.
#
# @author Halis Duraki
class Devist::Tag

  # Initialize changetag object. Creates a new multidimensional array of
  # changes.
  def initialize
    @list = %w[added fixed removed improved]
    @change = Marray.new(@list.count)
  end

  # Add a new changelog and changetag data into given tag.
  #
  # @param [String] change type from enum
  # @param [String] change information
  #
  # @return [Array] tag array
  def add (type, change)
    @change[@list.index(type)][@change[@list.index(type)].count] = change
  end

  # Return current instance of tag array.
  #
  # @return [Array] tag array
  def get
    @change
  end

end
