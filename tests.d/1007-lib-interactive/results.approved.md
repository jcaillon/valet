# Test suite 1007-lib-interactive

## Test script 00.tests

### test interactive::promptYesNo with yes

Exit code: `0`

**Standard** output:

```plaintext
echo y | interactive::promptYesNo 'Do you see this message?'
[2m░─[24b─┐[0m
[2m  [0mDo you see this message? [28G[2m│[0m
[2m░─[24b─┘[0m
[1G[0J
[1F[?25l[7m   (Y)ES   [0m      (N)O   [0m[1G[0K[?25h[2m[9992G┌─[4b─░[0m
[2m[9992G│[0m Yes.[2m[0m
[2m[9992G└─[4b─░[0m
```

### Testing interactive::promptYesNo

Exit code: `1`

**Standard** output:

```plaintext

echo n | interactive::promptYesNo 'Do you see this message?'
[2m░─[24b─┐[0m
[2m  [0mDo you see this message? [28G[2m│[0m
[2m░─[24b─┘[0m
[1G[0J
[1F[?25l[7m   (Y)ES   [0m      (N)O   [0m[1G[0K[?25h[2m[9993G┌─[3b─░[0m
[2m[9993G│[0m No.[2m[0m
[2m[9993G└─[3b─░[0m
```

### test interactive::askForConfirmation with yes

Exit code: `0`

**Standard** output:

```plaintext
echo y | interactive::askForConfirmation 'Please press OK.'
[2m░─[16b─┐[0m
[2m  [0mPlease press OK. [20G[2m│[0m
[2m░─[16b─┘[0m
[1G[0J
[1F[?25l[7m   (O)K   [0m[1G[0K[?25h
```

## Test script 01.utilities

### Testing interactive::createSpace

Exit code: `0`

**Standard** output:

```plaintext
interactive::createSpace 5
[1G[0J



[4F
```

### Testing interactive::getCursorPosition

Exit code: `0`

**Standard** output:

```plaintext
printf '\e[%sR' '123;456' | interactive::getCursorPosition
CURSOR_LINE: 123; CURSOR_COLUMN: 456
```

