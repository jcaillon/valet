---
title: 📂 profiler
cascade:
  type: docs
url: /docs/libraries/profiler
---

## profiler::disable

Disable the profiler if previously activated with profiler::enable.

```bash
profiler::disable
```

## profiler::enable

Enables the profiler and start writing to the given file.
The profiler will also be active in subshells of this current shell.

- $1: **path** _as string_:
      the file to write to.

```bash
profiler::enable "${HOME}/valet-profiler-${BASHPID}.txt"
```

> There can be only one profiler active at a time.

## profiler::pause

Pause the profiler if previously activated with profiler::enable.

```bash
profiler::pause
```

## profiler::resume

Resume the profiler if previously paused with profiler::pause.

```bash
profiler::resume
```

{{< callout type="info" >}}
Documentation generated for the version 0.29.197 (2025-03-29).
{{< /callout >}}
