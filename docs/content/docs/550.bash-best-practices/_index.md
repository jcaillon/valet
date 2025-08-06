---
title: 💅 Bash best practices
cascade:
  type: docs
weight: 550
url: /docs/bash-best-practices
---

> [!INFORMATION]
> Disclaimer: This page is just my humble take on how to write bash scripts in Valet. It does not mean that your way of coding isn't fit for your particular use case!
> I am writing this page mostly as a reference for myself, to work on Valet and its extensions the way I intended it when building this tool.

{{< callout type="warning" >}}
🚧 Work in progress 🚧
{{< /callout >}}

I am keeping example bash scripts that demonstrates the points I am making in this page in [lessons-learned][lessons-learned].

## CLI guidelines

Valet is trying to follow the best practices for CLI applications. One good guideline can be found at [clig.dev][cliGuidelineReference].

## 🕳️ Notable pitfalls

### Error handling / ERR trap in bash

It is crucial to remember that any command executed in a `until`, `while`, `if`, or as part of a `!`, `||`, `&&` pipeline will not trigger the **ERR trap** if it fails! This behavior is described in the [trap builtin documentation](https://www.gnu.org/software/bash/manual/bash.html#index-trap) as well as in the [set builtin documentation](https://www.gnu.org/software/bash/manual/bash.html#The-Set-Builtin-1) for the `-e` option.

This is also true for the body of a function or for command/functions that runs in this context where the **ERR trap** is not triggered.

See the [error-handling.sh][error-handling] for a demonstration.

> Quote from bash manual: If a compound command or shell function executes in a context where -e is being ignored, none of the commands executed within the compound command or function body will be affected by the -e setting, even if -e is set and a command returns a failure status.

{{< callout emoji="💡" >}}
Do not call a complex function in a `until`, `while`, `if`, or as part of a `!`, `||`, `&&` pipeline because any error happening in the function will not trigger the **ERR trap** and will effectively be silent.
{{< /callout >}}

{{< callout emoji="💡" >}}
When creating a complex function, do not use `return` and set an exit code because this would encourage a bad usage of the function. Instead, use `REPLY` and simply return 0 from the function. 
{{< /callout >}}

### Jobs and coproc

If the main process exits, the coprocs and jobs **will not exit** automatically: When we exit an interactive shell, a SIGHUP will be sent to the shell process which forwards it to all its children processes, including the coproc/jobs. But in the case of a script, we start a new bash process for the script which in turns starts processes for coproc/jobs. The SIGHUP is not sent automatically to the coproc/jobs when the script ends (it only happens at the end of an interactive shell session).

> Coproc/jobs will no longer have the PPID of the bash script but will be assigned the PPID 1 which is the init process. This is actually a way to 'daemonize' a process (detaching it from the terminal). This technical is called 'double fork' and can also be replaced by using the builtin 'disown' command.

We must check if the main process is still running inside the coproc or we must kill all the coproc/jobs when the main script exits.

Traps and set options are inherited from the parent shell but the exit trap is not executed on error (at least not in bash 5.2 when writing this page)! If we re register the EXIT trap in the coproc/job, it will be executed on error. So it is better to re-register the EXIT trap in the coproc/job for consistent behavior.

Coproc behaves like a background job with the exception that they do not inherit the SIGINT trap. CTRL+C will interrupt both the main process and a background job, but not a coproc.

To make our life easier, Valet only uses coproc and never uses jobs. Coproc are as fast as jobs to start and they come with two way communication channels (stdin/stdout).

{{< callout emoji="💡" >}}
For background tasks, always use the [coproc](../libraries/coproc) library which correctly handles all the subtleties of correctly managing a coproc.
{{< /callout >}}

## 🎨 Coding style

### Library functions

This section describes how to write **library** functions that can be used in Valet extensions. For functions that are solely use in one command, you don't have to stick to these strict rules, but it is still a good idea to follow them.

#### Function parameters

Ideally, we would use positional arguments and flags like we do for our CLI. But it would be too costly to parse these in each function that we call. So we use positional arguments for mandatory and obvious parameters, and we use shell parameter syntax for optional parameters.

```bash
function argument1 argument2 1 2 3 --- myOption=one myOption3="my value"
```

Optional parameters all start with the `_OPTION_` prefix and can be use like so:

```bash
function myFunction() {
  local myOption="${myOption:-default_value}"
  # ...
}
_myOption="my_value" myFunction
```

This way we can immediately understand what is passed to the function and easily use the option inside our function block.

One caveat to pay attention to is that the inline variables will be also inherited to any child functions called from our function. This is also why our functions should not rely on other functions. But when that is the case, we can simply `unset -v ${!_OPTION_*}` to unset all options.

{{< callout emoji="💡" >}}
Use positional arguments for mandatory parameters and inline variables for optional parameters. Use the `_OPTION_` prefix for the inline variables.
{{< /callout >}}

#### Function outputs

When it comes to outputs, we should use the `REPLY` global variable to store the output of our function. This way, we can easily access the output after the function has been called.

```bash
function myFunction() {
  local myOption="${myOption:-default_value}"
  # ...
  REPLY="some output"
}
_myOption="my_value" myFunction
echo "${REPLY}"
```

- We can use `REPLY2`, `REPLY3`, etc... if we need to return multiple values from a function.
- We can use `REPLY_ARRAY`, `REPLY_ARRAY2`, etc... to return an array of values from a function.
- We can use `REPLY_CODE` to return an exit code from a function.

As [seen above](#error-handling--err-trap-in-bash), we should not use `return` to return an exit code because it would encourage a bad usage of the function. Instead, we should always return 0 from our functions and use the `REPLY_CODE` variable to return an exit code.

{{< callout emoji="💡" >}}
Use the `REPLY` global variable to store the string output of your function. Use `REPLY2`, `REPLY_ARRAY`, etc... for multiple outputs. And use `REPLY_CODE` to return an exit code. Do not use `return` with a non-zero exit code because it would push the users to use the function in a way that would not trigger the **ERR trap**.
{{< /callout >}}

#### Function body

If possible, make each function independent and self-contained. This means that the function should not rely on other functions or global variables. A bit of copy-paste is acceptable if it makes the function self-contained. This will make the function easier to test and debug.

Explicitly declare all the parameters of the function at the top of the function body using `local` declare statements. This will make it easier to understand what parameters it expects and what are the default values. This extra cost is negligible.

{{< cards >}}
  {{< card icon="arrow-circle-left" link="../work-on-bash-scripts" title="Work on bash scripts" >}}
  {{< card icon="arrow-circle-right" link="../performance-tips" title="Performance tips" >}}
{{< /cards >}}

[lessons-learned]: https://github.com/jcaillon/valet/tree/main/lessons-learned
[error-handling]: https://github.com/jcaillon/valet/tree/main/lessons-learned/error-handling.sh
[cliGuidelineReference]: https://clig.dev/
