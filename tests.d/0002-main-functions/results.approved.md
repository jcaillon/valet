# Test suite 0002-main-functions

## Test script 01.sort-commands

### Testing sortCommands without prior choices, the order of commands is kept

Exit code: 0

**Standard** output:

```plaintext
cm1  	This is command 1
cm2  	This is command 2
sub cmd1  	This is sub command 1
sub cmd2  	This is sub command 2
another3  	This is another command 3
```

### Testing sortCommands after choosing another3 then cm2

Exit code: 0

**Standard** output:

```plaintext
cm2  	This is command 2
another3  	This is another command 3
cm1  	This is command 1
sub cmd1  	This is sub command 1
sub cmd2  	This is sub command 2
```

### Testing sortCommands for another id, the order of commands should be the initial one

Exit code: 0

**Standard** output:

```plaintext
cm1  	This is command 1
cm2  	This is command 2
sub cmd1  	This is sub command 1
sub cmd2  	This is sub command 2
another3  	This is another command 3
```

### Testing addLastChoice after adding more than 20 commands, we only keep the last 20

Exit code: 0

**Standard** output:

```plaintext
Content of myid1-last-choice:
cm30
cm29
cm28
cm27
cm26
cm25
cm24
cm23
cm22
cm21
cm20
cm19
cm18
cm17
cm16
cm15
cm14
cm13
cm12
cm11

```

### Testing addLastChoice after adding the same command multiple times only keeps the last one

Exit code: 0

**Standard** output:

```plaintext
Content of myid1-last-choice:
another3
cm30
cm29
cm28
cm27
cm26
cm25
cm24
cm23
cm22
cm21
cm20
cm19
cm18
cm17
cm16
cm15
cm14
cm13
cm12


```

## Test script 02.arguments-parser

### Testing parseFunctionArguments

Exit code: 0

**Standard** output:

```plaintext
--- Testing with showcaseCommand1 and no arguments ---
local parsingErrors option1 thisIsOption2 help firstArg
local -a more
option1="${OPTION1:-}"
thisIsOption2="${THIS_IS_OPTION2:-}"
parsingErrors="Expecting ⌜2⌝ argument(s) but got ⌜0⌝."
more=(
)
--- Testing with showcaseCommand1 -o -2 optionValue2 arg1 more1 more2 ---
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
--- Testing with showcaseCommand1 -o -o2 optionValue2 arg1 ---
local parsingErrors option1 thisIsOption2 help firstArg
local -a more
parsingErrors="Expecting ⌜2⌝ argument(s) but got ⌜1⌝."
option1="true"
thisIsOption2="optionValue2"
firstArg="arg1"
more=(
)
--- Testing with showcaseCommand1 -unknown -what optionValue2 arg ---
local parsingErrors option1 thisIsOption2 help firstArg
local -a more
option1="${OPTION1:-}"
thisIsOption2="${THIS_IS_OPTION2:-}"
parsingErrors="Unknown option ⌜-unknown⌝.
Unknown option ⌜-what⌝."
firstArg="optionValue2"
more=(
"arg"
)
--- Testing with showcaseCommand1 arg more1 more2 -o ---
local parsingErrors option1 thisIsOption2 help firstArg
local -a more
option1="${OPTION1:-}"
thisIsOption2="${THIS_IS_OPTION2:-}"
parsingErrors="Option ⌜-o⌝ was given after the first argument, it should come before that."
firstArg="arg"
more=(
"more1"
"more2"
)
--- Testing with showcaseCommand1 -this arg more1 ---
local parsingErrors option1 thisIsOption2 help firstArg
local -a more
option1="${OPTION1:-}"
thisIsOption2="${THIS_IS_OPTION2:-}"
parsingErrors="Unknown option ⌜-this⌝ (did you mean ⌜--this-is-option2⌝?)."
firstArg="arg"
more=(
"more1"
)
--- Testing with showcaseCommand1 --this-is-option2 --option1 arg more1 ---
local parsingErrors option1 thisIsOption2 help firstArg
local -a more
option1="${OPTION1:-}"
parsingErrors=""
thisIsOption2="--option1"
firstArg="arg"
more=(
"more1"
)
```

## Test script 99.tests

### Testing getFunctionNameFromCommand

Exit code: 0

**Standard** output:

```plaintext
--- Testing with 'self build' ---
selfBuild
```

### Testing fuzzyMatchCommandtoFunctionName

Exit code: 0

**Standard** output:

```plaintext
--- Testing with 'e bu other stuff dont care' ---

--- Testing with 'sf nop other stuff dont care' ---

```

### Testing getMaxPossibleCommandLevel

Exit code: 0

**Standard** output:

```plaintext
--- Testing with '1' '2' '3' ---
2
--- Testing with '1 2 3' ---
2
--- Testing with '1' ---
1
--- Testing with '' ---
0
```

### Testing getMaxPossibleCommandLevel

Exit code: 0

**Standard** output:

```plaintext
--- Testing with '--opt1 --derp2 --allo3' 'de' ---
 (did you mean ⌜--derp2⌝?)
--- Testing with '--opt1 --derp2 --allo3' '-a' ---
 (did you mean ⌜--allo3⌝?)
--- Testing with '--opt1 --derp2 --allo3' 'thing' ---
 (did you mean ⌜--allo3⌝?)
```

