---
title: 📂 benchmark
cascade:
  type: docs
url: /docs/libraries/benchmark
---

## ⚡ benchmark::run

This function runs a benchmark on given functions.

First, it will run the 1st function (the baseline) for a given amount of time and
mark the number of times it was able to run it.

Then, it will run all the functions for the same number of time and
print the difference between the baseline and the other functions.

Inputs:

- `$1`: **baseline** _as string_:

  the name of the function to use as baseline

- `$@`: functions _as string_:

  The names of the functions to benchmark, comma separated.

- `${baselineTimeInSeconds}` _as int_:

  (optional) The time in seconds for which to run the baseline.

  (defaults to 3)

- `${maxRuns}` _as int_:

  (optional) The maximum number of runs to do for each function.
  Set to -1 to run until the baseline time is reached.

  (defaults to -1)

Example usage:

```bash
benchmark::run baseline function1 function2
benchmark::run baseline function1 function2 --- baselineTimeInSeconds=5 maxRuns=100
```

> [!IMPORTANT]
> Documentation generated for the version 0.36.26 (2025-10-10).
