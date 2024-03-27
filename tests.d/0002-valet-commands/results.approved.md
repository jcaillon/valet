# Test: 0002-valet-commands

## Testing help for the showcase hello-world command

Exit code: 0

**Standard** output:

```plaintext
ABOUT

  An hello world command.

USAGE

  valet showcase hello-world [options]

OPTIONS

  -h, --help
      Display the help for this command


```

## Testing to fuzzy find command

Exit code: 0

**Standard** output:

```plaintext
ABOUT

  An hello world command.

USAGE

  valet showcase hello-world [options]

OPTIONS

  -h, --help
      Display the help for this command


```

**Error** output:

```log
INFO     Fuzzy matching the command ⌜h s⌝ to ⌜help⌝.
INFO     Fuzzy matching the command ⌜s h⌝ to ⌜showcase hello-world⌝.
```

## Testing help with columns 60

Exit code: 0

**Standard** output:

```plaintext
------------------------------------------------------------
ABOUT

  Show the help this program or of the help of a specific 
  command.
  
  You can show the help with or without colors and set the 
  maximum columns for the help text.

USAGE

  valet help [options] <commands...>

OPTIONS

  -nc, --no-colors
      Do not use any colors in the output
      This option can be set by exporting the variable 
      VALET_NO_COLORS="true".
  -c, --columns <number>
      Set the maximum columns for the help text
      This option can be set by exporting the variable 
      VALET_COLUMNS="<number>".
  -h, --help
      Display the help for this command

ARGUMENTS

  commands...
      The name of the command to show the help for.
      If not provided, show the help for the program.

EXAMPLES

  help ⌟cmd⌞
      Shows the help for the command ⌜cmd⌝
  help ⌟cmd⌞ ⌟subCmd⌞
      Shows the help for the sub command ⌜subCmd⌝ of the 
      command ⌜cmd⌝
  help --no-colors --columns 50
      Shows the help for the program without any color and 
      with a maximum of 50 columns


```

## Testing that we catch option errors

Exit code: 1

**Error** output:

```log
ERROR    Unknown option ⌜--unknown⌝.
Unknown option ⌜-colo⌝ (did you mean ⌜--no-colors⌝?).
Use valet help --help to get help.
```

## Testing that no arguments show the valet help

Exit code: 0

**Standard** output:

```plaintext
ABOUT

  Valet is wrapper around a collection of commands that help you with your daily tasks.
  
  You can call valet without any commands to start an interactive session.
  
  ⌜Exit codes:⌝
  - 0: everything went well
  - 1: an error occured
  
  ⌜Create your own commands:⌝
  You can create your own commands and have them available in valet, please check the README.md or the examples under 
  examples.d to do so.
  Valet looks for commands in the valet user directory, which default to ~/.valet.d and can be overwritten using an 
  environment variable (see below).
  Once you have created your new command script, run the ⌜valet self build⌝ command to update the valet menu.
  
  ⌜Configuration through environment variables:⌝
  In addition to the environment variables defined for each options, you can define the following environment variables 
  to configure valet:
  - VALET_USER_DIRECTORY="my/path": set the path to the valet user directory (in which to find user commands).
  - VALET_NO_COLOR="true": will disable the color output for logs and help.
  - VALET_NO_WRAP="true": will disable the text wrapping for logs.
  - VALET_NO_ICON="true": will disable the icons for logs and help.
  - VALET_NO_TIMESTAMP="true": will disable the timestamp for logs.
  - VALET_CI_MODE="true": will simplify the log output for CI/CD environments (or slow systems), will display the logs 
  without colors, without wrapping lines and with the full date.
  - VALET_OPTIONS_INTERACTIVE_MODE="true": will enter interactive mode for command options (default is to only ask for 
  arguments).
  
  ⌜Developer notes:⌝
  You can enable debug mode with profiling for valet by setting the environment variable VALET_STARTUP_PROFILING to true
  (it will output to ~/profile_valet.txt).

USAGE

  valet [options] <command> <commands...>

OPTIONS

  -x, --profiling
      Turn on profiling (with debug mode) before running the required command.
      It will output to ~/profile_valet_cmd.txt.
      This is useful to debug your command and understand what takes a long time to execute.
      This option can be set by exporting the variable VALET_PROFILING="true".
  -ll, -log, --log-level <level>
      Set the log level of valet (defaults to info).
      Possible values are: debug, info, warn, error, fatal.
      This option can be set by exporting the variable VALET_LOG_LEVEL="<level>".
  -v, --verbose
      Output verbose information.
      This is the equivalent of setting the log level to debug.
      This option can be set by exporting the variable VALET_VERBOSE="true".
  --version
      Display the current version of valet.
      This option can be set by exporting the variable VALET_VERSION="true".
  -h, --help
      Display the help for this command

ARGUMENTS

  commands...
      The command or sub commands to execute.
      See the commands section for more information.

COMMANDS

  self build
      Re-build the menu of valet from your commands.
  showcase hello-world
      An hello world command
  self
      Show the valet self-maintenance sub menu.
  self test-commands
      Test your valet custom commands.
  self test-core
      Test valet core features.
  self update
      Test valet core features.
  help
      Show the help this program or of a specific command
  showcase command1
      A showcase command that uses arguments and options.
  showcase
      Show the showcase sub menu.

EXAMPLES

  --help
      Displays this help text.
  -v a-command and-sub-command
      Active ⌜verbose⌝ mode and run the command ⌜a-command⌝ with the sub command ⌜and-sub-command⌝.


```

