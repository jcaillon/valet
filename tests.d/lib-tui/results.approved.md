# Test suite lib-tui

## Test script 00.tui

### ✅ Testing tui::createSpace

❯ `tui::createSpace 5`

**Error output**:

```text
[?25l[1G[0J[4S[4F
```

### ✅ Testing tui::getCursorPosition

❯ `printf '\e[%sR' '123;456' | tui::getCursorPosition`

```text
GLOBAL_CURSOR_LINE='123'
GLOBAL_CURSOR_COLUMN='456'
```

### ✅ Testing tui::clearBox

```text
GLOBAL_CURSOR_LINE='42'
GLOBAL_CURSOR_COLUMN='42'
```

❯ `tui::clearBox 1 1 10 10`

**Error output**:

```text
[?25l[1;1H[10X[2;1H[10X[3;1H[10X[4;1H[10X[5;1H[10X[6;1H[10X[7;1H[10X[8;1H[10X[9;1H[10X[10;1H[10X[42;42H
```

❯ `tui::clearBox 10 10 5 5`

**Error output**:

```text
[?25l[10;10H[5X[11;10H[5X[12;10H[5X[13;10H[5X[14;10H[5X[42;42H
```

### ✅ Testing tui::getBestAutocompleteBox

```text
GLOBAL_LINES='10'
GLOBAL_COLUMNS='10'
```

❯ `tui::getBestAutocompleteBox 1 1 20 20`

Returned variables:

```text
RETURNED_VALUE='2'
RETURNED_VALUE2='1'
RETURNED_VALUE3='10'
RETURNED_VALUE4='9'
```

❯ `tui::getBestAutocompleteBox 1 1 20 20 2`

Returned variables:

```text
RETURNED_VALUE='2'
RETURNED_VALUE2='1'
RETURNED_VALUE3='10'
RETURNED_VALUE4='2'
```

❯ `tui::getBestAutocompleteBox 1 1 5 5`

Returned variables:

```text
RETURNED_VALUE='2'
RETURNED_VALUE2='1'
RETURNED_VALUE3='5'
RETURNED_VALUE4='5'
```

❯ `tui::getBestAutocompleteBox 5 5 6 9`

Returned variables:

```text
RETURNED_VALUE='6'
RETURNED_VALUE2='2'
RETURNED_VALUE3='9'
RETURNED_VALUE4='5'
```

❯ `tui::getBestAutocompleteBox 7 7 10 4`

Returned variables:

```text
RETURNED_VALUE='1'
RETURNED_VALUE2='7'
RETURNED_VALUE3='4'
RETURNED_VALUE4='6'
```

❯ `tui::getBestAutocompleteBox 7 7 10 10 '' true`

Returned variables:

```text
RETURNED_VALUE='8'
RETURNED_VALUE2='1'
RETURNED_VALUE3='10'
RETURNED_VALUE4='3'
```

❯ `tui::getBestAutocompleteBox 1 1 10 10 999 true true 999 5`

Returned variables:

```text
RETURNED_VALUE='2'
RETURNED_VALUE2='1'
RETURNED_VALUE3='10'
RETURNED_VALUE4='4'
```

❯ `tui::getBestAutocompleteBox 1 1 20 20 '' '' false`

Returned variables:

```text
RETURNED_VALUE='1'
RETURNED_VALUE2='1'
RETURNED_VALUE3='10'
RETURNED_VALUE4='10'
```

❯ `tui::getBestAutocompleteBox 1 1 20 20 2 '' false`

Returned variables:

```text
RETURNED_VALUE='1'
RETURNED_VALUE2='1'
RETURNED_VALUE3='10'
RETURNED_VALUE4='2'
```

❯ `tui::getBestAutocompleteBox 1 1 5 5 '' '' false`

Returned variables:

```text
RETURNED_VALUE='1'
RETURNED_VALUE2='1'
RETURNED_VALUE3='5'
RETURNED_VALUE4='5'
```

❯ `tui::getBestAutocompleteBox 5 5 6 9 '' '' false`

Returned variables:

```text
RETURNED_VALUE='5'
RETURNED_VALUE2='2'
RETURNED_VALUE3='9'
RETURNED_VALUE4='6'
```

❯ `tui::getBestAutocompleteBox 7 7 10 4 '' '' false`

Returned variables:

```text
RETURNED_VALUE='1'
RETURNED_VALUE2='7'
RETURNED_VALUE3='4'
RETURNED_VALUE4='7'
```

❯ `tui::getBestAutocompleteBox 7 7 4 4 '' '' false`

Returned variables:

```text
RETURNED_VALUE='7'
RETURNED_VALUE2='7'
RETURNED_VALUE3='4'
RETURNED_VALUE4='4'
```

❯ `tui::getBestAutocompleteBox 7 7 10 10 '' true false`

Returned variables:

```text
RETURNED_VALUE='7'
RETURNED_VALUE2='1'
RETURNED_VALUE3='10'
RETURNED_VALUE4='4'
```

