# Manuals tests

A list of tests that are yet to be automated.

- Verify that we can interrupt a command (e.g. `valet self test -C`) with CTRL+C and that it exits gracefully. All temp files should be cleaned up, and the terminal restored to its original state. There should be no ghost processes left running.
