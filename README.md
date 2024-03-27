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
- You never implemented tests for your scripts because you don't known how to do that fast.

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

You need bash version 5 or higher to be installed on your machine to run valet.

### Automated installation

Run the following command to install valet:

```bash
curl https://github.com/jcaillon/valet | bash
```

> [!NOTE]
> The automated installation downloads [fzf][fzf] and [yq][yq] in the valet `bin` sub directory.
>
> It also copies the [examples.d](examples.d) directory to your valet user directory (if empty) and runs `valet self build` in order to get you started.

### Manual installation

You need the following tools installed and present in your PATH for valet to work:

- [fzf][fzf]
- [yq][yq]

You can then git clone this project or download the source from the latest release into the directory of your choice.

Finally, add this directory to your PATH so you can call `valet` from your terminal.

## Usage

xxx

> [!IMPORTANT]
> If you see the replacement character � in my terminal, it means you don't have a [nerd font][nerd-font] setup in your terminal.
>
> Either install a nerd font and activate it on our terminal or `export VALET_NO_ICON=true` in your environment.

## How to add your own command

Please check the [docs/create-new-command.md][new-command] documentation.

## Contributions

Please check the [CONTRIBUTING.md](CONTRIBUTING.md) documentation if you intend to work on this project.

## Roadmap

- Installation and self update script.
- Add support for interactive mode.
- Setup github actions to automatically test valet.
- Generate an autocompletion script for bash and zsh.
- Self command to create a new command interactively.
- Get rid of yq dependency in self build.
- Replace fzf menu with equivalent pure bash menu.
- Allow fileToSource to have multiple values separated by a comma (so we can load libraries of functions).
- Add about option to hide the command in the menus.
- Add tests for self build.

[fzf]: https://github.com/junegunn/fzf
[yq]: https://github.com/mikefarah/yq
[nerd-font]: https://www.nerdfonts.com/
[new-command]: docs/create-new-command.md
