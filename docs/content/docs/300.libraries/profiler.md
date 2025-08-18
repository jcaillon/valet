---
title: 📂 profiler
cascade:
  type: docs
url: /docs/libraries/profiler
---

## ⚡ profiler::disable

Disable the profiler if previously activated with profiler::enable.

Example usage:

```bash
profiler::disable
```

## ⚡ profiler::enable

Enables the profiler and start writing to the given file.
The profiler will also be active in subshells of this current shell.

Inputs:

- `$1`: **path** _as string_:

  the file to write to.

Example usage:

```bash
profiler::enable "${HOME}/valet-profiler-${BASHPID}.txt"
```

> There can be only one profiler active at a time.

## ⚡ profiler::pause

Pause the profiler if previously activated with profiler::enable.

Example usage:

```bash
profiler::pause
```

## ⚡ profiler::resume

Resume the profiler if previously paused with profiler::pause.

Example usage:

```bash
profiler::resume
```

> [!IMPORTANT]
> Documentation generated for the version 0.30.1455 (2025-08-18).
