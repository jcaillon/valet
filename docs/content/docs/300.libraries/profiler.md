---
title: 📂 profiler
cascade:
  type: docs
url: /docs/libraries/profiler
---

## profiler::enable

Enables the profiler and start writing to the given file.

- $1: **path** _as string_:
      the file to write to.

```bash
profiler::enable "${HOME}/valet-profiler-${BASHPID}.txt"
```

> There can be only one profiler active at a time.


## profiler::disable

Disable the profiler if previously activated with profiler::enable.

```bash
profiler::disable
```




> Documentation generated for the version 0.18.426 (2024-07-08).
