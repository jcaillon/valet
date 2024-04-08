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
local parsingErrors option1 thisIsOption2 help firstArg
local -a more
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
parsingErrors="Expecting ⌜2⌝ argument(s) but got ⌜0⌝."
more=(
)

→ main::parseFunctionArguments selfMock2 -o -2 optionValue2 arg1 more1 more2
local parsingErrors option1 thisIsOption2 help firstArg
local -a more
parsingErrors=""
option1="true"
thisIsOption2="optionValue2"
firstArg="arg1"
more=(
"more1"
"more2"
)

→ main::parseFunctionArguments selfMock2 -o -2 optionValue2 arg1
local parsingErrors option1 thisIsOption2 help firstArg
local -a more
parsingErrors="Expecting ⌜2⌝ argument(s) but got ⌜1⌝."
option1="true"
thisIsOption2="optionValue2"
firstArg="arg1"
more=(
)

→ main::parseFunctionArguments selfMock2 -unknown -what optionValue2 arg
local parsingErrors option1 thisIsOption2 help firstArg
local -a more
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
parsingErrors="Unknown option ⌜-unknown⌝.
Unknown option ⌜-what⌝."
firstArg="optionValue2"
more=(
"arg"
)

→ main::parseFunctionArguments selfMock2 arg more1 more2 -o
local parsingErrors option1 thisIsOption2 help firstArg
local -a more
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
parsingErrors="Option ⌜-o⌝ was given after the first argument, it should come before that."
firstArg="arg"
more=(
"more1"
"more2"
)

→ main::parseFunctionArguments selfMock2 -this arg more1
local parsingErrors option1 thisIsOption2 help firstArg
local -a more
thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
parsingErrors="Unknown option ⌜-this⌝ (did you mean ⌜--this-is-option2⌝?)."
firstArg="arg"
more=(
"more1"
)

→ main::parseFunctionArguments selfMock2 --this-is-option2 --option1 arg more1
local parsingErrors option1 thisIsOption2 help firstArg
local -a more
parsingErrors=""
thisIsOption2="--option1"
firstArg="arg"
more=(
"more1"
)
```

## Test script 99.tests

### Testing main::getFunctionNameFromCommand

Exit code: `0`

**Standard** output:

```plaintext
→ main::getFunctionNameFromCommand 'self build'
selfBuild
```

### Testing main::fuzzyMatchCommandtoFunctionName

Exit code: `0`

**Standard** output:

```plaintext
→ main::fuzzyMatchCommandtoFunctionName 'se bu other stuff dont care'
selfBuild
2
self build

→ main::fuzzyMatchCommandtoFunctionName 'sf' 'nop' 'other' 'stuff' 'dont care'
_menu
1
self
```

**Error** output:

```log
INFO     Fuzzy matching the command ⌜se bu⌝ to ⌜self build⌝.
INFO     Fuzzy matching the command ⌜sf⌝ to ⌜self⌝.
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
→ main::fuzzyFindOption '--opt1 --derp2 --allo3' 'de'
 (did you mean ⌜--derp2⌝?)

→ main::fuzzyFindOption '--opt1 --derp2 --allo3' '-a'
 (did you mean ⌜--allo3⌝?)

→ main::fuzzyFindOption '--opt1 --derp2 --allo3' 'thing'

```
