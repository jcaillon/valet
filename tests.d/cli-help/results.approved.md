# Test suite cli-help

## Test script 01.command-help

### ✅ Get help for self mock3 using fuzzy matching

❯ `main::parseMainArguments hel sel mo3`

**Standard output**:

```text
ABOUT

  Before starting this command, valet will check if sudo is available.
  
  If so, it will require the user to enter the sudo password and use sudo inside the command

USAGE

  valet [global options] self mock3 [options]

```

**Error output**:

```text
INFO     Fuzzy matching the command ⌜hel⌝ to ⌜help⌝.
INFO     Fuzzy matching the command ⌜sel mo3⌝ to ⌜self mock3⌝.
```

### ✅ Testing help with columns 48

❯ `main::parseMainArguments help --columns 48 help`

**Standard output**:

```text
ABOUT

  Show the help of this program or of the help 
  of a specific command.
  
  You can show the help with or without colors 
  and set the maximum columns for the help text.

USAGE

```

### ✅ Testing that no arguments show the valet help

❯ `main::parseMainArguments help`

**Standard output**:

```text
ABOUT

  Valet helps you browse, understand and execute your custom bash commands.
  
  Online documentation is available at https://jcaillon.github.io/valet/.
  
  You can call valet without any commands to start an interactive session.
  
  ⌜Exit codes:⌝
  
```

### ✅ Testing that we can display the help of a function using command::showHelp

❯ `valet self mock1 show-help`

**Standard output**:

```text
ABOUT

  A command that only for testing valet core functions.

USAGE

  valet [global options] self mock1 [options] [--] <action>

GLOBAL OPTIONS

```

