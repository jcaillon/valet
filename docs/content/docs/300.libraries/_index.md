---
title: 📦 Use core libraries
cascade:
  type: docs
weight: 300
url: /docs/libraries
---

## 🧩 Source core libraries

A set of core libraries are immediately available on Valet. To use the library functions, you need to _source_ the library that you need, e.g.:

```bash
source string
source interactive
```

All Valet functions are prefixed with the library name. E.g. the function `string::cutField` is from the `string` library. A clear error message will be displayed if you are trying to use a library function without sourcing the library.

{{< callout type="info" emoji="💡" >}}
The bash built-in `source` is overridden by a function in Valet. This allows to not source the same file twice, so you can safely call `source mylibrary` several times without impacting the runtime performance. If you need to use the default source keyword, use `builtin source`.
{{< /callout >}}

## 🎀 Available core libraries

<!-- https://v1.heroicons.com/ -->
For more details, please check the documentation on each library:
{{< cards >}}
  {{< card link="ansi-codes" icon="annotation" title="ansi-code" subtitle="Declares variables containing ASCII escape codes, enabling interactive programs." >}}
  {{< card link="array" icon="table" title="array" subtitle="Manipulate bash arrays." >}}
  {{< card link="bash" icon="code" title="bash" subtitle="Extend bash capabilities." >}}
  {{< card link="benchmark" icon="trending-up" title="benchmark" subtitle="Benchmark bash functions." >}}
  {{< card link="command" icon="ticket" title="command" subtitle="Functions to be used in your commands." >}}
  {{< card link="core" icon="star" title="core" subtitle="The core functions of Valet." >}}
  {{< card link="curl" icon="cloud-download" title="curl" subtitle="Wrapper functions around curl." >}}
  {{< card link="exe" icon="star" title="exe" subtitle="Run commands and executables." >}}
  {{< card link="fs" icon="document" title="fs" subtitle="Manipulate the files and directories." >}}
  {{< card link="http" icon="cloud-download" title="http" subtitle="Naive http implementation." >}}
  {{< card link="interactive" icon="cursor-click" title="interactive" subtitle="Make your command interactive." >}}
  {{< card link="log" icon="pencil-alt" title="log" subtitle="Logging functions." >}}
  {{< card link="profiler" icon="finger-print" title="profiler" subtitle="Enable and disable the bash profiler." >}}
  {{< card link="progress" icon="dots-horizontal" title="progress" subtitle="Display a progress bar or a spinner." >}}
  <!-- {{< card link="prompt" icon="chevron-right" title="prompt" subtitle="Prompt the user for input." >}} -->
  {{< card link="regex" icon="tag" title="regex" subtitle="Use regular expressions." >}}
  {{< card link="sfzf" icon="template" title="sfzf" subtitle="Simple fuzzy search interface, similar to fzf." >}}
  {{< card link="string" icon="scissors" title="string" subtitle="Functions for string manipulation." >}}
  {{< card link="system" icon="desktop-computer" title="system" subtitle="Functions to get system/user information." >}}
  {{< card link="test" icon="badge-check" title="test" subtitle="Functions usable in your test scripts." >}}
  {{< card link="time" icon="clock" title="time" subtitle="Functions related to time." >}}
  {{< card link="tui" icon="terminal" title="tui" subtitle="Built terminal UI apps with these helper functions." >}}
  {{< card link="version" icon="calculator" title="version" subtitle="Compare and manipulate semantic versions." >}}
  {{< card link="windows" icon="view-grid" title="windows" subtitle="Functions specific to windows systems." >}}
{{< /cards >}}
