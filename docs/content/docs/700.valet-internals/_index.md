---
title: 🫀 Valet internals
cascade:
  type: docs
weight: 700
url: /docs/valet-internals
---

In this page, we will document the internals of Valet. This is useful if you want to contribute to Valet or if you want to understand how it works.

{{< callout type="warning" >}}
🚧 Work in progress 🚧
{{< /callout >}}

## File descriptors

For file descriptors, we create 4 main global variables:

- `GLOBAL_FD_ORIGINAL_STDIN`: the original stdin fd (0).
- `GLOBAL_FD_ORIGINAL_STDERR`: the original stderr fd (2).
- `GLOBAL_FD_TUI`: the fd where we write the TUI (default is stderr).
- `GLOBAL_FD_LOG`: the fd where we write the logs (default is stderr), set by `log::init`.

We use these variables to redirect the output of the program to the correct fd.

{{< cards >}}
  {{< card icon="arrow-circle-left" link="../bash-best-practices" title="Bash best practices" >}}
  {{< card icon="arrow-circle-right" link="../roadmap" title="Roadmap" >}}
{{< /cards >}}