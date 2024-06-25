# Test suite 1001-main-functions

## Test script 01.sort-commands

### Testing main::sortCommands without prior choices, the order of commands is kept

Exit code: `0`

**Standard** output:

```plaintext
→ main::sortCommands myid1 "${commands}"
cm1  	This is command 1
cm2  	This is command 2
sub cmd1  	This is sub command 1
sub cmd2  	This is sub command 2
another3  	This is another command 3
```

### Testing main::sortCommands after choosing another3 then cm2

Exit code: `0`

**Standard** output:

```plaintext
→ main::addLastChoice myid1 another3
→ main::addLastChoice myid1 cm2
→ main::sortCommands myid1 "${commands}"
cm2  	This is command 2
another3  	This is another command 3
cm1  	This is command 1
sub cmd1  	This is sub command 1
sub cmd2  	This is sub command 2
```

### Testing main::sortCommands, with VALET_CONFIG_REMEMBER_LAST_CHOICES=0 the order does not change

Exit code: `0`

**Standard** output:

```plaintext
→ VALET_CONFIG_REMEMBER_LAST_CHOICES=0 main::sortCommands myid1 "${commands}"
cm1  	This is command 1
cm2  	This is command 2
sub cmd1  	This is sub command 1
sub cmd2  	This is sub command 2
another3  	This is another command 3
```

### Testing main::sortCommands for another id, the order of commands should be the initial one

Exit code: `0`

**Standard** output:

```plaintext
→ main::sortCommands myid2 "${commands}"
cm1  	This is command 1
cm2  	This is command 2
sub cmd1  	This is sub command 1
sub cmd2  	This is sub command 2
another3  	This is another command 3
```

### Testing main::addLastChoice after adding more than 5 commands, we only keep the last 5

Exit code: `0`

**Standard** output:

```plaintext
Content of last-choices-myid1:
cm10
cm9
cm8
cm7
cm6

```

### Testing main::addLastChoice after adding the same command multiple times only keeps the last one

Exit code: `0`

**Standard** output:

```plaintext
Content of last-choices-myid1:
another3
cm10
cm9
cm8
cm7

```

## Test script 02.arguments-parser

### Testing main::parseFunctionArguments

Exit code: `0`

**Standard** output:

```plaintext
→ main::parseFunctionArguments selfMock2
local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
parsingErrors="Expecting ⌜2⌝ argument(s) but got ⌜0⌝.
Use ⌜valet self mock2 --help⌝ to get help.

Usage:
valet [global options] self mock2 [options] [--] <firstArg> <more...>"
more=(
)

→ main::parseFunctionArguments selfMock2 -o -2 optionValue2 arg1 more1 more2
local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
parsingErrors=""
option1="true"
thisIsOption2="optionValue2"
firstArg="arg1"
more=(
"more1"
"more2"
)

→ main::parseFunctionArguments selfMock2 -o -2 optionValue2 arg1
local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
parsingErrors="Expecting ⌜2⌝ argument(s) but got ⌜1⌝.
Use ⌜valet self mock2 --help⌝ to get help.

Usage:
valet [global options] self mock2 [options] [--] <firstArg> <more...>"
option1="true"
thisIsOption2="optionValue2"
firstArg="arg1"
more=(
)

→ main::parseFunctionArguments selfMock2 -unknown -what optionValue2 arg
local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
flag3="${VALET_FLAG3:-}"
help=""
parsingErrors="Unknown option ⌜-unknown⌝, valid options are:
-o
--option1
-2
--this-is-option2
-3
--flag3
-4
--with-default
-h
--help
Expecting ⌜2⌝ argument(s) but got ⌜1⌝.
Use ⌜valet self mock2 --help⌝ to get help.

Usage:
valet [global options] self mock2 [options] [--] <firstArg> <more...>"
withDefault="optionValue2"
firstArg="arg"
more=(
)

→ main::parseFunctionArguments selfMock2 arg more1 more2 -o
local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
parsingErrors=""
firstArg="arg"
option1="true"
more=(
"more1"
"more2"
)

→ main::parseFunctionArguments selfMock2 -this arg more1
local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
parsingErrors="Expecting ⌜2⌝ argument(s) but got ⌜1⌝.
Use ⌜valet self mock2 --help⌝ to get help.

Usage:
valet [global options] self mock2 [options] [--] <firstArg> <more...>"
thisIsOption2="arg"
firstArg="more1"
more=(
)

→ main::parseFunctionArguments selfMock2 --this-is-option2 --option1 arg more1
local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
parsingErrors=""
thisIsOption2="--option1"
firstArg="arg"
more=(
"more1"
)

→ main::parseFunctionArguments selfMock4 arg1 arg2
local parsingErrors help firstArg secondArg
help=""
parsingErrors=""
firstArg="arg1"
secondArg="arg2"


→ main::parseFunctionArguments selfMock2 -- --arg1-- --arg2--
local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
parsingErrors=""
firstArg="--arg1--"
more=(
"--arg2--"
)


→ main::parseFunctionArguments selfMock2 arg1 arg2 --th
local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
parsingErrors="Found multiple matches for the option ⌜--th⌝, please be more specific:
CHI-CDECHI-CDECHItCDECHIhCDEis-is-option2
CHI-CDECHI-CDEwiCHItCDECHIhCDE-default
Use ⌜valet self mock2 --help⌝ to get help."
firstArg="arg1"
more=(
"arg2"
)

```

