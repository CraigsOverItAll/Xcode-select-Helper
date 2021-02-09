#!/bin/zsh
# Set Xcode paths etc, to the Current Xcode or a previous version
version="1.3.2"

# Bold and Normal markers
bold=$(tput bold)
normal=$(tput sgr0)

# Colors for output
orange="\033[38;5;208m" #orange
grey="\033[38;5;7m"     #grey
green="\033[38;5;10m"   #apple-green
# Colour end
e="\033[0;00m"

function currentXcodePath {
  echo $(dirname "$(dirname "$(xcode-select -p)")")
}

function currentXcodeVersion {
  xpath=$(currentXcodePath)
  echo $(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "$xpath/Contents/version.plist")
}

function printSwappedMsg {
  echo "Swapped to Xcode "$(currentXcodeVersion)" at:"
  currentXcodePath
}

function printHelp {
  echo
  echo $bold"Usage:"$normal" x [-p --current] [-d] [NN.N]"
  echo
  echo $bold"Options"$normal
  echo $green"\t-p"$e
  echo $green"\t--current\tPrints the current Xcode path"$e
  echo
  echo $green"\t-d"$e
  echo $green"\t--default\tSet Xcode path to the current Xcode (i.e. /Applications/Xcode.app )"$e
  echo
  echo $green"\tNN.N or AAAA"$e
  echo $green"\tWhere NN.N (or AAAA) is a value like 9.4, 10.0 or 11GM2 it will look for a version of Xcode with"$e
  echo $green"\ta matching name and if it exists set the Xcode path to it. It will also look for hyphens '-' or"$e
  echo $green"\tunderscores '_' in the name like 'Xcode-beta' (Apples current beta naming convention) so you can."$e
  echo $green"\tsimple type 'x beta' to swap to the current beta release."$e
  echo
  echo $green"\t-h"$e
  echo $green"\t--help\tShows this help screen."$e
  echo
  echo $green"\t-v"$e
  echo $green"\t--version\tShows the current version of this script."$e
  echo
  echo $bold"Examples:"$normal
  echo "\t$: x\n\tCurrent Xcode (10.2.1) is at:\n\t/Applications/Xcode.app"
  echo
  echo "\t$: x -d\n\tReset to default Xcode (10.3) at:\n\t/Applications/Xcode.app"
  echo
  echo "\t$: x 9.4\n\tSwapped to Xcode 9.4 at:\n\t/Applications/Xcode 9.4.app"
  echo
  echo "\t$: x beta\n\tSwapped to Xcode 11.0 at:\n\t/Applications/Xcode-beta.app"
  echo
  echo
  echo $grey"Current Xcode ("$(currentXcodeVersion)") is at:\n"$e$green`currentXcodePath`$e
}

# The actual useful stuff
if [[ -z $1 ]]
  then
  echo "Current Xcode ("$(currentXcodeVersion)") is at :\n"`currentXcodePath`
elif [[ -n $1 ]]
  then
    if [[ $1 = "-d" ]] || [[ $1 = "--default" ]] || [[ $1 = "-r" ]] || [[ $1 = "--reset" ]]
    then
      sudo xcode-select -r
      echo "Reset to default Xcode ("$(currentXcodeVersion)") at: "
      currentXcodePath
    elif [[ $1 == "-p" ]] || [[ $1 == "--current" ]]
      then
      currentXcodePath
    elif [[ $1 == "-v" ]] || [[ $1 == "--version" ]]
      then
        echo
        echo $bold"x Version: "$normal$green$version$e
        echo
    elif [[ -z $2 ]] && [[ -d /Applications/Xcode\ $1.app ]]
      then
        sudo xcode-select -s /Applications/Xcode\ $1.app/Contents/Developer/
        printSwappedMsg
    elif [[ -z $2 ]] && [[ -d /Applications/Xcode-$1.app ]]
      then
        sudo xcode-select -s /Applications/Xcode-$1.app/Contents/Developer/
        printSwappedMsg
    elif [[ -z $2 ]] && [[ -d /Applications/Xcode_$1.app ]]
      then
        sudo xcode-select -s /Applications/Xcode_$1.app/Contents/Developer/
        printSwappedMsg
    elif [[ $1 = "-h" ]] || [[ $1 = "--help" ]]
    then
      echo
      echo $bold"x ($version)"$normal
      printHelp
    else
      echo $orange"Unsupported option(s) supplied: $@"$e
      echo
      printHelp
    fi
fi
