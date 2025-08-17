---
title: ✒️ Implement a command
cascade:
  type: docs
weight: 26
url: /docs/implement-a-command
---

Once you have [created a command](../new-commands) and set its [properties](../command-properties), the next step is to implement the command function.

A minimal command function has the following content (where `helloWorld` is the command function name):

```bash {linenos=table,hl_lines=[2,3],linenostart=1,filename="command.sh"}
function helloWorld() {
  command::parseArguments "$@"; eval "${REPLY}"
  command::checkParsedResults
}
```

**Explanations:**

- `command::parseArguments "$@"` is a core function of Valet which parses the input argument (i.e. `$@`) and returns a string in the global variable `REPLY` which can be evaluated to set local variables corresponding to positional arguments and options. See the function help in the [command library documentation page](../libraries/command/#-commandparsearguments).
- `eval "${REPLY}"` evaluates the output string of the parsing function which sets local variables.
- `command::checkParsedResults` will check if the local variable `help` is true, which corresponds to the option `--help` passed to the function, in which case it will display the function help and stop its execution. It will also check if the local variable `commandArgumentsErrors` is not empty, which indicates that the parsing function encountered input errors: the function execution is also stopped with parsing errors shown to the user.

After these two mandatory lines, you can implement your function and expect the existence of local variables for each one of your command arguments and options.

> [!TIP]
> All arguments and option local variables will be defined even if they are not present in the user inputs (set to null in that case).
>
> You can use the bash builtin `local` to list the existing local variables.

## 👉 A command example

Find below the complete definition of an `example` command that can take an option `--my-option` and requires one argument `my-argument`.

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
  command::parseArguments "$@"; eval "${REPLY}"
  command::checkParsedResults

  # use options and arguments
  echo "${myOption} and ${myArgument}"
}
```

Executing `valet example --my-option opt1 arg1` will display `opt1 and arg1` in the standard output:

- An option named `-o, --my-option` will translate to a local variable `myOption` (takes the first long name found and convert it to camel case).
- A positional argument named `my-argument` will translate to a local variable `myArgument` (camel case).

Check [the command properties section][command-properties] for more details on how arguments and options are translated to local variables.

## ✂️ Understand the parser

The function `command::parseArguments "$@"` will return a string that can be evaluated to define the parsed options and arguments as local variables.

With the command example above, assuming that the user input is `valet example --thing --my-option opt1 arg1` the content of the global variable `REPLY` would be:

```bash
local myoptions="opt1"
local myArgument="arg1"
local commandArgumentsErrors="Unknown option '--thing'"
```

The `commandArgumentsErrors` variable contains the parser error: here we passed an option that is unknown for this command. Calling `command::checkParsedResults` will print that parsing error message to the user and exit the program.

## 🧩 Access Valet library functions

In the function of a command, you have access by default to a set of Valet functions:

- Function starting with `core::`. See the [core library documentation][core-library].
- Function starting with `log::`. See the [log library documentation][log-library].
- Function starting with `command::`. See the [command library documentation][command-library].

More useful functions are accessible by including a Valet standard library in your script or command function. For this, you need to `source` or `include` the library that you need, e.g.:

```bash
source string
include time
```

You can find a list of [all the standard libraries here][libraries].

> [!TIP]
> Learn how to [configure VS code][work-on-bash-scripts] to have autocompletion on all Valet functions.

Additionally, you can create your own library functions. See the [create a library][newLibraryLink] section for more information.

## 🐞 Error handling and return values

Although you can simply `exit` from a command function, it is recommended to:

- ✅ `return 0` if all went well.
- ❌ `core::fail "My error message"` if something went wrong. This will exit the program with code 1 and print your error to the user.

> [!IMPORTANT]
> In Valet, the following bash options are set: `set -Eeu -o pipefail`: your function will stop with an error if any statement returns an error code different from zero; this also include any program in a pipe (e.g. `myProgramThatFails | cat`). It will end with an error if you try to use an unset variable.

The options `set -Eeu -o pipefail` have the [following meaning][bash-manual-set]:

- `-e`: This option instructs the shell to immediately exit if any command has a non-zero exit status.
- `-u`: This option instructs the shell to immediately exit if it tries to use an unset variable.
- `-o pipefail`: This option prevents errors in a pipeline from being masked.
- `-E`: Any trap on ERR is inherited by shell functions, command substitutions, and commands executed in a subshell environment. The ERR trap is normally not inherited in such cases.

> [!TIP]
> Because Valet traps both exit and error events, you will always see a stacktrace to the faulty line on unexpected errors.

If you expect a statement to fail but want to continue the execution, use one of the following syntax:

```bash
# Catch the exit code
local exitCode=0
thingThatReturns1 || exitCode=$?
if [[ ${exitCode} != 0 ]]; echo "do something if the command failed?..."; fi

# Discard the error
thingThatReturns1 || :

# Run in an if, while or until statement
if ! thingThatReturns1; then
  echo "do something if the command failed?"
fi
```

> [!WARNING]
> Be aware that running a bash function in a list or conditional construct will disable error handling for that function. See [bash best practices](../bash-best-practices) to learn what you should do instead.

If you use a variable that could be unset, provide a default value using [bash parameter expansion][bashParameterExpansion]:

```bash
echo "${myUnsureVariable:-default value}"
```

> [!NOTE]
> You can always revert these bash options in your function. However, continuing the execution of a program that has encountered an unexpected error is most likely a bad idea.

## 💡 Implementation tips and best practices

Please find these dedicated pages to help you write better bash scripts:

{{< cards >}}
  {{< card icon="fast-forward" link="../performance-tips" title="Performance tips" tag="reference" tagType="info" >}}
  {{< card icon="book-open" link="../bash-best-practices" title="Bash best practices" tag="reference" tagType="info" >}}
{{< /cards >}}

## 🐛 How to debug your program

Your command function is not working as expected or seems stuck?

There are two ways to approach this problem:

- Run your valet command in the bash debugger on Visual Studio.
- Or use the `valet -x` option to enable the profiler (this turns the debug mode on `set -x`). This will output the complete trace in `~/valet-profiler-{PID}.txt` (or you can choose the destination with the environment variable `VALET_CONFIG_COMMAND_PROFILING_FILE`). You can see what the profiling file looks like in this [test report][profiler-output-example].

Of course, a simpler strategy is to log stuff with `debug`.

You can also do the following to avoid computing a string value for debugging;

```bash
if log::isDebugEnabled; then 
  log::debug "stuff"
fi
```

You can activate the debug log level with Valet `-v` option, e.g. `valet -v my command`.

[work-on-bash-scripts]: ../work-on-bash-scripts
[command-properties]: ../command-properties
[core-library]: ../libraries/core/
[command-library]: ../libraries/command/
[log-library]: ../libraries/log/
[bash-manual-set]: https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html#index-set
[profiler-output-example]: https://github.com/jcaillon/valet/blob/latest/tests.d/cli-profiler/results.approved.md
[libraries]: ../libraries
[newLibraryLink]: ../new-libraries
[bashParameterExpansion]: https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion

{{< main-section-end >}}
