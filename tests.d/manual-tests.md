# Manuals tests

A list of tests that are yet to be automated.

- Verify that we can interrupt a command (e.g. `valet self test -C`) with CTRL+C and that it exits gracefully. All temp files should be cleaned up, and the terminal restored to its original state. There should be no ghost processes left running.
- Start a subshell that starts a coproc. Verify that CTRL+C kills everything.
- test CTRL+Z (suspend) + fg command to resume when in interactive mode.
- curl / http lib
- test the windows lib functions
- test the self install / extend / update