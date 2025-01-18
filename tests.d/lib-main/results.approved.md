# Test suite lib-main

## Test script 01.sort-commands

### Testing main::sortCommands without prior choices, the order of commands is kept



Exit code: `0`

**Standard output**:

```text
→ main::sortCommands myid1 "${commands}"
cm1  This is command 1
cm2  This is command 2
sub cmd1  This is sub command 1
sub cmd2  This is sub command 2
another3  This is another command 3
```

### Testing main::sortCommands after choosing another3 then cm2



Exit code: `0`

**Standard output**:

```text
→ main::addLastChoice myid1 another3
→ main::addLastChoice myid1 cm2
→ main::sortCommands myid1 "${commands}"
cm2  This is command 2
another3  This is another command 3
cm1  This is command 1
sub cmd1  This is sub command 1
sub cmd2  This is sub command 2
```

### Testing main::sortCommands, with VALET_CONFIG_REMEMBER_LAST_CHOICES=0 the order does not change



Exit code: `0`

**Standard output**:

```text
→ VALET_CONFIG_REMEMBER_LAST_CHOICES=0 main::sortCommands myid1 "${commands}"
cm1  This is command 1
cm2  This is command 2
sub cmd1  This is sub command 1
sub cmd2  This is sub command 2
another3  This is another command 3
```

### Testing main::sortCommands for another id, the order of commands should be the initial one



Exit code: `0`

**Standard output**:

```text
→ main::sortCommands myid2 "${commands}"
cm1  This is command 1
cm2  This is command 2
sub cmd1  This is sub command 1
sub cmd2  This is sub command 2
another3  This is another command 3
```

### Testing main::addLastChoice after adding more than 5 commands, we only keep the last 5



Exit code: `0`

**Standard output**:

```text
Content of last-choices-myid1:
cm10
cm9
cm8
cm7
cm6

```

### Testing main::addLastChoice after adding the same command multiple times only keeps the last one



Exit code: `0`

**Standard output**:

```text
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

**Standard output**:

```text
# missing argument
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

# ok
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

# missing argument
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

# unknown options
→ main::parseFunctionArguments selfMock2 --unknown --what optionValue2 arg
local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
flag3="${VALET_FLAG3:-}"
help=""
parsingErrors="Unknown option ⌜--unknown⌝, valid options are:
-o --option1
-2 --this-is-option2
-3 --flag3
-4 --with-default
-h --help
Expecting ⌜2⌝ argument(s) but got ⌜1⌝.
Use ⌜valet self mock2 --help⌝ to get help.

Usage:
valet [global options] self mock2 [options] [--] <firstArg> <more...>"
withDefault="optionValue2"
firstArg="arg"
more=(
)

# ok with the option at the end
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

# fuzzy match the option --this
→ main::parseFunctionArguments selfMock2 --this arg more1
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

# ok, --option1 is interpreted as the value for --this-is-option2
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

# ok only args
→ main::parseFunctionArguments selfMock4 arg1 arg2
local parsingErrors help firstArg secondArg
help=""
parsingErrors=""
firstArg="arg1"
secondArg="arg2"


# ok with -- to separate options from args
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

# missing a value for the option 2
→ main::parseFunctionArguments selfMock2 arg1 arg2 --this-is-option2
local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
parsingErrors="Missing value for option ⌜thisIsOption2⌝.
Use ⌜valet self mock2 --help⌝ to get help."
firstArg="arg1"
more=(
"arg2"
)

# ambiguous fuzzy match
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

# ok single letter options grouped together
→ main::parseFunctionArguments selfMock2 -o3 allo1 allo2 allo3 allo4
local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
parsingErrors=""
option1="true"
flag3="true"
firstArg="allo1"
more=(
"allo2"
"allo3"
"allo4"
)

# ok single letter options, consume argument as option values
→ main::parseFunctionArguments selfMock2 -o243 allo1 allo2 allo3 allo4
local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
help=""
parsingErrors=""
option1="true"
thisIsOption2="allo1"
withDefault="allo2"
flag3="true"
firstArg="allo3"
more=(
"allo4"
)

