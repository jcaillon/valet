# Test suite lib-time

## Test script 00.tests

### ✅ Testing time::startTimer function

❯ `time::startTimer`

❯ `time::getTimerMicroseconds`

Returned variables:

```text
REPLY='2000000'
```

❯ `_OPTION_LOG_ELAPSED_TIME=true time::getTimerMicroseconds`

**Error output**:

```text
INFO     Elapsed time: 5.000s
```

Returned variables:

```text
REPLY='5000000'
```

❯ `_OPTION_LOG_ELAPSED_TIME=true _OPTION_FORMAT=%L time::getTimerMicroseconds`

**Error output**:

```text
INFO     Elapsed time: 9000
```

Returned variables:

```text
REPLY='9000000'
```

### ✅ Testing time::getDate

❯ `time::getDate`

Returned variables:

```text
REPLY='1987-05-25_01h00m00s'
```

❯ `time::getDate '%(%H:%M:%S)T'`

Returned variables:

```text
REPLY='01:00:00'
```

### ✅ Testing time::convertMicrosecondsToHuman function

```text
format='Hours: %HH
Minutes: %MM
Seconds: %SS
Milliseconds: %LL
Microseconds: %UU

Hours: %h
Minutes: %m
Seconds: %s
Milliseconds: %l
Microseconds: %u

Total minutes: %M
Total seconds: %S
Total milliseconds: %L
Total microseconds: %U'
```

❯ `time::convertMicrosecondsToHuman 18243002234 "${format}"`

Returned variables:

```text
REPLY='Hours: 05
Minutes: 04
Seconds: 03
Milliseconds: 002
Microseconds: 234

Hours: 5
Minutes: 4
Seconds: 3
Milliseconds: 2
Microseconds: 234

Total minutes: 304
Total seconds: 18243
Total milliseconds: 4320003002
Total microseconds: 18243002234'
```

❯ `time::convertMicrosecondsToHuman 18243002234`

Returned variables:

```text
REPLY='05:04:03'
```

❯ `_OPTION_FORMAT=%U time::convertMicrosecondsToHuman 18243002234`

Returned variables:

```text
REPLY='18243002234'
```

