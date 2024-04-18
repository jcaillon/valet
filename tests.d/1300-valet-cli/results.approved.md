# Test suite 1300-valet-cli

## Test script 01.command-help

### Testing help for the self mock2 command

Exit code: `0`

**Standard** output:

```plaintext
→ valet help self mock2
ABOUT

  An example of description.
  
  You can put any text here, it will be wrapped to fit the terminal width.
  
  You can ⌜highlight⌝ some text as well.

USAGE

  valet self mock2 [options] <firstArg> <more...>

OPTIONS

  -o, --option1
      First option.
  -2, --this-is-option2 <level>
      An option with a value.
      This option can be set by exporting the variable VALET_THIS_IS_OPTION2='<level>'.
  -h, --help
      Display the help for this command.

ARGUMENTS

  firstArg
      First argument.
  more...
      Will be an an array of strings.

EXAMPLES

  self mock2 -o -2 value1 arg1 more1 more2
      Call command1 with option1, option2 and some arguments.
      

```

### Testing to fuzzy find an help

Exit code: `0`

**Standard** output:

```plaintext
→ valet hel sel mo3
ABOUT

  Before starting this command, valet will check if sudo is available.
  
  If so, it will require the user to enter the sudo password and use sudo inside the command
  

USAGE

  valet self mock3 [options]

OPTIONS

  -h, --help
      Display the help for this command.

```

**Error** output:

```log
INFO     Fuzzy matching the command ⌜hel⌝ to ⌜help⌝.
INFO     Fuzzy matching the command ⌜sel mo3⌝ to ⌜self mock3⌝.
```

### Testing help with columns 48

Exit code: `0`

**Standard** output:

```plaintext
→ valet help --columns 48 help
ABOUT

  Show the help this program or of the help of a
  specific command.
  
  You can show the help with or without colors 
  and set the maximum columns for the help text.

USAGE

  valet help [options] [commands...]

OPTIONS

  -n, --no-colors
      Do not use any colors in the output
      This option can be set by exporting the 
      variable VALET_NO_COLORS='true'.
  -c, --columns <number>
      Set the maximum columns for the help text
      This option can be set by exporting the 
      variable VALET_COLUMNS='<number>'.
  -h, --help
      Display the help for this command.

ARGUMENTS

  commands?...
      The name of the command to show the help 
      for.
      If not provided, show the help for the 
      program.

EXAMPLES

  help cmd
      Shows the help for the command ⌜cmd⌝
  help cmd subCmd
      Shows the help for the sub command 
      ⌜subCmd⌝ of the command ⌜cmd⌝
  help --no-colors --columns 50
      Shows the help for the program without any
      color and with a maximum of 50 columns
      

```

### Testing that we catch option errors in help

Exit code: `1`

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

Exit code: `0`

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
  
  In addition to the environment variables defined for each options, you can define environment variables to configure valet.
  
  These variables are conviently defined in the valet user config file, located by default at ~/.config/valet/config (the path to this file can be configured using the 
  VALET_CONFIG_FILE environment variable).
  
  You can run ⌜valet self config⌝ to open the configuration file with your default editor (the file will get created if it does not yet exist).
  
  ⌜Developer notes:⌝
  
  You can enable debug mode with profiling for valet by setting the environment variable VALET_CONFIG_STARTUP_PROFILING to true (it will output to ~/profile_valet.txt).

USAGE

  valet [options] [command]

OPTIONS

  -x, --profiling
      Turn on profiling (with debug mode) before running the required command.
      It will output to ~/profile_valet_cmd.txt.
      This is useful to debug your command and understand what takes a long time to execute.
      The profiler log will be cleanup to only keep lines relevant for your command script. You can disable this behavior by setting the environment variable 
      VALET_CONFIG_KEEP_ALL_PROFILER_LINES to true.
      This option can be set by exporting the variable VALET_PROFILING='true'.
  -l, --log-level, --log <level>
      Set the log level of valet (defaults to info).
      Possible values are: debug, success, info, success, warning, error.
      This option can be set by exporting the variable VALET_LOG_LEVEL,='<level>'.
  -v, --verbose
      Output verbose information.
      This is the equivalent of setting the log level to debug.
      This option can be set by exporting the variable VALET_VERBOSE='true'.
  -i, --force-interactive-mode
      Enter interactive mode for commands even if arguments are not required or provided.
      This option can be set by exporting the variable VALET_FORCE_INTERACTIVE_MODE='true'.
  --version
      Display the current version of valet.
  -h, --help
      Display the help for this command.