**Error** output:

```log
INFO     Fuzzy matching the option ⌜-what⌝ to ⌜--with-default⌝.
INFO     Fuzzy matching the option ⌜-this⌝ to ⌜--this-is-option2⌝.
```

## Test script 99.tests

### Testing main::getFunctionNameFromCommand

Exit code: `0`

**Standard** output:

```plaintext
→ main::getFunctionNameFromCommand 'self build'
selfBuild
```

### Testing main::fuzzyMatchCommandtoFunctionNameOrFail

Exit code: `0`

**Standard** output:

```plaintext
→ main::fuzzyMatchCommandtoFunctionNameOrFail 'se bu other stuff dont care'
selfBuild
2
self build

→ VALET_CONFIG_STRICT_MATCHING=true main::fuzzyMatchCommandtoFunctionNameOrFail 'se bu other stuff dont care'
Failed as expected because strict mode is activated

→ main::fuzzyMatchCommandtoFunctionNameOrFail 'sf' 'nop' 'other' 'stuff' 'dont care'
Failed as expected on ambiguous result
```

**Error** output:

```log
INFO     Fuzzy matching the command ⌜se bu⌝ to ⌜self build⌝.
ERROR    Could not find an exact command for ⌜se⌝, use ⌜--help⌝ to get a list of valid commands.
ERROR    Found multiple matches for the command ⌜sf⌝, please be more specific:
CHIsCDEelCHIfCDE build
CHIsCDEelCHIfCDE config
CHIsCDEelCHIfCDE export
CHIsCDEelCHIfCDE mock1
CHIsCDEelCHIfCDE mock2
CHIsCDEelCHIfCDE mock3
CHIsCDEelCHIfCDE mock4
CHIsCDEelCHIfCDE release
CHIsCDEelCHIfCDE setup
CHIsCDEelCHIfCDE test
CHIsCDEelCHIfCDE update
```

### Testing main::getMaxPossibleCommandLevel

Exit code: `0`

**Standard** output:

```plaintext
→ main::getMaxPossibleCommandLevel '1' '2' '3'
2

→ main::getMaxPossibleCommandLevel '1 2 3'
2

→ main::getMaxPossibleCommandLevel '1'
1

→ main::getMaxPossibleCommandLevel
0
```

### Testing main::fuzzyFindOption

Exit code: `0`

**Standard** output:

```plaintext
→ VALET_CONFIG_STRICT_MATCHING=true main::fuzzyFindOption de --opt1 --derp2 --allo3
Unknown option ⌜de⌝, did you mean ⌜--derp2⌝?


→ main::fuzzyFindOption de --opt1 --derp2 --allo3

--derp2

→ VALET_CONFIG_STRICT_MATCHING=true main::fuzzyFindOption -a --opt1 --derp2 --allo3
Unknown option ⌜-p⌝, valid matches are:
CHI-CDE-oCHIpCDEt1
CHI-CDE-derCHIpCDE2


→ main::fuzzyFindOption -a --opt1 --derp2 --allo3
Found multiple matches for the option ⌜-p⌝, please be more specific:
CHI-CDE-oCHIpCDEt1
CHI-CDE-derCHIpCDE2


→ main::fuzzyFindOption thing --opt1 --derp2 --allo3
Unknown option ⌜thing⌝, valid options are:
--opt1
--derp2
--allo3

```

**Error** output:

```log
INFO     Fuzzy matching the option ⌜de⌝ to ⌜--derp2⌝.
```

