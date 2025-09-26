# Test suite lib-time

## Test script 00.lib-time

### ✅ Testing time::isTimeElapsed function

❯ `time::isTimeElapsed 1900000`

Returned code: `1`

❯ `time::isTimeElapsed 1900000`

Returned code: `1`

❯ `time::isTimeElapsed 1900000`

### ✅ Testing time::isTimeElapsed called from a different function

### ✅ Testing time::isTimeElapsed using timerName

### ✅ Testing time::getMicrosecondsFromSeconds function

❯ `time::getMicrosecondsFromSeconds 987`

Returned variables:

```text
REPLY='987000000'
```

❯ `time::getMicrosecondsFromSeconds 1.5`

Returned variables:

```text
REPLY='1500000'
```

❯ `time::getMicrosecondsFromSeconds 1.234567`

Returned variables:

```text
REPLY='1234567'
```

❯ `time::getMicrosecondsFromSeconds 33.00405`

Returned variables:

```text
REPLY='33004050'
```

❯ `time::getMicrosecondsFromSeconds 1234567890.123456`

Returned variables:

```text
REPLY='1234567890123456'
```

### ✅ Testing time::getSecondsFromMicroseconds function

❯ `time::getSecondsFromMicroseconds 1`

Returned variables:

```text
REPLY='0.000001'
```

❯ `time::getSecondsFromMicroseconds 1000 precision=3`

Returned variables:

```text
REPLY='0.001'
```

❯ `time::getSecondsFromMicroseconds 1234567890`

Returned variables:

```text
REPLY='1234.567890'
```

❯ `time::getSecondsFromMicroseconds 1234567890 precision=3`

Returned variables:

```text
REPLY='1234.567'
```

❯ `time::getSecondsFromMicroseconds 1234567890 precision=6`

Returned variables:

```text
REPLY='1234.567890'
```

### ✅ Testing time::startTimer function

❯ `time::startTimer`

❯ `time::getTimerMicroseconds`

Returned variables:

```text
REPLY='1000000'
```

❯ `time::getTimerMicroseconds logElapsedTime=true`

**Error output**:

```text
INFO     Elapsed time: 2.000s
```

Returned variables:

```text
REPLY='2000000'
```

❯ `time::getTimerMicroseconds format=%L logElapsedTime=true`

**Error output**:

```text
INFO     Elapsed time: 3000
```

Returned variables:

```text
REPLY='3000000'
```

### ✅ Testing time::getDate

❯ `time::getDate`

Returned variables:

```text
REPLY='1987-05-25_01h00m00s'
```

❯ `time::getDate format='%(%H:%M:%S)T'`

Returned variables:

```text
REPLY='01:00:00'
```

### ✅ Testing time::getHumanTimeFromMicroseconds function

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

❯ `time::getHumanTimeFromMicroseconds 18243002234 format="${format}"`

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

❯ `time::getHumanTimeFromMicroseconds 18243002234`

Returned variables:

```text
REPLY='05:04:03'
```

❯ `time::getHumanTimeFromMicroseconds 18243002234 format=%U`

Returned variables:

```text
REPLY='18243002234'
```

