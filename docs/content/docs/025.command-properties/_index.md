---
title: ⚙️ Command properties
cascade:
  type: docs
weight: 25
url: /docs/command-properties
---

This page describes the properties available to define a command.

Here is a definition example that uses all the properties:

```yaml {linenos=table,linenostart=1}
command: command
function: functionName
shortDescription: A short sentence.
description: |-
  A long description that can use ⌜quotes⌝.
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
- name: command -o -2 value1 arg1 more1 more2
  description: |-
    Call command with option1, option2 and some arguments.
```

You can check the [showcase commands][showcase-examples] to get definition examples.

## 🫚 Top level properties

The available properties are:

### ✔️ command

The name with which your command can be called by the user. E.g. `mycmd` will be accessible with `valet mycmd`.

| Mandatory? | Default value? |
|----------|---------------|
| yes ✔️ | N/A |

### ✔️ function

The name of the function that corresponds to the command. This is the function that will be called by Valet when the user executes this command.

| Mandatory? | Default value? |
|----------|---------------|
| yes ✔️ | N/A |

### ✔️ shortDescription

Shortly describe your command. This will appear next to your command name in the valet menu.

This should be a single, short, line.

| Mandatory? | Default value? |
|----------|---------------|
| yes ✔️ | N/A |

### ✔️ description

Long description of your command and its purpose. It will display when getting the help/usage on the command using `valet help command` or `valet command --help`.

| Mandatory? | Default value? |
|----------|---------------|
| yes ✔️ | N/A |

### sudo

Set to `true` if you intend to use `sudo` in your command. It will define a `SUDO` variable that you should instead (e.g. `${SUDO} cp stuff /usr/bin/local/stuff` instead of `sudo cp stuff /usr/bin/local/stuff`).

The idea is to make your command compatible for systems with and without `sudo`. The variable `SUDO` will be defined as empty if the sudo command can not be found.

If `true`, it will prompt the user for sudo password before executing the command.

| Mandatory? | Default value? |
|----------|---------------|
| no | false |

### hideInMenu

Set to `true` if you do not want this command to appear in the Valet menu. The command will still get listed in the help/usage of valet.

| Mandatory? | Default value? |
|----------|---------------|
| no | false |

### arguments

A list of arguments for your command. See [Arguments](#-arguments) for the details of an argument.

| Mandatory? | Default value? |
|----------|---------------|
| no | N/A |

### options

A list of options for your command. See [Options](#️-options) for the details of an option.

By definition, an option is optional (i.e. it is not mandatory like an argument). If you expect an option to be defined, then it is an argument.

{{< callout type="info" emoji="💡" >}}
All commands have, by default, an `-h, --help` option to display the help of the command.
{{< /callout >}}

| Mandatory? | Default value? |
|----------|---------------|
| no | N/A |

### examples

A list of examples for your command. See [Examples](#-examples) for the details of an example.

They are used exclusively in the command help/usage text.

## 💬 Arguments

Arguments are parsed in the order given in the list of arguments for the command definition.

### ✔️ name

The argument name (in kebab-case).

When calling `command::parseArguments` the argument will be parsed to local variable which name correspond to the camelCase equivalent of its name.

Moreover, the name can be suffixed to enable extra features:

- The name ends with `...` then the argument will be defined as an array and the variable will hold all remaining arguments. Only the last argument can be suffixed like that.
- The name ends with `?` then the argument is optional (otherwise there will be an error if the user does not provide a value). Only the last arguments can be suffixed like that.
- The name ends with `?...` then the argument is an optional array (combination of the two above).

Example of a argument names and their corresponding variables:

- `my-arg1` → `local myArg1`
- `files...` → `local -a files`
- `commands?...` → `local -a commands`

| Mandatory? | Default value? |
|----------|---------------|
| yes ✔️ | N/A |

### ✔️ description

The description for this argument. It will be used to display the help/usage of the command.

| Mandatory? | Default value? |
|----------|---------------|
| yes ✔️ | N/A |

## 🎚️ Options

### ✔️ name

The option name(s). An option can have one or more long name and up to one short name. Each name is separated with `, `.

- A short name is composed of a single hyphen and a single letter. E.g. `-o` or `-b`.
- A long name is composed of two hyphens then a valid string (alpha numerical that can contain hyphens). E.g. `--option` or `--my-great-option`.

An option can be a simple true/false flag or it can hold a user value:

- If the option ends with ` <something>`, then the option will hold a value passed by the user.
- Otherwise, the option will be a simple flag and will be equal to `true` if the user passed the option, `false` otherwise.

When calling `command::parseArguments` options will be parsed to local variable which name correspond to the camelCase equivalent of the first long option name.

Example of a valid option names and their corresponding variable name:

- `-x, --profiling` → `local profiling`
- `--thing` → `local thing`
- `-l, --log-level, --log <level>` → `local logLevel`

Short names can be grouped together when calling the command. E.g. `-fsL` is equivalent to `-f -s -L` or equivalent to the long name options `--force --silent --follow`.

| Mandatory? | Default value? |
|----------|---------------|
| yes ✔️ | N/A |

### ✔️ description

The description for this option. It will be used to display the help/usage of the command.

| Mandatory? | Default value? |
|----------|---------------|
| yes ✔️ | N/A |

### noEnvironmentVariable

By default, an option that can have a value (e.g. `--option <something>`) will be parsed to a local variable which default to a global variable if not value was passed by the user.

For instance, the option `--option1` will be parsed to the local variable `option1` with the following definition: `local option1="${VALET_OPTION1:-}"`. This allows to define options through environment variable.

This behavior can be changed by setting `noEnvironmentVariable: true` which will always make the local variable for the option empty.

| Mandatory? | Default value? |
|----------|---------------|
| no | false |

### default

The default value to give to the local variable parsed from the option. The global variable will take precedence (see noEnvironmentVariable).

The local variable will be defined like this: `local option1="${VALET_OPTION1:-"default value"}"`. Where `default value` is the value of this option.

| Mandatory? | Default value? |
|----------|---------------|
| no | N/A |

## 🎈 Examples

Examples are used in the command help/usage and let the user quickly understand how to use the command.

### ✔️ name

The command for this example.

You should not include `valet` as it will be prepended automatically. If you do not want to prepend it, start the name with `!` (useful to illustrate a more complex command line).

| Mandatory? | Default value? |
|----------|---------------|
| yes ✔️ | N/A |

### ✔️ description

The description for this example.

| Mandatory? | Default value? |
|----------|---------------|
| yes ✔️ | N/A |

{{< cards >}}
  {{< card icon="arrow-circle-left" link="../new-commands" title="New commands" >}}
  {{< card icon="arrow-circle-right" link="../test-commands" title="Test commands" >}}
{{< /cards >}}

[showcase-examples]: https://github.com/jcaillon/valet/tree/main/showcase.d/commands.d