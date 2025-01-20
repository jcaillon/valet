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

## Test script 01.utilities

### ✅ Testing interactive::createSpace

❯ `interactive::createSpace 5`

**Standard output**:

```text
[?25l[1G[0J[4S[4F[?25h
```

### ✅ Testing interactive::getCursorPosition

❯ `printf '\e[%sR' '123;456' | interactive::getCursorPosition`

```text
GLOBAL_CURSOR_LINE="123"
GLOBAL_CURSOR_COLUMN="456"
```

### ✅ Testing interactiveGetProgressBarString

❯ `interactiveGetProgressBarString 0 1`

Returned variables:

```text
RETURNED_VALUE=' '
```

❯ `interactiveGetProgressBarString 10 1`

Returned variables:

```text
RETURNED_VALUE=' '
```

❯ `interactiveGetProgressBarString 50 1`

Returned variables:

```text
RETURNED_VALUE='▌'
```

❯ `interactiveGetProgressBarString 90 1`

Returned variables:

```text
RETURNED_VALUE='▉'
```

❯ `interactiveGetProgressBarString 100 1`

Returned variables:

```text
RETURNED_VALUE='█'
```

❯ `interactiveGetProgressBarString 22 10`

Returned variables:

```text
RETURNED_VALUE='██▏       '
```

❯ `interactiveGetProgressBarString 50 15`

Returned variables:

```text
RETURNED_VALUE='███████▌       '
```

❯ `interactiveGetProgressBarString 83 30`

Returned variables:

```text
RETURNED_VALUE='████████████████████████▉     '
```

### ✅ Testing interactive::clearBox

```text
GLOBAL_CURSOR_LINE="42"
GLOBAL_CURSOR_COLUMN="42"
```

❯ `interactive::clearBox 1 1 10 10`

**Standard output**:

```text
[?25l[1;1H[10X[2;1H[10X[3;1H[10X[4;1H[10X[5;1H[10X[6;1H[10X[7;1H[10X[8;1H[10X[9;1H[10X[10;1H[10X[42;42H[?25h
```

❯ `interactive::clearBox 10 10 5 5`

**Standard output**:

```text
[?25l[10;10H[5X[11;10H[5X[12;10H[5X[13;10H[5X[14;10H[5X[42;42H[?25h
```

### ✅ Testing interactive::getBestAutocompleteBox

```text
GLOBAL_LINES="10"
GLOBAL_COLUMNS="10"
```

❯ `interactive::getBestAutocompleteBox 1 1 20 20`

Returned variables:

```text
RETURNED_VALUE='2'
RETURNED_VALUE2='1'
RETURNED_VALUE3='10'
RETURNED_VALUE4='9'
```

❯ `interactive::getBestAutocompleteBox 1 1 20 20 2`

Returned variables:

```text
RETURNED_VALUE='2'
RETURNED_VALUE2='1'
RETURNED_VALUE3='10'
RETURNED_VALUE4='2'
```

❯ `interactive::getBestAutocompleteBox 1 1 5 5`

Returned variables:

```text
RETURNED_VALUE='2'
RETURNED_VALUE2='1'
RETURNED_VALUE3='5'
RETURNED_VALUE4='5'
```

❯ `interactive::getBestAutocompleteBox 5 5 6 9`

Returned variables:

```text
RETURNED_VALUE='6'
RETURNED_VALUE2='2'
RETURNED_VALUE3='9'
RETURNED_VALUE4='5'
```

❯ `interactive::getBestAutocompleteBox 7 7 10 4`

Returned variables:

```text
RETURNED_VALUE='1'
RETURNED_VALUE2='7'
RETURNED_VALUE3='4'
RETURNED_VALUE4='6'
```

❯ `interactive::getBestAutocompleteBox 7 7 10 10 '' true`

Returned variables:

```text
RETURNED_VALUE='8'
RETURNED_VALUE2='1'
RETURNED_VALUE3='10'
RETURNED_VALUE4='3'
```

❯ `interactive::getBestAutocompleteBox 1 1 10 10 999 true true 999 5`

Returned variables:

```text
RETURNED_VALUE='2'
RETURNED_VALUE2='1'
RETURNED_VALUE3='10'
RETURNED_VALUE4='4'
```

❯ `interactive::getBestAutocompleteBox 1 1 20 20 '' '' false`

Returned variables:

```text
RETURNED_VALUE='1'
RETURNED_VALUE2='1'
RETURNED_VALUE3='10'
RETURNED_VALUE4='10'
```

❯ `interactive::getBestAutocompleteBox 1 1 20 20 2 '' false`

Returned variables:

```text
RETURNED_VALUE='1'
RETURNED_VALUE2='1'
RETURNED_VALUE3='10'
RETURNED_VALUE4='2'
```

❯ `interactive::getBestAutocompleteBox 1 1 5 5 '' '' false`

Returned variables:

```text
RETURNED_VALUE='1'
RETURNED_VALUE2='1'
RETURNED_VALUE3='5'
RETURNED_VALUE4='5'
```

❯ `interactive::getBestAutocompleteBox 5 5 6 9 '' '' false`

Returned variables:

```text
RETURNED_VALUE='5'
RETURNED_VALUE2='2'
RETURNED_VALUE3='9'
RETURNED_VALUE4='6'
```

❯ `interactive::getBestAutocompleteBox 7 7 10 4 '' '' false`

Returned variables:

```text
RETURNED_VALUE='1'
RETURNED_VALUE2='7'
RETURNED_VALUE3='4'
RETURNED_VALUE4='7'
```

❯ `interactive::getBestAutocompleteBox 7 7 4 4 '' '' false`

Returned variables:

```text
RETURNED_VALUE='7'
RETURNED_VALUE2='7'
RETURNED_VALUE3='4'
RETURNED_VALUE4='4'
```

❯ `interactive::getBestAutocompleteBox 7 7 10 10 '' true false`

Returned variables:

```text
RETURNED_VALUE='7'
RETURNED_VALUE2='1'
RETURNED_VALUE3='10'
RETURNED_VALUE4='4'
```

