---
title: 🎹 Usage
cascade:
  type: docs
weight: 10
url: /docs/usage
---

## 📨 Valet commands

Valet is a CLI tool that accepts **options** (e.g. `--help` or `-v`) and **commands** (e.g. `valet help`) or **sub commands** (e.g. `valet self update`).

Each command has properties that enable Valet to display its usage (e.g. a description, some examples...) and also parse the options and arguments of that command.

Commands can be _nested_ under another parent command which is what we call _sub commands_. E.g. the `self update` command is a sub command of the `self` command. There is no limit to the level of nesting for sub commands.

Behind the scene, a command refers to a **bash function** written in a bash script file which is _source'd_ before calling the function. Commands are indexed ahead of time in a process called **build** (the `valet self build` command) in order to not waste time during Valet execution.

## ✒️ Adding your own commands

Valet is pre-configured with some example commands so you can try it immediately and see how it feels.

However, the main goal is to create your own commands and add them in Valet. Valet takes care of the boilerplate stuff (parsing arguments, proper log functions, help, testing your command...) so you can focus on the feature of your command.

To create a new command, follow this [documentation][new-commands].

## 📖 Command menu

Calling `valet` without any arguments (you can pass options) will open the interactive search for commands.

Type your query (fuzzy matching is active so you can skip some letters), press ⬇️/⬆️ to select the command and hit enter to run it. Press ⬅️/➡️ or `[PAGE_DOWN]/[PAGE_UP]` to navigate a command help. Press `ESC` to leave without selecting a command.

The command property `hideInMenu` can prevent a command from being displayed in the menu. These commands are still executable by passing the command name directly to Valet (i.e. you can call `valet self setup` even if it is hidden in the menu).

Similarly, you can execute a parent command (e.g. `valet self`) to open an interactive menu with only the commands that are nested under it.

<!-- ## ⌨️ Interactive mode

Calling any command that requires arguments without arguments will start the interactive mode and prompt you for the required values.

You can force entering the interactive mode with the Valet option `-i`, e.g. `valet -i my command`. -->

## 🌳 Environments variables

Almost all options in Valet are configurable with environment variables. Even options that you can pass to your custom commands can be set through variables (check the `--help`)!

This makes Valet particularly suitable for automation (in CI/CD pipelines for instance).

Additionally, at the beginning of its execution, Valet will `source` a file named `.env` located in the current directory, which enables you to set up command options (this file name can be changed if needed).

{{< cards >}}
  {{< card icon="arrow-circle-left" link="../installation" title="Installation" >}}
  {{< card icon="arrow-circle-right" link="../Configuration" title="Valet configuration" >}}
{{< /cards >}}

[new-commands]: ../new-commands
