# Test suite 1109-self-add-x

## Test script 01.self-add-x

### Testing selfAddCommand

Exit code: `0`

**Standard output**:

```text
→ selfAddCommand 'new cool command'
prompt: It does not look like the current directory ⌜$GLOBAL_VALET_HOME/tests.d/1109-self-add-x/resources/gitignored⌝ is a valet extension, do you want to proceed anyway?
→ selfAddCommand 'new cool command'
prompt: Do you want to override the existing command file?

→ cat commands.d/new-cool-command.sh
#!/usr/bin/env bash

#===============================================================
# >>> command: new cool command
#===============================================================

: "---
command: new cool command
function: newCoolCommand
shortDescription: My new command one line description.
description: |-
  My long description.
sudo: false
hideInMenu: false
arguments:
- name: firstArg
  description: |-
    First argument.
- name: more...
  description: |-
    Will be an an array of strings.
options:
- name: -o, --option1
  description: |-
    First option.
  noEnvironmentVariable: true
- name: -2, --this-is-option2 <level>
  description: |-
    An option with a value.
  noEnvironmentVariable: false
examples:
- name: new cool command -o -2 value1 arg1 more1 more2
  description: |-
    Call new cool command with option1, option2 and some arguments.
---"
function newCoolCommand() {
  local -a more
  local firstArg option1 thisIsOption2
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  log::info "First argument: ${firstArg:-}."
  log::info "Option 1: ${option1:-}."
  log::info "Option 2: ${thisIsOption2:-}."
  log::info "More: ${more[*]}."

  # example use of a library function
  # Importing the string library (note that we could also do that at the beginning of the script)
  # shellcheck disable=SC1091
  source string
  string::extractBetween "<b>My bold text</b>" "<b>" "</b>"
  local extractedText="${RETURNED_VALUE}"
  log::info "Extracted text is: ⌜${extractedText:-}⌝"
}
```

**Error output**:

```text
WARNING  The current directory is not under the valet user directory ⌜/nop/.valet.d⌝.
SUCCESS  The command ⌜new cool command⌝ has been created with the file ⌜$GLOBAL_VALET_HOME/tests.d/1109-self-add-x/resources/gitignored/commands.d/new-cool-command.sh⌝.
WARNING  The command file ⌜$GLOBAL_VALET_HOME/tests.d/1109-self-add-x/resources/gitignored/commands.d/new-cool-command.sh⌝ already exists.
SUCCESS  The command ⌜new cool command⌝ has been created with the file ⌜$GLOBAL_VALET_HOME/tests.d/1109-self-add-x/resources/gitignored/commands.d/new-cool-command.sh⌝.
```

### Testing selfAddLibrary

Exit code: `0`

**Standard output**:

```text
→ selfAddLibrary 'new-cool-lib'
prompt: It does not look like the current directory ⌜$GLOBAL_VALET_HOME/tests.d/1109-self-add-x/resources/gitignored⌝ is a valet extension, do you want to proceed anyway?
→ selfAddLibrary 'new-cool-lib'
prompt: Do you want to override the existing library file?

→ cat commands.d/new-cool-command.sh

```

**Error output**:

```text
WARNING  The current directory is not under the valet user directory ⌜/nop/.valet.d⌝.
SUCCESS  The library ⌜new-cool-lib⌝ has been created with the file ⌜$GLOBAL_VALET_HOME/tests.d/1109-self-add-x/resources/gitignored/libraries.d/lib-new-cool-lib⌝.
WARNING  The library file ⌜$GLOBAL_VALET_HOME/tests.d/1109-self-add-x/resources/gitignored/libraries.d/lib-new-cool-lib⌝ already exists.
SUCCESS  The library ⌜new-cool-lib⌝ has been created with the file ⌜$GLOBAL_VALET_HOME/tests.d/1109-self-add-x/resources/gitignored/libraries.d/lib-new-cool-lib⌝.
```

