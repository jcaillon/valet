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

declare -a TEMP_CMD_BUILD_arguments_description=([0]="Description of arg 1." [1]="Description of arg 2." [2]="Description of arg 3.")
declare -a TEMP_CMD_BUILD_arguments_fourthProp=([0]="" [1]="" [2]="ok3")
declare -a TEMP_CMD_BUILD_arguments_name=([0]="arg1" [1]="arg2" [2]="arg3")
declare -a TEMP_CMD_BUILD_arguments_thirdProp=([0]="" [1]="ok2")
declare -- TEMP_CMD_BUILD_author="github.com/jcaillon"
declare -- TEMP_CMD_BUILD_command="test"
declare -- TEMP_CMD_BUILD_description=$'A long description.\n\nIn a multi-line string.\n\nWith 3 paragraphs.'
declare -- TEMP_CMD_BUILD_fileToSource="source"
declare -a TEMP_CMD_BUILD_options_description=([0]=$'Description of option 1.\n\nAnother line.' [1]=$'Description of option 2.\n\nAnother line.' [2]=$'Description of option 3.\n\nAnother line.\n')
declare -a TEMP_CMD_BUILD_options_name=([0]="option1" [1]="option2")
declare -- TEMP_CMD_BUILD_shortDescription="Short description."
```

### Testing extractFirstLongNameFromOptionString

Exit code: `0`

**Standard** output:

```plaintext
→ extractFirstLongNameFromOptionString '-x, --profiling'
--profiling
```

