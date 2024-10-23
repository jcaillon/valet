# Test suite 1008-lib-autocompletion

## Test script 01.utilities

### Testing autocompletionComputeSize

Exit code: `0`

**Standard** output:

```plaintext
GLOBAL_LINES=10
GLOBAL_COLUMNS=10
autocompletionComputeSize '' '' 1 1 20 20
10 x 9 at 1:2
autocompletionComputeSize 2 '' 1 1 20 20
10 x 2 at 1:2

autocompletionComputeSize '' '' 1 1 5 5
10 x 5 at 1:2

autocompletionComputeSize '' '' 5 5 6 9
10 x 5 at 2:6

autocompletionComputeSize '' '' 7 7 10 4
10 x 6 at 7:1

autocompletionComputeSize '' true 7 7 10 10
10 x 3 at 1:8
```

### Testing autocompletionGetDisplayedPromptString

Exit code: `0`

**Standard** output:

```plaintext
AUTOCOMPLETION_PROMPT_WIDTH=5
AUTOCOMPLETION_USER_STRING= AUTOCOMPLETION_PROMPT_INDEX=0 autocompletionGetDisplayedPromptString
 ░░ 0
=░░ 0
AUTOCOMPLETION_USER_STRING=a AUTOCOMPLETION_PROMPT_INDEX=1 autocompletionGetDisplayedPromptString
 ░a░ 1
=░a░ 1
AUTOCOMPLETION_USER_STRING=ab AUTOCOMPLETION_PROMPT_INDEX=2 autocompletionGetDisplayedPromptString
 ░ab░ 2
=░ab░ 2
AUTOCOMPLETION_USER_STRING=abc AUTOCOMPLETION_PROMPT_INDEX=3 autocompletionGetDisplayedPromptString
 ░abc░ 3
=░abc░ 3
AUTOCOMPLETION_USER_STRING=abcd AUTOCOMPLETION_PROMPT_INDEX=4 autocompletionGetDisplayedPromptString
 ░abcd░ 4
=░abcd░ 4
AUTOCOMPLETION_USER_STRING=abcde AUTOCOMPLETION_PROMPT_INDEX=0 autocompletionGetDisplayedPromptString
 ░abcde░ 0
=░abcde░ 0
AUTOCOMPLETION_USER_STRING=abcdef AUTOCOMPLETION_PROMPT_INDEX=4 autocompletionGetDisplayedPromptString
 ░…cdef░ 3
=░…cdef░ 3
AUTOCOMPLETION_USER_STRING=abcdef AUTOCOMPLETION_PROMPT_INDEX=3 autocompletionGetDisplayedPromptString
 ░abcd…░ 3
=░abcd…░ 3
AUTOCOMPLETION_USER_STRING=abcdef AUTOCOMPLETION_PROMPT_INDEX=1 autocompletionGetDisplayedPromptString
 ░abcd…░ 1
=░abcd…░ 1
AUTOCOMPLETION_USER_STRING=abcde AUTOCOMPLETION_PROMPT_INDEX=5 autocompletionGetDisplayedPromptString
 ░…cde░ 4
=░…cde░ 4
AUTOCOMPLETION_USER_STRING=abcdef AUTOCOMPLETION_PROMPT_INDEX=6 autocompletionGetDisplayedPromptString
 ░…def░ 4
=░…def░ 4
AUTOCOMPLETION_USER_STRING=abcdef AUTOCOMPLETION_PROMPT_INDEX=5 autocompletionGetDisplayedPromptString
 ░…cdef░ 4
=░…cdef░ 4
AUTOCOMPLETION_USER_STRING=abcdef AUTOCOMPLETION_PROMPT_INDEX=4 autocompletionGetDisplayedPromptString
 ░…cdef░ 3
=░…cdef░ 3
AUTOCOMPLETION_USER_STRING=abcdef AUTOCOMPLETION_PROMPT_INDEX=3 autocompletionGetDisplayedPromptString
 ░abcd…░ 3
=░abcd…░ 3
AUTOCOMPLETION_USER_STRING=abcdefghij AUTOCOMPLETION_PROMPT_INDEX=6 autocompletionGetDisplayedPromptString
 ░…efg…░ 3
=░…efg…░ 3
AUTOCOMPLETION_USER_STRING=bl AUTOCOMPLETION_PROMPT_INDEX=0 autocompletionGetDisplayedPromptString
 ░bl░ 0
=░bl░ 0
```

