---
title: 🧱 Create an extension
cascade:
  type: docs
weight: 17
url: /docs/new-extensions
---

Valet can be extended to let the user create its own set of **commands** and **libraries**.

Extensions can be shared as git repositories and installed by others in a single command.

## ➕ Create an extension

The core command `valet self extend` allows to create a new extension (here named `my-extension`):

```bash
valet self extend my-extension
```

Move to the created directory (`cd` into it) and start creating your new [commands][new-commands] and [libraries][new-libraries].

## 📂 Extensions location and anatomy

Extensions are created as a directory under the Valet user directory (which defaults to `~/.valet.d` and can be [overridden][valetConfigUserDirectory]).

This command will initialize your new extension with the following files:

{{< filetree/container >}}
  {{< filetree/folder name="~/.valet.d" >}}
    {{< filetree/folder name="my-extension" >}}
      {{< filetree/folder name=".vscode" >}}
        {{< filetree/file name="extensions.json" >}}
        {{< filetree/file name="settings.json" >}}
        {{< filetree/file name="valet.code-snippets" >}}
      {{< /filetree/folder >}}
      {{< filetree/folder name="commands.d" >}}
      {{< /filetree/folder >}}
      {{< filetree/folder name="libraries.d" >}}
      {{< /filetree/folder >}}
      {{< filetree/folder name="tests.d" >}}
      {{< /filetree/folder >}}
      {{< filetree/file name="lib-valet" >}}
      {{< filetree/file name="lib-valet.md" >}}
      {{< filetree/file name=".gitignore" >}}
    {{< /filetree/folder >}}
  {{< /filetree/folder >}}
{{< /filetree/container >}}

About these files:

- `.vscode`: contains the Visual Studio Code configuration files, will only be created if you have Visual Studio Code installed (`code` found in your path). See [work on bash scripts][work-on-bash-scripts] for more information.
  - `extensions.json`: contains the list of recommended extensions to install in Visual Studio Code.
  - `settings.json`: contains the default settings for Visual Studio Code.
  - `valet.code-snippets`: contains the code snippets for Visual Studio Code. This is a symlink to `~/.valet.d/valet.code-snippets` which get created by the `valet self document` command.
- `commands.d`: a directory that will contain the bash scripts defining the commands of the extension.
- `libraries.d`: a directory that will contain the bash scripts defining the libraries of the extension.
- `tests.d`: a directory that will contain the tests for the commands and libraries of the extension.
- `lib-valet`: This is a symlink to `~/.valet.d/lib-valet` which get created by the `valet self document` command. It contains the prototype of each functions defined in Valet libraries.
- `lib-valet.md`: This is a symlink to `~/.valet.d/lib-valet.md` which get created by the `valet self document` command. It contains the documentation of each functions defined in Valet libraries.

## 🛠️ Develop your extension

Once your extension is created, you can start developing your commands, libraries and tests:

{{< cards >}}
  {{< card icon="sparkles" link="../new-commands" title="Create a new command" tag="tutorial" tagType="info" >}}
  {{< card icon="book-open" link="../new-libraries" title="Create a new library" tag="tutorial" tagType="info" >}}
  {{< card icon="beaker" link="../new-tests" title="Create a new test" tag="tutorial" tagType="info" >}}
{{< /cards >}}

## 🛜 Share and install extensions

To share your extension, make it a git repository with `git init`, then commit and push your files to a remote Git server such as [GitHub][github].

Others can then install your extension with the `valet self extend` command.

For instance, the following command will install the `valet-devops-toolbox` extension from GitHub:

```bash
valet self extend https://github.com/jcaillon/valet-devops-toolbox.git
```

> [!TIP]
> By default, the `valet self extend` command will install the extension from the `latest` git reference.
>
> As a best practice, you should version your extension and always push the latest version to the `latest` branch.
>
> You can also install a specific version of the extension by providing the git reference `--version my-ref`. See `valet self extend --help` for more options.

## 🚧 Install dependencies

If your extension requires additional dependencies, you can create a `extension.setup.sh` script at the root of your extension directory.

This script will be sourced from Valet when installing or updating the extension. You can use Valet functions as if you were coding a command.

> [!WARNING]
> The user will always have the possibility to skip the execution of this script.

[work-on-bash-scripts]: ../work-on-bash-scripts
[new-commands]: ../new-commands
[new-libraries]: ../new-libraries
[github]: https://github.com/
[valetConfigUserDirectory]: ../configuration/#valet_config_user_valet_directory

{{< main-section-end >}}
