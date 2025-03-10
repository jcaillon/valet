# Test suite lib-prompt

## Test script 00.tests

### ✅ Testing prompt_getIndexDeltaToEndOfWord

❯ `_PROMPT_STRING_INDEX=0 prompt_getIndexDeltaToEndOfWord`

Returned variables:

```text
RETURNED_VALUE='5'
```

❯ `_PROMPT_STRING_INDEX=4 prompt_getIndexDeltaToEndOfWord`

Returned variables:

```text
RETURNED_VALUE='1'
```

❯ `_PROMPT_STRING_INDEX=5 prompt_getIndexDeltaToEndOfWord`

Returned variables:

```text
RETURNED_VALUE='8'
```

❯ `_PROMPT_STRING_INDEX=8 prompt_getIndexDeltaToEndOfWord`

Returned variables:

```text
RETURNED_VALUE='5'
```

❯ `_PROMPT_STRING_INDEX=10 prompt_getIndexDeltaToEndOfWord`

Returned variables:

```text
RETURNED_VALUE='3'
```

❯ `_PROMPT_STRING_INDEX=11 prompt_getIndexDeltaToEndOfWord`

Returned variables:

```text
RETURNED_VALUE='2'
```

❯ `_PROMPT_STRING_INDEX=12 prompt_getIndexDeltaToEndOfWord`

Returned variables:

```text
RETURNED_VALUE='1'
```

❯ `_PROMPT_STRING_INDEX=20 prompt_getIndexDeltaToEndOfWord`

Returned variables:

```text
RETURNED_VALUE='-7'
```

### ✅ Testing prompt_getIndexDeltaToBeginningOfWord

❯ `_PROMPT_STRING_INDEX=0 prompt_getIndexDeltaToBeginningOfWord`

Returned variables:

```text
RETURNED_VALUE='0'
```

❯ `_PROMPT_STRING_INDEX=5 prompt_getIndexDeltaToBeginningOfWord`

Returned variables:

```text
RETURNED_VALUE='-5'
```

❯ `_PROMPT_STRING_INDEX=6 prompt_getIndexDeltaToBeginningOfWord`

Returned variables:

```text
RETURNED_VALUE='-6'
```

❯ `_PROMPT_STRING_INDEX=9 prompt_getIndexDeltaToBeginningOfWord`

Returned variables:

```text
RETURNED_VALUE='-3'
```

❯ `_PROMPT_STRING_INDEX=11 prompt_getIndexDeltaToBeginningOfWord`

Returned variables:

```text
RETURNED_VALUE='-5'
```

❯ `_PROMPT_STRING_INDEX=12 prompt_getIndexDeltaToBeginningOfWord`

Returned variables:

```text
RETURNED_VALUE='-6'
```

❯ `_PROMPT_STRING_INDEX=13 prompt_getIndexDeltaToBeginningOfWord`

Returned variables:

```text
RETURNED_VALUE='-7'
```

❯ `_PROMPT_STRING_INDEX=20 prompt_getIndexDeltaToBeginningOfWord`

Returned variables:

```text
RETURNED_VALUE='-1'
```

### ✅ Testing prompt_getDisplayedPromptString

```text
_PROMPT_STRING=''
_PROMPT_STRING_INDEX='0'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░░ 0`

```text
_PROMPT_STRING='a'
_PROMPT_STRING_INDEX='1'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░a░ 1`

```text
_PROMPT_STRING='ab'
_PROMPT_STRING_INDEX='2'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░ab░ 2`

```text
_PROMPT_STRING='abc'
_PROMPT_STRING_INDEX='3'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░abc░ 3`

```text
_PROMPT_STRING='abcd'
_PROMPT_STRING_INDEX='4'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░abcd░ 4`

```text
_PROMPT_STRING='abcde'
_PROMPT_STRING_INDEX='0'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░abcde░ 0`

```text
_PROMPT_STRING='abcdef'
_PROMPT_STRING_INDEX='4'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░…cdef░ 3`

```text
_PROMPT_STRING='abcdef'
_PROMPT_STRING_INDEX='3'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░abcd…░ 3`

```text
_PROMPT_STRING='abcdef'
_PROMPT_STRING_INDEX='1'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░abcd…░ 1`

```text
_PROMPT_STRING='abcde'
_PROMPT_STRING_INDEX='5'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░…cde░ 4`

```text
_PROMPT_STRING='abcdef'
_PROMPT_STRING_INDEX='6'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░…def░ 4`

```text
_PROMPT_STRING='abcdef'
_PROMPT_STRING_INDEX='5'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░…cdef░ 4`

