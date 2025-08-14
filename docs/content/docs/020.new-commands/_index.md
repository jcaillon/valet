---
title: ✨ Create a command
cascade:
  type: docs
weight: 20
url: /docs/new-commands
---

Once you have [created an extension][newExtensionsLink] and moved to its directory, you can start creating your new commands.

## 📂 Command files location

Commands are found and indexed by Valet if they are defined in `*.sh` bash scripts located in the `commands.d` directory of your extensions.

Commands can be defined individually in separated files or can be regrouped in a single script. Keep in mind that the bash script of the command function will be sourced, so you might want to keep them light/short.

Here is an example content for your user directory:

{{< filetree/container >}}
  {{< filetree/folder name="~/.valet.d" >}}
    {{< filetree/folder name="my-extension" >}}
      {{< filetree/folder name="commands.d" >}}
        {{< filetree/file name="my-awesome-cmd.sh" >}}
        {{< filetree/file name="another.sh" >}}
      {{< /filetree/folder >}}
    {{< /filetree/folder >}}
  {{< /filetree/folder >}}
{{< /filetree/container >}}

## ➕ Create a command

{{% steps %}}

### 🧑‍💻 Setup your development environment

The section [working on bash][work-on-bash-scripts] will help you set up a coding environment for bash.

Open your existing extension directory or [create a new one][newLibraryLink].

### 📄 Add a new command file

> [!TIP]
> This step is optional, you can add a command in an existing file.

Run the following command to create a new command file named `my-command.sh` in the `commands.d` directory of your extension:

 _Replace `my-command` with the name of your command._

```bash
valet self add-command my-command
```

Alternatively, create the file manually.

### 🔤 Define your new command

Valet looks for a specific YAML formatted string to read command properties.

A simple example is:

```bash
: "---
command: hello-world
function: helloWorld
shortDescription: A dummy command.
description: |-
  This command says hello world.
---"
```

In the example above, we need to define a bash function named `helloWorld` in the same file as the command properties (see next step). When running `valet hello-world`, this function will be called.

A list of all the available command properties can be found here:

{{< cards >}}
  {{< card icon="cog" link="../command-properties" title="Define your command properties" tag="reference" tagType="info" >}}
{{< /cards >}}

If your new command name contains one or more spaces, you are defining a sub command. E.g. `sub cmd` defines a command `cmd` which is a sub command of the `sub` command.

Sub commands can be useful to regroup commands. Valet will show a menu for the command `valet sub` which displays only the sub commands of `sub`.

For more examples, take a look at the [showcase command definitions][showcase-commands].

Alternatively, you can add a new command definition using bash comments and the following format:

```bash
##<<<VALET_COMMAND
# command: hello-world
# function: helloWorld
# shortDescription: A dummy command.
# description: |-
#   This command says hello world.
##VALET_COMMAND
```

### ✒️ Implement your command

Once the command properties are set, the next step is to implement the command function.

{{< cards >}}
  {{< card icon="pencil" link="../implement-a-command" title="How to implement a command" tag="tutorial" tagType="info" >}}
{{< /cards >}}

### 🧪 (optional) Test your command

You can optionally test your command to ensure future non-regressions of its behavior:

{{< cards >}}
  {{< card icon="beaker" link="../new-tests" title="How to test a command" tag="tutorial" tagType="info" >}}
{{< /cards >}}

### 🛠️ Rebuild valet menu

You will not find your command in the Valet menu nor will you be able to execute it immediately after adding (or modifying) its definition.

You first need to let Valet "re-index" all your commands by executing:

```bash
valet self build
```

The build process consists of updating the `~/.local/share/valet/commands` file by extracting all the commands definitions from your scripts. This file defines variables which are used internally by Valet.

> [!TIP]
> In case of an issue with your `~/.local/share/valet/commands` file you might be unable to run the `self build` command. In which case you can execute the build directly by calling `${VALET_INSTALLATION_DIRECTORY}/commands.d/self-build.sh` (`VALET_INSTALLATION_DIRECTORY` being your Valet installation directory).

{{% /steps %}}

[work-on-bash-scripts]: ../work-on-bash-scripts
[showcase-commands]: https://github.com/jcaillon/valet/tree/latest/showcase.d/commands.d
[newExtensionsLink]: ../new-extensions
[newLibraryLink]: ../new-libraries

{{< main-section-end >}}
