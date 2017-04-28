require '../Model/version.rb'
require './extractor.rb'

class Parser

    def parse_file (file_name)
        
        changelog = []
        version = -1 # Start from 0

        File.foreach(file_name) do |line|
                
            case line
                when /### Version.+/
                    version += 1 # Increment version
                    changelog[version] = Version.new ( Extractor.extract_version ( line ) )
                    next

                when /#added.+/
                    changelog[version].tag 'added', Extractor.extract_change (line)
                    next

                when /#fixed.+/
                    changelog[version].tag 'fixed', Extractor.extract_change (line)
                    next

                when /#removed.+/
                    changelog[version].tag 'removed', Extractor.extract_change (line)
                    next

                when /#improved.+/
                    changelog[version].tag 'improved', Extractor.extract_change (line)
                    next
            end

        end

    end

end
