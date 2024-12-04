# Test suite 1109-self-add-x

## Test script 01.self-add-x

### Testing selfAddCommand

Exit code: `0`

**Standard** output:

```plaintext
→ selfAddCommand 'new cool command'
[2m   ┌─[197b─┐[0m
[2m░──┤[0m It does not look like the current directory ⌜$GLOBAL_VALET_HOME/tests.d/1109-self-add-x/resources/gitignored⌝ is a valet extension, do you want to proceed anyway? [204G[2m│[0m
[2m   └─[197b─┘[0m
[1G[0J
[1F[?25l[7m   (Y)ES   [0m      (N)O   [0m[1G[0K[?25h[2m[9G┌─[4b─┐[0m
[2m[9G│[0m Yes. [16G[2m├──░[0m
[2m[9G└─[4b─┘[0m
→ selfAddCommand 'new cool command'
[2m   ┌─[50b─┐[0m
[2m░──┤[0m Do you want to override the existing command file? [57G[2m│[0m
[2m   └─[50b─┘[0m
[1G[0J
[1F[?25l[7m   (Y)ES   [0m      (N)O   [0m[1G[0K[?25h[2m[9G┌─[4b─┐[0m
[2m[9G│[0m Yes. [16G[2m├──░[0m
[2m[9G└─[4b─┘[0m

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

**Error** output:

```log
WARNING  The current directory is not under the valet user directory ⌜/nop/.valet.d⌝.
SUCCESS  The command ⌜new cool command⌝ has been created with the file ⌜$GLOBAL_VALET_HOME/tests.d/1109-self-add-x/resources/gitignored/commands.d/new-cool-command.sh⌝.
WARNING  The command file ⌜$GLOBAL_VALET_HOME/tests.d/1109-self-add-x/resources/gitignored/commands.d/new-cool-command.sh⌝ already exists.
SUCCESS  The command ⌜new cool command⌝ has been created with the file ⌜$GLOBAL_VALET_HOME/tests.d/1109-self-add-x/resources/gitignored/commands.d/new-cool-command.sh⌝.
```

### Testing selfAddLibrary

Exit code: `0`

**Standard** output:

```plaintext
→ selfAddLibrary 'new-cool-lib'
[2m   ┌─[197b─┐[0m
[2m░──┤[0m It does not look like the current directory ⌜$GLOBAL_VALET_HOME/tests.d/1109-self-add-x/resources/gitignored⌝ is a valet extension, do you want to proceed anyway? [204G[2m│[0m
[2m   └─[197b─┘[0m
[1G[0J
[1F[?25l[7m   (Y)ES   [0m      (N)O   [0m[1G[0K[?25h[2m[9G┌─[4b─┐[0m
[2m[9G│[0m Yes. [16G[2m├──░[0m
[2m[9G└─[4b─┘[0m
→ selfAddLibrary 'new-cool-lib'
[2m   ┌─[50b─┐[0m
[2m░──┤[0m Do you want to override the existing library file? [57G[2m│[0m
[2m   └─[50b─┘[0m
[1G[0J
[1F[?25l[7m   (Y)ES   [0m      (N)O   [0m[1G[0K[?25h[2m[9G┌─[4b─┐[0m
[2m[9G│[0m Yes. [16G[2m├──░[0m
[2m[9G└─[4b─┘[0m

→ cat commands.d/new-cool-command.sh

```

**Error** output:

```log
WARNING  The current directory is not under the valet user directory ⌜/nop/.valet.d⌝.
SUCCESS  The library ⌜new-cool-lib⌝ has been created with the file ⌜$GLOBAL_VALET_HOME/tests.d/1109-self-add-x/resources/gitignored/libraries.d/lib-new-cool-lib⌝.
WARNING  The library file ⌜$GLOBAL_VALET_HOME/tests.d/1109-self-add-x/resources/gitignored/libraries.d/lib-new-cool-lib⌝ already exists.
SUCCESS  The library ⌜new-cool-lib⌝ has been created with the file ⌜$GLOBAL_VALET_HOME/tests.d/1109-self-add-x/resources/gitignored/libraries.d/lib-new-cool-lib⌝.
```

