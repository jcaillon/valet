# Test suite 0000-valet-cli

## Test script 01.command-help

### Testing help for the showcase hello-world command

Exit code: 0

**Standard** output:

```plaintext
→ valet help showcase hello-world
ABOUT

  An hello world command.

USAGE

  valet showcase hello-world [options]

OPTIONS

  -h, --help
      Display the help for this command


```

### Testing to fuzzy find an help

Exit code: 0

**Standard** output:

```plaintext
→ valet hel s h
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
INFO     Fuzzy matching the command ⌜hel⌝ to ⌜help⌝.
INFO     Fuzzy matching the command ⌜s h⌝ to ⌜showcase hello-world⌝.
```

### Testing help with columns 60

Exit code: 0

**Standard** output:

```plaintext
→ valet help --columns 60 help
ABOUT

  Show the help this program or of the help of a specific 
  command.
  
  You can show the help with or without colors and set the 
  maximum columns for the help text.

USAGE

  valet help [options] [commands...]

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

  commands?...
      The name of the command to show the help for.
      If not provided, show the help for the program.

EXAMPLES

  help cmd
      Shows the help for the command ⌜cmd⌝
  help cmd subCmd
      Shows the help for the sub command ⌜subCmd⌝ of the 
      command ⌜cmd⌝
  help --no-colors --columns 50
      Shows the help for the program without any color and 
      with a maximum of 50 columns


```

### Testing that we catch option errors in help

Exit code: 1

**Standard** output:

```plaintext
→ valet help --unknown -colo
```

**Error** output:

```log
ERROR    Unknown option ⌜--unknown⌝.
Unknown option ⌜-colo⌝ (did you mean ⌜--no-colors⌝?).
Use valet help --help to get help.
```

### Testing that no arguments show the valet help

Exit code: 0

**Standard** output:

```plaintext
→ valet help
ABOUT

  Valet helps you browse, understand and execute your custom bash commands.
  
  Online documentation is available at https://github.com/jcaillon/valet.
  
  You can call valet without any commands to start an interactive session.
  
  ⌜Exit codes:⌝
  
  - 0: everything went well
  - 1+: an error occured
  
  ⌜Create your own commands:⌝
  You can create your own commands and have them available in valet, please check https://github.com/jcaillon/valet/blob/main/docs/create-new-command.md or the examples under 
  examples.d to do so.
  Valet looks for commands in the valet user directory, which default to ~/.valet.d and can be overwritten using an environment variable (see below).
  Once you have created your new command script, run the ⌜valet self build⌝ command to update the valet menu.
  
  ⌜Configuration through environment variables:⌝
  
  In addition to the environment variables defined for each options, you can define the following environment variables to configure valet:
  
  - VALET_USER_DIRECTORY="my/path": set the path to the valet user directory (in which to find user commands).
  - VALET_NO_COLOR="true": will disable the color output for logs and help.
  - VALET_COLOR_XXX="color": will set the colors for the logs and the help, XXX can be one of these: DEFAULT, TITLE, OPTION, ARGUMENT, COMMAND, DEBUG, INFO, WARNING, SUCCESS, 
  ERROR, TIMESTAMP, HIGHLIGHT.
  - VALET_NO_WRAP="true": will disable the text wrapping for logs.
  - VALET_NO_ICON="true": will disable the icons for logs and help.
  - VALET_NO_TIMESTAMP="true": will disable the timestamp for logs.
  - VALET_LOG_COLUMNS="120": the number of columns at which to wrap the logs (if wrap is enabled); defaults to the terminal width.
  - VALET_CI_MODE="true": will simplify the log output for CI/CD environments (or slow systems), will display the logs without colors, without wrapping lines and with the full 
  date.
  - VALET_REMEMBER_LAST_CHOICES="3": number of last choices to remember when selecting an item from a menu. Set to 0 to disable this feature and always display items in the 
  alphabetical order.
  - VALET_DO_NOT_USE_LOCAL_BIN="false": if true, valet will use the executable from the PATH even if they exist in the valet bin/ directory.
  
  These variables can be exported in your .bashrc file.
  Alternatively, you can define them in your valet user config file, located by default at ~/.config/valet/config. This path can be configured using the VALET_USER_CONFIG_FILE 
  environment variable.
  
  ⌜Developer notes:⌝
  
  You can enable debug mode with profiling for valet by setting the environment variable VALET_STARTUP_PROFILING to true (it will output to ~/profile_valet.txt).

USAGE

  valet [options] [command]

OPTIONS

  -x, --profiling
      Turn on profiling (with debug mode) before running the required command.
      It will output to ~/profile_valet_cmd.txt.
      This is useful to debug your command and understand what takes a long time to execute.
      This option can be set by exporting the variable VALET_PROFILING="true".
  -ll, -log, --log-level <level>
      Set the log level of valet (defaults to info).
      Possible values are: debug, success, info, success, warning, error.
      This option can be set by exporting the variable VALET_LOG_LEVEL="<level>".
  -v, --verbose
      Output verbose information.
      This is the equivalent of setting the log level to debug.
      This option can be set by exporting the variable VALET_VERBOSE="true".
  -i, --force-interactive-mode
      Enter interactive mode for commands even if arguments are not required or provided.
      This option can be set by exporting the variable VALET_FORCE_INTERACTIVE_MODE="true".
  --version
      Display the current version of valet.
  -h, --help
      Display the help for this command

COMMANDS

  showcase hello-world
      An hello world command
  self build
      Re-build the menu of valet from your commands.
  self download-binaries
      Download the required binaries for valet.
  self
      Show the valet self-maintenance sub menu.
  self release
      Release a new version of valet.
  self test
      Test your valet custom commands.
  self test-core
      Test valet core features.
  self update
      Update valet using the latest release on GitHub.
  showcase sudo-command
      A command that requires sudo
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

### Testing that we can display the help of a function using showHelp

Exit code: 0

**Standard** output:

```plaintext
→ valet self test-core --show-help
ABOUT

  Test valet core features using approval tests approach.

