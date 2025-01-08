# Test suite 1008-lib-prompt

## Test script 00.tests

### Testing prompt_getDisplayedPromptString

Exit code: `0`

**Standard** output:

```plaintext

declare -- _PROMPT_STRING=""
declare -- _PROMPT_STRING_INDEX="0"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░░ 0

declare -- _PROMPT_STRING="a"
declare -- _PROMPT_STRING_INDEX="1"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░a░ 1

declare -- _PROMPT_STRING="ab"
declare -- _PROMPT_STRING_INDEX="2"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░ab░ 2

declare -- _PROMPT_STRING="abc"
declare -- _PROMPT_STRING_INDEX="3"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░abc░ 3

declare -- _PROMPT_STRING="abcd"
declare -- _PROMPT_STRING_INDEX="4"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░abcd░ 4

declare -- _PROMPT_STRING="abcde"
declare -- _PROMPT_STRING_INDEX="0"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░abcde░ 0

declare -- _PROMPT_STRING="abcdef"
declare -- _PROMPT_STRING_INDEX="4"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░…cdef░ 3

declare -- _PROMPT_STRING="abcdef"
declare -- _PROMPT_STRING_INDEX="3"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░abcd…░ 3

declare -- _PROMPT_STRING="abcdef"
declare -- _PROMPT_STRING_INDEX="1"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░abcd…░ 1

declare -- _PROMPT_STRING="abcde"
declare -- _PROMPT_STRING_INDEX="5"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░…cde░ 4

declare -- _PROMPT_STRING="abcdef"
declare -- _PROMPT_STRING_INDEX="6"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░…def░ 4

declare -- _PROMPT_STRING="abcdef"
declare -- _PROMPT_STRING_INDEX="5"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░…cdef░ 4

declare -- _PROMPT_STRING="abcdef"
declare -- _PROMPT_STRING_INDEX="4"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░…cdef░ 3

declare -- _PROMPT_STRING="abcdef"
declare -- _PROMPT_STRING_INDEX="3"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░abcd…░ 3

declare -- _PROMPT_STRING="abcdefghij"
declare -- _PROMPT_STRING_INDEX="6"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░…efg…░ 3

declare -- _PROMPT_STRING="abcdefghij"
declare -- _PROMPT_STRING_INDEX="3"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░abcd…░ 3

declare -- _PROMPT_STRING="abcdefghij"
declare -- _PROMPT_STRING_INDEX="4"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░…cde…░ 3

declare -- _PROMPT_STRING="abcdefghij"
declare -- _PROMPT_STRING_INDEX="5"
declare -- _PROMPT_STRING_SCREEN_WIDTH="5"
→ prompt_getDisplayedPromptString
 ░…def…░ 3

declare -- _PROMPT_STRING="This is a long string that will be displayed in the screen."
declare -- _PROMPT_STRING_INDEX="20"
declare -- _PROMPT_STRING_SCREEN_WIDTH="10"
→ prompt_getDisplayedPromptString
 ░…g string…░ 8

declare -- _PROMPT_STRING="bl"
declare -- _PROMPT_STRING_INDEX="0"
declare -- _PROMPT_STRING_SCREEN_WIDTH="4"
→ prompt_getDisplayedPromptString
 ░bl░ 0
```

### Testing prompt::getItemDisplayedString

Exit code: `0`

**Standard** output:

```plaintext
declare -- _PROMPT_ITEMS_BOX_ITEM_DISPLAYED="HellO wOrld"
declare -- _PROMPT_ITEMS_BOX_ITEM_WIDTH="5"
declare -- _PROMPT_ITEMS_BOX_FILTER_STRING="eLor"
→ prompt::getItemDisplayedString
H>e<>l<l…

_PROMPT_ITEMS_BOX_ITEM_DISPLAYED=$'\E[36mHellO\E[0m wOrld'
declare -- _PROMPT_ITEMS_BOX_ITEM_WIDTH="10"
declare -- _PROMPT_ITEMS_BOX_FILTER_STRING="eLor"
→ prompt::getItemDisplayedString
[36mH>e<>l<l>O<[0m wO>r<…

_PROMPT_ITEMS_BOX_ITEM_DISPLAYED=$'\E[36mHellO\E[0m wOrld'
declare -- _PROMPT_ITEMS_BOX_ITEM_WIDTH="11"
declare -- _PROMPT_ITEMS_BOX_FILTER_STRING="eLor"
→ prompt::getItemDisplayedString
[36mH>e<>l<l>O<[0m wO>r<ld

_PROMPT_ITEMS_BOX_ITEM_DISPLAYED=$'\E[7m\E[35md\E[27m\E[39m\E[7m\E[35mi\E[27m\E[39msable the \E[93mmonitor mode to avoid\E[39m the "Terminated" message with exit code once the spinner is stopped'
declare -- _PROMPT_ITEMS_BOX_ITEM_WIDTH="71"
declare -- _PROMPT_ITEMS_BOX_FILTER_STRING="abomamwesspp"
→ prompt::getItemDisplayedString
[7m[35md[27m[39m[7m[35mi[27m[39ms[4ma[24m[4mb[24mle the [93mm[4mo[24mnitor [4mm[24mode to [4ma[24mvoid[39m the "Ter[4mm[24minated" message [4mw[24mith [4me[24mxit c…
```

