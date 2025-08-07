# Test suite lib-interactive

## Test script 00.tests

### ✅ Testing interactive::displayDialogBox

❯ `interactive::displayQuestion $'Do you want to run the tests?\n\ncause it is super cool awesome you one know and stuff (y/n)' width=15`

**Error output**:

```text
   [90m╭─────────────────╮[0m
[90m░──┤[0m Do you want to  [22G[90m│[0m
   [90m│[0m run the tests? [22G[90m│[0m
   [90m│[0m  [22G[90m│[0m
   [90m│[0m cause it is  [22G[90m│[0m
   [90m│[0m super cool  [22G[90m│[0m
   [90m│[0m awesome you one [22G[90m│[0m
   [90m│[0m know and stuff  [22G[90m│[0m
   [90m│[0m (y/n) [22G[90m│[0m
   [90m╰─────────────────╯[0m
```

❯ `interactive::displayAnswer $'Do you want to run the tests?\n\ncause it is super cool awesome you one know and stuff (y/n)' width=10`

**Error output**:

```text
[9G[90m╭───────────╮[0m
[9G[90m│[0m Do you  [21G[90m├──░[0m
[9G[90m│[0m want to  [21G[90m│[0m
[9G[90m│[0m run the  [21G[90m│[0m
[9G[90m│[0m tests? [21G[90m│[0m
[9G[90m│[0m  [21G[90m│[0m
[9G[90m│[0m cause it  [21G[90m│[0m
[9G[90m│[0m is super  [21G[90m│[0m
[9G[90m│[0m cool  [21G[90m│[0m
[9G[90m│[0m awesome  [21G[90m│[0m
[9G[90m│[0m you one  [21G[90m│[0m
[9G[90m│[0m know and  [21G[90m│[0m
[9G[90m│[0m stuff  [21G[90m│[0m
[9G[90m│[0m (y/n) [21G[90m│[0m
[9G[90m╰───────────╯[0m
```

### ✅ Testing interactive::promptYesNo

❯ `echo y | interactive::promptYesNo 'Do you see this message?'`

❯ `interactive::promptYesNo Do\ you\ see\ this\ message\?`

**Error output**:

```text
   [90m╭──────────────────────────╮[0m
[90m░──┤[0m Do you see this message? [31G[90m│[0m
   [90m╰──────────────────────────╯[0m
[?25l
[1F[0J[?25l [7m[95m   (Y)ES   [0m   [7m[90m   (N)O   [0m[1G[0K[9G[90m╭──────╮[0m
[9G[90m│[0m Yes. [16G[90m├──░[0m
[9G[90m╰──────╯[0m
```

Returned variables:

```text
REPLY='true'
```

❯ `echo n | interactive::promptYesNo 'Do you see this message?'`

❯ `interactive::promptYesNo Do\ you\ see\ this\ message\?`

Returned code: `1`

**Error output**:

```text
   [90m╭──────────────────────────╮[0m
[90m░──┤[0m Do you see this message? [31G[90m│[0m
   [90m╰──────────────────────────╯[0m
[?25l
[1F[0J[?25l [7m[95m   (Y)ES   [0m   [7m[90m   (N)O   [0m[1G[0K[9G[90m╭─────╮[0m
[9G[90m│[0m No. [15G[90m├──░[0m
[9G[90m╰─────╯[0m
```

Returned variables:

```text
REPLY='false'
```

### ✅ Testing interactive::askForConfirmation

❯ `echo o | interactive::askForConfirmation 'Please press OK.'`

❯ `interactive::askForConfirmation Please\ press\ OK.`

**Error output**:

```text
   [90m╭──────────────────╮[0m
[90m░──┤[0m Please press OK. [23G[90m│[0m
   [90m╰──────────────────╯[0m
[?25l
[1F[0J [?25l[7m[95m   (O)K   [0m[1G[0K
```

❯ `echo n | interactive::askForConfirmation 'Please press OK.'`

❯ `interactive::askForConfirmation Please\ press\ OK.`

Returned code: `1`

**Error output**:

```text
   [90m╭──────────────────╮[0m
[90m░──┤[0m Please press OK. [23G[90m│[0m
   [90m╰──────────────────╯[0m
[?25l
[1F[0J [?25l[7m[95m   (O)K   [0m[1G[0K
```

