---
title: 📂 time
cascade:
  type: docs
url: /docs/libraries/time
---

## time::convertMicrosecondsToHuman

Convert microseconds to human readable format.

- $1: **microseconds** _as int_:
      the microseconds to convert
- $2: format _as string_:
     (optional) Can be set using the variable `_OPTION_FORMAT`.
     the format to use (defaults to "%HH:%MM:%SS")
     Usable formats:
     - %HH: hours
     - %MM: minutes
     - %SS: seconds
     - %LL: milliseconds
     - %h: hours without leading zero
     - %m: minutes without leading zero
     - %s: seconds without leading zero
     - %l: milliseconds without leading zero
     - %u: microseconds without leading zero
     - %M: total minutes
     - %S: total seconds
     - %L: total milliseconds
     - %U: total microseconds

Returns:

- ${RETURNED_VALUE}: the human readable format

```bash
time::convertMicrosecondsToHuman 123456789
echo "${RETURNED_VALUE}"
```

## time::getDate

Get the current date in the given format.

- $1: format _as string_:
      (optional) the format of the date to return
      (defaults to %(%F_%Hh%Mm%Ss)T).

Returns:

- ${RETURNED_VALUE}: the current date in the given format.

```bash
time::getDate
local date="${RETURNED_VALUE}"
```

> This function avoid to call $(date) in a subshell (date is a an external executable).

## time::getProgramElapsedMicroseconds

Get the elapsed time in µs since the program started.

Returns:

- ${RETURNED_VALUE}: the elapsed time in µs since the program started.

```bash
core::getElapsedProgramTime
echo "${RETURNED_VALUE}"
time::convertMicrosecondsToHuman "${RETURNED_VALUE}"
echo "Human time: ${RETURNED_VALUE}"
```

> We split the computation in seconds and milliseconds to avoid overflow on 32-bit systems.
> The 10# forces the base 10 conversion to avoid issues with leading zeros.
> Fun fact: this function will fail in 2038 on 32-bit systems because the number of seconds will overflow.

## time::getTimerValue

Get the time elapsed since the call of `time::startTimer`.

- ${_OPTION_LOG_ELAPSED_TIME} _as bool_:
     (optional) Wether or not to log the elapsed time.
     (defaults to false)
- ${_OPTION_FORMAT} _as string_:
     (optional) The format to use if we log the elapsed time.
     See `time::convertMicrosecondsToHuman` for the format.
     (defaults to "%S.%LLs").

Returns:

- ${RETURNED_VALUE}: the elapsed time in microseconds.

```bash
time::startTimer
_OPTION_LOG_ELAPSED_TIME=true time::getTimerValue
echo "Total microseconds: ${RETURNED_VALUE}"
```

## time::startTimer

Start a timer. You can then call `time::getTimerValue` to get the elapsed time.

```bash
time::startTimer
time::getTimerValue
```

> Documentation generated for the version 0.28.3846 (2025-03-18).
