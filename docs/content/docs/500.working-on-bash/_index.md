---
title: ✍️ Working on bash
cascade:
  type: docs
weight: 500
url: /docs/work-on-bash-scripts
---

> [!IMPORTANT] Disclaimer
> This page is just one opinion. This is not the best way to work on bash scripts, this is just an explanation of how I work.

## 🧑‍💻 VS Code

I work with [VS code]((https://code.visualstudio.com/download)) and [git bash](https://gitforwindows.org/) on Windows.

WSL and the GitHub actions allow me to test Valet on different Linux distributions.

### ⚙️ Settings

After [creating a new extension](../new-extensions), you can open the extension directory as a workspace on vscode.

It will come pre-configured with vscode snippets, settings, and extension recommendations.

### 🧩 Extensions

Here is a list of recommended extensions to work on bash scripts:

- [Bash IDE](https://marketplace.visualstudio.com/items?itemName=mads-hartmann.bash-ide-vscode)
- [Debug bash scripts](https://marketplace.visualstudio.com/items?itemName=rogalmic.bash-debug)
- [Shell Script Command Completion](https://marketplace.visualstudio.com/items?itemName=tetradresearch.vscode-h2o)
- [Better comments](https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments)
- [Better shellscript syntax](https://marketplace.visualstudio.com/items?itemName=jeff-hykin.better-shellscript-syntax)
- [Code spell checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)
- [EditorConfig](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)
- [Indent rainbow](https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow)
- [Format shell script](https://marketplace.visualstudio.com/items?itemName=foxundermoon.shell-format)
- [Shellcheck](https://marketplace.visualstudio.com/items?itemName=timonwong.shellcheck)
- [Snippets manager](https://marketplace.visualstudio.com/items?itemName=zjffun.snippetsmanager)
- [Snippets for bash scripts](https://marketplace.visualstudio.com/items?itemName=Remisa.shellman)
- [Snippets for shebang](https://marketplace.visualstudio.com/items?itemName=rpinski.shebang-snippets)

A more up-to-date list can be found in [extensions.json](https://raw.githubusercontent.com/jcaillon/valet/refs/heads/latest/extras/.vscode/extensions.json).

> [!TIP] Dependencies
> For those extensions to work, you will need to install: [shfmt](https://github.com/mvdan/sh#shfmt), [shellcheck](https://github.com/koalaman/shellcheck).

### 🆎 Autocompletion on Valet library functions

You can use the Valet [vscode snippets](https://github.com/jcaillon/valet/blob/latest/extras/valet.code-snippets) which should already be present in your extension directory. If not, you can setup your directory with `valet self extend .`.

Additionally, the already configured `.vscode/settings.json` will contain the following settings:

```json
{
  "bashIde.globPattern": "**/@(lib-*|commands.d/*.sh)",
  "bashIde.includeAllWorkspaceSymbols": true,
  "terminal.integrated.wordSeparators": " ()[]{}',\"`─‘’“”|⌜⌝"
}
```

It will allow you to navigate to the function definitions with `F12` and `Ctrl+click` on the function calls.

You should have autocompletion and help on all ibrary functions:

![autocompletion](image.png "Autocompletion with VS code")

### 👮 shellcheck

If you have installed the recommended extensions, you will also have shellcheck which will attempt to following the sourced files in your project. You should annotate each `source` statement for shellcheck to use the `lib-valet` file:

```bash
# shellcheck source=../lib-valet
source string
```

## 🚲 Where to start your bash journey

- [The official bash documentation](https://www.gnu.org/software/bash/manual/bash.html) / [Alternate view on devdocs.io](https://devdocs.io/bash/)
- [Advanced bash scripting guide](https://tldp.org/LDP/abs/html/index.html)
- [Google shell style guidelines](https://google.github.io/styleguide/shellguide.html)
- [Baeldung Linux scripting series](https://www.baeldung.com/linux/linux-scripting-series)
- [Pure bash bible](https://github.com/dylanaraps/pure-bash-bible)
- [Dave's videos](https://ysap.sh/)

{{< main-section-end >}}
