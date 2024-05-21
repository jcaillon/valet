---
title: ⚙️ Command properties
cascade:
  type: docs
weight: 25
url: /docs/command-properties
---

## 🫚 Top level properties

The available properties are:

| Property | Default value | Description |
|----------|---------------|-------------|
| **command** | N/A | The name with which your command can be called by the user. E.g. `mycmd` will be accessible with `valet mycmd`. |
| **sudo** | | `true` if your command uses `sudo`; in which case we will prompt the user for sudo password before executing the command. `false` otherwise.   |
| **shortDescription** | | shortly describe your command; this will appear next to your command name in the valet menu. |
| **description** | | long description of your command and its purpose. |
| **options** | | a list of options for your command. Don't forget that, by definition, an option is optional (i.e. it is not mandatory like an argument). If you expect an option to be defined, then it is an argument. |
| **arguments** | | a list of mandatory arguments for your command. If the user does not provide an argument, your command should fail. Otherwise, that means it is an option, not an argument. |
| **examples** | | a list of examples for your command. |

All commands will have, by default, an `-h, --help` option to display the help of this command.

## 🎚️ Options

## 💬 Arguments

## 🎈 Examples

{{< cards >}}
  {{< card icon="arrow-circle-left" link="../new-commands" title="New commands" >}}
  {{< card icon="arrow-circle-right" link="../test-commands" title="Test commands" >}}
{{< /cards >}}
