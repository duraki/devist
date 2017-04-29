#!/usr/local/bin/ruby

##############################################################
#
# bin/devist
#
# Main action point. Devist binary.
# stacklog/devist @ github
#
# Halis Duraki <duraki.halis@nsoft.ba>
#
##############################################################

class DevistBin

  # Print banner image.
  def print_logo
    puts <<EOL
         __          _      __ 
    ____/ /__ _   __(_)____/ /_
   / __  / _ \\ | / / / ___/ __/
  / /_/ /  __/ |/ / (__  ) /_  
  \\__,_/\\___/|___/_/____/\\__/ 
- Release notes generator.
  https://github.com/stacklog/devist

  Use --help for details.

EOL
  end

  # Print help menu.
  def print_help
    puts <<EOL
  Use devist to generate beautiful release notes. All you need to have is CHANGELOG.md with 
  .devist line at the end of the file. 
    
  $ devist          | compile to html from current directory with default theme
  $ devist --help   | usage / this menu
  $ devist --v      | show current version
  $ devist --new    | create template
  $ devist --theme  | set theme for export
  $ devist --file   | set filename to compile
  
  - 
  $ devist file_name theme_name

  Example:
  $ devist default CHANGELOG
EOL
  end

  # Entry point. Main.
  def ep (arguments)
    @arguments = arguments

    print_logo

    # Recieved filename + theme as args
    if @arguments.count.equal?(2)
      file_name   = @arguments[0]
      theme_name  = @arguments[1]

      print "  * devist will generate export for file '" + file_name + "' with theme '" + theme_name + "'\n"
    end

    case @arguments[0]
      when '--help'
        print_help

      when '--v'
        v = `git rev-parse HEAD`
        d = `git log -1 --format=%cd`
        print "  * devist version: " + v[0, 7] + " - " + d[0,10] + "\n"

      when '--new'
        print "  * Generating CHANGELOG.md ...\n"
        new = File.new(Dir.pwd + "/CHANGELOGs.md", "w")
        print "  * Output .devist as a way of thinkering ...\n"
        new.puts(".devist")
        new.close
        print "  * All done. Continue editing CHANGELOG.md.\n"
    end

  end

end

devistbin = DevistBin.new
#devistbin.print_logo
#devistbin.print_help
devistbin.ep(ARGV)