---
title: 🎹 Usage
cascade:
  type: docs
weight: 10
url: /docs/usage
---

## 📨 Valet commands

Valet is a CLI tool that exposes usable **commands** (e.g. `valet help`) or **sub commands** (e.g. `valet self update`).

Each command can accept **options** (e.g. `--help` or `-v`) and/or **arguments** (e.g. in `valet self extend my-extension`, `my-extension` is an argument of the `valet self extend` command).

Each command has properties that enable Valet to:

- Display its usage (e.g. a description, some examples...),
- parse the **options** and **arguments** of that command.

You can access the help of a command by either typing `valet help my-command` or `valet my-command --help`.

Commands can be _nested_ under another parent command which is what we call _sub commands_. E.g. the `self update` command is a sub command of the `self` command. There is no limit to the level of nesting for sub commands.

> [!TIP]
> By default, Valet will try to match a miss-spelled command or option in a process called _fuzzy finding_. For instance, typing `mcmd` can match the command `mycommand` if it exists. You can opt-out of this behavior through [configuration](../configuration).

Behind the scene, a command refers to a **bash function** written in a bash script file which is included (`source`) before calling the function. Commands are indexed ahead of time in a process called a **build** (the `valet self build` command) in order to not waste time searching for the command script during execution.

## 🤔 About options and arguments

### Options

Options can have multiple long name (`--my-option` is long name) and up to one short name (`-v` is a short option, composed of a single letter).

Short names can be grouped together, e.g. `-fsL` is equivalent to `-f -s -L` or equivalent to the long name options `--force --silent --follow`.

- Options can be simple flags (i.e. we check if the option is present or not): `--verbose`.
- Or can have a value, in which case they are represented as such: `--my-option <value>` and the user is expected to provide a value.

Each option can be set using a environment variable matching the option long name in `UPPER_SNAKE_CASE` (e.g. --my-option can be set using `export MY_OPTION="value"`).

## Arguments

Arguments usually indicate mandatory values that must be provided by the user.

An argument that starts with a `-` character can be wrongly interpreted as an option. You can use `--` to mark the separation between options and commands. E.g. `valet my-command -- -my-argument-` allows to interpret `-my-argument-` as the first and only argument of `my-command` instead of an option.

## 📖 Command menu

Calling `valet` without any arguments (you can pass options) will open the interactive search for commands.

Type your query (fuzzy matching is active so you can skip some letters), press <kbd>↓</kbd>/<kbd>↑</kbd> to select the command and hit enter to run it. Press <kbd>←</kbd>/<kbd>→</kbd> (or <kbd>Page down</kbd>/<kbd>Page Up</kbd> and <kbd>Home</kbd>/<kbd>End</kbd>) to navigate a command help. Press <kbd>⎋ Escape</kbd> to leave without selecting a command.

The command property `hideInMenu` can prevent a command from being displayed in the menu. These commands are still executable by passing the command name directly to Valet (i.e. you can call `valet self setup` even if it is hidden in the menu).

Similarly, you can execute a parent command (e.g. `valet self`) to open an interactive menu with only the commands that are nested under it.

<!-- 
## ⌨️ Interactive mode

Calling any command that requires arguments without arguments will start the interactive mode and prompt you for the required values.

You can force entering the interactive mode with the Valet option `-i`, e.g. `valet -i my command`. 
-->

## 🌳 Environments variables

Almost all options in Valet are configurable with environment variables. Even options that you can pass to your custom commands can be set through variables (check the `--help`)!

This makes Valet particularly suitable for automation (in CI/CD pipelines for instance).

Additionally, at the beginning of its execution, Valet will `source` a file named `.env` located in the current directory, which enables you to set up command options (this file name can be changed if needed).

## ✒️ Adding your own commands and libraries

Valet is pre-configured with some example commands so you can try it immediately and see how it feels.

However, the main goal is to extend Valet and create your own commands. Valet takes care of the boilerplate stuff (parsing arguments, proper log functions, help, testing your command, etc...) so you can focus on the feature of your command.

The first step is to **create an extension**, which packages a set of commands and libraries in one place:

{{< cards >}}
  {{< card icon="cube" link="../new-extensions" title="Create a new extension" tag="tutorial" tagType="info" >}}
{{< /cards >}}

> [!TIP]
> You can then share and install extensions in one simple command!

Once your extension is created, you can add commands and libraries to it:

{{< cards >}}
  {{< card icon="sparkles" link="../new-commands" title="Create a new command" tag="tutorial" tagType="info" >}}
  {{< card icon="book-open" link="../new-libraries" title="Create a new library" tag="tutorial" tagType="info" >}}
{{< /cards >}}

## 🧩 Use Valet library functions in your existing scripts

If you simply want to use specific library functions but do not wish to define a new command, you can source Valet directly in your existing script:

```bash
#!/usr/bin/env bash
source "$(valet --source)"

include system
system::getOs
log::success "You are running Valet on ${REPLY}, cool beans!"
```

## 🪄 Use Valet library functions directly in bash

Thanks to the `self source` command, you can source Valet functions so they are usable directly in your bash session:

```bash
eval "$(valet self source -a)"

log::info "Cool logs!"
if interactive::promptYesNo "Do you want to continue?"; then echo "Yes."; else echo "No."; fi
```

> [!NOTE]
> This command differs from simply sourcing Valet because it redeclare some Valet core functions to not exit the shell (otherwise your terminal would close at first error encountered).

{{< main-section-end >}}
