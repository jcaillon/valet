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

  valet [global options] self mock2 [options] [--] <firstArg> <more...>

GLOBAL OPTIONS

  -x, --profiling
      Turn on profiling (with debug mode) before running the required command.
      It will output to ~/valet-profiler-{PID}-command.txt.
      This is useful to debug your command and understand what takes a long time to execute.
      The profiler log will be cleanup to only keep lines relevant for your command script. You can disable this behavior by setting the environment variable 
      VALET_CONFIG_KEEP_ALL_PROFILER_LINES to true.
      This option can be set by exporting the variable VALET_PROFILING='true'.
  -l, --log-level, --log <level>
      Set the log level of valet (defaults to info).
      Possible values are: trace, debug, success, info, success, warning, error.
      This option can be set by exporting the variable VALET_LOG_LEVEL,='<level>'.
  -v, --verbose
      Output verbose information.
      This is the equivalent of setting the log level to debug.
      This option can be set by exporting the variable VALET_VERBOSE='true'.
  -w, --very-verbose
      Output very verbose information.
      This is the equivalent of setting the log level to trace.
      This option can be set by exporting the variable VALET_VERY_VERBOSE='true'.
  -i, --force-interactive-mode
      Enter interactive mode for commands even if arguments are not required or provided.
      This option can be set by exporting the variable VALET_FORCE_INTERACTIVE_MODE='true'.
  --version
      Display the current version of valet.
  -h, --help
      Display the help for this command.

OPTIONS

  -o, --option1
      First option.
  -2, --this-is-option2 <level>
      An option with a value.
      This option can be set by exporting the variable VALET_THIS_IS_OPTION2='<level>'.
  -3, --flag3
      Third option.
      This option can be set by exporting the variable VALET_FLAG3='true'.
  -4, --with-default <val>
      An option with a default value.
      This option can be set by exporting the variable VALET_WITH_DEFAULT='<val>'.
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

  valet [global options] self mock3 [options]

GLOBAL OPTIONS

  -x, --profiling
      Turn on profiling (with debug mode) before running the required command.
      It will output to ~/valet-profiler-{PID}-command.txt.
      This is useful to debug your command and understand what takes a long time to execute.
      The profiler log will be cleanup to only keep lines relevant for your command script. You can disable this behavior by setting the environment variable VALET_CONFIG_KEEP_ALL_PROFILER_LINES to true.
      This option can be set by exporting the variable VALET_PROFILING='true'.
  -l, --log-level, --log <level>
      Set the log level of valet (defaults to info).
      Possible values are: trace, debug, success, info, success, warning, error.
      This option can be set by exporting the variable VALET_LOG_LEVEL,='<level>'.
  -v, --verbose
      Output verbose information.
      This is the equivalent of setting the log level to debug.
      This option can be set by exporting the variable VALET_VERBOSE='true'.
  -w, --very-verbose
      Output very verbose information.
      This is the equivalent of setting the log level to trace.
      This option can be set by exporting the variable VALET_VERY_VERBOSE='true'.
  -i, --force-interactive-mode
      Enter interactive mode for commands even if arguments are not required or provided.
      This option can be set by exporting the variable VALET_FORCE_INTERACTIVE_MODE='true'.
  --version
      Display the current version of valet.
  -h, --help
      Display the help for this command.

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

  valet [global options] help [options] [--] 
  [commands...]