```text
_PROMPT_STRING='abcdef'
_PROMPT_STRING_INDEX='4'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░…cdef░ 3`

```text
_PROMPT_STRING='abcdef'
_PROMPT_STRING_INDEX='3'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░abcd…░ 3`

```text
_PROMPT_STRING='abcdefghij'
_PROMPT_STRING_INDEX='6'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░…efg…░ 3`

```text
_PROMPT_STRING='abcdefghij'
_PROMPT_STRING_INDEX='3'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░abcd…░ 3`

```text
_PROMPT_STRING='abcdefghij'
_PROMPT_STRING_INDEX='4'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░…cde…░ 3`

```text
_PROMPT_STRING='abcdefghij'
_PROMPT_STRING_INDEX='5'
_PROMPT_STRING_SCREEN_WIDTH='5'
```

❯ `prompt_getDisplayedPromptString`

`░…def…░ 3`

```text
_PROMPT_STRING='This is a long string that will be displayed in the screen.'
_PROMPT_STRING_INDEX='20'
_PROMPT_STRING_SCREEN_WIDTH='10'
```

❯ `prompt_getDisplayedPromptString`

`░…g string…░ 8`

```text
_PROMPT_STRING='bl'
_PROMPT_STRING_INDEX='0'
_PROMPT_STRING_SCREEN_WIDTH='4'
```

❯ `prompt_getDisplayedPromptString`

`░bl░ 0`

### ✅ Testing prompt::getItemDisplayedString

```text
_PROMPT_COLOR_LETTER_HIGHLIGHT='>'
_PROMPT_COLOR_LETTER_HIGHLIGHT_RESET='<'
_PROMPT_ITEMS_BOX_ITEM_WIDTH='5'
_PROMPT_ITEMS_BOX_FILTER_STRING='eLor'
_PROMPT_ITEMS_BOX_ITEM_DISPLAYED='HellO wOrld'
```

❯ `prompt::getItemDisplayedString`

Returned variables:

```text
RETURNED_VALUE='0'
```

`Hell…`

```text
_PROMPT_ITEMS_BOX_ITEM_WIDTH='15'
_PROMPT_ITEMS_BOX_ITEM_DISPLAYED='HellO wOrld'
```

❯ `prompt::getItemDisplayedString`

Returned variables:

```text
RETURNED_VALUE='4'
```

`HellO wOrld`

```text
_PROMPT_ITEMS_BOX_ITEM_WIDTH='10'
_PROMPT_ITEMS_BOX_ITEM_DISPLAYED='[36mHellO[0m wOrld'
```

❯ `prompt::getItemDisplayedString`

Returned variables:

```text
RETURNED_VALUE='0'
```

`[36mHellO[0m wOr…`

```text
_PROMPT_ITEMS_BOX_ITEM_WIDTH='11'
_PROMPT_ITEMS_BOX_ITEM_DISPLAYED='[36mHellO[0m wOrld'
```

❯ `prompt::getItemDisplayedString`

Returned variables:

```text
RETURNED_VALUE='0'
```

`[36mHellO[0m wOrld`

```text
_PROMPT_COLOR_LETTER_HIGHLIGHT='[4m'
_PROMPT_COLOR_LETTER_HIGHLIGHT_RESET='[24m'
_PROMPT_ITEMS_BOX_ITEM_WIDTH='71'
_PROMPT_ITEMS_BOX_FILTER_STRING='abomamwesspp'
_PROMPT_ITEMS_BOX_ITEM_DISPLAYED='[7m[35md[27m[39m[7m[35mi[27m[39msable the [93mmonitor mode to avoid[39m the "Terminated" message with exit code once the spinner is stopped'
```

❯ `prompt::getItemDisplayedString`

Returned variables:

```text
RETURNED_VALUE='0'
```

`[7m[35md[27m[39m[7m[35mi[27m[39msable the [93mmonitor mode to avoid[39m the "Terminated" message with exit c…`

### ✅ Testing fuzzy filtering with external programs

❯ `SEARCH_STRING=ea array::fuzzyFilterSort _MY_ARRAY SEARCH_STRING`

❯ `fs::head /out1 10`

**Standard output**:

```text
ea1
eat
evades
beader
decancellated
medakas
well-ankled
rerummage
sense-data
rectiserial
```

### ✅ Testing prompt_fuzzyFilterSortFileWithGrepAndGawk

❯ `SEARCH_STRING=ea prompt_fuzzyFilterSortFileWithGrepAndGawk /words SEARCH_STRING /out1 /out2`

❯ `fs::head /out1 10`

> The result is the same as the pure bash implementation.

