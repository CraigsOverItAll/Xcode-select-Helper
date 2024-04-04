# Xcode-select Helper
**tl;dr;** Swap/check current Xcode version in use with `x`.
([Original blog post here](https://thesumof.it/blog/2017-07-12-a-script-for-multiple-xcodes))

Every year there's a period of time where you will have at least two or more release versions of Xcode installed (and possbile some pre-release versions).
xcode-select is your friend in these situations, but syntax yada yada… made me make x.

For situations where you are working on apps with a lot of legacy support it not unusual to find [developers with many previous Xcode versions](https://twitter.com/philk1701/status/1123874346022375424?s=21) sitting alongside the current release.

`x` is a simple script to help in those situations.

Simply copy it to your shell's path (probably where you keep your other executable scripts) then make it executable.

`chmod +x x`

You can confirm it's working by running it without any options, to see your currently selected version of Xcode, and the versions of `xcode-select` and the `swift-driver`:

```shell
$: x
Current Xcode (15.3) is at:
/Applications/Xcode.app
swift-driver version: 1.90.11.1 Apple Swift version 5.10 (swiftlang-5.10.0.13 clang-1500.3.9.4) Target: arm64-apple-macosx14.0
xcode-select version 2406.
```

Then read the help file:

```shell
 x Version 1.4.2

Usage: x [-p --current] [-d] [NN.N]

Options
       -b
       --beta  Swaps to the currently installed beta of Xcode (typically called Xcode-beta.app)

       -p
       --current       Prints the current Xcode path

       -d
       --default       Set Xcode path to the current Xcode (i.e. /Applications/Xcode.app )

       NN.N or AAAA
       Where NN.N (or AAAA) is a value like 9.4, 10.0 or 11GM2 it will look for a version of Xcode with
       a matching name and if it exists set the Xcode path to it. It will also look for hyphens '-' or
       underscores '_' in the name like 'Xcode-beta' (Apples current beta naming convention) so you can.
       simple type 'x beta' to swap to the current beta release.

       -i
       --install       Uses xcode-select to open a dialog for installation of the command line developer tools

       -s
       --swift Equivalent to swift --version this help screen.

       -x
       --xcodeversion  Equivalent to xcodebuild -version

       -h
       --help  Shows this help screen.

       -v
       --version       Shows the current version of this script.
       -vv
       --vversion      Shows the verbose version of this script.

Examples:
        $: x
Current Xcode (15.3) is at:
/Applications/Xcode.app
swift-driver version: 1.90.11.1 Apple Swift version 5.10 (swiftlang-5.10.0.13 clang-1500.3.9.4) Target: arm64-apple-macosx14.0
xcode-select version 2406.

        $: x 9.4
        Swapped to Xcode 9.4 at:
        /Applications/Xcode 9.4.app

        $: x -b
        Swapped to Xcode 15.4 at:
        /Applications/Xcode-beta.app
        $: x -s
swift-driver version: 1.90.11.1 Apple Swift version 5.10 (swiftlang-5.10.0.13 clang-1500.3.9.4) Target: arm64-apple-macosx14.0


Current Xcode (15.3) is at:
/Applications/Xcode.app

```