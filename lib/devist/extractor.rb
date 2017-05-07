# extractor.rb
# This file is a part of the devist package.
# Halis Duraki <duraki.halis@nsoft.ba>
#
# The extractor class extracts all necessary elements
# from the line, or changelog revision. All methods
# shall be static.
class Devist::Extractor

  class << self

    def extract_version(line)
      line[/n (.*) of/, 1]
    end

    def extract_change(line)
      line.split(': ')[-1]
    end

    def extract_info(line)
      line.split(': ')[-1]
    end

  end

end