USAGE

  valet self test-core [options]

OPTIONS

  -a, --auto-approve
      The received test result files will automatically be approved.
      This option can be set by exporting the variable VALET_AUTO_APPROVE="true".
  -i, --include <pattern>
      A regex pattern to include only the test suites that match the pattern.
      
      The name of the test suite is given by the name of the directory containing the .sh test files.
      
      Example: --include '(1|commands)'
      This option can be set by exporting the variable VALET_INCLUDE="<pattern>".
  -e, --exclude <pattern>
      A regex pattern to exclude all the test suites that match the pattern.
      
      The name of the test suite is given by the name of the directory containing the .sh test files.
      
      Example: --exclude '(1|commands)'
      This option can be set by exporting the variable VALET_EXCLUDE="<pattern>".
  --error
      Test the error handling.
  --fail
      Test the fail.
  --exit
      Test the exit code.
  --unknown-command
      Test with an unknown command.
  --create-temp-files
      Test to create temp file and directory.
  --create-temp-files
      Test to create temp file and directory.
  --logging-level
      Test to output all log level messages.
  --wait-indefinitely
      Test to wait indefinitely.
  --show-help
      Test to show the help of the function.
      This option can be set by exporting the variable VALET_SHOW_HELP="true".
  -h, --help
      Display the help for this command


