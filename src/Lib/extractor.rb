class Extractor

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