GLOBAL OPTIONS

  -x, --profiling
      Turn on profiling (with debug mode) before
      running the required command.
      It will output to 
      ~/valet-profiler-{PID}-command.txt.
      This is useful to debug your command and 
      understand what takes a long time to 
      execute.
      The profiler log will be cleanup to only 
      keep lines relevant for your command 
      script. You can disable this behavior by 
      setting the environment variable 
      VALET_CONFIG_KEEP_ALL_PROFILER_LINES to 
      true.
      This option can be set by exporting the 
      variable VALET_PROFILING='true'.
  -l, --log-level, --log <level>
      Set the log level of valet (defaults to 
      info).
      Possible values are: trace, debug, 
      success, info, success, warning, error.
      This option can be set by exporting the 
      variable VALET_LOG_LEVEL,='<level>'.
  -v, --verbose
      Output verbose information.
      This is the equivalent of setting the log 
      level to debug.
      This option can be set by exporting the 
      variable VALET_VERBOSE='true'.
  -w, --very-verbose
      Output very verbose information.
      This is the equivalent of setting the log 
      level to trace.
      This option can be set by exporting the 
      variable VALET_VERY_VERBOSE='true'.
  -i, --force-interactive-mode
      Enter interactive mode for commands even 
      if arguments are not required or provided.
      This option can be set by exporting the 
      variable 
      VALET_FORCE_INTERACTIVE_MODE='true'.
  --version
      Display the current version of valet.
  -h, --help
      Display the help for this command.

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
Failed as expected.
```

**Error** output:

```log
INFO     Fuzzy matching the option ⌜--colo⌝ to ⌜--no-colors⌝.
ERROR    Unknown option ⌜--unknown⌝, valid options are:
-n --no-colors
-c --columns
-h --help
Use ⌜valet help --help⌝ to get help.
```

### Testing that no arguments show the valet help

Exit code: `0`

**Standard** output:

```plaintext
→ valet help
OK, we got the valet help.
```

### Testing that we can display the help of a function using core::showHelp

Exit code: `0`

**Standard** output:

```plaintext
→ valet self mock1 show-help
ABOUT

  Show a menu with sub commands for the current command.

USAGE

  valet [global options] selfMock1 [options]

GLOBAL OPTIONS

  -x, --profiling
      Turn on profiling (with debug mode) before running the required command.
      It will output to ~/valet-profiler-{PID}-command.txt.
      This is useful to debug your command and understand what takes a long time to execute.
      The profiler log will be cleanup to only keep lines relevant for your command script. You can disable this behavior by setting the environment variable 
      VALET_CONFIG_KEEP_ALL_PROFILER_LINES to true.
      This option can be set by exporting the variable VALET_PROFILING='true'.
  -l, --log-level, --log <level>
      Set the log level of valet (defaults to info).
      Possible values are: trace, debug, success, info, success, warning, error.
      This option can be set by exporting the variable VALET_LOG_LEVEL,='<level>'.
  -v, --verbose
      Output verbose information.
      This is the equivalent of setting the log level to debug.
      This option can be set by exporting the variable VALET_VERBOSE='true'.
  -w, --very-verbose
      Output very verbose information.
      This is the equivalent of setting the log level to trace.
      This option can be set by exporting the variable VALET_VERY_VERBOSE='true'.
  -i, --force-interactive-mode
      Enter interactive mode for commands even if arguments are not required or provided.
      This option can be set by exporting the variable VALET_FORCE_INTERACTIVE_MODE='true'.
  --version
      Display the current version of valet.
  -h, --help
      Display the help for this command.

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
Failed as expected.
```

**Error** output:

```log
ERROR    Expecting 1 argument(s), got extra argument ⌜nonNeededArg1⌝.
Unknown option letter ⌜d⌝ in group ⌜-derp⌝. Valid single letter options are: ⌜h⌝.
Unknown option letter ⌜e⌝ in group ⌜-derp⌝. Valid single letter options are: ⌜h⌝.
Unknown option letter ⌜r⌝ in group ⌜-derp⌝. Valid single letter options are: ⌜h⌝.
Unknown option letter ⌜p⌝ in group ⌜-derp⌝. Valid single letter options are: ⌜h⌝.
Expecting 1 argument(s), got extra argument ⌜anotherArg⌝.
Use ⌜valet self mock1 --help⌝ to get help.

