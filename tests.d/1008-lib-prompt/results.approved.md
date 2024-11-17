# Test suite 1008-lib-prompt

## Test script 01.utilities

### Testing prompt_getAutocompletionBoxSize

Exit code: `0`

**Standard** output:

```plaintext
GLOBAL_LINES=10
GLOBAL_COLUMNS=10
prompt_getAutocompletionBoxSize '' '' 1 1 20 20
10 x 9 at 1:2
prompt_getAutocompletionBoxSize 2 '' 1 1 20 20
10 x 2 at 1:2

prompt_getAutocompletionBoxSize '' '' 1 1 5 5
5 x 5 at 1:2

prompt_getAutocompletionBoxSize '' '' 5 5 6 9
9 x 5 at 2:6

prompt_getAutocompletionBoxSize '' '' 7 7 10 4
4 x 6 at 7:1

prompt_getAutocompletionBoxSize '' true 7 7 10 10
10 x 3 at 1:8


prompt_getAutocompletionBoxSize '' '' 1 1 20 20 false
10 x 10 at 1:1

prompt_getAutocompletionBoxSize 2 '' 1 1 20 20 false
10 x 2 at 1:1

prompt_getAutocompletionBoxSize '' '' 1 1 5 5 false
5 x 5 at 1:1

prompt_getAutocompletionBoxSize '' '' 5 5 6 9 false
9 x 6 at 2:5

prompt_getAutocompletionBoxSize '' '' 7 7 10 4 false
4 x 7 at 7:1

prompt_getAutocompletionBoxSize '' '' 7 7 4 4 false
4 x 4 at 7:7

prompt_getAutocompletionBoxSize '' true 7 7 10 10 false
10 x 4 at 1:7
```

### Testing prompt_getDisplayedPromptString

Exit code: `0`

**Standard** output:

```plaintext
_PROMPT_STRING_WIDTH=5
_PROMPT_STRING= _PROMPT_STRING_INDEX=0 prompt_getDisplayedPromptString
 ░░ 0
=░░ 0
_PROMPT_STRING=a _PROMPT_STRING_INDEX=1 prompt_getDisplayedPromptString
 ░a░ 1
=░a░ 1
_PROMPT_STRING=ab _PROMPT_STRING_INDEX=2 prompt_getDisplayedPromptString
 ░ab░ 2
=░ab░ 2
_PROMPT_STRING=abc _PROMPT_STRING_INDEX=3 prompt_getDisplayedPromptString
 ░abc░ 3
=░abc░ 3
_PROMPT_STRING=abcd _PROMPT_STRING_INDEX=4 prompt_getDisplayedPromptString
 ░abcd░ 4
=░abcd░ 4
_PROMPT_STRING=abcde _PROMPT_STRING_INDEX=0 prompt_getDisplayedPromptString
 ░abcde░ 0
=░abcde░ 0
_PROMPT_STRING=abcdef _PROMPT_STRING_INDEX=4 prompt_getDisplayedPromptString
 ░…cdef░ 3
=░…cdef░ 3
_PROMPT_STRING=abcdef _PROMPT_STRING_INDEX=3 prompt_getDisplayedPromptString
 ░abcd…░ 3
=░abcd…░ 3
_PROMPT_STRING=abcdef _PROMPT_STRING_INDEX=1 prompt_getDisplayedPromptString
 ░abcd…░ 1
=░abcd…░ 1
_PROMPT_STRING=abcde _PROMPT_STRING_INDEX=5 prompt_getDisplayedPromptString
 ░…cde░ 4
=░…cde░ 4
_PROMPT_STRING=abcdef _PROMPT_STRING_INDEX=6 prompt_getDisplayedPromptString
 ░…def░ 4
=░…def░ 4
_PROMPT_STRING=abcdef _PROMPT_STRING_INDEX=5 prompt_getDisplayedPromptString
 ░…cdef░ 4
=░…cdef░ 4
_PROMPT_STRING=abcdef _PROMPT_STRING_INDEX=4 prompt_getDisplayedPromptString
 ░…cdef░ 3
=░…cdef░ 3
_PROMPT_STRING=abcdef _PROMPT_STRING_INDEX=3 prompt_getDisplayedPromptString
 ░abcd…░ 3
=░abcd…░ 3
_PROMPT_STRING=abcdefghij _PROMPT_STRING_INDEX=6 prompt_getDisplayedPromptString
 ░…efg…░ 3
=░…efg…░ 3
_PROMPT_STRING=abcdefghij _PROMPT_STRING_INDEX=3 prompt_getDisplayedPromptString
 ░abcd…░ 3
=░abcd…░ 3
_PROMPT_STRING=abcdefghij _PROMPT_STRING_INDEX=4 prompt_getDisplayedPromptString
 ░…cde…░ 3
=░…cde…░ 3
_PROMPT_STRING=abcdefghij _PROMPT_STRING_INDEX=5 prompt_getDisplayedPromptString
 ░…def…░ 3
=░…def…░ 3
_PROMPT_STRING_WIDTH=4
_PROMPT_STRING=bl _PROMPT_STRING_INDEX=0 prompt_getDisplayedPromptString
 ░bl░ 0
=░bl░ 0
```

