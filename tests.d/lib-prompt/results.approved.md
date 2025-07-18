# Test suite lib-prompt

## Test script 00.tests

### ✅ Testing prompt_getIndexDeltaToEndOfWord

❯ `_PROMPT_STRING_INDEX=0 prompt_getIndexDeltaToEndOfWord`

Returned variables:

```text
REPLY='5'
```

❯ `_PROMPT_STRING_INDEX=4 prompt_getIndexDeltaToEndOfWord`

Returned variables:

```text
REPLY='1'
```

❯ `_PROMPT_STRING_INDEX=5 prompt_getIndexDeltaToEndOfWord`

Returned variables:

```text
REPLY='8'
```

❯ `_PROMPT_STRING_INDEX=8 prompt_getIndexDeltaToEndOfWord`

Returned variables:

```text
REPLY='5'
```

❯ `_PROMPT_STRING_INDEX=10 prompt_getIndexDeltaToEndOfWord`

Returned variables:

```text
REPLY='3'
```

❯ `_PROMPT_STRING_INDEX=11 prompt_getIndexDeltaToEndOfWord`

Returned variables:

```text
REPLY='2'
```

❯ `_PROMPT_STRING_INDEX=12 prompt_getIndexDeltaToEndOfWord`

Returned variables:

```text
REPLY='1'
```

❯ `_PROMPT_STRING_INDEX=20 prompt_getIndexDeltaToEndOfWord`

Returned variables:

```text
REPLY='-7'
```

### ✅ Testing prompt_getIndexDeltaToBeginningOfWord

❯ `_PROMPT_STRING_INDEX=0 prompt_getIndexDeltaToBeginningOfWord`

Returned variables:

```text
REPLY='0'
```

❯ `_PROMPT_STRING_INDEX=5 prompt_getIndexDeltaToBeginningOfWord`

Returned variables:

```text
REPLY='-5'
```

❯ `_PROMPT_STRING_INDEX=6 prompt_getIndexDeltaToBeginningOfWord`

Returned variables:

```text
REPLY='-6'
```

❯ `_PROMPT_STRING_INDEX=9 prompt_getIndexDeltaToBeginningOfWord`

Returned variables:

```text
REPLY='-3'
```

❯ `_PROMPT_STRING_INDEX=11 prompt_getIndexDeltaToBeginningOfWord`

Returned variables:

```text
REPLY='-5'
```

❯ `_PROMPT_STRING_INDEX=12 prompt_getIndexDeltaToBeginningOfWord`

Returned variables:

```text
REPLY='-6'
```

❯ `_PROMPT_STRING_INDEX=13 prompt_getIndexDeltaToBeginningOfWord`

Returned variables:

```text
REPLY='-7'
```

❯ `_PROMPT_STRING_INDEX=20 prompt_getIndexDeltaToBeginningOfWord`

Returned variables:

```text
REPLY='-1'
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

