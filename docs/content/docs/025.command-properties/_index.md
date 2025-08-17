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
shortDescription: A short sentence displayed in the command menu.
description: |-
  A long description that can use ⌜quotes⌝ which is displayed on --help.
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

> [!IMPORTANT]
> Don't forget to [re-build Valet](../new-commands/#-rebuild-valet-menu) after making changes to your command definitions.

## 🫚 API reference

Find below the possible command properties and their meaning:

{{< properties-table >}}

<!-- ___________________________ -->
<!-- ----- command ---------- -->
{{< properties-row name="command" mandatory="✔️" >}}
The name with which your command can be called by the user. E.g. `mycmd` will be accessible with `valet mycmd`.
{{< /properties-row >}}

<!-- ___________________________ -->
<!-- ----- function ---------- -->
{{< properties-row name="function" mandatory="✔️" >}}
The name of the function that corresponds to the command. This is the function that will be called by Valet when the user executes this command.
{{< /properties-row >}}

<!-- ___________________________ -->
<!-- ----- shortDescription ---------- -->
{{< properties-row name="shortDescription" mandatory="✔️" >}}
Shortly describe your command. This will appear next to your command name in the valet menu.

This should be a single, short, line.
{{< /properties-row >}}

<!-- ___________________________ -->
<!-- ----- description ---------- -->
{{< properties-row name="description" mandatory="✔️" >}}
Long description of your command and its purpose. It will display when getting the help/usage on the command using `valet help command` or `valet command --help`.
{{< /properties-row >}}

<!-- ___________________________ -->
<!-- ----- hideInMenu ---------- -->
{{< properties-row name="hideInMenu" mandatory="" >}}
Set to `true` if you do not want this command to appear in the Valet menu. The command will still get listed in the help/usage of valet.
{{< /properties-row >}}

<!-- ___________________________ -->
<!-- ----- arguments ---------- -->
{{< properties-row name="arguments" mandatory="" >}}
A list of positional arguments for your command.

Arguments are parsed in the order given in the list of arguments for the command definition.

{{< properties-table >}}

{{< properties-row name="name" mandatory="✔️" >}}
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
{{< /properties-row >}}

{{< properties-row name="description" mandatory="✔️" >}}
The description for this argument. It will be used to display the help/usage of the command.
{{< /properties-row >}}

{{< /properties-table >}}
{{< /properties-row >}}

<!-- ___________________________ -->
<!-- ----- options ---------- -->
{{< properties-row name="options" mandatory="" >}}
A list of options for your command.

{{< properties-table >}}

{{< properties-row name="name" mandatory="✔️" >}}
The option name(s). An option can have one or more long name and up to one short name. Each name is separated with `, `.

- A short name is composed of a single hyphen and a single letter. E.g. `-o` or `-b`.
- A long name is composed of two hyphens then a valid string (alpha numerical that can contain hyphens). E.g. `--option` or `--my-great-option`.

An option can be a simple true/false flag or it can hold a user value:

- If the option ends with ` <something>`, then the option will hold a value passed by the user.
- Otherwise, the option will be a simple flag and will be equal to `true` if the user passed the option, `false` otherwise.

When calling `command::parseArguments` options will be parsed to local variable which name correspond to the camelCase equivalent of the first long option name.

Example of a valid option names and their corresponding variable name:

- `--profiler` → `local profiling`
- `-t, --thing` → `local thing`
- `-l, --log-level, --log <level>` → `local logLevel`

Short names can be grouped together when calling the command. E.g. `-fsL` is equivalent to `-f -s -L` or equivalent to the long name options `--force --silent --follow`.
{{< /properties-row >}}

{{< properties-row name="description" mandatory="✔️" >}}
The description for this option. It will be used to display the help/usage of the command.
{{< /properties-row >}}

{{< properties-row name="noEnvironmentVariable" mandatory="" >}}
By default, an option that can have a value (e.g. `--option <something>`) will be parsed to a local variable which default to a global variable if not value was passed by the user.

For instance, the option `--option1` will be parsed to the local variable `option1` with the following definition: `local option1="${VALET_OPTION1:-}"`. This allows to define options through environment variable.

This behavior can be changed by setting `noEnvironmentVariable: true` which will always make the local variable for the option empty.
{{< /properties-row >}}

{{< properties-row name="default" mandatory="" >}}
The default value to give to the local variable parsed from the option. The global variable will take precedence (see noEnvironmentVariable).

The local variable will be defined like this: `local option1="${VALET_OPTION1:-"default value"}"`. Where `default value` is the value of this option.
{{< /properties-row >}}

{{< /properties-table >}}

> [!TIP]
> All commands will have, by default, an `-h, --help` option to display the help of the command.
{{< /properties-row >}}

<!-- ___________________________ -->
<!-- ----- examples ---------- -->
{{< properties-row name="examples" mandatory="" >}}
A list of examples for your command.

Examples are used in the command help/usage and let the user quickly understand how to use the command.

{{< properties-table >}}

{{< properties-row name="name" mandatory="✔️" >}}
The command for this example.

You should not include `valet` as it will be prepended automatically. If you do not want to prepend it, start the name with `!` (useful to illustrate a more complex command line).
{{< /properties-row >}}

{{< properties-row name="description" mandatory="✔️" >}}
The description for this example.
{{< /properties-row >}}

{{< /properties-table >}}
{{< /properties-row >}}

{{< /properties-table >}}

[showcase-examples]: https://github.com/jcaillon/valet/tree/main/showcase.d/commands.d

{{< main-section-end >}}
