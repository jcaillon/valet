# Test suite lib-command

## Test script 00.parser

### ✅ Testing command::parseFunctionArguments

Missing argument:

❯ `command::parseFunctionArguments selfMock2`

Returned variables:

```text
RETURNED_VALUE='local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
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
)'
```

ok

❯ `command::parseFunctionArguments selfMock2 -o -2 optionValue2 arg1 more1 more2`

Returned variables:

```text
RETURNED_VALUE='local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
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
)'
```

missing argument

❯ `command::parseFunctionArguments selfMock2 -o -2 optionValue2 arg1`

Returned variables:

```text
RETURNED_VALUE='local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
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
)'
```

unknown options

❯ `command::parseFunctionArguments selfMock2 --unknown --what optionValue2 arg`

**Error output**:

```text
INFO     Fuzzy matching the option ⌜--what⌝ to ⌜--with-default⌝.
```

Returned variables:

```text
RETURNED_VALUE='local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
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
)'
```

ok with the option at the end

❯ `command::parseFunctionArguments selfMock2 arg more1 more2 -o`

Returned variables:

```text
RETURNED_VALUE='local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
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
)'
```

fuzzy match the option --this

❯ `command::parseFunctionArguments selfMock2 --this arg more1`

**Error output**:

```text
INFO     Fuzzy matching the option ⌜--this⌝ to ⌜--this-is-option2⌝.
```

Returned variables:

```text
RETURNED_VALUE='local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
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
)'
```

ok, --option1 is interpreted as the value for --this-is-option2

❯ `command::parseFunctionArguments selfMock2 --this-is-option2 --option1 arg more1`

Returned variables:

```text
RETURNED_VALUE='local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
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
)'
```

ok only args

❯ `command::parseFunctionArguments selfMock4 arg1 arg2`

Returned variables:

```text
RETURNED_VALUE=''
```

ok with -- to separate options from args

❯ `command::parseFunctionArguments selfMock2 -- --arg1-- --arg2--`

Returned variables:

```text
RETURNED_VALUE='local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
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
)'
```

missing a value for the option 2

❯ `command::parseFunctionArguments selfMock2 arg1 arg2 --this-is-option2`

Returned variables:

```text
RETURNED_VALUE='local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
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
)'
```

ambiguous fuzzy match

❯ `command::parseFunctionArguments selfMock2 arg1 arg2 --th`

Returned variables:

```text
RETURNED_VALUE='local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
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
)'
```

ok single letter options grouped together

❯ `command::parseFunctionArguments selfMock2 -o3 allo1 allo2 allo3 allo4`

Returned variables:

```text
RETURNED_VALUE='local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
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
)'
```

ok single letter options, consume argument as option values

❯ `command::parseFunctionArguments selfMock2 -o243 allo1 allo2 allo3 allo4`

Returned variables:

```text
RETURNED_VALUE='local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
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
)'
```

ko, single letter options, invalid one

❯ `command::parseFunctionArguments selfMock2 -3ao allo1 allo2`

Returned variables:

```text
RETURNED_VALUE='local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
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
)'
```

ko, missing a value for the option 4

❯ `command::parseFunctionArguments selfMock2 arg1 arg2 -4`

Returned variables:

```text
RETURNED_VALUE='local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
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
)'
```

ko, missing multiple values in a group

❯ `command::parseFunctionArguments selfMock2 arg1 arg2 -4444`

Returned variables:

```text
RETURNED_VALUE='local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
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
)'
```

## Test script 01.command

### ✅ Testing main::getFunctionNameFromCommand

❯ `main::getFunctionNameFromCommand self\ build`

Returned variables:

```text
RETURNED_VALUE='selfBuild'
```

### ✅ Testing main::fuzzyMatchCommandToFunctionNameOrFail

Fuzzy match with single result:

❯ `main::fuzzyMatchCommandToFunctionNameOrFail se\ bu\ other\ stuff\ thing\ derp`

**Error output**:

```text
INFO     Fuzzy matching the command ⌜se bu⌝ to ⌜self build⌝.
```

Returned variables:

```text
RETURNED_VALUE='selfBuild'
RETURNED_VALUE2='2'
RETURNED_VALUE3='self build'
```