```

## Test script 02.command-misc

### Testing that we correctly parse arguments and options and fail if they don't match

Exit code: 1

**Standard** output:

```plaintext
→ valet self test-core --non-existing-option nonNeededArg1 -derp anotherArg
```

**Error** output:

```log
ERROR    Unknown option ⌜--non-existing-option⌝.
Expecting 0 argument(s), got extra argument ⌜nonNeededArg1⌝.
Unknown option ⌜-derp⌝.
Expecting 0 argument(s), got extra argument ⌜anotherArg⌝.
Use valet self test-core --help to get help.
```

### Testing that a command with sudo ask for sudo privileges

Exit code: 0

**Standard** output:

```plaintext
→ valet showcase sudo-command
```

**Error** output:

```log
INFO     This command requires sudo privileges.
▶ called sudo echo alright
▶ called sudo whoami
```

## Test script 03.event-handlers

### Testing error handling

Exit code: 0

**Standard** output:

```plaintext
→ valet self test-core --error
```

**Error** output:

```log
WARNING  This is for testing valet core functions, the next statement will return 1 and create an error.
ERROR    Error code 1 in selfTestCore(), stack:
├─ In function selfTestCore() $VALET_HOME/valet.d/commands.d/self-test.sh:XXX
├─ In function runFunction() $VALET_HOME/valet.d/main:XXX
├─ In function parseMainArguments() $VALET_HOME/valet.d/main:XXX
└─ In function main() $VALET_HOME/valet:XXX
```

### Testing exit message and custom onExit function

Exit code: 0

**Standard** output:

```plaintext
→ valet self test-core --exit
```

**Error** output:

```log
WARNING  This is for testing valet core functions, exiting with code 5.
WARNING  This is a custom on exit function.
EXIT     Exiting with code 5, stack:
├─ In function selfTestCore() $VALET_HOME/valet.d/commands.d/self-test.sh:XXX
├─ In function runFunction() $VALET_HOME/valet.d/main:XXX
├─ In function parseMainArguments() $VALET_HOME/valet.d/main:XXX
└─ In function main() $VALET_HOME/valet:XXX
```

### Testing fail function

Exit code: 1

**Standard** output:

```plaintext
→ valet self test-core --fail
```

**Error** output:

```log
ERROR    This is for testing valet core functions, failing now.
```

### Testing unknown command handling

Exit code: 0

**Standard** output:

```plaintext
→ valet self test-core --unknown-command
```

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

## Test script 04.interactive-mode

### Testing showInteractiveCommandsMenu, should return the last line of the input stream

Exit code: 0

**Standard** output:

```plaintext
→ showInteractiveCommandsMenu "ReturnLast My header
2 lines" "cm1  	This is command 1
cm2  	This is command 2
sub cmd1  	This is sub command 1
sub cmd2  	This is sub command 2
another3  	This is another command 3"

```

**Error** output:

```log
▶ called fzf --tiebreak=begin,index --no-multi --cycle --layout=reverse --info=default --margin=0 --padding=0 --header-lines=2 --preview-window=right:4989:wrap --preview=echo {} | cut -d$'\t' -f1 | sed -e 's/[[:space:]]*$//' | xargs -P1 -I{} '$VALET_HOME/valet' --log-level fail help --columns 4987 {}
▶ fzf input stream was:
⌈ReturnLast My header
2 lines
cm1  	This is command 1
cm2  	This is command 2
sub cmd1  	This is sub command 1
sub cmd2  	This is sub command 2
another3  	This is another command 3⌉
```

### Testing that valet can be called without any arguments and show the menu

Exit code: 0

**Standard** output:

```plaintext
→ valet
```

**Error** output:

```log
▶ called fzf --tiebreak=begin,index --no-multi --cycle --layout=reverse --info=default --margin=0 --padding=0 --header-lines=3 --preview-window=right:4989:wrap --preview=echo {} | cut -d$'\t' -f1 | sed -e 's/[[:space:]]*$//' | xargs -P1 -I{} '$VALET_HOME/valet' --log-level fail help --columns 4987 {}
▶ fzf input stream was:
⌈Please select the command to run (filter by typing anything)

Command name            	Short description
help                    	Show the help this program or of a specific command
self build              	Re-build the menu of valet from your commands.
self download-binaries  	Download the required binaries for valet.
self release            	Release a new version of valet.
self                    	Show the valet self-maintenance sub menu.
self test-core          	Test valet core features.
self test               	Test your valet custom commands.
self update             	Update valet using the latest release on GitHub.
showcase command1       	A showcase command that uses arguments and options.
showcase hello-world    	An hello world command
showcase                	Show the showcase sub menu.
showcase sudo-command   	A command that requires sudo⌉
```

## Test script 05.logging

### Testing log with success level

Exit code: 0

**Standard** output:

```plaintext
→ VALET_LOG_LEVEL=success valet self test-core --logging-level
```

**Error** output:

```log
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.
```

### Testing log with warn level

Exit code: 0

**Standard** output:

```plaintext
→ valet --log-level warn self test-core --logging-level
```

**Error** output:

```log
WARNING  This is a warning message.
With a second line.
```

### Testing log with debug level

Exit code: 0

**Standard** output:

```plaintext
→ valet -v self test-core --logging-level
```

**Error** output:

```log
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Command found ⌜self test-core⌝.
DEBUG    Function name found ⌜selfTestCore⌝.
DEBUG    Loaded file ⌜$VALET_HOME/valet.d/commands.d/self-test.sh⌝.
DEBUG    Running the command ⌜self test-core⌝ with the function ⌜selfTestCore⌝ and the arguments ⌜--logging-level⌝.
DEBUG    Parsed arguments:
local parsingErrors autoApprove include exclude error fail exit unknownCommand createTempFiles createTempFiles loggingLevel waitIndefinitely showHelp help
autoApprove="${AUTO_APPROVE:-}"
include="${INCLUDE:-}"
exclude="${EXCLUDE:-}"
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

