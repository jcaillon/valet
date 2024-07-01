# Test suite 1101-self-build-utils

## Test script 00.self-build-utils

### Testing extractCommandYamls

Exit code: `0`

**Error** output:

```log
INFO     content:
   1 ░ A content between tags
   2 ░ array:
   3 ░   - item1
   4 ░   - item2
   5 ░   - item3
   6 ░ 
INFO     content:
   1 ░ yep!
   2 ░ 
INFO     content:
   1 ░ And another one!
   2 ░ 
```

### Testing extractCommandDefinitionToVariables

Exit code: `0`

**Standard** output:

```plaintext
TEMP_CMD_BUILD_arguments_description=0 "Description of arg 1." 1 "Description of arg 2." 2 "Description of arg 3."
TEMP_CMD_BUILD_arguments_fourthProp=0 "" 1 "" 2 "ok3"
TEMP_CMD_BUILD_arguments_name=0 "arg1" 1 "arg2" 2 "arg3"
TEMP_CMD_BUILD_arguments_thirdProp=0 "" 1 "ok2"
TEMP_CMD_BUILD_author='github.com/jcaillon'
TEMP_CMD_BUILD_command='test'
TEMP_CMD_BUILD_description=$'A long description.\n\nIn a multi-line string.\n\nWith 3 paragraphs.'
TEMP_CMD_BUILD_examples_description=0 $'Call command with option1, option2 and some arguments.\n'
TEMP_CMD_BUILD_examples_name=0 "command -o -2 value1 arg1 more1 more2"
TEMP_CMD_BUILD_fileToSource='source'
TEMP_CMD_BUILD_hideInMenu='false'
TEMP_CMD_BUILD_options_default=0 "true" 1 "" 2 "default value"
TEMP_CMD_BUILD_options_description=0 $'Description of option 1.\n\nAnother line.' 1 $'Description of option 2.\n\nAnother line.' 2 $'Description of option 3.\n\nAnother line.'
TEMP_CMD_BUILD_options_name=0 "--option1" 1 "--option2"
TEMP_CMD_BUILD_options_noEnvironmentVariable=0 "true" 1 "false"
TEMP_CMD_BUILD_shortDescription='Short description.'
TEMP_CMD_BUILD_sudo='false'
```

**Error** output:

```log
   1 ░ 
   2 ░ command: test
   3 ░ author: github.com/jcaillon
   4 ░ fileToSource: source
   5 ░ shortDescription: Short description.
   6 ░ description: |-
   7 ░   A long description.
   8 ░ 
   9 ░   In a multi-line string.
  10 ░ 
  11 ░   With 3 paragraphs.
  12 ░ sudo: false
  13 ░ hideInMenu: false
  14 ░ arguments:
  15 ░ - name: arg1
  16 ░   description: Description of arg 1.
  17 ░ - name: arg2
  18 ░   description: Description of arg 2.
  19 ░   thirdProp: ok2
  20 ░ - name: arg3
  21 ░   description: Description of arg 3.
  22 ░   fourthProp: ok3
  23 ░ options:
  24 ░ - name: --option1
  25 ░   description: |-
  26 ░     Description of option 1.
  27 ░ 
  28 ░     Another line.
  29 ░   noEnvironmentVariable: true
  30 ░   default: true
  31 ░ - name: --option2
  32 ░   description: |-
  33 ░     Description of option 2.
  34 ░ 
  35 ░     Another line.
  36 ░   noEnvironmentVariable: false
  37 ░ - description: |-
  38 ░     Description of option 3.
  39 ░ 
  40 ░     Another line.
  41 ░   default: default value
  42 ░ examples:
  43 ░ - name: command -o -2 value1 arg1 more1 more2
  44 ░   description: |-
  45 ░     Call command with option1, option2 and some arguments.
  46 ░ 
```

### Testing extractFirstLongNameFromOptionString

Exit code: `0`

**Standard** output:

```plaintext
→ extractFirstLongNameFromOptionString '-x, --profiling'
--profiling
```

### Testing declareFinalCommandDefinition*

Exit code: `0`

**Standard** output:

