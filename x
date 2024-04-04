#!/bin/zsh
# Set Xcode paths etc, to the Current Xcode or a previous version
version="1.4.2"

# Target Xcode
targetName=''

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

function xcodeBuildVersion {
  printf "$(xcodebuild -version)\n"
}

function currentXcodeVersion {
  xcversion=$(xcodeBuildVersion | head -n 1)
  echo "${xcversion:6}"
}

function currentXcodeBuild {
  echo $(xcodeBuildVersion | tail -n 1)
}

function printSwappedMsg {
  echo "Swapped to Xcode "$(currentXcodeVersion)" at:"
  currentXcodePath
}

function printCurrentXcode {
  echo $grey"Current Xcode ("$(currentXcodeVersion)") is at:\n"$e$green`currentXcodePath`$e
}

function printSwiftVersion {
  echo $(swift --version)
}

function printXcodeSelectVersion {
  echo $(xcode-select -v)
}

function printVersion {
  echo $bold"x Version "$normal$version$e
}

function swapToXcode {
  if [[ -d /Applications/Xcode\ $targetName.app ]]
    then
      sudo xcode-select -s /Applications/Xcode\ $targetName.app/Contents/Developer/
  elif [[ -z $2 ]] && [[ -d /Applications/Xcode-$targetName.app ]]
    then
      sudo xcode-select -s /Applications/Xcode-$targetName.app/Contents/Developer/
  elif [[ -z $2 ]] && [[ -d /Applications/Xcode_$targetName.app ]]
    then
      sudo xcode-select -s /Applications/Xcode_$targetName.app/Contents/Developer/
  else
      printSuffixNotFound
      exit(0)
  fi

  printSwappedMsg
}

function printSuffixNotFound {
      echo $orange"Xcode suffix not found: $targetName"$e
      echo
}

function printUnsupportedOption {
      echo $orange"Unsupported option(s) supplied: $@"$e
      echo
      printHelp
}

function printHelp {
  printVersion
  echo
  echo $bold"Usage:"$normal" x [-p --current] [-d] [NN.N]"
  echo
  echo $bold"Options"$normal
  echo $green"\t-b"$e
  echo $green"\t--beta\tSwaps to the currently installed beta of Xcode (typically called Xcode-beta.app)"$e
  echo
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
  echo $green"\t-i"$e
  echo $green"\t--install\tUses xcode-select to open a dialog for installation of the command line developer tools"$e
  echo
  echo $green"\t-s"$e
  echo $green"\t--swift\tEquivalent to "$grey"swift --version"$green" this help screen."$e
  echo
  echo $green"\t-x"$e
  echo $green"\t--xcodeversion\tEquivalent to "$grey"xcodebuild -version"$e
  echo
  echo $green"\t-h"$e
  echo $green"\t--help\tShows this help screen."$e
  echo
  echo $green"\t-v"$e
  echo $green"\t--version\tShows the current version of this script."$e
  echo $green"\t-vv"$e
  echo $green"\t--vversion\tShows the verbose version of this script."$e
  echo
  echo $bold"Examples:"$normal
  echo "\t$: x\n\tCurrent Xcode (10.2.1) is at:\n\t/Applications/Xcode.app"
  echo "\t$: x\n\tCurrent Xcode (12.5) is at: /Applications/Xcode.app\n\tApple Swift version 5.4 (swiftlang-1205.0.26.9 clang-1205.0.19.55) Target: x86_64-apple-darwin20.5.0\n\txcode-select version 2384. darwin20.5.0"
  echo
  echo "\t$: x 9.4\n\tSwapped to Xcode 9.4 at:\n\t/Applications/Xcode 9.4.app"
  echo
  echo "\t$: x -b\n\tSwapped to Xcode 13.0 at:\n\t/Applications/Xcode-beta.app"
  echo "\t$: x -s\n\tswift-driver version: 1.26 Apple Swift version 5.5 (swiftlang-1300.0.19.104 clang-1300.0.18.4) Target: x86_64-apple-macosx11.0"
  echo
  echo
  printCurrentXcode
}

# The actual useful stuff
if which xcode-select >/dev/null
  then
    if [[ -z $1 ]]
      then
      printCurrentXcode
      printSwiftVersion
      printXcodeSelectVersion
    elif [[ -n $1 ]]
      then
        if [[ $1 = "-d" ]] || [[ $1 = "--default" ]] || [[ $1 = "-r" ]] || [[ $1 = "--reset" ]]
        then
          sudo xcode-select -r
          echo "Reset to default Xcode ("$(currentXcodeVersion)") at: "
          currentXcodePath
        elif [[ $1 == "-b" ]] || [[ $1 == "--beta" ]]
          then
          targetName=beta
          swapToXcode
        elif [[ $1 == "-p" ]] || [[ $1 == "--current" ]]
          then
          currentXcodePath
        elif [[ $1 == "-i" ]] || [[ $1 == "--install" ]]
          then
          xcode-select --install
        elif [[ $1 == "-s" ]] || [[ $1 == "--swift" ]]
          then
          printSwiftVersion
        elif [[ $1 == "-x" ]] || [[ $1 == "--xcodeversion" ]]
          then
            xcodeBuildVersion
        elif [[ $1 == "-v" ]] || [[ $1 == "--version" ]]
          then
            printVersion
        elif [[ $1 == "-vv" ]] || [[ $1 == "--vversion" ]]
          then
            echo $(printVersion)" using:"
            echo "Xcode $(currentXcodeVersion) (at: $(currentXcodePath))"
            printSwiftVersion
            xcodeBuildVersion
            printXcodeSelectVersion
        elif [[ $1 = "-h" ]] || [[ $1 = "--help" ]]
          then
            printHelp | less -r
        elif [[ -z $2 ]]
          then
            targetName=$1
            swapToXcode
        else
          printUnsupportedOption
        fi
    fi
else
  echo "Xcode-select not found. If Xcode is installed launch Xcode and install tools when prompted."
fi
