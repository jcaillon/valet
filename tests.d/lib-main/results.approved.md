# Test suite lib-main

## Test script 01.sort-commands

### ✅ Testing main::sortCommands

```text
VALET_CONFIG_LOCAL_STATE_DIRECTORY='/tmp/valet.d/d1-2'
VALET_CONFIG_REMEMBER_LAST_CHOICES='5'
COMMANDS=(
[0]='cm1  This is command 1'
[1]='cm2  This is command 2'
[2]='sub cmd1  This is sub command 1'
[3]='sub cmd2  This is sub command 2'
[4]='another3  This is another command 3'
)
```

testing commands sort and that without prior choices, the order of commands is kept

❯ `main::sortCommands my-id1 COMMANDS`

```text
COMMANDS=(
[0]='cm1  This is command 1'
[1]='cm2  This is command 2'
[2]='sub cmd1  This is sub command 1'
[3]='sub cmd2  This is sub command 2'
[4]='another3  This is another command 3'
)
```

testing commands sort after choosing another3 then cm2

❯ `main::addLastChoice my-id1 another3`

❯ `main::addLastChoice my-id1 cm2`

❯ `main::sortCommands my-id1 COMMANDS`

```text
COMMANDS=(
[0]='cm2  This is command 2'
[1]='another3  This is another command 3'
[2]='cm1  This is command 1'
[3]='sub cmd1  This is sub command 1'
[4]='sub cmd2  This is sub command 2'
)
```

testing with VALET_CONFIG_REMEMBER_LAST_CHOICES=0

❯ `VALET_CONFIG_REMEMBER_LAST_CHOICES=0 main::sortCommands my-id1 COMMANDS`

```text
COMMANDS=(
[0]='cm1  This is command 1'
[1]='cm2  This is command 2'
[2]='sub cmd1  This is sub command 1'
[3]='sub cmd2  This is sub command 2'
[4]='another3  This is another command 3'
)
```

testing commands sort for another id, the order of commands should be the initial one

❯ `main::sortCommands my-id2 COMMANDS`

```text
COMMANDS=(
[0]='cm1  This is command 1'
[1]='cm2  This is command 2'
[2]='sub cmd1  This is sub command 1'
[3]='sub cmd2  This is sub command 2'
[4]='another3  This is another command 3'
)
```

testing that after adding more than x commands, we only keep the last x

```text
VALET_CONFIG_REMEMBER_LAST_CHOICES='2'
```

❯ `main::addLastChoice my-id1 cm1`

❯ `main::addLastChoice my-id1 cm2`

❯ `main::addLastChoice my-id1 cm3`

❯ `main::addLastChoice my-id1 cm4`

❯ `fs::cat /tmp/valet.d/d1-2/last-choices-my-id1`

**Standard output**:

```text
cm4
cm3

```

testing commands that adding the same command multiple times only keeps the last one

❯ `main::addLastChoice my-id1 another3`

❯ `main::addLastChoice my-id1 another3`

❯ `main::addLastChoice my-id1 another3`

❯ `fs::cat /tmp/valet.d/d1-2/last-choices-my-id1`

**Standard output**:

```text
another3
cm4

```

