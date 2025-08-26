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

## ⚡ time::getMicrosecondsToHuman

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
time::getMicrosecondsToHuman 123456789
time::getMicrosecondsToHuman 123456789 format="%HH:%MM:%SS"
echo "${REPLY}"
```

## ⚡ time::getMicrosecondsToSeconds

Convert a microseconds integer to seconds float.
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
time::getMicrosecondsToSeconds 1234567
time::getMicrosecondsToSeconds 1234567 precision=3
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
time::getMicrosecondsToHuman "${REPLY}"
echo "Human time: ${REPLY}"
```

> We split the computation in seconds and milliseconds to avoid overflow on 32-bit systems.
> The 10# forces the base 10 conversion to avoid issues with leading zeros.
> Fun fact: this function will fail in 2038 on 32-bit systems because the number of seconds will overflow.

## ⚡ time::getTimerMicroseconds

Get the time elapsed since the call of `time::startTimer`.

Inputs:

- `${logElapsedTime}` _as bool_:

  (optional) Wether or not to log the elapsed time.

  (defaults to false)

- `${format}` _as string_:

  (optional) The format to use if we log the elapsed time.
  See `time::getMicrosecondsToHuman` for the format.

  (defaults to "%S.%LLs").

Returns:

- `${REPLY}`: the elapsed time in microseconds.

Example usage:

```bash
time::startTimer
time::getTimerMicroseconds logElapsedTime=true
echo "Total microseconds: ${REPLY}"
```

## ⚡ time::startTimer

Start a timer. You can then call `time::getTimerMicroseconds` to get the elapsed time.

Example usage:

```bash
time::startTimer
time::getTimerMicroseconds
```

> [!IMPORTANT]
> Documentation generated for the version 0.31.272 (2025-08-26).
