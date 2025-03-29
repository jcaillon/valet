---
title: 📂 benchmark
cascade:
  type: docs
url: /docs/libraries/benchmark
---

## benchmark::run

This function runs a benchmark on given functions.

First, it will run the 1st function (the baseline) for a given number of time and
mark the number of times it was able to run it in that given time.

Then, it will run all the functions for the same number of time and
print the difference between the baseline and the other functions.

- $1: **baseline** _as string_:
      the name of the function to use as baseline
- $2: functions _as string_:
      The names of the functions to benchmark, comma separated.
- $3: time _as int_:
      (optional) Can be set using the variable `_OPTION_TIME`.
      The time in seconds for which to run the baseline.
      (defaults to 3s)
- $4: max runs _as int_:
      (optional) Can be set using the variable `_OPTION_MAX_RUNS`.
      The maximum number of runs to do for each function.
      (defaults to -1 which means no limit)

```bash
benchmark::run "baseline" "function1,function2" 1 100
```

{{< callout type="info" >}}
Documentation generated for the version 0.29.197 (2025-03-29).
{{< /callout >}}
