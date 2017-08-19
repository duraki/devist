# Model class `version` is dynamic object that create and consist a new
# changelog version. A new version instance with appropriate changetags.
#
# @author Halis Duraki
# @!attribute [r] count
#     @return version [Object] project literal version 
#     @return date [Object] version release date
#     @return tags [Object] version changetags
class Devist::Version

  attr_accessor :version, :date, :tags

  # Initialize a new version instance with version details.
  #
  # @param [String] literal version
  # @return [Date] literal date 
  def initialize(version, date)
    @version = version
    @date = date
    @tags = Devist::Tag.new
  end

  # Create a new changetag for particular version.
  #
  # @param [String] change tag type / enum
  # @param [String] change given for the tag
  def tag (type, change)
    @tags.add(type, change)
  end

end

require 'devist/models/tags'
