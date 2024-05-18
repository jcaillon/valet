---
title: ✍️ Working on bash
cascade:
  type: docs
weight: 500
url: /docs/work-on-bash-scripts
---

> [!INFORMATION]
> Disclaimer: This page is just one opinion. This is not the best way to work on bash scripts, this is just an explanation of how I work.

## IDE

I work with VS code on windows + WSL.

Install VS code from [here](https://code.visualstudio.com/download).

## VS code extensions

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

GitHub Copilot is of great help if you can have it.

## VS code settings

You can open your `~/.valet.d` directory as a workspace on vscode. I recommend to copy (or link) the `valet.d` directory from the Valet installation to `~/.valet.d/.valet.libs` in your workspace folder and add the following settings in your `~/.valet.d/.vscode/settings.json`:

```json
{
  // https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html
  "bashIde.globPattern": "**/@(*@(.sh|.inc|.bash|.command|core)|lib-*)",
  "bashIde.includeAllWorkspaceSymbols": true
}
```

This allows you to have autocompletion of the core and libraries functions from your command scripts.

## Where to start your bash journey

- [The official bash documentation](https://www.gnu.org/software/bash/manual/bash.html) / [Alternate view on devdocs.io](https://devdocs.io/bash/)
- [Advanced bash scripting guide](https://tldp.org/LDP/abs/html/index.html)
- [Google shell style guidelines](https://google.github.io/styleguide/shellguide.html)
- [Baeldung Linux scripting series](https://www.baeldung.com/linux/linux-scripting-series)
- [Pure bash bible](https://github.com/dylanaraps/pure-bash-bible)
