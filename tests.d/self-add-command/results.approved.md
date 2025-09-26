# Test suite self-add-command

## Test script 00.self-add-command

### ✅ Testing self add-command

❯ `selfAddCommand new\ cool\ command`

**Standard output**:

```text
🙈 mocking interactive::confirm It does not look like the current directory ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/self-add-command/resources/gitignored⌝ is a valet extension, do you want to proceed anyway?
```

**Error output**:

```text
WARNING  The current directory is not under the valet user directory ⌜/tmp/valet.valet.d⌝.
SUCCESS  The command ⌜new cool command⌝ has been created with the file ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/self-add-command/resources/gitignored/commands.d/new-cool-command.sh⌝.
```

❯ `selfAddCommand new\ cool\ command`

**Standard output**:

```text
🙈 mocking interactive::confirm Do you want to override the existing command file?
```

**Error output**:

```text
WARNING  The command file ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/self-add-command/resources/gitignored/commands.d/new-cool-command.sh⌝ already exists.
SUCCESS  The command ⌜new cool command⌝ has been created with the file ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/self-add-command/resources/gitignored/commands.d/new-cool-command.sh⌝.
```

❯ `fs::cat commands.d/new-cool-command.sh`

**Standard output**:

```text
#!/usr/bin/env bash

#===============================================================
# >>> command: new cool command
#===============================================================

: <<"COMMAND_YAML"
command: new cool command
function: newCoolCommand
shortDescription: My new command one line description.
description: |-
  My long description.
sudo: false
hideInMenu: false
arguments:
- name: first-arg
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
COMMAND_YAML
function newCoolCommand() {
  local -a more
  local firstArg option1 thisIsOption2
  command::parseArguments "$@"; eval "${REPLY}"
  command::checkParsedResults

  log::info "First argument: ${firstArg:-}."
  log::info "Option 1: ${option1:-}."
  log::info "Option 2: ${thisIsOption2:-}."
  log::info "More: ${more[*]}."

  # example use of a library function
  # Importing the string library (note that we could also do that at the beginning of the script)
  # shellcheck disable=SC1091
  source string
  local _myString="<b>My bold text</b>"
  string::extractBetween _myString "<b>" "</b>"
  local extractedText="${REPLY}"
  log::info "Extracted text is: ⌜${extractedText:-}⌝"
}
```

