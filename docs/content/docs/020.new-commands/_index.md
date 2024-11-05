---
title: ✨ New commands
cascade:
  type: docs
weight: 20
url: /docs/new-commands
---

This page describes how to add your own commands in Valet. Make sure to review the [Valet usage][usage] first to get a good understanding of what is a command.

The section [working on bash][work-on-bash-scripts] helps you set up a coding environment for bash.

For command examples, take a look at the [showcase command definitions][showcase-commands].

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

### 📄 Add a new command file

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

### 🔤 Define your new command

Valet looks for a specific YAML formatted string to read command properties.

A simple example is:

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

If your new command name contains one or more spaces, you are defining a sub command. E.g. `sub cmd` defines a command `cmd` which is a sub command of the `sub` command. It can be useful to regroup commands. Valet will show a menu for the command `valet sub` which displays only the sub commands of `sub`.

For more examples, take a look at the [showcase command definitions][showcase-commands].

Alternatively, you can add a new command definition using bash comments and the following format:

```bash
##<<VALET_COMMAND
# command: hello-world
# function: helloWorld
# shortDescription: A dummy command.
# description: |-
#   This command says hello world.
##VALET_COMMAND
```

### ✒️ Implement your command

Once the command properties are set, the next step is to implement the command function.

A minimal command function has the following content (note that the function name matches the example of the previous step: change it to your function name).

```bash {linenos=table,hl_lines=[2,3],linenostart=1,filename="command.sh"}
function helloWorld() {
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"
}
```

**Explanations:**

- `core::parseArguments "$@"` is a core function of Valet which parses the input argument (i.e. `$@`) and returns a string in the global variable `RETURNED_VALUE` which can be evaluated to set local variables corresponding to arguments and options. See the function help in the [core library documentation page][core-library].
- `eval "${RETURNED_VALUE}"` evaluates the output string of the parsing function which sets local variables.
- `core::checkParseResults "${help:-}" "${parsingErrors:-}"` will check if the local variable `help` is true, which corresponds to the option `--help` passed to the function, in which case it will display the function help and stop its execution. It will also check if the local variable `parsingErrors` is not empty, which indicates that the parsing function encountered input errors: the function execution is also stopped with parsing errors shown to the user.

After these two mandatory lines, you can implement your function using local variables defined for you depending on the user inputs. You are guaranteed that the inputs are valid.

{{< callout type="info" >}}
All arguments and option local variables will be defined, even if they are not present in the user inputs.
{{< /callout >}}

#### A command example

Find below the complete definition of a `example` command that can take an option `--my-option` and requires one argument `my-argument`.

```bash {linenos=table,linenostart=1,filename="example.sh"}
: "---
command: example
function: example
shortDescription: An example command
description: |-
  Will display the passed argument and option.
arguments:
- name: my-argument
  description: |-
    First argument.
options:
- name: -o, --my-option
  description: |-
    First option.
---"
function example() {
  local myOption myArgument
  # parse the arguments of the command and evaluates to local variables
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  # check if we need to exit because there was some inputs errors or if we need to just display the help
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  # use options and arguments
  echo "${myOption} and ${myArgument}"
}
```

Executing `valet example --my-option opt1 arg1` will display `opt1 and arg1` in the standard output:

- An option named `-o, --my-option` will translate to a local variable `myOption` (takes the first long name found and convert it to camel case).
- An argument named `my-argument` will translate to a local variable `myArgument` (camel case).

Check [the command properties section][command-properties] for more details on how arguments and options are translated to local variables.

#### Understand the parser

The function `core::parseArguments "$@"` will return a string that can be evaluated to define the parsed options and arguments as local variables.

With the command example above, assuming that the user input is `valet example --thing --my-option opt1 arg1` the content of the global variable `RETURNED_VALUE` would be:

```bash
local myoptions="opt1"
localmyArgument="arg1"
local parsingErrors="Unknown option '--thing'"
```

The `parsingErrors` variable contains the parser error: here we passed an option that is unknown for this command. Calling `core::checkParseResults "${help:-}" "${parsingErrors:-}"` will print that parsing error message to the user and exit the program.

#### Access Valet library functions

In the function of a command, you have access by default to a set of Valet functions:

- All the core functions, i.e. function starting with `core::`. See the [core library documentation page][core-library] for more available functions.
- All the log functions, i.e. function starting with `log::`. See the [core library documentation page][core-library] for more available functions.

More useful function are accessible by including a Valet library in your script or command function. For this, you need to _source_ the library that you need, e.g.:

```bash
source string
```

