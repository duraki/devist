#!/bin/sh
set -e
#
# This script is meant for quick & easy install via:
#   'curl -sSL https://raw.githubusercontent.com/stacklog/devist/master/install.sh | sh'
# or:
#   'wget -qO- https://raw.githubusercontent.com/stacklog/devist/master/install.sh | sh'
#
# Maintainer:
# Halis Duraki <duraki.halis@nsoft.ba>
# stacklog/devist
#


do_install() {
    # Go to home
    cd

    if [ -d "devist" ]; then
        # Devist is already installed
        echo Devist is already installed.
        echo You can try to uninstall and run script again
        echo Run: rm -rf $HOME/devist to remove old version
        exit
    fi

    # Clone latest repository
    echo Cloning devist in home directory ...
    git clone https://github.com/stacklog/devist
    echo ++++++++++++++++++++++++++++++++++++++++++++
    echo Devist is cloned in the home directory!

    # Export run function
    echo ++++++++++++++++++++++++++++++++++++++++++++
    echo Exporting devist function ...
    echo "devist() { ruby $HOME/devist/src/bin/devist.rb \$1 \$2 }" >> $HOME/.bashrc
    echo "devist() { ruby $HOME/devist/src/bin/devist.rb \$1 \$2 }" >> $HOME/.zshrc
    echo All done.
    echo ++++++++++++++++++++++++++++++++++++++++++++
    echo Please restart your terminal or reload your .bashrc/.zshrc file.
}

do_install