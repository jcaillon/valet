# Test suite lib-terminal

## Test script 00.terminal

### ✅ Testing terminal::createSpace

❯ `terminal::createSpace 1`

**Error output**:

```text
[?25l[1G[2K
```

❯ `terminal::createSpace 20`

**Error output**:

```text
[?25l








[9F[0J
```

❯ `terminal::createSpace 5`

**Error output**:

```text
[?25l



[4F[0J
```

### ✅ Testing terminal::getCursorPosition

❯ `printf '\e[%sR' '123;456' | terminal::getCursorPosition`

❯ `terminal::getCursorPosition`

**Error output**:

```text
[6n
```

```text
GLOBAL_CURSOR_LINE='123'
GLOBAL_CURSOR_COLUMN='456'
```

### ✅ Testing terminal::clearBox

```text
GLOBAL_CURSOR_LINE='42'
GLOBAL_CURSOR_COLUMN='42'
```

❯ `terminal::clearBox 1 1 10 10`

**Error output**:

```text
[?25l[1;1H[10X[2;1H[10X[3;1H[10X[4;1H[10X[5;1H[10X[6;1H[10X[7;1H[10X[8;1H[10X[9;1H[10X[10;1H[10X[42;42H
```

❯ `terminal::clearBox 10 10 5 5`

**Error output**:

```text
[?25l[10;10H[5X[11;10H[5X[12;10H[5X[13;10H[5X[14;10H[5X[42;42H
```

### ✅ Testing terminal::getBestAutocompleteBox

```text
GLOBAL_LINES='10'
GLOBAL_COLUMNS='10'
```

❯ `terminal::getBestAutocompleteBox 1 1 20 20`

Returned variables:

```text
REPLY='2'
REPLY2='1'
REPLY3='10'
REPLY4='9'
```

❯ `terminal::getBestAutocompleteBox 1 1 20 20 2`

Returned variables:

```text
REPLY='2'
REPLY2='1'
REPLY3='10'
REPLY4='2'
```

❯ `terminal::getBestAutocompleteBox 1 1 5 5`

Returned variables:

```text
REPLY='2'
REPLY2='1'
REPLY3='5'
REPLY4='5'
```

❯ `terminal::getBestAutocompleteBox 5 5 6 9`

Returned variables:

```text
REPLY='6'
REPLY2='2'
REPLY3='9'
REPLY4='5'
```

❯ `terminal::getBestAutocompleteBox 7 7 10 4`

Returned variables:

```text
REPLY='1'
REPLY2='7'
REPLY3='4'
REPLY4='6'
```

❯ `terminal::getBestAutocompleteBox 7 7 10 10 '' true`

Returned variables:

```text
REPLY='8'
REPLY2='1'
REPLY3='10'
REPLY4='3'
```

❯ `terminal::getBestAutocompleteBox 1 1 10 10 999 true true 999 5`

Returned variables:

```text
REPLY='2'
REPLY2='1'
REPLY3='10'
REPLY4='4'
```

❯ `terminal::getBestAutocompleteBox 1 1 20 20 '' '' false`

Returned variables:

```text
REPLY='1'
REPLY2='1'
REPLY3='10'
REPLY4='10'
```

❯ `terminal::getBestAutocompleteBox 1 1 20 20 2 '' false`

Returned variables:

```text
REPLY='1'
REPLY2='1'
REPLY3='10'
REPLY4='2'
```

❯ `terminal::getBestAutocompleteBox 1 1 5 5 '' '' false`

Returned variables:

```text
REPLY='1'
REPLY2='1'
REPLY3='5'
REPLY4='5'
```

❯ `terminal::getBestAutocompleteBox 5 5 6 9 '' '' false`

Returned variables:

```text
REPLY='5'
REPLY2='2'
REPLY3='9'
REPLY4='6'
```

❯ `terminal::getBestAutocompleteBox 7 7 10 4 '' '' false`

Returned variables:

```text
REPLY='1'
REPLY2='7'
REPLY3='4'
REPLY4='7'
```

❯ `terminal::getBestAutocompleteBox 7 7 4 4 '' '' false`

Returned variables:

```text
REPLY='7'
REPLY2='7'
REPLY3='4'
REPLY4='4'
```

❯ `terminal::getBestAutocompleteBox 7 7 10 10 '' true false`

Returned variables:

```text
REPLY='7'
REPLY2='1'
REPLY3='10'
REPLY4='4'
```

### ✅ Testing terminal::switchToFullScreen

❯ `terminal::switchBackFromFullScreen`

**Error output**:

```text
[2J[0m[?1049l
```

❯ `terminal::switchToFullScreen`

**Error output**:

```text
[?1049h[?25l[2J
```

❯ `terminal::switchBackFromFullScreen`

**Error output**:

```text
[2J[0m[?1049l
```

### ✅ Testing terminal::setRawMode

❯ `terminal::restoreSettings`

❯ `terminal::setRawMode`

stty called with `-icrnl -inlcr -ixon -ixoff nl0 cr0 tab0 ff0 -onlret -icanon -echo -echok -echonl -echoe -echoke -ctlecho -tostop erase ^B werase ^W min 1 time 0`

❯ `terminal::restoreSettings`

stty called with `original config`

### ✅ Testing terminal::rerouteLogs

❯ `terminal::restoreLogs`

**Error output**:

```text
INFO     Before rerouting Logs
```

❯ `terminal::rerouteLogs`

❯ `terminal::restoreLogs`

**Error output**:

```text
INFO     After rerouting Logs
```

