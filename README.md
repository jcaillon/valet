# valet

Valet is a wrapper around your bash scripts that provides an interactive menu, standard help output, auto parsing for options and arguments, and so on...

It works on **any Linux environment with bash** or on **Git bash for Windows**.

## Showcase

xxx

## Installation

xxx

## Usage

xxx

## How to add your own command

Please check the [NEW_COMMAND.md](NEW_COMMAND.md) documentation.

## Developers notes

To get better performances:

- Always favor bash built-in over forking to an external process.
- Avoid using subshell (and thus, pipes). To get the standard output of a function, use a global variable `LAST_RETURNED_VALUE`.

While the difference may seem insignificant on linux systems, it is **HUGE** in windows bash (I went from 5s to <0.300ms for executing a command by remove all forking and subshell). The exception is the build script, which has not been refactored for performance since it is run only once.

## Roadmap

- Add support for interactive mode.
- Generate an autocompletion script for bash and zsh.
