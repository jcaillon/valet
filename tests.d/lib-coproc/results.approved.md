# Test suite lib-coproc

## Test script 00.lib-coproc

### ✅ Testing coproc::run with a simple init command

❯ `coproc::run _COPROC_1 mainCommand=mainCommand`

**Error output**:

```text
INFO     Running init command in coproc (_COPROC_1).
```

### ✅ Testing coproc::sendMessage, coproc::isRunning and coproc::wait

❯ `coproc::run _COPROC_2 mainCommand=mainCommand loopCommand=loopCommand onMessageCommand=onMessageCommand;break endCommand=endCommand`

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

### ✅ Testing coproc::run with wait for readiness

❯ `coproc::run _COPROC_3 mainCommand=mainCommand waitForMainEnd=true`

**Error output**:

```text
INFO     Running init command in coproc (_COPROC_3).
```

### ✅ Testing coproc::kill

❯ `coproc::run _COPROC_4 mainCommand=mainCommand loopCommand=loopCommand waitForMainEnd=true`

❯ `coproc::kill _COPROC_4`

**Error output**:

```text
INFO     Running init command in coproc (_COPROC_4).
```

### ✅ Testing coproc messages when coproc is killed

❯ `coproc::run _COPROC_5 waitForMainEnd=true`

❯ `coproc::sendMessage _COPROC_5 hello`

Returned code: `1`

❯ `coproc::receiveMessage _COPROC_5`

Returned code: `1`

❯ `coproc::isRunning _COPROC_5`

Returned code: `1`

❯ `coproc::wait _COPROC_5`

❯ `coproc::kill _COPROC_5`

### ✅ Testing coproc::run with a realistic usage

❯ `coproc::run _COPROC_9 loopCommand=realisticLoop onMessageCommand=realisticOnMessage keepOnlyLastMessage=false`

**Error output**:

```text
INFO     Running loop command in coproc (_COPROC_9), loop number: 1.
INFO     Received message in coproc (_COPROC_9): decoy
INFO     Running loop command in coproc (_COPROC_9), loop number: 2.
INFO     Received message in coproc (_COPROC_9): message 0
INFO     Received message in coproc (_COPROC_9): decoy
INFO     Received message in coproc (_COPROC_9): message 1
INFO     Received message in coproc (_COPROC_9): stop
INFO     Stopping the coproc (_COPROC_9).
```

### ✅ Testing coproc::run with a realistic usage and keeping only the last message

❯ `coproc::run _COPROC_9 loopCommand=realisticLoop onMessageCommand=realisticOnMessage keepOnlyLastMessage=true`

**Error output**:

```text
INFO     Running loop command in coproc (_COPROC_9), loop number: 1.
INFO     Received message in coproc (_COPROC_9): message 0
INFO     Running loop command in coproc (_COPROC_9), loop number: 2.
INFO     Received message in coproc (_COPROC_9): message 1
INFO     Received message in coproc (_COPROC_9): stop
INFO     Stopping the coproc (_COPROC_9).
```

### ✅ Testing coproc::run with an error in the init command

❯ `coproc::run _COPROC_20 mainCommand=mainCommand`

**Error output**:

```text
$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-coproc/00.lib-coproc.sh: line 155: ((: 0 / 0: division by 0 (error token is "0")
CMDERR   Error code ⌜1⌝ for the command:
╭ ((0 / 0))
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
INFO     The coproc ⌜_COPROC_20⌝ failed as expected.
```

❯ `coproc::run _COPROC_21 mainCommand=mainCommand waitForMainEnd=true redirectLogsToFile=/tmp/valet-temp`

❯ `coproc::run _COPROC_21 mainCommand=mainCommand waitForMainEnd=true redirectLogsToFile=/tmp/valet-temp`

Exited with code: `1`

**Error output**:

```text
FAIL     The coproc ⌜_COPROC_21⌝ did not start correctly.
```

> cat `/tmp/valet-temp`

```text
$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-coproc/00.lib-coproc.sh: line 175: 1: unbound variable
ERROR    Exiting subshell depth 4 with code 1, stack:
╭ local a="${1}"
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300

```