COMMANDS

  help
      Show the help this program or of a specific command.
  self build
      Re-build the menu of valet from your commands.
  self config
      Open the configuration file of Valet with your default editor.
  self download-binaries
      Download the required binaries for valet.
  self mock1
      A command that only for testing valet core functions.
  self mock2
      A command that only for testing valet core functions.
  self mock3
      A command that only for testing valet core functions.
  self release
      Release a new version of valet.
  self setup
      The command run after the installation of Valet to setup the tool.
  self test
      Test your valet custom commands.
  self update
      Update valet using the latest release on GitHub.

EXAMPLES

  --help
      Displays this help text.
  -v a-command and-sub-command
      Active ⌜verbose⌝ mode and run the command ⌜a-command⌝ with the sub command ⌜and-sub-command⌝.
      

```

### Testing that we can display the help of a function using core::showHelp

Exit code: `0`

**Standard** output:

```plaintext
→ valet self mock1 show-help
ABOUT

  Show a menu with sub commands for the current command.

USAGE

  valet selfMock1 [options]

OPTIONS

  -h, --help
      Display the help for this command.

```

## Test script 02.command-misc

### Testing that we correctly parse arguments and options and fail if they don't match

Exit code: `1`

**Standard** output:

```plaintext
→ valet self mock1 non-existing-option nonNeededArg1 -derp anotherArg
```

**Error** output:

```log
ERROR    Expecting 1 argument(s), got extra argument ⌜nonNeededArg1⌝.
Unknown option ⌜-derp⌝.
Expecting 1 argument(s), got extra argument ⌜anotherArg⌝.
Use valet self mock1 --help to get help.
```

### Testing that a command with sudo ask for sudo privileges

Exit code: `0`

**Standard** output:

```plaintext
→ valet self mock3
```

**Error** output:

```log
INFO     This command requires sudo privileges.
▶ called sudo echo alright
▶ called sudo whoami
```

## Test script 03.event-handlers

### Testing error handling

Exit code: `0`

**Standard** output:

```plaintext
→ valet self mock1 error
```

**Error** output:

```log
WARNING  This is for testing valet core functions, the next statement will return 1 and create an error.
ERROR    Error code 1 in selfMock1(), stack:
├─ In function selfMock1() $GLOBAL_VALET_HOME/valet.d/commands.d/self-mock.sh:XXX
├─ In function main::runFunction() $GLOBAL_VALET_HOME/valet.d/main:XXX
├─ In function main::parseMainArguments() $GLOBAL_VALET_HOME/valet.d/main:XXX
└─ In function main() $GLOBAL_VALET_HOME/valet:XXX
```

### Testing exit message and custom onExit function

Exit code: `0`

**Standard** output:

```plaintext
→ valet self mock1 exit
```

**Error** output:

```log
WARNING  This is for testing valet core functions, exiting with code 5.
WARNING  This is a custom on exit function.
EXIT     Exiting with code 5, stack:
├─ In function selfMock1() $GLOBAL_VALET_HOME/valet.d/commands.d/self-mock.sh:XXX
├─ In function main::runFunction() $GLOBAL_VALET_HOME/valet.d/main:XXX
├─ In function main::parseMainArguments() $GLOBAL_VALET_HOME/valet.d/main:XXX
└─ In function main() $GLOBAL_VALET_HOME/valet:XXX
```

### Testing fail function

Exit code: `1`

**Standard** output:

```plaintext
→ valet self mock1 fail
```

**Error** output:

```log
ERROR    This is for testing valet core functions, failing now.
```

### Testing unknown command handling

Exit code: `0`

**Standard** output:

```plaintext
→ valet self mock1 unknown-command
```

**Error** output:

```log
WARNING  This is for testing valet core functions, the next statement will call a non existing command, causing a call to command_not_found_handle.
ERROR    Command not found: ⌜thisIsAnUnknownCommandForTesting⌝.
Please check your ⌜PATH⌝ variable.
stack:
├─ In function core::fail() $GLOBAL_VALET_HOME/valet.d/core:XXX
├─ In function command_not_found_handle() $GLOBAL_VALET_HOME/valet.d/main:XXX
├─ In function selfMock1() $GLOBAL_VALET_HOME/valet.d/commands.d/self-mock.sh:XXX
├─ In function main::runFunction() $GLOBAL_VALET_HOME/valet.d/main:XXX
├─ In function main::parseMainArguments() $GLOBAL_VALET_HOME/valet.d/main:XXX
└─ In function main() $GLOBAL_VALET_HOME/valet:XXX
ERROR    Error code 1 in selfMock1(), stack:
├─ In function selfMock1() $GLOBAL_VALET_HOME/valet.d/commands.d/self-mock.sh:XXX
├─ In function main::runFunction() $GLOBAL_VALET_HOME/valet.d/main:XXX
├─ In function main::parseMainArguments() $GLOBAL_VALET_HOME/valet.d/main:XXX
└─ In function main() $GLOBAL_VALET_HOME/valet:XXX
```

## Test script 04.interactive-mode

### Testing that valet can be called without any arguments and show the menu

Exit code: `0`

**Standard** output:

```plaintext
→ valet
```

**Error** output:

```log
▶ called ⌈fzf --history=/tmp/valet.d/d801-0/fzf-history-main-menu --history-size=50 --bind alt-up:prev-history --bind alt-down:next-history --bind=alt-h:preview(echo -e 'HELP

Navigate through the options with the UP/DOWN keys.

Validate your choice with ENTER.

Cancel with ESC or CTRL+C.

ADDITIONAL KEY BINDINGS

ALT+H: Show this help.
ALT+/: Rotate through the preview options (this pane).
ALT+UP/ALT+DOWN: Previous/next query in the history.
SHIFT+UP/SHIFT+DOWN: Scroll the preview up and down.
') --preview-window=right,80 --bind alt-/:change-preview-window(right,70%|down,40%,border-horizontal|hidden|) --layout=reverse --info=right --pointer=◆ --marker=✓ --cycle --tiebreak=begin,index --margin=0 --padding=0 --delimiter=
 --tabstop=3 --header-first --header=Press ALT+H to display the help and keybindings.
Please select the command to run. --print-query --no-multi --preview-label=Command help --preview=VALET_LOG_LEVEL=error '$GLOBAL_VALET_HOME/valet' help --columns $((FZF_PREVIEW_COLUMNS - 1)) {1}⌉
▶ fzf input stream was:
⌈help                  	Show the help this program or of a specific command.
self build            	Re-build the menu of valet from your commands.
self test             	Test your valet custom commands.
self update           	Update valet using the latest release on GitHub.⌉
```

## Test script 05.logging

### Testing log with success level

Exit code: `0`

**Standard** output:

```plaintext
→ VALET_LOG_LEVEL=success valet self mock1 logging-level
```

**Error** output:

```log
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.
```

### Testing log with warning level

Exit code: `0`

**Standard** output:

```plaintext
→ valet --log-level warning self mock1 logging-level
```

**Error** output:

```log
WARNING  This is a warning message.
With a second line.
```

### Testing log with debug level

Exit code: `0`

**Standard** output:

```plaintext
→ valet -v self mock1 logging-level
```

**Error** output:

```log
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Command found ⌜self mock1⌝.
DEBUG    Function name found ⌜selfMock1⌝.
DEBUG    Loaded file ⌜$GLOBAL_VALET_HOME/valet.d/commands.d/self-mock.sh⌝.
DEBUG    Running the command ⌜self mock1⌝ with the function ⌜selfMock1⌝ and the arguments ⌜logging-level⌝.
DEBUG    Parsed arguments:
local parsingErrors help action
parsingErrors=""
action="logging-level"

DEBUG    This is a debug message.
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.
The debug mode is activated!
DEBUG    Exiting with code 0 after Xs.
```

### Testing default logging

Exit code: `0`

**Standard** output:

```plaintext
→ valet self mock1 logging-level
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

### Testing color + icon logging

Exit code: `0`

**Standard** output:

```plaintext
→ VALET_CONFIG_ENABLE_COLORS=true VALET_CONFIG_ENABLE_NERDFONT_ICONS=true valet self mock1 logging-level
```

**Error** output:

```log
CTIHH:MM:SS CININFO    II  CDE This is an info message with a super long sentence. The value of life is not in its duration, but in
                    its donation. You are not important because of how long you live, you are important because of how 
                    effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed 
                    him for a lifetime. Surround yourself with the best people you can find, delegate authority, and 
                    don't interfere as long as the policy you've decided upon is being carried out.
CTIHH:MM:SS CSUSUCCESS IS  CDE This is a success message.
CTIHH:MM:SS CWAWARNING IW  CDE This is a warning message.
                    With a second line.
```

### Testing no timestamp, no wrap logging

Exit code: `0`

**Standard** output:

```plaintext
→ VALET_CONFIG_DISABLE_LOG_WRAP=true VALET_CONFIG_DISABLE_LOG_TIME=true valet self mock1 logging-level
```

**Error** output:

```log
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.
```

### Testing enable log timestamp and wrap at 80 logging

Exit code: `0`

**Standard** output:

```plaintext
→ VALET_CONFIG_ENABLE_LOG_TIMESTAMP= true VALET_CONFIG_LOG_COLUMNS=80 valet self mock1 logging-level
```

**Error** output:

```log
YYYY:MM:DD_HH:MM:SS INFO     This is an info message with a super long sentence. The value 
                  of life is not in its duration, but in its donation. You are 
                  not important because of how long you live, you are important 
                  because of how effective you live. Give a man a fish and you 
                  feed him for a day; teach a man to fish and you feed him for a
                  lifetime. Surround yourself with the best people you can find,
                  delegate authority, and don't interfere as long as the policy 
                  you've decided upon is being carried out.
YYYY:MM:DD_HH:MM:SS SUCCESS  This is a success message.
YYYY:MM:DD_HH:MM:SS WARNING  This is a warning message.
                  With a second line.
```

## Test script 06.misc

### Testing version option

Exit code: `0`

**Standard** output:

```plaintext
→ valet --version
OK, we got a version.
```

### Testing unknown option, corrected with fuzzy match

Exit code: `1`

**Standard** output:

```plaintext
→ valet -prof
```

**Error** output:

```log
ERROR    Unknown option ⌜-prof⌝ (did you mean ⌜--profiling⌝?).
```

### Testing temp files/directories creation, cleaning and custom cleanUp

Exit code: `0`

**Standard** output:

```plaintext
→ valet self mock1 create-temp-files
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

Exit code: `1`

**Standard** output:

```plaintext
→ VALET_USER_DIRECTORY=non-existing self mock1 logging-level
```

**Error** output:

```log
INFO     The valet user directory ⌜/tmp/valet.d/d601-0/non-existing⌝ does not contain a built ⌜commands⌝ file.
Now building it using ⌜valet self build⌝ command.
WARNING  Skipping user directory ⌜/tmp/valet.d/d601-0/non-existing⌝ because it does not exist.
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.
```

## Test script 08.submenu

### Testing that we go into the interactive sub menu with no arguments

Exit code: `0`

**Standard** output:

```plaintext
→ valet self
```

**Error** output:

```log
▶ called ⌈fzf --history=/tmp/valet.d/d801-0/fzf-history-self
--history-size=50
--bind
alt-up:prev-history
--bind
alt-down:next-history
--bind=alt-h:preview(echo -e 'HELP

Navigate through the options with the UP/DOWN keys.

Validate your choice with ENTER.

Cancel with ESC or CTRL+C.

ADDITIONAL KEY BINDINGS

ALT+H: Show this help.
ALT+/: Rotate through the preview options (this pane).
ALT+UP/ALT+DOWN: Previous/next query in the history.
SHIFT+UP/SHIFT+DOWN: Scroll the preview up and down.
')
--preview-window=right,80
--bind
alt-/:change-preview-window(right,70%|down,40%,border-horizontal|hidden|)
--layout=reverse
--info=right
--pointer=◆
--marker=✓
--cycle
--tiebreak=begin,index
--margin=0
--padding=0
--delimiter=

--tabstop=3
--header-first
--header=Press ALT+H to display the help and keybindings.
Please select the command to run.
--print-query
--no-multi
--preview-label=Command help
--preview=VALET_LOG_LEVEL=error '$GLOBAL_VALET_HOME/valet' help --columns $((FZF_PREVIEW_COLUMNS - 1)) {1}⌉
▶ fzf input stream was:
⌈self build            	Re-build the menu of valet from your commands.
self test             	Test your valet custom commands.
self update           	Update valet using the latest release on GitHub.⌉
```

### Testing that we can display the help of a sub menu

Exit code: `0`

**Standard** output:

```plaintext
→ valet self -h
ABOUT

  Show a menu with sub commands for the current command.

USAGE

  valet self [options] [command]

OPTIONS

  -h, --help
      Display the help for this command.

COMMANDS

  self build
      Re-build the menu of valet from your commands.
  self config
      Open the configuration file of Valet with your default editor.
  self download-binaries
      Download the required binaries for valet.
  self mock1
      A command that only for testing valet core functions.
  self mock2
      A command that only for testing valet core functions.
  self mock3
      A command that only for testing valet core functions.
  self release
      Release a new version of valet.
  self setup
      The command run after the installation of Valet to setup the tool.
  self test
      Test your valet custom commands.
  self update
      Update valet using the latest release on GitHub.

```

### Testing that we catch option errors in sub menu

Exit code: `1`

**Standard** output:

```plaintext
→ valet self --unknown
```

**Error** output:

```log
ERROR    Unknown option ⌜--unknown⌝.
Use valet self --help to get help.
```

