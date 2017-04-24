
def extract_version (line)
  p line[/n (.*) of/, 1]
end


def parse_changelog (file_name)
  section = []

  File.foreach(file_name) do |line|

    #p line

    case line
      when /### Version.+/
        section.push line
        next

      when /#added.+/
        section.push line
        next

      when /#fixed.+/
        section.push line
        next

      when /#removed.+/
        section.push line
        next

      when /#improved.+/
        section.push line
        next
    end

  end

  p section

end

p Dir.pwd
parse_changelog(Dir.pwd + "/src/CHANGELOG.md")

extract_version("### Version 1.0.0 of Apr 24 2017")