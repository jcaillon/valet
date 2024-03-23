# valet

Valet is a wrapper around your bash scripts that provides an interactive menu, standard help output, auto parsing for options and arguments, and so on...

It works on **any Linux environment with bash** or on **Git bash for Windows**.

## Showcase

xxx

## Installation

xxx

> [!IMPORTANT]
> Valet has an interactive mode which allows you to select the commands you want to play and pick your arguments interactively.
> It requires [fzf](https://github.com/junegunn/fzf) to be installed and present in your PATH.
> Please check the fzf Github page to learn how to install it.

## Usage

xxx

## How to add your own command

Please check the [NEW_COMMAND.md](NEW_COMMAND.md) documentation.

## Developers notes

To get better performances:

- We always favor bash built-in over forking to an external process.
- We avoid using subshell (and thus, pipes).
- When possible, we also avoid the `<<<` syntax.
- We get the standard output of a function using the global variable `LAST_RETURNED_VALUE`. This avoid to have to invoke a function in a subshell to have the output. E.g. instead of `local value=$(myfunc)`, we do `local value; myfunc && value="${LAST_RETURNED_VALUE}"`. It also has the benefit of correctly showing a potential programming error instead of hiding it and just exiting the subshell with an error code.
- We "build" the information of each command as simple global variables (e.g. `CMD_COMMAND_build="self build"`, see [valet.d/cmd](valet.d/cmd)). Then we can get a value with `local -n command="CMD_COMMAND_${functionName}"`: no need for additional assignment or call to a function.

> While the difference may seem insignificant on linux systems, it is **HUGE** in windows bash (I went from 5s to <0.300ms for executing a command by remove all forking and subshell). The exception is the build script, which has not been refactored for performance since it is run only once.

## Roadmap

- Add support for interactive mode.
- Generate an autocompletion script for bash and zsh.
- Implement self test with approval tests.