Usage:
valet [global options] self mock1 [options] [--] <action>
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
▶ called sudo printf %s alright
▶ called sudo whoami
```

## Test script 03.event-handlers

### Testing error handling

Exit code: `1`

**Standard** output:

```plaintext
→ valet self mock1 error
Failed as expected.
```

**Error** output:

```log
WARNING  This is for testing valet core functions, the next statement will return 1 and create an error.
ERROR    Error code 1 in selfMock1(), stack:
├─ in selfMock1() at $GLOBAL_VALET_HOME/valet.d/commands.d/self-mock.sh:XXX
├─ in main::runFunction() at $GLOBAL_VALET_HOME/valet.d/main:XXX
├─ in main::parseMainArguments() at $GLOBAL_VALET_HOME/valet.d/main:XXX
└─ in main() at $GLOBAL_VALET_HOME/valet:XXX
```

### Testing exit message and custom onExit function

Exit code: `1`

**Standard** output:

```plaintext
→ valet self mock1 exit
Failed as expected.
```

**Error** output:

```log
WARNING  This is for testing valet core functions, exiting with code 5.
WARNING  This is a custom on exit function.
EXIT     Exiting with code 5, stack:
├─ in selfMock1() at $GLOBAL_VALET_HOME/valet.d/commands.d/self-mock.sh:XXX
├─ in main::runFunction() at $GLOBAL_VALET_HOME/valet.d/main:XXX
├─ in main::parseMainArguments() at $GLOBAL_VALET_HOME/valet.d/main:XXX
└─ in main() at $GLOBAL_VALET_HOME/valet:XXX
```

### Testing fail function

Exit code: `1`

**Standard** output:

```plaintext
→ valet self mock1 fail
Failed as expected.
```

**Error** output:

```log
ERROR    This is for testing valet core functions, failing now.
```

### Testing fail2 function

Exit code: `1`

**Standard** output:

```plaintext
→ valet self mock1 fail2
Failed as expected with code 255.
```

**Error** output:

```log
ERROR    This is for testing valet core functions, failing now with exit code 255.
```

### Testing unknown command handling

Exit code: `1`

**Standard** output:

```plaintext
→ valet self mock1 unknown-command
Failed as expected.
```

**Error** output:

```log
WARNING  This is for testing valet core functions, the next statement will call a non existing command, causing a call to command_not_found_handle.
ERROR    Command not found: ⌜thisIsAnUnknownCommandForTesting⌝.
Please check your ⌜PATH⌝ variable.
ERROR    Error code 1 in selfMock1(), stack:
├─ in selfMock1() at $GLOBAL_VALET_HOME/valet.d/commands.d/self-mock.sh:XXX
├─ in main::runFunction() at $GLOBAL_VALET_HOME/valet.d/main:XXX
├─ in main::parseMainArguments() at $GLOBAL_VALET_HOME/valet.d/main:XXX
└─ in main() at $GLOBAL_VALET_HOME/valet:XXX
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
▶ called main::showInteractiveCommandsMenu main-menu Please select the command to run. CMD_ALL_COMMAND_SELECTION_ITEMS_ARRAY⌉
▶ received array was:
⌈help            Show the help this program or of a specific command.
self build      Re-build the menu of valet from your commands.
self config     Open the configuration file of Valet with your default editor.
self test       Test your valet custom commands.
self update     Update valet using the latest release on GitHub.⌉
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
TRACE    This is an error trace message which is always displayed.
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
TRACE    This is an error trace message which is always displayed.
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
help=""
parsingErrors=""
action="logging-level"

TRACE    This is an error trace message which is always displayed.
DEBUG    This is a debug message.
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.
The debug mode is activated!
DEBUG    Exiting with code 0 after Xs.
```

### Testing log with trace level

Exit code: `0`

**Standard** output:

```plaintext
→ valet -w self mock1 logging-level
```

**Error** output:

```log
DEBUG    Log level set to trace.
DEBUG    Command found ⌜self mock1⌝.
DEBUG    Function name found ⌜selfMock1⌝.
DEBUG    Loaded file ⌜$GLOBAL_VALET_HOME/valet.d/commands.d/self-mock.sh⌝.
DEBUG    Running the command ⌜self mock1⌝ with the function ⌜selfMock1⌝ and the arguments ⌜logging-level⌝.
DEBUG    Parsed arguments:
local parsingErrors help action
help=""
parsingErrors=""
action="logging-level"

TRACE    This is an error trace message which is always displayed.
TRACE    This is a trace message.
DEBUG    This is a debug message.
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.
The debug mode is activated!
The trace mode is activated!
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
HH:MM:SS TRACE    This is an error trace message which is always displayed.
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
CTIHH:MM:SS CDBTRACE    CDE This is an error trace message which is always displayed.
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
TRACE    This is an error trace message which is always displayed.
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
YYYY:MM:DD_HH:MM:SS TRACE    This is an error trace message which is always displayed.
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

