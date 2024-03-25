# valet

Valet is a wrapper around your bash scripts that provides an interactive menu, standard help output, auto parsing for options and arguments, and so on...

It works on **any Linux environment with bash** or on **Git bash for Windows**.

It is written for performance and to minimize the overhead of a script calling your scripts.

## Showcase

xxx

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

- Add support for interactive mode.
- Generate an autocompletion script for bash and zsh.
- Implement self test with approval tests.
- Get rid of yq dependency in self build.
- Replace fzf menu with equivalent pure bash menu.
