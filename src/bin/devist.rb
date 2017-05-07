#!/usr/bin/ruby

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

require 'devist'

# bin/devist.rb
# This file is a part of the devist package.
# Halis Duraki <duraki.halis@nsoft.ba>
#
# This is the main entry point of the Devist. It creates a
# binary and parse and execute actions based on given CLI
# arguments.
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
    
  $ devist          | run devist
  $ devist --help   | usage / this menu
  $ devist --v      | show current version
  $ devist --new    | create changelog template 
  
  - 
  $ devist file_name theme_name

  Example:
  $ devist changelog
  $ devist changelog polar
EOL
  end

  # Entry point. Main.
  def ep (arguments)
    @arguments = arguments

    print_logo

    # Recieved filename + theme as args
    if @arguments.count.equal?(2)
      return theme
    end

    # Check other arguments
    case @arguments[0]
    when '--help'
      print_help
    when '--v'
      version
    when '--new'
      create  # Create new changelog (fresh project)
    else
      default # Try to export with filename and default theme
      return
    end
  end

  # Generate with default theme.
  def default
    file_name = @arguments[0]

    unless file_name.nil?
      decompile(file_name)
    end
  end

  # Generate by specifying theme.
  def theme
    file_name = @arguments[0]
    theme_name = @arguments[1]

    unless file_name.nil?
      decompile(file_name, theme_name)
    end
  end

  # Display devist version.
  def version
    v = `git rev-parse HEAD`
    d = `git log -1 --format=%cd`
    print "  * devist version: #{v[0, 7]} - #{d[0, 10]}\n"
  end

  # Create new changelog.
  def create
    print "  * Generating CHANGELOG.md ...\n"

    if File.file?(Dir.pwd + '/CHANGELOG.md')
      print "  * File CHANGELOG.md already exists. Backup it, remove, and try again.\n"
      print "  * You may try to run 'devist changelog' to try generate the export.\n"
      abort
    end

    new = File.new(Dir.pwd + '/CHANGELOG.md', 'w')
    print "  * Output .devist as a way of thinkering ...\n"
    thinkering(new)
    print "  -\n"
    print "  ** All done! Continue editing CHANGELOG.md.\n"
  end

  # Fill new changelog.
  def thinkering(new)
    new.puts('@project: MyProject  ')
    new.puts('@author: Your Name <email@address.com>  ')
    new.puts('@homepage: https://example.com  ')
    new.puts('')
    new.puts("### Version 1.0.0 of #{Time.now.strftime("%d %b %Y")}")
    new.puts('+ #added: something goes here')
    new.puts('')
    new.puts('.devist')
    new.close
  end

  # Decompile ep.
  def decompile(file_name, theme_name = 'default')
    print "  * devist will try to generate export for file '#{file_name}' with theme '#{theme_name}'\n"

    @devist = Devist.new(file_name, theme_name)
    @devist.decompile
    @devist.recompile
  end

end

# Create new bin/ep with argv
devistbin = DevistBin.new
devistbin.ep(ARGV)