### Testing printing raw string and printing file

Exit code: `0`

**Standard** output:

```plaintext
→ VALET_CONFIG_DISABLE_LOG_TIME=true VALET_CONFIG_DISABLE_LOG_WRAP=false VALET_CONFIG_LOG_COLUMNS=80 valet self mock1 print-raw-and-file
```

**Error** output:

```log
INFO     This is to test the printString function.
         Preventing the exploitation of animals is not the only reason for becom
         ###ing vegan, but for many it remains the key factor in their decision 
         ###to go vegan and stay vegan. Having emotional attachments with animal
         ###s may form part of that reason, while many believe that all sentient
         ### creatures have a right to life and freedom. Specifics aside, avoidi
         ###ng animal products is one of the most obvious ways you can take a st
         ###and against animal cruelty and animal exploitation everywhere. Read 
         ###a detailed overview on why being vegan demonstrates true compassion 
         ###for animals.
INFO     This is to test the printRaw function.
  Two spaces before that
New line(    )here.INFO     This is to test the printFile function from an actual file.
            1 ░ # Explore why veganism is kinder to animals, to people and to ou
              ░ r planet's future.
            2 ░ 
            3 ░ Source: <https://www.vegansociety.com/go-vegan/why-go-vegan>
            4 ░ 
            5 ░ ## For the animals
            6 ░ 
            7 ░   Preventing the exploitation of animals is not the only reason 
              ░ for becoming vegan, but for many it remains the key factor in th
              ░ eir decision to go vegan and stay vegan. Having emotional attach
              ░ ments with animals may form part of that reason, while many beli
              ░ eve that all sentient creatures have a right to life and freedom
              ░ . Specifics aside, avoiding animal products is one of the most o
              ░ bvious ways you can take a stand against animal cruelty and anim
              ░ al exploitation everywhere. Read a detailed overview on why bein
              ░ g vegan demonstrates true compassion for animals.
            8 ░ 
            9 ░ ## For your health
           10 ░ 
           11 ░   Well-planned vegan diets follow healthy eating guidelines, and
              ░  contain all the nutrients that our bodies need. Both the Britis
              ░ h Dietetic Association and the American Academy of Nutrition and
              ░  Dietetics recognise that they are suitable for every age and st
              ░ age of life. Some research has linked that there are certain hea
              ░ lth benefits to vegan diets with lower blood pressure and choles
              ░ terol, and lower rates of heart disease, type 2 diabetes and som
              ░ e types of cancer.
           12 ░ 
           13 ░   Going vegan is a great opportunity to learn more about nutriti
              ░ on and cooking, and improve your diet. Getting your nutrients fr
              ░ om plant foods allows more room in your diet for health-promotin
              ░ g options like whole grains, fruit, nuts, seeds and vegetables, 
              ░ which are packed full of beneficial fibre, vitamins and minerals
              ░ .
           14 ░ 
           15 ░ ## For the environment
           16 ░ 
           17 ░   From recycling our household rubbish to cycling to work, we're
              ░  all aware of ways to live a greener life. One of the most effec
              ░ tive things an individual can do to lower their carbon footprint
              ░  is to avoid all animal products. This goes way beyond the probl
              ░ em of cow flatulence and air pollution!
           18 ░   Why is meat and dairy so bad for the environment?
           19 ░ 
           20 ░   The production of meat and other animal derived products place
              ░ s a heavy burden on the environment. The vast amount of grain fe
              ░ ed required for meat production is a significant contributor to 
              ░ deforestation, habitat loss and species extinction. In Brazil al
              ░ one, the equivalent of 5.6 million acres of land is used to grow
              ░  soya beans for animals in Europe. This land contributes to deve
              ░ loping world malnutrition by driving impoverished populations to
              ░  grow cash crops for animal feed, rather than food for themselve
              ░ s. On the other hand, considerably lower quantities of crops and
              ░  water are required to sustain a vegan diet, making the switch t
              ░ o veganism one of the easiest, most enjoyable and most effective
              ░  ways to reduce our impact on the environment. For more on how v
              ░ eganism is the way forward for the environment, see our environm
              ░ ent section.
           21 ░ 
           22 ░ ## For people
           23 ░ 
           24 ░   Just like veganism is the sustainable option when it comes to 
              ░ looking after our planet, plant-based living is also a more sust
              ░ ainable way of feeding the human family. A plant-based diet requ
              ░ ires only one third of the land needed to support a meat and dai
              ░ ry diet. With rising global food and water insecurity due to a m
              ░ yriad of environmental and socio-economic problems, there's neve
              ░ r been a better time to adopt a more sustainable way of living. 
              ░ Avoiding animal products is not just one of the simplest ways an
              ░  individual can reduce the strain on food as well as other resou
              ░ rces, it's the simplest way to take a stand against inefficient 
              ░ food systems which disproportionately affect the poorest people 
              ░ all over the world. Read more about how vegan diets can help peo
              ░ ple.
INFO     This is to test the printFile function from an actual file with number 
         of lines restriction.
            1 ░ # Explore why veganism is kinder to animals, to people and to ou
              ░ r planet's future.
            2 ░ 
            3 ░ Source: <https://www.vegansociety.com/go-vegan/why-go-vegan>
            4 ░ 
            5 ░ ## For the animals
            6 ░ 
            7 ░   Preventing the exploitation of animals is not the only reason 
              ░ for becoming vegan, but for many it remains the key factor in th
              ░ eir decision to go vegan and stay vegan. Having emotional attach
              ░ ments with animals may form part of that reason, while many beli
              ░ eve that all sentient creatures have a right to life and freedom
              ░ . Specifics aside, avoiding animal products is one of the most o
              ░ bvious ways you can take a stand against animal cruelty and anim
              ░ al exploitation everywhere. Read a detailed overview on why bein
              ░ g vegan demonstrates true compassion for animals.
            8 ░ 
            9 ░ ## For your health
           10 ░ 
            … ░ (truncated)
INFO     This is to test the printFile function from a string.
            1 ░ This is an info message with a super long sentence.
            2 ░ The value of life is not in its duration, but in its donation.
            3 ░ You are not important because of how long you live, you are impo
              ░ rtant because of how effective you live.
            4 ░ Give a man a fish and you feed him for a day; teach a man to fis
              ░ h and you feed him for a lifetime.
            5 ░ 
            6 ░ Surround yourself with the best people you can find, delegate au
              ░ thority, and don't interfere as long as the policy you've decide
              ░ d upon is being carried out.
```

