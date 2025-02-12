# Test suite lib-command

## Test script 00.parser

### ✅ Testing command::parseFunctionArguments

Missing argument:

❯ `command::parseFunctionArguments selfMock2`

Returned variables:

```text
RETURNED_VALUE='local commandArgumentsErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
commandArgumentsErrors="Expecting ⌜2⌝ argument(s) but got ⌜0⌝.
Use ⌜valet self mock2 --help⌝ to get help.

Usage:
valet [global options] self mock2 [options] [--] <first-arg> <more...>"
more=(
)'
```

ok

❯ `command::parseFunctionArguments selfMock2 -o -2 optionValue2 arg1 more1 more2`

Returned variables:

```text
RETURNED_VALUE='local commandArgumentsErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
commandArgumentsErrors=""
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
RETURNED_VALUE='local commandArgumentsErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
commandArgumentsErrors="Expecting ⌜2⌝ argument(s) but got ⌜1⌝.
Use ⌜valet self mock2 --help⌝ to get help.

Usage:
valet [global options] self mock2 [options] [--] <first-arg> <more...>"
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
RETURNED_VALUE='local commandArgumentsErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
flag3="${VALET_FLAG3:-}"
help=""
commandArgumentsErrors="Unknown option ⌜--unknown⌝, valid options are:
-o --option1
-2 --this-is-option2
-3 --flag3
-4 --with-default
-h --help
Expecting ⌜2⌝ argument(s) but got ⌜1⌝.
Use ⌜valet self mock2 --help⌝ to get help.

Usage:
valet [global options] self mock2 [options] [--] <first-arg> <more...>"
withDefault="optionValue2"
firstArg="arg"
more=(
)'
```

ok with the option at the end

❯ `command::parseFunctionArguments selfMock2 arg more1 more2 -o`

Returned variables:

```text
RETURNED_VALUE='local commandArgumentsErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
commandArgumentsErrors=""
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
RETURNED_VALUE='local commandArgumentsErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
commandArgumentsErrors="Expecting ⌜2⌝ argument(s) but got ⌜1⌝.
Use ⌜valet self mock2 --help⌝ to get help.

Usage:
valet [global options] self mock2 [options] [--] <first-arg> <more...>"
thisIsOption2="arg"
firstArg="more1"
more=(
)'
```

ok, --option1 is interpreted as the value for --this-is-option2

❯ `command::parseFunctionArguments selfMock2 --this-is-option2 --option1 arg more1`

Returned variables:

```text
RETURNED_VALUE='local commandArgumentsErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
commandArgumentsErrors=""
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
RETURNED_VALUE='local commandArgumentsErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
commandArgumentsErrors=""
firstArg="--arg1--"
more=(
"--arg2--"
)'
```

missing a value for the option 2

❯ `command::parseFunctionArguments selfMock2 arg1 arg2 --this-is-option2`

Returned variables:

```text
RETURNED_VALUE='local commandArgumentsErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
commandArgumentsErrors="Missing value for option ⌜thisIsOption2⌝.
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
RETURNED_VALUE='local commandArgumentsErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
flag3="${VALET_FLAG3:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
commandArgumentsErrors="Found multiple matches for the option ⌜--th⌝, please be more specific:
[95m-[0m[95m-[0m[95mt[0m[95mh[0mis-is-option2
[95m-[0m[95m-[0mwi[95mt[0m[95mh[0m-default

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
RETURNED_VALUE='local commandArgumentsErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
commandArgumentsErrors=""
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
RETURNED_VALUE='local commandArgumentsErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
help=""
commandArgumentsErrors=""
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
RETURNED_VALUE='local commandArgumentsErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
withDefault="${VALET_WITH_DEFAULT:-"cool"}"
help=""
commandArgumentsErrors="Unknown option letter ⌜a⌝ in group ⌜-3ao⌝. Valid single letter options are: ⌜o⌝, ⌜2⌝, ⌜3⌝, ⌜4⌝, ⌜h⌝.
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
RETURNED_VALUE='local commandArgumentsErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
flag3="${VALET_FLAG3:-}"
help=""
commandArgumentsErrors="Missing value for option ⌜withDefault⌝.
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
RETURNED_VALUE='local commandArgumentsErrors option1 thisIsOption2 flag3 withDefault help firstArg
local -a more
option1=""
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
flag3="${VALET_FLAG3:-}"
help=""
commandArgumentsErrors="Missing value for option ⌜withDefault⌝.
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
[95ms[0mel[95mf[0m add-command
[95ms[0mel[95mf[0m add-library
[95ms[0mel[95mf[0m build
[95ms[0mel[95mf[0m config
[95ms[0mel[95mf[0m document
[95ms[0mel[95mf[0m export
[95ms[0mel[95mf[0m extend
[95ms[0mel[95mf[0m mock1
[95ms[0mel[95mf[0m mock2
[95ms[0mel[95mf[0m mock3
[95ms[0mel[95mf[0m release
[95ms[0mel[95mf[0m setup
[95ms[0mel[95mf[0m test
[95ms[0mel[95mf[0m uninstall
[95ms[0mel[95mf[0m update

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
[95m-[0m-o[95mp[0mt1
[95m-[0m-der[95mp[0m2
'
RETURNED_VALUE2=''
```

multiple matches, strict mode is disabled

❯ `main::fuzzyFindOption -p --opt1 --derp2 --allo3`

Returned variables:

```text
RETURNED_VALUE='Found multiple matches for the option ⌜-p⌝, please be more specific:
[95m-[0m-o[95mp[0mt1
[95m-[0m-der[95mp[0m2
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

❯ `MY_CHARS=ae main::getDisplayableFilteredArray ARRAY MY_CHARS`

Returned variables:

```text
RETURNED_VALUE='b[95ma[0mnana
[95ma[0mppl[95me[0m
or[95ma[0mng[95me[0m
gr[95ma[0mp[95me[0m
[95ma[0mnanas
lemon
'
```

