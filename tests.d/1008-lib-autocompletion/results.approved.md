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
AUTOCOMPLETION_USER_STRING= AUTOCOMPLETION_PROMPT_CURSOR_INDEX=0 autocompletionGetDisplayedPromptString
 ░░ 0
=░_░
AUTOCOMPLETION_USER_STRING=a AUTOCOMPLETION_PROMPT_CURSOR_INDEX=1 autocompletionGetDisplayedPromptString
 ░a░ 1
=░a_░
AUTOCOMPLETION_USER_STRING=ab AUTOCOMPLETION_PROMPT_CURSOR_INDEX=2 autocompletionGetDisplayedPromptString
 ░ab░ 2
=░ab_░
AUTOCOMPLETION_USER_STRING=abc AUTOCOMPLETION_PROMPT_CURSOR_INDEX=3 autocompletionGetDisplayedPromptString
 ░abc░ 3
=░abc_░
AUTOCOMPLETION_USER_STRING=abcd AUTOCOMPLETION_PROMPT_CURSOR_INDEX=4 autocompletionGetDisplayedPromptString
 ░abcd░ 4
=░abcd_░
```

