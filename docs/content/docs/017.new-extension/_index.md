---
title: 🧱 Create an extension
cascade:
  type: docs
weight: 17
url: /docs/new-extensions
---

Valet can be extended to let the user create its own set of **commands** and **libraries**.

## ➕ Create an extension

The core command `valet self extend my-extension` allows to create a new extension (here named `my-extension`).

Open the created directory (or `cd` into it) and start creating your new [commands][new-commands] and libraries.

## 📂 Extensions location and anatomy

Extensions are created as a directory under the Valet user directory (which defaults to `~/.valet.d`).

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

- `.vscode`: contains the Visual Studio Code configuration files, will only be created if you have Visual Studio Code installed. See [work on bash scripts][work-on-bash-scripts] for more information.
  - `extensions.json`: contains the list of recommended extensions to install in Visual Studio Code.
  - `settings.json`: contains the default settings for Visual Studio Code.
  - `valet.code-snippets`: contains the code snippets for Visual Studio Code. This is a symlink to `~/.valet.d/valet.code-snippets` which get created by the `valet self document` command.
- `commands.d`: contains the bash scripts defining the commands of the extension.
- `libraries.d`: contains the bash scripts defining the libraries of the extension.
- `tests.d`: contains the tests for the commands and libraries of the extension.
- `lib-valet`: This is a symlink to `~/.valet.d/lib-valet` which get created by the `valet self document` command. It contains the prototype of each functions defined in Valet libraries.
- `lib-valet.md`: This is a symlink to `~/.valet.d/lib-valet.md` which get created by the `valet self document` command. It contains the documentation of each functions defined in Valet libraries.

## 🛜 Share your extensions

To share your extension, make it a git repository with `git init`, then commit and push your files to a remote Git server such as [GitHub][github].

Others can then install your extension with the `valet self extend` command. For instance, the command `valet self extend https://github.com/jcaillon/valet-devops-toolbox.git` will install the `valet-devops-toolbox` extension from GitHub.

{{< callout type="info" >}}
  By default, the `valet self extend` command will install the extension from the `latest` git reference.

  As a best practice, you should version your extension and always push the latest version to the `latest` branch.

  You can also install a specific version of the extension by providing the git reference `--version my-ref`. See `valet self extend --help` for more options.
{{< /callout >}}

{{< cards >}}
  {{< card icon="arrow-circle-left" link="../configuration" title="Configuration" >}}
  {{< card icon="arrow-circle-right" link="../new-commands" title="Create a new command" >}}
{{< /cards >}}

[work-on-bash-scripts]: ../work-on-bash-scripts
[new-commands]: ../new-commands
[github]: https://github.com/
