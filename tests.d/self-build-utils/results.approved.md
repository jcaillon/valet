# Test suite self-build-utils

## Test script 00.self-build-utils

### ✅ Testing selfBuild_extractCommandYamls

❯ `selfBuild_extractCommandYamls resources/extract-command-yamls-test-file`

Returned variables:

```text
REPLY_ARRAY=(
[0]='A content between tags
array:
  - item1
  - item2
  - item3
'
[1]='yep!
'
[2]='And another one!
'
)
```

### ✅ Testing selfBuild_extractFirstLongNameFromOptionString

❯ `selfBuild_extractFirstLongNameFromOptionString -x\,\ --profiling`

Returned variables:

```text
REPLY='--profiling'
```

### ✅ Testing to extract command definition to variables

```text
_VALID_YAML='
command: test
author: github.com/jcaillon
fileToSource: source
shortDescription: Short description.
description: |-
  A long description.

  In a multi-line string.

  With 3 paragraphs.
sudo: false
hideInMenu: false
arguments:
- name: arg1
  description: Description of arg 1.
- name: arg2
  description: Description of arg 2.
  thirdProp: ok2
- name: arg3
  description: Description of arg 3.
  fourthProp: ok3
options:
- name: --option1
  description: |-
    Description of option 1.

    Another line.
  noEnvironmentVariable: true
  default: true
- name: --option2
  description: |-
    Description of option 2.

    Another line.
  noEnvironmentVariable: false
- description: |-
    Description of option 3.

    Another line.
  default: default value
examples:
- name: command -o -2 value1 arg1 more1 more2
  description: |-
    Call command with option1, option2 and some arguments.
'
```

❯ `selfBuild_extractCommandDefinitionToVariables "${_VALID_YAML}"`

```text
TEMP_CMD_BUILD_arguments_description=(
[0]='Description of arg 1.'
[1]='Description of arg 2.'
[2]='Description of arg 3.'
)
TEMP_CMD_BUILD_arguments_fourthProp=(
[0]=''
[1]=''
[2]='ok3'
)
TEMP_CMD_BUILD_arguments_name=(
[0]='arg1'
[1]='arg2'
[2]='arg3'
)
TEMP_CMD_BUILD_arguments_thirdProp=(
[0]=''
[1]='ok2'
)
TEMP_CMD_BUILD_author='github.com/jcaillon'
TEMP_CMD_BUILD_command='test'
TEMP_CMD_BUILD_description='A long description.

In a multi-line string.

With 3 paragraphs.'
TEMP_CMD_BUILD_examples_description=(
[0]='Call command with option1, option2 and some arguments.
'
)
TEMP_CMD_BUILD_examples_name=(
[0]='command -o -2 value1 arg1 more1 more2'
)
TEMP_CMD_BUILD_fileToSource='source'
TEMP_CMD_BUILD_hideInMenu='false'
TEMP_CMD_BUILD_options_default=(
[0]='true'
[1]=''
[2]='default value'
)
TEMP_CMD_BUILD_options_description=(
[0]='Description of option 1.

Another line.'
[1]='Description of option 2.

Another line.'
[2]='Description of option 3.

Another line.'
)
TEMP_CMD_BUILD_options_name=(
[0]='--option1'
[1]='--option2'
)
TEMP_CMD_BUILD_options_noEnvironmentVariable=(
[0]='true'
[1]='false'
)
TEMP_CMD_BUILD_shortDescription='Short description.'
TEMP_CMD_BUILD_sudo='false'
```

❯ `declareFinalCommandDefinitionCommonVariables func cmd`

❯ `declareFinalCommandDefinitionHelpVariables func`

❯ `declareFinalCommandDefinitionParserVariables func`

```text
CMD_ALL_COMMANDS_ARRAY=(
[0]='cmd'
)
CMD_ALL_FUNCTIONS_ARRAY=(
[0]='func'
)
CMD_ARGS_LAST_IS_ARRAY_func='false'
CMD_ARGS_NAME_func=(
[0]='arg1'
[1]='arg2'
[2]='arg3'
)
CMD_ARGS_NB_OPTIONAL_func='0'
CMD_ARGUMENTS_DESCRIPTION_func=(
[0]='Description of arg 1.'
[1]='Description of arg 2.'
[2]='Description of arg 3.'
)
CMD_ARGUMENTS_NAME_func=(
[0]='arg1'
[1]='arg2'
[2]='arg3'
)
CMD_COMMAND_func='cmd'
CMD_DESCRIPTION_func='A long description.

In a multi-line string.

With 3 paragraphs.'
CMD_EXAMPLES_DESCRIPTION_func=(
[0]='Call command with option1, option2 and some arguments.
'
)
CMD_EXAMPLES_NAME_func=(
[0]='valet command -o -2 value1 arg1 more1 more2'
)
CMD_FILETOSOURCE_func='source'
CMD_FUNCTION_NAME_cmd='func'
CMD_MAX_COMMAND_WIDTH='3'
CMD_MAX_SUB_COMMAND_LEVEL='0'
CMD_OPTIONS_DESCRIPTION_func=(
[0]='Description of option 1.

Another line.'
[1]='Description of option 2.

Another line.
This option can be set by exporting the variable VALET_OPTION2='"'"'true'"'"'.'
[2]='Description of option 3.

Another line.'
[3]='Display the help for this command.'
)
CMD_OPTIONS_NAME_func=(
[0]='--option1'
[1]='--option2'
[2]='-h, --help'
)
CMD_OPTS_DEFAULT_func=(
[0]='true'
[1]=''
[2]='default value'
)
CMD_OPTS_HAS_VALUE_func=(
[0]='false'
[1]='false'
[2]='false'
)
CMD_OPTS_NAME_SC_func=(
[0]=''
[1]='VALET_OPTION2'
[2]=''
)
CMD_OPTS_NAME_func=(
[0]='option1'
[1]='option2'
[2]='help'
)
CMD_OPTS_func=(
[0]='--option1'
[1]='--option2'
[2]='-h --help'
)
CMD_SHORT_DESCRIPTION_func='Short description.'
CMD_SUDO_func='false'
```

❯ `selfBuild_verifyCommandDefinition func cmd`

