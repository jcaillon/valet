---
title: 📦 Libraries
cascade:
  type: docs
weight: 300
url: /docs/libraries
---

## 🧩 Source libraries from your command function

Useful function are accessible by including a Valet library in your script or command function. For this, you need to _source_ the library that you need, e.g.:

```bash
source string
source interactive
```

All Valet functions are prefixed with the library name. E.g. the function `string::cutField` is from the `string` library. A clear error message will be output if you are trying to use a library function without sourcing the library.

{{< callout type="info" emoji="💡" >}}
The bash built-in `source` is overridden by a function in Valet. This allows to not source the same file twice, so you can safely call `source mylibrary` several times without impacting the runtime performance. If you need to use the default source keyword, use `builtin source`.
{{< /callout >}}

## 🪄 Use Valet functions directly in bash

Thanks to the `self export` command, you can export Valet functions so they are usable directly in your bash session:

```bash
eval "$(valet self export -a)"

log::info "Cool logs!"
if interactive::promptYesNo "Do you want to continue?"; then echo "Yes."; else echo "No."; fi
```

## 🎀 Available libraries

For more details, please check the documentation on each library:

{{< cards >}}
  {{< card link="ansi-codes" icon="code" title="ansi-code" subtitle="This library exports variables containing ASCII escape codes, enabling interactive programs." >}}
  {{< card link="array" icon="clipboard-list" title="array" subtitle="Functions to manipulate bash arrays." >}}
  {{< card link="fsfs" icon="table" title="fsfs" subtitle="Functions to display a full screen fuzzy search, which is used for the Valet menus." >}}
  {{< card link="interactive" icon="cursor-click" title="interactive" subtitle="Functions to make your program interactive." >}}
  {{< card link="io" icon="lightning-bolt" title="io" subtitle="Functions for file manipulation, command execution..." >}}
  {{< card link="kurl" icon="cloud-download" title="kurl" subtitle="Wrapper functions around curl." >}}
  {{< card link="string" icon="menu-alt-2" title="string" subtitle="Functions for string manipulation." >}}
  {{< card link="system" icon="desktop-computer" title="system" subtitle="Functions to get system/user information." >}}
{{< /cards >}}
