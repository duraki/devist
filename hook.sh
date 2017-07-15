#!/bin/bash

# This hook is called to verify what is about to be pushed. Called by "git push" this script
# will check if CHANGELOG.md consist of latest tag you are about to push. This hook only check for
# tags being pushed (since they are release). You may edit the script for your own reason and per
# project basis and put it into .git/hooks/

# This file is a part of Devist package <https://devist.io> 
# Stackrecord (c) Stacklog / Devist <https://github.com/stacklog/devist>
# An open-source changelog file and release notes generator.
#
# Developed by Halis Duraki 
# <duraki@linuxmail.org> <https://duraki.github.io>

LOGFILE="CHANGELOG.md"

remote="$1"
url="$2"

HELPMSG01="Use --no-verify while to skip this git-hook."

z40=0000000000000000000000000000000000000000

while read local_ref local_sha remote_ref remote_sha
do

    if [[ $local_ref == *"tags"* ]]; then
        echo "Devist / tag/hook / pre-push - https://devist.io"

        echo "> Pre-push hook activated."
        echo "> Tag detected."
        echo "> Checking for file $LOGFILE in this directory ..."

        if [ ! -f $LOGFILE ]; then
            echo "File $LOGFILE not found!"
            echo "Run devist --new or edit the FILENAME in `.git/hooks/pre-push`"
            echo $HELPMSG01
            echo "Exiting ..."
            exit 1
        fi

        echo "Checking tag version ..."
        TAG=$(cut -d "/" -f 3 <<< "$local_ref")

        echo "Stripping non-numeric characters ..."
        TAG=$(echo $TAG | sed 's/[^.0-9]*//g')

        echo "Detected tag: $TAG"

        echo "Checking latest TAG in changelog file ..."
        if grep $TAG $LOGFILE
        then
            echo "Tag found in $LOGFILE ; continue ..."
        else
            echo "Tag not found in $LOGFILE ; please bump your version."
            echo $HELPMSG01
            exit 1
        fi

        echo "Pushing a tag / release ..."
    fi

done

exit 0