Fuzzy match by strict mode is enabled so it fails:

❯ `VALET_CONFIG_STRICT_MATCHING=true main::fuzzyMatchCommandToFunctionNameOrFail se\ bu\ other\ stuff\ stuff\ thing\ derp`

Exited with code: `1`

**Error output**:

```text
ERROR    Could not find an exact command for ⌜se⌝, use ⌜--help⌝ to get a list of valid commands.
```

Fuzzy match with ambiguous result:

❯ `main::fuzzyMatchCommandToFunctionNameOrFail sf nop other stuff stuff\ thing\ derp`

Exited with code: `1`

**Error output**:

```text
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
CHIsCDEelCHIfCDE release
CHIsCDEelCHIfCDE setup
CHIsCDEelCHIfCDE test
CHIsCDEelCHIfCDE uninstall
CHIsCDEelCHIfCDE update

```

### ✅ Testing main::getMaxPossibleCommandLevel

❯ `main::getMaxPossibleCommandLevel 1 2 3`

Returned variables:

```text
RETURNED_VALUE='2'
```

❯ `main::getMaxPossibleCommandLevel 1\ 2\ 3`

Returned variables:

```text
RETURNED_VALUE='2'
```

❯ `main::getMaxPossibleCommandLevel 1`

Returned variables:

```text
RETURNED_VALUE='1'
```

❯ `main::getMaxPossibleCommandLevel`

Returned variables:

```text
RETURNED_VALUE='0'
```

### ✅ Testing main::fuzzyFindOption

single match, strict mode is enabled

❯ `VALET_CONFIG_STRICT_MATCHING=true main::fuzzyFindOption de --opt1 --derp2 --allo3`

Returned variables:

```text
RETURNED_VALUE='Unknown option ⌜de⌝, did you mean ⌜--derp2⌝?'
RETURNED_VALUE2=''
```

single match, strict mode is disabled

❯ `main::fuzzyFindOption de --opt1 --derp2 --allo3`

**Error output**:

```text
INFO     Fuzzy matching the option ⌜de⌝ to ⌜--derp2⌝.
```

Returned variables:

```text
RETURNED_VALUE=''
RETURNED_VALUE2='--derp2'
```

multiple matches, strict mode is enabled

❯ `VALET_CONFIG_STRICT_MATCHING=true main::fuzzyFindOption -p --opt1 --derp2 --allo3`

Returned variables:

```text
RETURNED_VALUE='Unknown option ⌜-p⌝, valid matches are:
CHI-CDE-oCHIpCDEt1
CHI-CDE-derCHIpCDE2
'
RETURNED_VALUE2=''
```

multiple matches, strict mode is disabled

❯ `main::fuzzyFindOption -p --opt1 --derp2 --allo3`

Returned variables:

```text
RETURNED_VALUE='Found multiple matches for the option ⌜-p⌝, please be more specific:
CHI-CDE-oCHIpCDEt1
CHI-CDE-derCHIpCDE2
'
RETURNED_VALUE2=''
```

no match

❯ `main::fuzzyFindOption thing --opt1 --derp2 --allo3`

Returned variables:

```text
RETURNED_VALUE='Unknown option ⌜thing⌝, valid options are:
--opt1
--derp2
--allo3'
RETURNED_VALUE2=''
```

### ✅ Testing main::getSingleLetterOptions

❯ `main::getSingleLetterOptions -a --opt1 --derp2 -b --allo3 -c`

Returned variables:

```text
RETURNED_VALUE='Valid single letter options are: ⌜a⌝, ⌜b⌝, ⌜c⌝.'
```

### ✅ Testing main::getDisplayableFilteredArray

```text
ARRAY=(
[0]='banana'
[1]='apple'
[2]='orange'
[3]='grape'
[4]='ananas'
[5]='lemon'
)
```

❯ `main::getDisplayableFilteredArray ae ARRAY`

Returned variables:

```text
RETURNED_VALUE='bCHIaCDEnana
CHIaCDEpplCHIeCDE
orCHIaCDEngCHIeCDE
grCHIaCDEpCHIeCDE
CHIaCDEnanas
lemon
'
```

