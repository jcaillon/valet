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