### Testing that we can output the logs to a file additionally to console

Exit code: `0`

**Standard** output:

```plaintext
→ VALET_CONFIG_LOG_TO_DIRECTORY=/tmp/valet.d/d2-0 VALET_CONFIG_DISABLE_LOG_TIME=true valet self mock1 logging-level

→ io::countArgs /tmp/valet.d/d2-0/*
1
```

**Error** output:

```log
TRACE    This is an error trace message which is always displayed.
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its 
         donation. You are not important because of how long you live, you are important because of how effective you 
         live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. 
         Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the 
         policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
         With a second line.
```

### Testing that we can output the logs to a specific file name additionally to console

Exit code: `0`

**Standard** output:

```plaintext
→ VALET_CONFIG_LOG_FILENAME_PATTERN='logFile=test.log' VALET_CONFIG_LOG_TO_DIRECTORY=/tmp/valet.d/d2-0 VALET_CONFIG_DISABLE_LOG_TIME=true valet self mock1 logging-level

→ cat /tmp/valet.d/d2-0/test.log
TRACE    This is an error trace message which is always displayed.
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its 
         donation. You are not important because of how long you live, you are important because of how effective you 
         live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. 
         Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the 
         policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
         With a second line.

```

**Error** output:

```log
TRACE    This is an error trace message which is always displayed.
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its 
         donation. You are not important because of how long you live, you are important because of how effective you 
         live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. 
         Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the 
         policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
         With a second line.
```

### Testing that we can output the logs to a file directly instead of the console err stream

Exit code: `0`

**Standard** output:

