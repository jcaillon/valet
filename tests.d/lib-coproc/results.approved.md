# Test suite lib-coproc

## Test script 00.lib-coproc

### ✅ Testing coproc::run

❯ `coproc::run _COPROC_1 initCommand false willNotBeUsed :`

❯ `coproc::wait _COPROC_1`

**Error output**:

```text
INFO     Running init command in coproc (_COPROC_1).
```

❯ `coproc::run _COPROC_2 initCommand loopCommand onMessageCommand endCommand`

❯ `coproc::isRunning _COPROC_2`

❯ `coproc::sendMessage _COPROC_2 Hello, coproc 2!`

❯ `coproc::wait _COPROC_2`

❯ `coproc::isRunning _COPROC_2`

**Error output**:

```text
INFO     Running init command in coproc (_COPROC_2).
INFO     Running loop command in coproc (_COPROC_2).
INFO     Received message in coproc (_COPROC_2): Hello, coproc 2!
INFO     Running end command in coproc (_COPROC_2).
```

❯ `_OPTION_WAIT_FOR_READINESS=true coproc::run _COPROC_3 initCommand false false true`

❯ `coproc::wait _COPROC_3`

**Error output**:

```text
INFO     Running init command in coproc (_COPROC_3).
```

### ✅ Testing coproc::run with a realistic usage

❯ `coproc::run _COPROC_4 : realisticLoop realisticOnMessage :`

**Error output**:

```text
INFO     Running loop command in coproc (_COPROC_4), loop number: 1.
INFO     Received message in coproc (_COPROC_4): decoy
INFO     Running loop command in coproc (_COPROC_4), loop number: 2.
INFO     Received message in coproc (_COPROC_4): message 0
INFO     Received message in coproc (_COPROC_4): decoy
INFO     Received message in coproc (_COPROC_4): message 1
INFO     Received message in coproc (_COPROC_4): stop
INFO     Stopping the coproc (_COPROC_4).
```

### ✅ Testing coproc::run with a realistic usage and keeping only the last message

❯ `coproc::run _COPROC_4 : realisticLoop realisticOnMessage :`

**Error output**:

```text
INFO     Running loop command in coproc (_COPROC_4), loop number: 1.
INFO     Received message in coproc (_COPROC_4): message 0
INFO     Running loop command in coproc (_COPROC_4), loop number: 2.
INFO     Received message in coproc (_COPROC_4): message 1
INFO     Received message in coproc (_COPROC_4): stop
INFO     Stopping the coproc (_COPROC_4).
```

