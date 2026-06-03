---
title: 📂 time
cascade:
  type: docs
url: /docs/libraries/time
---

## ⚡ time::getDate

Get the current date in the given format.

Inputs:

- `${format}` _as string_:

  (optional) the format (see printf) of the date to return

  (defaults to "%(%F_%Hh%Mm%Ss)T")

Returns:

- `${REPLY}`: the current date in the given format.

Example usage:

```bash
time::getDate
local date="${REPLY}"
time::getDate format="'%(%Hh%Mm%Ss)T'"
```

> This function avoid to call $(date) in a subshell (date is a an external executable).

## ⚡ time::getHumanTimeFromMicroseconds

Convert microseconds to human readable format.

Inputs:

- `$1`: **microseconds** _as int_:

  the microseconds to convert

- `${format}` _as string_:

  (optional) the format to use

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


  (defaults to "%HH:%MM:%SS")

Returns:

- `${REPLY}`: the human readable format

Example usage:

```bash
time::getHumanTimeFromMicroseconds 123456789
time::getHumanTimeFromMicroseconds 123456789 format="%HH:%MM:%SS"
echo "${REPLY}"
```

## ⚡ time::getMicrosecondsFromSeconds

Convert seconds (float number representation) to microseconds.
e.g. 1.234567 → 1234567

Inputs:

- `$1`: **seconds** _as float_:

  the seconds to convert

Returns:

- `${REPLY}`: The microseconds (integer number).

Example usage:

```bash
time::getMicrosecondsFromSeconds 1.234567
echo "${REPLY}"
```

## ⚡ time::getProgramElapsedMicroseconds

Get the elapsed time in µs since the program started.

Returns:

- `${REPLY}`: the elapsed time in µs since the program started.

Example usage:

```bash
time::getProgramElapsedMicroseconds
echo "${REPLY}"
time::getHumanTimeFromMicroseconds "${REPLY}"
echo "Human time: ${REPLY}"
```

> We split the computation in seconds and milliseconds to avoid overflow on 32-bit systems.
> The 10# forces the base 10 conversion to avoid issues with leading zeros.
> Fun fact: this function will fail in 2038 on 32-bit systems because the number of seconds will overflow.

## ⚡ time::getSecondsFromMicroseconds

Convert microseconds to seconds (float number representation).
e.g. 1234567 → 1.234567

Inputs:

- `$1`: **microseconds** _as int_:

  the microseconds to convert

- `${precision}` _as string_:

  (optional) The precision to get (number of digits after the dot).

  (defaults to 6)

Returns:

- `${REPLY}`: The seconds (float number).

Example usage:

```bash
time::getSecondsFromMicroseconds 1234567
time::getSecondsFromMicroseconds 1234567 precision=3
echo "${REPLY}"
```

## ⚡ time::getTimerMicroseconds

Get the time elapsed since the call of `time::startTimer`.
By default, it returns an integer representing the elapsed time in microseconds,
but you can change the output format with the `format` option.

Inputs:

- `${timerName}` _as string_:

  (optional) A variable name that will be used to fetch the start time of the timer.
  Must match the one used in the call of `time::startTimer`.

  (defaults to "${FUNCNAME[1]}")

- `${format}` _as string_:

  (optional) The format with which to output the elapsed time.
  See `time::getHumanTimeFromMicroseconds` for the format.

  (defaults to "%U").

Returns:

- `${REPLY}`: the elapsed time in microseconds.

Example usage:

```bash
time::startTimer
time::getTimerMicroseconds format="%S.%LLs"
echo "Total elapsed time: ${REPLY}"
```

## ⚡ time::isSpamming

Check if it's been less than a given delay since the last call to this function.

Can be used to check if a function is being called too often, for example a user
spamming a command or key.

Inputs:

- `$1`: **time** _as string_:

  The time to check. Must be an integer followed by a unit.
  Can be given in seconds (s), milliseconds (ms) or microseconds (us).

- `${timerName}` _as string_:

  A variable name that will be used to store the last time this function was called.
  Defaults to the name of the calling function.
  Can be set to a fixed value if you call this function from different functions
  and want to share the same timer.

  (defaults to "${FUNCNAME[1]}")

Returns:

- `$?`:
  - 0 if the time has not elapsed yet (spamming)
  - 1 if the time has elapsed (not spamming)

Example usage:

```bash
if time::isSpamming 500ms; then
  echo "500ms has elapsed since the last call to this function"
fi
```

## ⚡ time::isTimerElapsed

Check if a given time has elapsed since the call of `time::startTimer`.

Inputs:

- `$1`: **time** _as string_:

  The time to check. Must be an integer followed by a unit.
  Can be given in seconds (s), milliseconds (ms) or microseconds (us).

- `${timerName}` _as string_:

  (optional) A variable name that will be used to fetch the start time of the timer.
  Must match the one used in the call of `time::startTimer`.

  (defaults to "${FUNCNAME[1]}")

Returns:

- `$?`: 0 if the time has elapsed, 1 if it has not.

Example usage:

```bash
time::startTimer
if time::isTimerElapsed 500ms; then
  echo "500ms has elapsed since the last call to time::startTimer"
fi
```

## ⚡ time::logTimerElapsedTime

Log the time elapsed since the call of `time::startTimer`.

Inputs:

- `${timerName}` _as string_:

  (optional) A variable name that will be used to fetch the start time of the timer.
  Must match the one used in the call of `time::startTimer`.

  (defaults to "${FUNCNAME[1]}")

- `${format}` _as string_:

  (optional) The format with which to output the elapsed time.
  See `time::getHumanTimeFromMicroseconds` for the format.

  (defaults to "%S.%LLs").

Example usage:

```bash
time::startTimer
# some code
time::logTimerElapsedTime
```

## ⚡ time::startTimer

Start a new timer.
You can then call `time::getTimerMicroseconds` to get the elapsed time.
Or call `time::isTimerElapsed` to check if a given time has elapsed since the call of this function.

# - ${timerName} _as string_:
  (optional) A variable name that will be used to store the start time of the timer.
  Defaults to the name of the calling function.
  Can be set to a fixed value if you call this function from different functions
  and want to share the same timer.

  (defaults to "${FUNCNAME[1]}")

Example usage:

```bash
time::startTimer myTimer
time::getTimerMicroseconds myTimer
```

> [!IMPORTANT]
> Documentation generated for the version 0.40.137 (2026-06-03).
