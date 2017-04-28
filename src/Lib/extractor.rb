class Extractor

    class << self

        def self.extract_version (line)
            line[/n (.*) of/, 1]
        end

        def self.extract_change (line)
            line.split(': ')[-1]
        end

    end

end
