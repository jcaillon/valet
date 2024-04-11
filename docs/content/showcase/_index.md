---
title: Showcase
cascade:
  type: default
weight: 2
toc: false
layout: wide
sidebar:
  exclude: true
---


Valet in a gist:

- In Valet, you can create new **commands** that you can invoke with `valet my-command`.
- Each command has a definition with properties that help you describe it (a description, a list of arguments and options, and so on...).
- Each command has an associated bash function that is called when the command is invoked and which contains your logic.
- You define commands and their functions in `.sh` files under your Valet user directory and Valet takes care of indexing your commands; which allows you to quickly find them, parse options, arguments, print their help...

Invoking `valet` without arguments lets you interactively search and invoke commands:

![demo-menu](demo-menu.gif)

With `valet command --help` or `valet help command`, you get a beautifully formatted help for your command usage:

![demo-help](demo-help.gif)

Fuzzy matching command names allow you to invoke the right command more quickly, see this example with `valet h s h`:

![demo-fuzzy](demo-fuzzy.gif)

Automate tests for your script with approval test approach:

![demo-tests](demo-tests.gif)

Get beautiful logs fully customizable (with optional wrapping!):

![demo-logs](demo-logs.gif)

Auto parsing of arguments and options based on your command configuration:

![demo-parsing](demo-parsing.gif)

> [!NOTE]
> This showcase is recorded with the [windows terminal][windows-terminal], [debian on WSL][debian-wsl] with zsh & [oh my zsh][oh-my-zsh]. The color scheme for the terminal is [dracula][dracula-theme] and the font is a homemade modification of windows Consolas (with ligatures + with nerd font icons).

[windows-terminal]: https://github.com/microsoft/terminal
[debian-wsl]: https://wiki.debian.org/InstallingDebianOn/Microsoft/Windows/SubsystemForLinux
[oh-my-zsh]: https://ohmyz.sh/
[dracula-theme]: https://draculatheme.com/windows-terminal