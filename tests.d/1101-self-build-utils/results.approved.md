# Test suite 1101-self-build-utils

## Test script 00.self-build-utils

### Testing extractCommandYamls

Exit code: `0`

**Standard** output:

```plaintext
content:
⌜A content between tags
array:
  - item1
  - item2
  - item3
⌝
content:
⌜And another one!
⌝
```

### Testing extractCommandDefinitionToVariables

Exit code: `0`

**Standard** output:

```plaintext

command: test
author: github.com/jcaillon
fileToSource: source
shortDescription: Short description.
description: |-
  A long description.

  In a multi-line string.

  With 3 paragraphs.
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
- name: option1
  description: |-
    Description of option 1.

    Another line.
- name: option2
  description: |-
    Description of option 2.

    Another line.
- description: |-
    Description of option 3.

    Another line.

TEMP_CMD_BUILD_arguments_description='Description of arg 1.'
TEMP_CMD_BUILD_arguments_fourthProp=''
TEMP_CMD_BUILD_arguments_name='arg1'
TEMP_CMD_BUILD_arguments_thirdProp=''
TEMP_CMD_BUILD_author='github.com/jcaillon'
TEMP_CMD_BUILD_command='test'
TEMP_CMD_BUILD_description=$'A long description.\n\nIn a multi-line string.\n\nWith 3 paragraphs.'
TEMP_CMD_BUILD_fileToSource='source'
TEMP_CMD_BUILD_options_description=$'Description of option 1.\n\nAnother line.'
TEMP_CMD_BUILD_options_name='option1'
TEMP_CMD_BUILD_shortDescription='Short description.'
```

### Testing extractFirstLongNameFromOptionString

Exit code: `0`

**Standard** output:

```plaintext
→ extractFirstLongNameFromOptionString '-x, --profiling'
--profiling
```

