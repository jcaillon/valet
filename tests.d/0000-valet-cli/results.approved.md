# Test: 0000-valet-cli

## Testing error handling

Exit code: 0

**Error** output:

```log
WARNING  This is for testing valet core functions, the next statement will return 1 and create an error.
ERROR    Error code 1 in selfTestCore(), stack:
├─ In function selfTestCore() $VALET_HOME/valet.d/commands.d/self-test.sh:XXX
├─ In function runFunction() $VALET_HOME/valet.d/main:XXX
├─ In function parseMainArguments() $VALET_HOME/valet.d/main:XXX
└─ In function main() $VALET_HOME/valet:XXX
```

## Testing exit message --exit

Exit code: 5

**Error** output:

```log
WARNING  This is for testing valet core functions, exiting with code 5.
WARNING  This is a custom on exit function.
EXIT     Exiting with code 5.
```

## Testing fail function --fail

Exit code: 1

**Error** output:

```log
ERROR    This is for testing valet core functions, failing now.
```

## Testing unknown command handling

Exit code: 0

**Error** output:

```log
WARNING  This is for testing valet core functions, the next statement will call a non existing command, causing a call to command_not_found_handle.
ERROR    Command not found: ⌜thisIsAnUnknownCommandForTesting⌝.
Please check your ⌜PATH⌝ variable.
ERROR    Error code 1 in selfTestCore(), stack:
├─ In function selfTestCore() $VALET_HOME/valet.d/commands.d/self-test.sh:XXX
├─ In function runFunction() $VALET_HOME/valet.d/main:XXX
├─ In function parseMainArguments() $VALET_HOME/valet.d/main:XXX
└─ In function main() $VALET_HOME/valet:XXX
```

## Testing log level

Exit code: 0

**Error** output:

```log
---- level success with variable ----
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.
---- level warn with option ----
WARNING  This is a warning message.
With a second line.
---- level debug with verbose option ----
DEBUG    Log level set to debug.
DEBUG    Command found ⌜self test-core⌝.
DEBUG    Function name found ⌜selfTestCore⌝.
DEBUG    Loaded file ⌜$VALET_HOME/valet.d/commands.d/self-test.sh⌝.
DEBUG    Running the command ⌜self test-core⌝ with the function ⌜selfTestCore⌝ and the arguments ⌜--logging-level⌝.
DEBUG    Parsed arguments:
local parsingErrors autoApprove include exclude error fail exit unknownCommand createTempFiles createTempFiles loggingLevel waitIndefinitely showHelp help
autoApprove="${AUTO_APPROVE:-}"
include="${INCLUDE:-}"
exclude="${EXCLUDE:-}"
error="${ERROR:-}"
fail="${FAIL:-}"
exit="${EXIT:-}"
unknownCommand="${UNKNOWN_COMMAND:-}"
createTempFiles="${CREATE_TEMP_FILES:-}"
createTempFiles="${CREATE_TEMP_FILES:-}"
waitIndefinitely="${WAIT_INDEFINITELY:-}"
showHelp="${SHOW_HELP:-}"
parsingErrors=""
loggingLevel="true"

DEBUG    This is a debug message.
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.
The debug mode is activated!
DEBUG    Exiting with code 0 after Xs.
```

## Testing log options

Exit code: 0

**Error** output:

```log
---- normal output ----
[1;30mHH:MM:SS [0;36mINFO     [0m This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you
                    live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. 
                    Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
[1;30mHH:MM:SS [0;32mSUCCESS  [0m This is a success message.
[1;30mHH:MM:SS [0;33mWARNING  [0m This is a warning message.
                    With a second line.
---- CI mode ----
YYYY:MM:DD_HH:MM:SS INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
YYYY:MM:DD_HH:MM:SS SUCCESS  This is a success message.
YYYY:MM:DD_HH:MM:SS WARNING  This is a warning message.
With a second line.
---- normal, no timestamp ----
[0;36mINFO     [0m This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, 
           you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself
           with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
[0;32mSUCCESS  [0m This is a success message.
[0;33mWARNING  [0m This is a warning message.
           With a second line.
---- normal, no icons ----
[1;30mHH:MM:SS [0;36mINFO    [0m This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you 
                  live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. 
                  Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
[1;30mHH:MM:SS [0;32mSUCCESS [0m This is a success message.
[1;30mHH:MM:SS [0;33mWARNING [0m This is a warning message.
                  With a second line.
---- normal, no wrap ----
[1;30mHH:MM:SS [0;36mINFO     [0m This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
[1;30mHH:MM:SS [0;32mSUCCESS  [0m This is a success message.
[1;30mHH:MM:SS [0;33mWARNING  [0m This is a warning message.
With a second line.
---- normal, wrapping at 80 ----
[1;30mHH:MM:SS [0;36mINFO     [0m This is an info message with a super long sentence. The 
                    value of life is not in its duration, but in its donation. 
                    You are not important because of how long you live, you are 
                    important because of how effective you live. Give a man a 
                    fish and you feed him for a day; teach a man to fish and you
                    feed him for a lifetime. Surround yourself with the best 
                    people you can find, delegate authority, and don't interfere
                    as long as the policy you've decided upon is being carried 
                    out.
[1;30mHH:MM:SS [0;32mSUCCESS  [0m This is a success message.
[1;30mHH:MM:SS [0;33mWARNING  [0m This is a warning message.
                    With a second line.
```

## Testing profiling for command and startup

Exit code: 0

**Standard** output:

```plaintext
OK, command profiling file is not empty.
OK, startup profiling file is not empty.
```

## Testing version option

Exit code: 0

**Standard** output:

```plaintext
OK, we got a version.
```

## Testing unknown option, corrected with fuzzy match

Exit code: 1

**Error** output:

```log
ERROR    Unknown option ⌜-prof⌝ (did you mean ⌜--profiling⌝?)).
```

## Testing temp files/directories creation, cleaning and custom cleanUp

Exit code: 0

**Error** output:

```log
INFO     Created temp file: /tmp/valet/f01.
INFO     Created temp file: /tmp/valet/f02.
INFO     Created temp directory: /tmp/valet/d01.
INFO     Created temp directory: /tmp/valet/d02.
DEBUG    Log level set to debug.
DEBUG    Exiting with code 0 after Xs.
DEBUG    Deleting temporary files.
WARNING  This is a custom clean up function.
```

## Testing with a non existing user directory

Exit code: 0

**Error** output:

```log
WARNING  The valet user directory ⌜/mnt/c/data/repo/github.com/jcaillon/valet/non-existing⌝ does not contain a built ⌜commands⌝ file.
         To get started with valet, you must build your command list using the ⌜valet self build⌝ command.
         Please check the help using ⌜valet self build --help⌝ for details.
         Now using the examples commands from ⌜/mnt/c/data/repo/github.com/jcaillon/valet/examples.d⌝.
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you 
         are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with 
         the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
         With a second line.
```