# ko, single letter options, invalid one
→ main::parseFunctionArguments selfMock2 -3ao allo1 allo2
local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
parsingErrors="Unknown option letter ⌜a⌝ in group ⌜-3ao⌝. Valid single letter options are: ⌜o⌝, ⌜2⌝, ⌜3⌝, ⌜4⌝, ⌜h⌝.
Use ⌜valet self mock2 --help⌝ to get help."
flag3="true"
option1="true"
firstArg="allo1"
more=(
"allo2"
)

# ko, missing a value for the option 4
→ main::parseFunctionArguments selfMock2 arg1 arg2 -4
local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
flag3="${VALET_FLAG3:-}"
help=""
parsingErrors="Missing value for option ⌜withDefault⌝.
Use ⌜valet self mock2 --help⌝ to get help."
firstArg="arg1"
more=(
"arg2"
)

# ko, missing multiple values in a group
→ main::parseFunctionArguments selfMock2 arg1 arg2 -4444
local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
flag3="${VALET_FLAG3:-}"
help=""
parsingErrors="Missing value for option ⌜withDefault⌝.
Missing value for option ⌜withDefault⌝.
Missing value for option ⌜withDefault⌝.
Missing value for option ⌜withDefault⌝.
Use ⌜valet self mock2 --help⌝ to get help."
firstArg="arg1"
more=(
"arg2"
)

```

**Error output**:

```text
INFO     Fuzzy matching the option ⌜--what⌝ to ⌜--with-default⌝.
INFO     Fuzzy matching the option ⌜--this⌝ to ⌜--this-is-option2⌝.
```

## Test script 99.tests

### Testing main::getFunctionNameFromCommand



Exit code: `0`

**Standard output**:

```text
→ main::getFunctionNameFromCommand 'self build'
selfBuild
```

### Testing main::fuzzyMatchCommandToFunctionNameOrFail



Exit code: `0`

**Standard output**:

```text
→ main::fuzzyMatchCommandToFunctionNameOrFail 'se bu other stuff dont care'
selfBuild
2
self build

→ VALET_CONFIG_STRICT_MATCHING=true main::fuzzyMatchCommandToFunctionNameOrFail 'se bu other stuff dont care'
Failed as expected because strict mode is activated

→ main::fuzzyMatchCommandToFunctionNameOrFail 'sf' 'nop' 'other' 'stuff' 'dont care'
Failed as expected on ambiguous result
```

**Error output**:

```text
INFO     Fuzzy matching the command ⌜se bu⌝ to ⌜self build⌝.
ERROR    Could not find an exact command for ⌜se⌝, use ⌜--help⌝ to get a list of valid commands.
ERROR    Found multiple matches for the command ⌜sf⌝, please be more specific:
CHIsCDEelCHIfCDE add-command
CHIsCDEelCHIfCDE add-library
CHIsCDEelCHIfCDE build
CHIsCDEelCHIfCDE config
CHIsCDEelCHIfCDE document
CHIsCDEelCHIfCDE export
CHIsCDEelCHIfCDE extend
CHIsCDEelCHIfCDE mock1
CHIsCDEelCHIfCDE mock2
CHIsCDEelCHIfCDE mock3
CHIsCDEelCHIfCDE mock4
CHIsCDEelCHIfCDE release
CHIsCDEelCHIfCDE setup
CHIsCDEelCHIfCDE test
CHIsCDEelCHIfCDE uninstall
CHIsCDEelCHIfCDE update

```

### Testing main::getMaxPossibleCommandLevel



Exit code: `0`

**Standard output**:

```text
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

**Standard output**:

```text
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

**Error output**:

```text
INFO     Fuzzy matching the option ⌜de⌝ to ⌜--derp2⌝.
```

### Testing main::getSingleLetterOptions



Exit code: `0`

**Standard output**:

```text
→ main::getSingleLetterOptions -a --opt1 --derp2 -b --allo3 -c
Valid single letter options are: ⌜a⌝, ⌜b⌝, ⌜c⌝.
```

### Testing main::getDisplayableFilteredArray



Exit code: `0`

**Standard output**:

```text
→ main::getDisplayableFilteredArray ae ARRAY
bCHIaCDEnana
CHIaCDEpplCHIeCDE
orCHIaCDEngCHIeCDE
grCHIaCDEpCHIeCDE
CHIaCDEnanas
lemon

```