```plaintext
→ VALET_CONFIG_LOG_FD=/tmp/valet.d/d2-0/test2.log VALET_CONFIG_DISABLE_LOG_TIME=true valet self mock1 logging-level

→ cat /tmp/valet.d/d2-0/test2.log
TRACE    This is an error trace message which is always displayed.
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its 
         donation. You are not important because of how long you live, you are important because of how effective you 
         live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. 
         Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the 
         policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
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

### Testing unknown single letter

Exit code: `1`

**Standard** output:

```plaintext
→ valet -prof
Failed as expected.
```

**Error** output:

```log
ERROR    Unknown option letter ⌜p⌝ in group ⌜-p⌝. Valid single letter options are: ⌜x⌝, ⌜l⌝, ⌜v⌝, ⌜w⌝, ⌜i⌝, ⌜h⌝.
```

### Testing option corrected with fuzzy match

Exit code: `0`

**Standard** output:

```plaintext
→ valet --versin
```

**Error** output:

```log
INFO     Fuzzy matching the option ⌜--versin⌝ to ⌜--version⌝.
```

### Testing option corrected with fuzzy match

Exit code: `0`

**Standard** output:

```plaintext
→ valet -vwvw --versin
```

**Error** output:

```log
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Log level set to trace.
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Log level set to trace.
INFO     Fuzzy matching the option ⌜--versin⌝ to ⌜--version⌝.
DEBUG    Exiting with code 0 after Xs.
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
INFO     The valet user directory ⌜/tmp/valet.d/d3-0/non-existing⌝ does not contain a built ⌜commands⌝ file.
Now building it using ⌜valet self build⌝ command.
WARNING  Skipping user directory ⌜/tmp/valet.d/d3-0/non-existing⌝ because it does not exist.
TRACE    This is an error trace message which is always displayed.
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
▶ called main::showInteractiveCommandsMenu self Please select the command to run. FILTERED_COMMANDS_FOR_SUB_MENU⌉
▶ received array was:
⌈self build      Re-build the menu of valet from your commands.
self config     Open the configuration file of Valet with your default editor.
self test       Test your valet custom commands.
self update     Update valet using the latest release on GitHub.⌉
```

### Testing that we can display the help of a sub menu

Exit code: `0`

**Standard** output:

```plaintext
→ valet self -h
ABOUT

  Show a menu with sub commands for the current command.

USAGE

  valet [global options] self [options] [command]

GLOBAL OPTIONS

  -x, --profiling
      Turn on profiling (with debug mode) before running the required command.
      It will output to ~/valet-profiler-{PID}-command.txt.
      This is useful to debug your command and understand what takes a long time to execute.
      The profiler log will be cleanup to only keep lines relevant for your command script. You can disable this behavior by setting the environment variable 
      VALET_CONFIG_KEEP_ALL_PROFILER_LINES to true.
      This option can be set by exporting the variable VALET_PROFILING='true'.
  -l, --log-level, --log <level>
      Set the log level of valet (defaults to info).
      Possible values are: trace, debug, success, info, success, warning, error.
      This option can be set by exporting the variable VALET_LOG_LEVEL,='<level>'.
  -v, --verbose
      Output verbose information.
      This is the equivalent of setting the log level to debug.
      This option can be set by exporting the variable VALET_VERBOSE='true'.
  -w, --very-verbose
      Output very verbose information.
      This is the equivalent of setting the log level to trace.
      This option can be set by exporting the variable VALET_VERY_VERBOSE='true'.
  -i, --force-interactive-mode
      Enter interactive mode for commands even if arguments are not required or provided.
      This option can be set by exporting the variable VALET_FORCE_INTERACTIVE_MODE='true'.
  --version
      Display the current version of valet.
  -h, --help
      Display the help for this command.

OPTIONS

  -h, --help
      Display the help for this command.

COMMANDS

  self build
      Re-build the menu of valet from your commands.
  self config
      Open the configuration file of Valet with your default editor.
  self export
      Returns a string that can be evaluated to have Valet functions in bash.
  self mock1
      A command that only for testing valet core functions.
  self mock2
      A command that only for testing valet core functions.
  self mock3
      A command that only for testing valet core functions.
  self mock4
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
Failed as expected.
```

**Error** output:

```log
ERROR    Unknown option ⌜--unknown⌝, valid options are:
-h --help
Use ⌜valet self --help⌝ to get help.
```

