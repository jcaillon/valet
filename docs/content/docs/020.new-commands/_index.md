---
title: ✨ Create a command
cascade:
  type: docs
weight: 20
url: /docs/new-commands
---

Once you have [created an extension][newExtensionsLink] and opened its directory, you can start creating your new commands.

## 📂 Command files location

Commands are found and indexed by Valet if they are defined in `*.sh` bash scripts located in the `commands.d` directory of your extensions.

Commands can be defined individually in separated files or can be regrouped in a single script. Keep in mind that the bash script of the command function will be sourced, so you might want to keep them light/short.

Here is an example content for your user directory:

{{< filetree/container >}}
  {{< filetree/folder name="~/.valet.d" >}}
    {{< filetree/folder name="my-extension" >}}
      {{< filetree/folder name="commands.d" >}}
        {{< filetree/file name="my-awesome-cmd.sh" >}}
        {{< filetree/file name="another.sh" >}}
      {{< /filetree/folder >}}
    {{< /filetree/folder >}}
  {{< /filetree/folder >}}
{{< /filetree/container >}}

## ➕ Create a command

{{% steps %}}

### 🧑‍💻 Setup your development environment

The section [working on bash][work-on-bash-scripts] will help you set up a coding environment for bash.

Open your existing extension directory or [create a new one][newLibraryLink].

### 📄 Add a new command file

{{< callout type="info" >}}
This step is optional, you can add a command in an existing file.
{{< /callout >}}

Run the command `valet self add-command my-command` to create a new command file named `my-command.sh` in the `commands.d` directory of your extension. _Replace `my-command` with the name of your command._

Alternatively, create the file manually.

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
  command::parseArguments "$@" && eval "${RETURNED_VALUE}"
  command::checkParsedResults
}
```

**Explanations:**

- `command::parseArguments "$@"` is a core function of Valet which parses the input argument (i.e. `$@`) and returns a string in the global variable `RETURNED_VALUE` which can be evaluated to set local variables corresponding to arguments and options. See the function help in the [core library documentation page][core-library].
- `eval "${RETURNED_VALUE}"` evaluates the output string of the parsing function which sets local variables.
- `command::checkParsedResults` will check if the local variable `help` is true, which corresponds to the option `--help` passed to the function, in which case it will display the function help and stop its execution. It will also check if the local variable `parsingErrors` is not empty, which indicates that the parsing function encountered input errors: the function execution is also stopped with parsing errors shown to the user.

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
  command::parseArguments "$@" && eval "${RETURNED_VALUE}"
  # check if we need to exit because there was some inputs errors or if we need to just display the help
  command::checkParsedResults

  # use options and arguments
  echo "${myOption} and ${myArgument}"
}
```

Executing `valet example --my-option opt1 arg1` will display `opt1 and arg1` in the standard output:

- An option named `-o, --my-option` will translate to a local variable `myOption` (takes the first long name found and convert it to camel case).
- An argument named `my-argument` will translate to a local variable `myArgument` (camel case).

Check [the command properties section][command-properties] for more details on how arguments and options are translated to local variables.

#### Understand the parser

The function `command::parseArguments "$@"` will return a string that can be evaluated to define the parsed options and arguments as local variables.

With the command example above, assuming that the user input is `valet example --thing --my-option opt1 arg1` the content of the global variable `RETURNED_VALUE` would be:

```bash
local myoptions="opt1"
localmyArgument="arg1"
local parsingErrors="Unknown option '--thing'"
```

The `parsingErrors` variable contains the parser error: here we passed an option that is unknown for this command. Calling `command::checkParsedResults` will print that parsing error message to the user and exit the program.

#### Access Valet library functions

In the function of a command, you have access by default to a set of Valet functions:

- All the core functions, i.e. function starting with `core::`. See the [core library documentation page][core-library] for more available functions.
- All the log functions, i.e. function starting with `log::`. See the [core library documentation page][core-library] for more available functions.

More useful function are accessible by including a Valet library in your script or command function. For this, you need to _source_ the library that you need, e.g.:

```bash
source string
```

You can find a list of [all the libraries here][libraries].

Additionally, you can create your own library functions. See the [create a library][newLibraryLink] section for more information.

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

#### Notable information

Valet uses the the 3rd, 4th, 5th and 6 file descriptors for various internal purposes. If you need to use file descriptors in your command, you should use the 7th, 8th or 9th file descriptors.

#### Implementation tips

The section [performance tips][performance-tips] gives you pointer to write scripts that are fast to execute.

You don't have to remember all the Valet functions or look at the documentation every 5s: check [this section][work-on-bash-scripts] to learn how to configure VScode to have autocompletion on all Valet functions.

### 🧪 (optional) Test your command

Please check the [create a test](../test-commands) section.

### 🛠️ Rebuild valet menu

You will not find your command in the Valet menu nor will you be able to execute it immediately after adding (or modifying) its definition.

You first need to let Valet "re-index" all your commands by executing the `self build`.

The build process consists of updating the `~/.valet.d/commands` file by extracting all the commands definitions from your scripts. This file defines variables which are used internally by Valet.

{{< callout type="info" >}}
In case of an issue with your `~/.valet.d/commands` file you might be unable to run the `self build` command. In which case you can execute the build directly by calling `${VALET_HOME}/commands.d/self-build.sh` (`VALET_HOME` being your Valet installation directory).
{{< /callout >}}

During the build, all files matching `*.sh` will be read by Valet to look for command definitions, and the search is recursive. Hidden directories (starting with a `.`) will be ignored, consider this rule to lower the build time if it becomes too important.

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

[work-on-bash-scripts]: ../work-on-bash-scripts
[performance-tips]: performance-tips
[showcase-commands]: https://github.com/jcaillon/valet/tree/latest/examples.d/showcase
[command-properties]: ../command-properties
[core-library]: ../libraries/core/
[bash-manual-set]: https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html#index-set
[profiler-output-example]: https://github.com/jcaillon/valet/blob/latest/tests.d/cli-profiler/results.approved.md
[libraries]: ../libraries
[newExtensionsLink]: ../new-extensions
[newLibraryLink]: ../new-libraries