### Testing default logging

Exit code: 0

**Standard** output:

```plaintext
→ valet self test-core --logging-level
```

**Error** output:

```log
[1;30mHH:MM:SS [0;36mINFO     [0m This is an info message with a super long sentence. The value of life is not in its duration, but in
                    its donation. You are not important because of how long you live, you are important because of how 
                    effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed 
                    him for a lifetime. Surround yourself with the best people you can find, delegate authority, and 
                    don't interfere as long as the policy you've decided upon is being carried out.
[1;30mHH:MM:SS [0;32mSUCCESS  [0m This is a success message.
[1;30mHH:MM:SS [0;33mWARNING  [0m This is a warning message.
                    With a second line.
```

### Testing no color logging

Exit code: 0

**Standard** output:

```plaintext
→ VALET_NO_COLOR=true valet self test-core --logging-level
```

**Error** output:

```log
HH:MM:SS INFO      This is an info message with a super long sentence. The value of life is not in its duration, but in
                    its donation. You are not important because of how long you live, you are important because of how 
                    effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed 
                    him for a lifetime. Surround yourself with the best people you can find, delegate authority, and 
                    don't interfere as long as the policy you've decided upon is being carried out.
HH:MM:SS SUCCESS   This is a success message.
HH:MM:SS WARNING   This is a warning message.
                    With a second line.
```

### Testing CI MODE logging

Exit code: 0

**Standard** output:

```plaintext
→ VALET_NO_COLOR=true VALET_CI_MODE=true valet self test-core --logging-level
```

**Error** output:

```log
YYYY:MM:DD_HH:MM:SS INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
YYYY:MM:DD_HH:MM:SS SUCCESS  This is a success message.
YYYY:MM:DD_HH:MM:SS WARNING  This is a warning message.
With a second line.
```

### Testing no timestamp logging

Exit code: 0

**Standard** output:

```plaintext
→ VALET_NO_COLOR=true VALET_NO_TIMESTAMP=true valet self test-core --logging-level
```

**Error** output:

```log
INFO      This is an info message with a super long sentence. The value of life is not in its duration, but in its 
           donation. You are not important because of how long you live, you are important because of how effective you 
           live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. 
           Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the 
           policy you've decided upon is being carried out.
SUCCESS   This is a success message.
WARNING   This is a warning message.
           With a second line.
```

### Testing no icon logging

Exit code: 0

**Standard** output:

```plaintext
→ VALET_NO_COLOR=true VALET_NO_ICON=true valet self test-core --logging-level
```

**Error** output:

```log
HH:MM:SS INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in 
                  its donation. You are not important because of how long you live, you are important because of how 
                  effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him
                  for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't 
                  interfere as long as the policy you've decided upon is being carried out.
HH:MM:SS SUCCESS  This is a success message.
HH:MM:SS WARNING  This is a warning message.
                  With a second line.
```

### Testing no wrap logging

Exit code: 0

**Standard** output:

```plaintext
→ VALET_NO_COLOR=true VALET_NO_WRAP=true valet self test-core --logging-level
```

**Error** output:

```log
HH:MM:SS INFO      This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
HH:MM:SS SUCCESS   This is a success message.
HH:MM:SS WARNING   This is a warning message.
With a second line.
```

### Testing wrap at 80 logging

Exit code: 0

**Standard** output:

```plaintext
→ VALET_NO_COLOR=true VALET_LOG_COLUMNS=80 valet self test-core --logging-level
```

**Error** output:

