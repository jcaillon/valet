# Test suite cli-commands

## Test script 01.commands

### ✅ Testing that we correctly parse arguments and options and fail if they don't match

❯ `command::parseProgramArguments self mock1 non-existing-option nonNeededArg1 -derp anotherArg`

Exited with code: `1`

**Error output**:

```text
FAIL     Expecting 1 argument(s), got extra argument ⌜nonNeededArg1⌝.
Unknown option letter ⌜d⌝ in group ⌜-derp⌝. Valid single letter options are: ⌜h⌝.
Unknown option letter ⌜e⌝ in group ⌜-derp⌝. Valid single letter options are: ⌜h⌝.
Unknown option letter ⌜r⌝ in group ⌜-derp⌝. Valid single letter options are: ⌜h⌝.
Unknown option letter ⌜p⌝ in group ⌜-derp⌝. Valid single letter options are: ⌜h⌝.
Expecting 1 argument(s), got extra argument ⌜anotherArg⌝.
Use ⌜valet self mock1 --help⌝ to get help.

Usage:
valet [global options] self mock1 [options] [--] <action>
```

### ✅ Testing that a command with sudo ask for sudo privileges

❯ `command::parseProgramArguments self mock3`

**Error output**:

```text
INFO     This command requires sudo privileges.
🙈 mocking sudo printf %s alright
🙈 mocking sudo whoami
```

### ✅ Testing that valet can be called without any arguments and show the menu

❯ `command::parseProgramArguments`

**Error output**:

```text
🙈 mocking command_showInteractiveCommandsMenu:
declare -- menuHeader="Please select the command to run."
declare -n array="_COPIED_COMMANDS_ARRAY"
```

### ✅ Testing that we go into the interactive sub menu with no arguments

❯ `command::parseProgramArguments self`

**Error output**:

```text
🙈 mocking command_showInteractiveCommandsMenu:
declare -- menuHeader="Please select the command to run."
declare -n array="FILTERED_COMMANDS_FOR_SUB_MENU"
```

### ✅ Testing that we can display the help of a sub menu

❯ `command::parseProgramArguments self -h
`

**Standard output**:

```text
ABOUT

  Show a menu with sub commands for the current command.

USAGE

  valet [global options] self [options] [command]

GLOBAL OPTIONS

```

### ✅ Testing that we catch option errors of a sub menu

❯ `command::parseProgramArguments self --unknown`

Exited with code: `1`

**Error output**:

```text
FAIL     Unknown option ⌜--unknown⌝, valid options are:
-h --help
Use ⌜valet self --help⌝ to get help.
```

