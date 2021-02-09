# Xcode-select Helper
**tl;dr;** Swap/check current Xcode version in use with `x`.
([Original blog post here](https://thesumof.it/blog/2017-07-12-a-script-for-multiple-xcodes))

Every year there's a period of time where you will have at least two or more release versions of Xcode installed (and possbile some pre-release versions).
xcode-select is your friend in these situations, but syntax yada yada… made me make x.

For situations where you are working on apps with a lot of legacy support it not unusual to find [developers with many previous Xcode versions](https://twitter.com/philk1701/status/1123874346022375424?s=21) sitting alongside the current release.

`x` is a simple script to help in those situations.

Simply copy it to your shell's path (probably where you keep your other executable scripts) then make it executable.

`chmod +x x`

You can confirm it's working by running it without any options, to see your currently selected version of Xcode:

```
% x                                                                                                                                       🚨 develop/… 
Current Xcode (12.5) is at :
/Applications/Xcode-beta.app
```

Then read the help file:

```
 % x -h                                                                                                                                    🚨 develop/… 

x (1.3.2)

Usage: x [-p --current] [-d] [NN.N]

Options
	-p
	--current	Prints the current Xcode path

	-d
	--default	Set Xcode path to the current Xcode (i.e. /Applications/Xcode.app )

	NN.N or AAAA
	Where NN.N (or AAAA) is a value like 9.4, 10.0 or 11GM2 it will look for a version of Xcode with
	a matching name and if it exists set the Xcode path to it. It will also look for hypdens '-' or
	underscores '_' in the name like 'Xcode-beta'.

	-h
	--help	Shows this help screen.

	-v
	--version	Shows the current version of this script.

Examples:
	$: x
	Current Xcode (10.2.1) is at:
	/Applications/Xcode.app

	$: x -d
	Reset to default Xcode (10.3) at:
	/Applications/Xcode.app

	$: x 9.4
	Swapped to Xcode 9.4 at:
	/Applications/Xcode 9.4.app

	$: x beta
	Swapped to Xcode 11.0 at:
	/Applications/Xcode-beta.app


Current Xcode (12.5) is at:
/Applications/Xcode-beta.app

```