```log
HH:MM:SS INFO      This is an info message with a super long sentence. The 
                    value of life is not in its duration, but in its donation. 
                    You are not important because of how long you live, you are 
                    important because of how effective you live. Give a man a 
                    fish and you feed him for a day; teach a man to fish and you
                    feed him for a lifetime. Surround yourself with the best 
                    people you can find, delegate authority, and don't interfere
                    as long as the policy you've decided upon is being carried 
                    out.
HH:MM:SS SUCCESS   This is a success message.
HH:MM:SS WARNING   This is a warning message.
                    With a second line.
```

## Test script 06.misc

### Testing version option

Exit code: 0

**Standard** output:

```plaintext
→ valet --version
OK, we got a version.
```

### Testing unknown option, corrected with fuzzy match

Exit code: 1

**Standard** output:

```plaintext
→ valet -prof
```

**Error** output:

```log
ERROR    Unknown option ⌜-prof⌝ (did you mean ⌜--profiling⌝?)).
```

### Testing temp files/directories creation, cleaning and custom cleanUp

Exit code: 0

**Standard** output:

```plaintext
→ valet self test-core --create-temp-files
```

**Error** output:

```log
INFO     Created temp file: /tmp/valet.d/f1-0.
INFO     Created temp file: /tmp/valet.d/f2-0.
INFO     Created temp directory: /tmp/valet.d/d1-0.
INFO     Created temp directory: /tmp/valet.d/d2-0.
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Exiting with code 0 after Xs.
DEBUG    Deleting temporary directory.
WARNING  This is a custom clean up function.
```

### Testing with a non existing user directory

Exit code: 0

**Standard** output:

```plaintext
→ VALET_USER_DIRECTORY=non-existing self test-core --logging-level
```

**Error** output:

```log
WARNING  The valet user directory ⌜$VALET_HOME/non-existing⌝ does not contain a built ⌜commands⌝ file.
To get started with valet, you must build your command list using the ⌜valet self build⌝ command.
Please check the help using ⌜valet self build --help⌝ for details.
Now using the examples commands from ⌜$VALET_HOME/examples.d⌝.
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.
```

## Test script 07.profiler

### Testing profiling for command and startup

Exit code: 0

**Standard** output:

```plaintext
→ valet --log-level error -x self test-core --logging-level
OK, command profiling file is not empty.
OK, startup profiling file is not empty.
```

## Test script 08.submenu

### Testing that we go into the interactive sub menu with no arguments

Exit code: 0

**Standard** output:

```plaintext
→ valet self
```

**Error** output:

```log
▶ called fzf --tiebreak=begin,index
--no-multi
--cycle
--layout=reverse
--info=default
--margin=0
--padding=0
--header-lines=3
--preview-window=right:4989:wrap
--preview=echo {} | cut -d$'\t' -f1 | sed -e 's/[[:space:]]*$//' | xargs -P1 -I{} '$VALET_HOME/valet' --log-level fail help --columns 4987 {}
▶ fzf input stream was:
⌈Please select the command to run (filter by typing anything)

Command name            	Short description
self build              	Re-build the menu of valet from your commands.
self download-binaries  	Download the required binaries for valet.
self release            	Release a new version of valet.
self test-core          	Test valet core features.
self test               	Test your valet custom commands.
self update             	Update valet using the latest release on GitHub.⌉
```

### Testing that we can display the help of a sub menu

Exit code: 0

**Standard** output:

```plaintext
→ valet self -h
ABOUT

  Show the valet self-maintenance sub menu.
  
  This is a sub command that regroups commands useful to maintain valet.

USAGE

  valet self [options] [command]

OPTIONS

  -h, --help
      Display the help for this command

COMMANDS

  build
      Re-build the menu of valet from your commands.
  download-binaries
      Download the required binaries for valet.
  release
      Release a new version of valet.
  test
      Test your valet custom commands.
  test-core
      Test valet core features.
  update
      Update valet using the latest release on GitHub.

EXAMPLES

  self build
      Re-build the valet menu by calling the ⌜build⌝ sub command.


```

### Testing that we catch option errors in sub menu

Exit code: 1

**Standard** output:

```plaintext
→ valet self --unknown
```

**Error** output:

```log
ERROR    Unknown option ⌜--unknown⌝.
Use valet self --help to get help.
```

