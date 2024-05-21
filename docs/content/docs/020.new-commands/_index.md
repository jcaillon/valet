---
title: ✨ New commands
cascade:
  type: docs
weight: 20
url: /docs/new-commands
---

This page describes how to add your own commands in Valet. Make sure to review the [Valet usage][usage] first to get a good understanding of what is a command.

The section [working on bash][work-on-bash-scripts] helps you set up a coding environment for bash.

## 📂 Commands file location

Commands are found and indexed by Valet if they are defined in `*.sh` bash scripts located under your user directory which defaults to `~/.valet.d`. This directory can be changed with the variable `VALET_USER_DIRECTORY`, see [configuration][configuration].

It is recommended to organize commands in subdirectories which has the added benefice of allowing you to share commands with other, by cloning repositories under your `~/.valet.d` directory.

Commands can be defined individually in separated files or can be regrouped in a single script. Keep in mind that the bash script of the command function will be sourced, so you might want to keep them light/short.

Here is an example content for your user directory:

{{< filetree/container >}}
  {{< filetree/folder name="~/.valet.d" >}}
    {{< filetree/folder name="showcase" >}}
      {{< filetree/file name="showcase.sh" >}}
      {{< filetree/file name="showcase-interactive.sh" >}}
    {{< /filetree/folder >}}
    {{< filetree/folder name="personal" >}}
      {{< filetree/file name="myawesomecmd.sh" >}}
      {{< filetree/file name="another.sh" >}}
    {{< /filetree/folder >}}
    {{< filetree/folder name="shared-commands" state="closed" >}}
      {{< filetree/file name="file.sh" >}}
    {{< /filetree/folder >}}
  {{< /filetree/folder >}}
{{< /filetree/container >}}

## ➕ Create a command

{{% steps %}}

### Add a new command file

{{< callout type="info" >}}
This step is optional, you can add a command in an existing file.
{{< /callout >}}

Create a new bash script with the file extension `.sh` under your user directory. E.g.:

{{< filetree/container >}}
  {{< filetree/folder name="~/.valet.d" >}}
    {{< filetree/file name="command.sh" >}}
  {{< /filetree/folder >}}
{{< /filetree/container >}}

Add the bash [shebang][shebang] at the beginning of the file to help your editor identifying the correct shell:

```bash
#!/usr/bin/env bash
```

### Define your new command

Valet looks for a specific YAML formatted string to read command properties.

A very simple example is:

```bash
: "---
command: hello-world
function: helloWorld
shortDescription: A dummy command.
description: |-
  This command says hello world.
---"
```

In the example above, we need to define a bash function named `helloWorld` in the same file as the command properties (see next step). When running `valet hello-world`, this function will be called.

A list of all the available command properties can be found in [this section][command-properties].

Fore more examples, take a look at the [showcase command definitions][showcase-commands].

### Implement your command

Once the command properties are set.

Valet has a function to parse the expected options and arguments directly into variables. See the example file `showcase.sh`. Here is a standard usage of the parser:

```bash
local myOption myArgument
# parse the arguments of the command
core::parseArguments "$@" && eval "${RETURNED_VALUE}"
# check if we need to fail because there was some inputs errors or if we need to just display the help
core::checkParseResults "${help:-}" "${parsingErrors:-}"

# check if the user asked to just display the help of this command
if [[ -n "${help:-}" ]]; then core::showHelp; return 0; fi

# check if the parser caught some errors and fail if so
if [[ -n "${parsingErrors:-}" ]]; then core::fail "${parsingErrors}"; fi

# use options and arguments
echo "${myOption} > ${myArgument}"
# e.g. if the user called
# valet mycmd --my-option opt1 arg1
# the line above would display
# opt1 > arg1
```

- An option named `-o, --my-option` will translate to a local variable `myOption` (takes the first long name found and convert it to camel case).
- An argument named `my-argument` will translate to a local variable `myArgument` (camel case).
- An argument named `my-other-args...` will translate to a local bash array `myOtherArgs` (camel case). Note that only the last argument can end with `...` to indicate an array of arguments.
- `parsingErrors` will contain the parsing error messages (one per line).

The function `main::parseFunctionArgumentsOrmain::goInteractive` will return a string that can be evaluated to define the parsed variables. E.g. it can look like that:

```bash
local parsingErrors myOption myArgument
myoptions="opt1"
myArgument="arg1"
parsingErrors="Unknown option '--truc'"
```

In the function of a command, you have access to all functions defined in `valet.d/core`.

In case of error, your function should call the `fail` directly which will exit the program while displaying a meaningful message to the user.

 The section [performance tips][performance-tips] gives you pointer to write scripts that are fast to execute.

> [!NOTE]
> In Valet, the bash options are set like so `set -Eeu -o pipefail`, which means that your command will stop with an error if any statement returns an error code different than zero. This also include any program in a pipe.
>
> If you expect a statement to fail but want to continue the execution, catch the exit code:
> `thingThatReturns1 || exitCode=$?`
> Or simply discard the error:
> `thingThatReturns1 || :`

### (optional) Test your command

Please check the [test command](../test-commands) section.

### Rebuild valet menu

In order to find your new command in the valet menu; you need to call the `self build` command. Either from the valet menu or by executing directly `./valet.d/commands.d/self-build.sh`. The later option is mandatory if you have an issue with the `valet.d/cmd` file itself.

The build process consists of recreating the `valet.d/cmd` program by reading all the `about_xxx` functions and extracting info from the YAML definition. It also appends all the functions defined in `cmd-extra`.

{{< callout type="info" emoji="💡" >}}
During the build, all files matching `*.sh` will be read by Valet and the search is recursive. Directories named `tests.d` or hidden directory (starting with a `.`) will be ignored. Consider these rules to lower the build time if it becomes too important.
{{< /callout >}}

{{% /steps %}}

## 🐛 How to debug your program

Your command function is not working as expected or seems stuck?

Two ways to approach this problem:

- Run your valet command in the bash debugger on Visual Studio.
- Or use the `valet -x` option to enable the profiler (this turns the debug mode on `set -x`). This will output the complete trace in `~/valet-profiler-{PID}.txt` (or you can choose the destination with the environment variable `VALET_CONFIG_COMMAND_PROFILING_FILE`). You can see what the profiling file looks like in this [test report](../tests.d/1301-profiler/results.approved.md).

Of course, a simpler strategy is to log stuff with `debug` (you can also do `if log::isDebugEnabled; then log::debug "stuff"; fi` to avoid computing a string value for debug).

You can active the debug log level with Valet `-v` option, e.g. `valet -v my command`.

## Extra: defining sub commands

If your new command name contains one or more spaces, you are defining a sub command. E.g. `sub cmd` defines a command `cmd` which is a sub command of the `sub` command. It can be useful to regroup commands under a theme. Valet will show a menu for the command `sub` which displays only the sub commands under this command.

{{< cards >}}
  {{< card icon="arrow-circle-left" link="../configuration" title="Configuration" >}}
  {{< card icon="arrow-circle-right" link="../command-properties" title="Command properties" >}}
{{< /cards >}}

[usage]: ../usage
[work-on-bash-scripts]: ../work-on-bash-scripts
[performance-tips]: performance-tips
[configuration]: ../configuration
[shebang]: https://en.wikipedia.org/wiki/Shebang_(Unix)
[showcase-commands]: https://github.com/jcaillon/valet/tree/main/examples.d/showcase
[command-properties]: ../command-properties