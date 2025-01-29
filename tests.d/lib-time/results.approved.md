# Test suite lib-time

## Test script 00.tests

### ✅ Testing time::getDate

❯ `time::getDate`

Returned variables:

```text
RETURNED_VALUE='1987-05-25_01h00m00s'
```

❯ `time::getDate '%(%H:%M:%S)T'`

Returned variables:

```text
RETURNED_VALUE='01:00:00'
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
RETURNED_VALUE='Hours: 05
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
RETURNED_VALUE='05:04:03'
```

❯ `_OPTION_FORMAT=%U time::convertMicrosecondsToHuman 18243002234`

Returned variables:

```text
RETURNED_VALUE='18243002234'
```

