# valet

Valet is a wrapper around your bash scripts that provides an interactive menu, standard help output, auto parsing for options and arguments, a framework for approval testing, and so on...

It works on **any Linux environment with bash** or on **Git bash for Windows**.

It is written for performance and to minimize the overhead of a script calling your scripts.

## Use case

To help you on your daily tasks, you have created a collection of bash scripts that you added to your path.

But...

- You never recall what are the options and/or arguments of these scripts.
- You struggle to even remember how they are named and how to invoke them.
- They are not correctly documented.
- They all follow a different convention regarding options and arguments.

**→ This is where Valet can help you!**

## Features showcase

Valet in a gist:

- In Valet, you can create new **commands** that you can invoke with `valet my-command`.
- Each command has properties that help you describe it (a description, a list of arguments and options, and so on...).
- Each command has a associated bash function that is called when the command is invoked and which contains your logic.
- You define commands and their functions in `.sh` files under your valet user directory and Valet takes care of indexing your commands; which allows you to quickly find them, parse options, arguments, print their help...

Invoking `valet` without arguments lets you interactively search and invoke commands:

*insert gif*

With `valet command --help` or `valet help command`, you get a beautifully formatted help for your command usage:

*insert gif*

Fuzzy matching command names allow you to invoke the right command more quickly, see this example with `valet h s h`:

*insert gif*

## Installation

xxx

> [!IMPORTANT]
> Valet has an interactive mode which allows you to select the commands you want to play and pick your arguments interactively.
> It requires [fzf](https://github.com/junegunn/fzf) to be installed and present in your PATH.
> Please check the fzf Github page to learn how to install it.

> [!IMPORTANT]
> If you see the replacement character � in my terminal, it means you don't have a [nerd font](https://www.nerdfonts.com/) setup in your terminal.

## Usage

xxx

## How to add your own command

Please check the [docs/create-new-command.md](docs/create-new-command.md) documentation.

## Developers notes

Please check [docs/working-on-bash-scripts.md](docs/working-on-bash-scripts.md) to learn more about working on bash scripts.

You can enable debug mode with profiling for valet by setting the environment variable `VALET_STARTUP_PROFILING` to true (it will output to the file `~/profile_valet.txt`).

## Roadmap

- Installation and self update script.
- Add support for interactive mode.
- Generate an autocompletion script for bash and zsh.
- Implement self test with approval tests.
- Get rid of yq dependency in self build.
- Replace fzf menu with equivalent pure bash menu.
