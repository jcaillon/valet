# Test suite cli-help

## Test script 01.command-help

### ✅ Get help for self mock3 using fuzzy matching

❯ `command::parseProgramArguments hel sel mo3`

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

❯ `command::parseProgramArguments help --columns 48 help`

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

❯ `command::parseProgramArguments help`

**Standard output**:

```text
ABOUT

  Valet helps you browse, understand and execute your custom bash commands.
  
  Online documentation is available at https://jcaillon.github.io/valet/.
  
  You can call valet without any commands to start an interactive session.
  
  ⌜Configuration through environment variables:⌝
  
```

### ✅ Testing that we can display the help of a function using command::showHelp

❯ `valet self mock1 show-help`

**Standard output**:

```text
[31mABOUT[0m

  A command that only for testing valet core functions.

[31mUSAGE[0m

  valet [94m[global options][0m self mock1 [94m[options][0m [--] [96m<action>[0m

[31mGLOBAL OPTIONS[0m

```

