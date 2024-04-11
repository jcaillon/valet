# Test suite 1007-lib-interactive

## Test script 00.tests

### test interactive::promptYesNo with yes

Exit code: `0`

**Standard** output:

```plaintext
echo y | interactive::promptYesNo 'Do you see this message?'
[2m   ┌─[24b─┐[0m
[2m   │[0m Do you see this message? [2m│[0m
[2m   └─[24b─┘\[0m
[?25l[1m[7m   (Y)ES   [0m   [1m[7m   (N)O   [0m[1G[0K[?25h[2m ┌─[4b─┐[0m
[2m │[0m Yes. [2m│[0m
[2m/└─[4b─┘[0m
```

### Testing interactive::promptYesNo

Exit code: `1`

**Standard** output:

```plaintext

echo n | interactive::promptYesNo 'Do you see this message?'
[2m   ┌─[24b─┐[0m
[2m   │[0m Do you see this message? [2m│[0m
[2m   └─[24b─┘\[0m
[?25l[1m[7m   (Y)ES   [0m   [1m[7m   (N)O   [0m[1G[0K[?25h[2m ┌─[3b─┐[0m
[2m │[0m No. [2m│[0m
[2m/└─[3b─┘[0m
```

### test interactive::askForConfirmation with yes

Exit code: `0`

**Standard** output:

```plaintext
echo y | interactive::askForConfirmation 'Please press OK.'
[2m   ┌─[16b─┐[0m
[2m   │[0m Please press OK. [2m│[0m
[2m   └─[16b─┘\[0m
[?25l[1m[7m   (O)K   [0m[1G[0K[?25h[2m ┌─[3b─┐[0m
[2m │[0m Ok. [2m│[0m
[2m/└─[3b─┘[0m
```

