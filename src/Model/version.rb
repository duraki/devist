require './Model/tags.rb'

class Version
   
    attr_accessor :version

    def initialize(version)
        @version = version
        @tags = Tag.new
    end

    # Create a new tag.
    def tag (type, change)
        @tags.add(type, change)
    end

end
