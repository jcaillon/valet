# Test suite lib-coproc

## Test script 00.lib-coproc

### ✅ Testing coproc::run with a simple init command

❯ `_OPTION_INIT_COMMAND=initCommand coproc::run _COPROC_1`

❯ `coproc::wait _COPROC_1`

**Error output**:

```text
INFO     Running init command in coproc (_COPROC_1).
```

### ✅ Testing coproc::sendMessage, coproc::isRunning and coproc::wait

❯ `_OPTION_INIT_COMMAND=initCommand _OPTION_LOOP_COMMAND=loopCommand _OPTION_ON_MESSAGE_COMMAND=onMessageCommand;break _OPTION_END_COMMAND=endCommand coproc::run _COPROC_2`

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

❯ `_OPTION_INIT_COMMAND=initCommand _OPTION_WAIT_FOR_READINESS=true coproc::run _COPROC_3`

❯ `coproc::wait _COPROC_3`

**Error output**:

```text
INFO     Running init command in coproc (_COPROC_3).
```

### ✅ Testing coproc::kill

❯ `_OPTION_INIT_COMMAND=initCommand _OPTION_LOOP_COMMAND=loopCommand _OPTION_WAIT_FOR_READINESS=true coproc::run _COPROC_4`

❯ `coproc::kill _COPROC_4`

**Error output**:

```text
INFO     Running init command in coproc (_COPROC_4).
```

### ✅ Testing coproc::run with a realistic usage

❯ `_OPTION_LOOP_COMMAND=realisticLoop _OPTION_ON_MESSAGE_COMMAND=realisticOnMessage coproc::run _COPROC_9`

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

❯ `_OPTION_LOOP_COMMAND=realisticLoop _OPTION_ON_MESSAGE_COMMAND=realisticOnMessage coproc::run _COPROC_9`

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

❯ `_OPTION_INIT_COMMAND=initCommand coproc::run _COPROC_20`

**Error output**:

```text
$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-coproc/00.lib-coproc.sh: line 150: ((: 0/0: division by 0 (error token is "0")
CMDERR   Error code ⌜1⌝ for the command:
╭ ((0/0))
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
WARNING  Subshell exited with code 1
ERROR    Exiting subshell 3 with code 1, stack:
╭ eval "${initCommand}"
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
INFO     The coproc ⌜_COPROC_20⌝ failed as expected.
```