```plaintext
CMD_ALL_COMMANDS_ARRAY=0 "cmd"
CMD_ALL_FUNCTIONS_ARRAY=0 "func"
CMD_ARGS_LAST_IS_ARRAY_func='false'
CMD_ARGS_NAME_func=0 "arg1" 1 "arg2" 2 "arg3"
CMD_ARGS_NB_OPTIONAL_func='0'
CMD_ARGUMENTS_DESCRIPTION_func=0 "Description of arg 1." 1 "Description of arg 2." 2 "Description of arg 3."
CMD_ARGUMENTS_NAME_func=0 "arg1" 1 "arg2" 2 "arg3"
CMD_COMMAND_func='cmd'
CMD_DESCRIPTION_func=$'A long description.\n\nIn a multi-line string.\n\nWith 3 paragraphs.'
CMD_EXAMPLES_DESCRIPTION_func=0 $'Call command with option1, option2 and some arguments.\n'
CMD_EXAMPLES_NAME_func=0 "valet command -o -2 value1 arg1 more1 more2"
CMD_FILETOSOURCE_func='source'
CMD_FUNCTION_NAME_cmd='func'
CMD_MAX_COMMAND_WIDTH='3'
CMD_MAX_SUB_COMMAND_LEVEL='0'
CMD_OPTIONS_DESCRIPTION_func=0 $'Description of option 1.\n\nAnother line.' 1 $'Description of option 2.\n\nAnother line.\nThis option can be set by exporting the variable VALET_OPTION2=\'true\'.' 2 $'Description of option 3.\n\nAnother line.' 3 "Display the help for this command."
CMD_OPTIONS_NAME_func=0 "--option1" 1 "--option2" 2 "-h, --help"
CMD_OPTS_DEFAULT_func=0 "true" 1 "" 2 "default value"
CMD_OPTS_HAS_VALUE_func=0 "false" 1 "false" 2 "false"
CMD_OPTS_NAME_SC_func=0 "" 1 "VALET_OPTION2" 2 ""
CMD_OPTS_NAME_func=0 "option1" 1 "option2" 2 "help"
CMD_OPTS_func=0 "--option1" 1 "--option2" 2 "-h --help"
CMD_SHORT_DESCRIPTION_func='Short description.'
CMD_SUDO_func='false'
```

**Error** output:

```log
   1 ░ 
   2 ░ command: test
   3 ░ author: github.com/jcaillon
   4 ░ fileToSource: source
   5 ░ shortDescription: Short description.
   6 ░ description: |-
   7 ░   A long description.
   8 ░ 
   9 ░   In a multi-line string.
  10 ░ 
  11 ░   With 3 paragraphs.
  12 ░ sudo: false
  13 ░ hideInMenu: false
  14 ░ arguments:
  15 ░ - name: arg1
  16 ░   description: Description of arg 1.
  17 ░ - name: arg2
  18 ░   description: Description of arg 2.
  19 ░   thirdProp: ok2
  20 ░ - name: arg3
  21 ░   description: Description of arg 3.
  22 ░   fourthProp: ok3
  23 ░ options:
  24 ░ - name: --option1
  25 ░   description: |-
  26 ░     Description of option 1.
  27 ░ 
  28 ░     Another line.
  29 ░   noEnvironmentVariable: true
  30 ░   default: true
  31 ░ - name: --option2
  32 ░   description: |-
  33 ░     Description of option 2.
  34 ░ 
  35 ░     Another line.
  36 ░   noEnvironmentVariable: false
  37 ░ - description: |-
  38 ░     Description of option 3.
  39 ░ 
  40 ░     Another line.
  41 ░   default: default value
  42 ░ examples:
  43 ░ - name: command -o -2 value1 arg1 more1 more2
  44 ░   description: |-
  45 ░     Call command with option1, option2 and some arguments.
  46 ░ 
```

### Testing verifyCommandDefinition

Exit code: `0`

**Standard** output:

```plaintext


```

**Error** output:

```log
   1 ░ 
   2 ░ command: test
   3 ░ author: github.com/jcaillon
   4 ░ fileToSource: source
   5 ░ shortDescription: Short description.
   6 ░ description: |-
   7 ░   A long description.
   8 ░ 
   9 ░   In a multi-line string.
  10 ░ 
  11 ░   With 3 paragraphs.
  12 ░ sudo: false
  13 ░ hideInMenu: false
  14 ░ arguments:
  15 ░ - name: arg1
  16 ░   description: Description of arg 1.
  17 ░ - name: arg2
  18 ░   description: Description of arg 2.
  19 ░   thirdProp: ok2
  20 ░ - name: arg3
  21 ░   description: Description of arg 3.
  22 ░   fourthProp: ok3
  23 ░ options:
  24 ░ - name: --option1
  25 ░   description: |-
  26 ░     Description of option 1.
  27 ░ 
  28 ░     Another line.
  29 ░   noEnvironmentVariable: true
  30 ░   default: true
  31 ░ - name: --option2
  32 ░   description: |-
  33 ░     Description of option 2.
  34 ░ 
  35 ░     Another line.
  36 ░   noEnvironmentVariable: false
  37 ░ - description: |-
  38 ░     Description of option 3.
  39 ░ 
  40 ░     Another line.
  41 ░   default: default value
  42 ░ examples:
  43 ░ - name: command -o -2 value1 arg1 more1 more2
  44 ░   description: |-
  45 ░     Call command with option1, option2 and some arguments.
  46 ░ 
```