You can find a list of [all the libraries here][libraries].

#### Error handling and return values

Although you can simply `exit` from a command function, it is recommended to:

- ✅ `return 0` if all went well.
- ❌ `core::fail "My error message"` if something went wrong. This will exit the program with code 1 and print your error to the user. You can use `core::failWithCode` if you need to return a particular exit code.

{{< callout type="warning" >}}
In Valet, the following bash options are set: `set -Eeu -o pipefail`: your function will stop with an error if any statement returns an error code different from zero; this also include any program in a pipe. It will end with an error if you try to use an unset variable.
{{< /callout >}}

The options `set -Eeu -o pipefail` have the [following meaning][bash-manual-set]:

- `-e`: This option instructs the shell to immediately exit if any command has a non-zero exit status.
- `-u`: This option instructs the shell to immediately exit if it tries to use an unset variable.
- `-o pipefail`: This option prevents errors in a pipeline from being masked.
- `-E`: Any trap on ERR is inherited by shell functions, command substitutions, and commands executed in a subshell environment. The ERR trap is normally not inherited in such cases.

If you expect a statement to fail but want to continue the execution, catch the exit code:

```bash
local exitCode=0
thingThatReturns1 || exitCode=$?
if [[ ${exitCode} != 0 ]]; echo "do something if the command failed?..."; fi
```

Or simply discard the error:

```bash
thingThatReturns1 || :
```

If you use a variable that could be unset, provide a default value:

```bash
echo "${myUnsureVariable:-default value}"
```

{{< callout type="info" emoji="💡" >}}
You can also revert these bash options in your function. However, they are very good options to catch unexpected errors in your code, and they force you to pay attention at each possible conditional branches.
{{< /callout >}}

#### Implementation tips

The section [performance tips][performance-tips] gives you pointer to write scripts that are fast to execute.

You don't have to remember all the Valet functions or look at the documentation every 5s: check [this section][work-on-bash-scripts] to learn how to configure VScode to have autocompletion on all Valet functions.

### 🧪 (optional) Test your command

Please check the [test command](../test-commands) section.

### 🛠️ Rebuild valet menu

You will not find your command in the Valet menu nor will you be able to execute it immediately after adding (or modifying) its definition.

You first need to let Valet "re-index" all your commands by executing the `self build`.

The build process consists of updating the `~/.valet.d/commands` file by extracting all the commands definitions from your scripts. This file defines variables which are used internally by Valet.

{{< callout type="info" >}}
In case of an issue with your `~/.valet.d/commands` file you might be unable to run the `self build` command. In which case you can execute the build directly by calling `${VALET_HOME}/valet.d/commands.d/self-build.sh` (`VALET_HOME` being your Valet installation directory).
{{< /callout >}}

During the build, all files matching `*.sh` will be read by Valet to look for command definitions, and the search is recursive. Directories named `tests.d` or hidden directory (starting with a `.`) will be ignored. Consider these rules to lower the build time if it becomes too important.

{{% /steps %}}

## 🐛 How to debug your program

Your command function is not working as expected or seems stuck?

Two ways to approach this problem:

- Run your valet command in the bash debugger on Visual Studio.
- Or use the `valet -x` option to enable the profiler (this turns the debug mode on `set -x`). This will output the complete trace in `~/valet-profiler-{PID}.txt` (or you can choose the destination with the environment variable `VALET_CONFIG_COMMAND_PROFILING_FILE`). You can see what the profiling file looks like in this [test report][profiler-output-example].

Of course, a simpler strategy is to log stuff with `debug` (you can also do `if log::isDebugEnabled; then log::debug "stuff"; fi` to avoid computing a string value for debug).

You can activate the debug log level with Valet `-v` option, e.g. `valet -v my command`.

{{< cards >}}
  {{< card icon="arrow-circle-left" link="../configuration" title="Configuration" >}}
  {{< card icon="arrow-circle-right" link="../command-properties" title="Command properties" >}}
{{< /cards >}}

[usage]: ../usage
[work-on-bash-scripts]: ../work-on-bash-scripts
[performance-tips]: performance-tips
[configuration]: ../configuration
[shebang]: https://en.wikipedia.org/wiki/Shebang_(Unix)
[showcase-commands]: https://github.com/jcaillon/valet/tree/latest/examples.d/showcase
[command-properties]: ../command-properties
[core-library]: ../libraries/core/
[bash-manual-set]: https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html#index-set
[profiler-output-example]: https://github.com/jcaillon/valet/blob/latest/tests.d/1301-profiler/results.approved.md
[libraries]: ../libraries
