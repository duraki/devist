# Extractor class parse given filename and extracts affected elements line by
# line on a changelog revision. 
#
# @author Halis Duraki
class Devist::Extractor

  class << self

    # Match version pattern.
    #
    # @param [String] line to cmp to
    # @return [String] extracted version 
    def extract_version(line)
      line[/n (.*) of/, 1]
    end

    # Match changetag pattern.
    #
    # @param [String] line to cmp to
    # @return [String] extracted change
    def extract_change(line)
      line.split(': ')[-1]
    end

    # Match project info pattern.
    #
    # @param [String] line to cmp to
    # @return [String] extracted project info
    def extract_info(line)
      line.split(': ')[-1]
    end

  end

end
