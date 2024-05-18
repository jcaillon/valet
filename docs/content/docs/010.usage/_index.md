---
title: 🎹 Usage
cascade:
  type: docs
weight: 10
url: /docs/usage
---

## ✒️ Adding your own commands

Valet is pre-configured with some example commands so you can try it immediately and see how it feels.

However, the main goal is to create your own commands and add them in Valet. Valet takes care of the boilerplate stuff (parsing arguments, proper log functions, help, testing your command...) so you can focus on the feature of your command.

To create a new command, follow this [documentation][new-commands].

## 📖 Command menu

Calling `valet` without any arguments (you can pass options) will open the interactive search for commands.

Type your query (fuzzy matching is active so you can skip some letters), press ⬇️/⬆️ to select the command and hit enter to run it. Press `ALT+H` to show the help text for interactive mode.

Valet will remember your last choices, and they will appear at the top of the list the next time the menu shows up. You can set up how many choices to remember with the variable `VALET_CONFIG_REMEMBER_LAST_CHOICES`. Setting `VALET_CONFIG_REMEMBER_LAST_CHOICES=0` will effectively disable this feature and always display items sorted alphabetically.

## ⌨️ Interactive mode

Calling any command that requires arguments without arguments will start the interactive mode and prompt you for the required values.

You can force entering the interactive mode with the Valet option `-i`, e.g. `valet -i my command`.

## 🌳 Environments variables

Most (all?) options in Valet are configurable with environment variables. Even options that you can pass to your custom commands can be set through variables (check the `--help`)!

This makes Valet particularly suitable for automation (in CI/CD pipelines for instance).

[new-commands]: ../new-commands
