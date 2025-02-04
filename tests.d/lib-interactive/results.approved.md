# Test suite lib-interactive

## Test script 00.tests

### ✅ Testing interactive::promptYesNo

❯ `echo y | interactive::promptYesNo 'Do you see this message?'`

**Standard output**:

```text
[2m   ┌─[24b─┐[0m
[2m░──┤[0m Do you see this message? [31G[2m│[0m
[2m   └─[24b─┘[0m
[?25l[1G[0J[1S[1F[?25h[?25l[7m   (Y)ES   [0m      (N)O   [0m[1G[0K[?25h[2m[9G┌─[4b─┐[0m
[2m[9G│[0m Yes. [16G[2m├──░[0m
[2m[9G└─[4b─┘[0m
```

❯ `echo echo n | interactive::promptYesNo 'Do you see this message?'`

Exited with code: `1`

**Standard output**:

```text
[2m   ┌─[24b─┐[0m
[2m░──┤[0m Do you see this message? [31G[2m│[0m
[2m   └─[24b─┘[0m
[?25l[1G[0J[1S[1F[?25h[?25l[7m   (Y)ES   [0m      (N)O   [0m[1G[0K[?25h[2m[9G┌─[3b─┐[0m
[2m[9G│[0m No. [15G[2m├──░[0m
[2m[9G└─[3b─┘[0m
```

### ✅ Testing interactive::askForConfirmation

❯ `echo y | interactive::askForConfirmation 'Please press OK.'`

**Standard output**:

```text
[2m   ┌─[16b─┐[0m
[2m░──┤[0m Please press OK. [23G[2m│[0m
[2m   └─[16b─┘[0m
[?25l[1G[0J[1S[1F[?25h[?25l[7m   (O)K   [0m[1G[0K[?25h
```

### ✅ Testing interactive::displayDialogBox

❯ `interactive::displayDialogBox system $'Do you want to run the tests?\n\ncause it is super cool awesome you one know and stuff (y/n)' 15`

**Standard output**:

```text
[2m   ┌─[15b─┐[0m
[2m░──┤[0m Do you want to  [22G[2m│[0m
[2m   │[0m run the tests? [22G[2m│[0m
[2m   │[0m  [22G[2m│[0m
[2m   │[0m cause it is  [22G[2m│[0m
[2m   │[0m super cool  [22G[2m│[0m
[2m   │[0m awesome you one [22G[2m│[0m
[2m   │[0m know and stuff  [22G[2m│[0m
[2m   │[0m (y/n) [22G[2m│[0m
[2m   └─[15b─┘[0m
```

❯ `interactive::displayDialogBox user $'Do you want to run the tests?\n\ncause it is super cool awesome you one know and stuff (y/n)' 10`

**Standard output**:

```text
[2m[9G┌─[9b─┐[0m
[2m[9G│[0m Do you  [21G[2m├──░[0m
[2m[9G│[0m want to  [21G[2m│[0m
[2m[9G│[0m run the  [21G[2m│[0m
[2m[9G│[0m tests? [21G[2m│[0m
[2m[9G│[0m  [21G[2m│[0m
[2m[9G│[0m cause it  [21G[2m│[0m
[2m[9G│[0m is super  [21G[2m│[0m
[2m[9G│[0m cool  [21G[2m│[0m
[2m[9G│[0m awesome  [21G[2m│[0m
[2m[9G│[0m you one  [21G[2m│[0m
[2m[9G│[0m know and  [21G[2m│[0m
[2m[9G│[0m stuff  [21G[2m│[0m
[2m[9G│[0m (y/n) [21G[2m│[0m
[2m[9G└─[9b─┘[0m
```

