---
title: 📂 trap
cascade:
  type: docs
url: /docs/libraries/trap
---

## ⚡ trap::register

Register a given function to execute when a specific event happens (e.g. on-exit, on-interrupt, etc...).
Only one function can be registered for each event, if you register a new one it will replace the previous one.

Because this function will be executed during a critical moment, an error in the function must not prevent
the execution from continuing. This is why the function is executed in a "if" statement to disable the "errexit"
shell option and avoid exiting the program in case of an error.

Inputs:

- `$1`: **function name** _as string_:

  The name of the function to call when the event is emitted.
  Can be blank to unregister a function for an event.

- `$2`: **event name** _as string_:

  The name of the event to register to among the following ones:

  - `on-exit`: when the program exits (in all cases, error or not).
               The function will be executed in the same shell that has been exited, as if we called this
               function at the line executed at the moment when the program exited.
               Note: The stdout/stderr might be redirected somewhere else if the program exited in a
               ``command &>/dev/null` context.
  - `on-interrupt`: when the program is interrupted by the user (SIGINT, SIGQUIT, e.g. CTRL+C or CTRL+\).
               The function can return 1 to cancel the interrupt and continue running the program.
               The function will be executed in the same shell that has been interrupted,
               as if we called this function at the line executed at the moment when the interruption took place.
  - `on-terminate`: when the program is terminated by the system (SIGHUP, SIGTERM).
               The function can return 1 to cancel the termination and continue running the program.
               The function will be called from the main process.
  - `on-resize`: when the terminal changes its size.
               You can immediately use the global variables `GLOBAL_COLUMNS` and `GLOBAL_LINES` to get the
               new terminal size.
               The function will be called from the main process and it will not be triggered if the program is
               busy running an external command (e.g. sleep).
               Note that the builtin read command also blocks this trigger until it is finished.
  - `on-suspend`: when the program is required to pause (e.g. CTRL+Z).
               The function can return 1 to cancel the suspend and continue running the program.
               The function will be called from the main process.
  - `on-continue`: when the program is required to resume its execution after a suspend (e.g. fg or bg).
               The function will be called from the main process.

Example usage:

```bash
trap::register myCleanUpFunction on-exit
trap::register "" on-exit
```

> [!IMPORTANT]
> Documentation generated for the version 0.41.182 (2026-06-11).
