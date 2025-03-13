# Test suite lib-list

## Test script 00.tests

### ✅ Testing list::getItemDisplayedString

```text
_PROMPT_COLOR_LETTER_HIGHLIGHT='>'
_PROMPT_COLOR_LETTER_HIGHLIGHT_RESET='<'
_PROMPT_ITEMS_BOX_ITEM_WIDTH='5'
_PROMPT_ITEMS_BOX_FILTER_STRING='eLor'
_PROMPT_ITEMS_BOX_ITEM_DISPLAYED='HellO wOrld'
```

❯ `list::getItemDisplayedString`

Returned variables:

```text
RETURNED_VALUE='0'
```

`Hell…`

```text
_PROMPT_ITEMS_BOX_ITEM_WIDTH='15'
_PROMPT_ITEMS_BOX_ITEM_DISPLAYED='HellO wOrld'
```

❯ `list::getItemDisplayedString`

Returned variables:

```text
RETURNED_VALUE='4'
```

`HellO wOrld`

```text
_PROMPT_ITEMS_BOX_ITEM_WIDTH='10'
_PROMPT_ITEMS_BOX_ITEM_DISPLAYED='[36mHellO[0m wOrld'
```

❯ `list::getItemDisplayedString`

Returned variables:

```text
RETURNED_VALUE='0'
```

`[36mHellO[0m wOr…`

```text
_PROMPT_ITEMS_BOX_ITEM_WIDTH='11'
_PROMPT_ITEMS_BOX_ITEM_DISPLAYED='[36mHellO[0m wOrld'
```

❯ `list::getItemDisplayedString`

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

❯ `list::getItemDisplayedString`

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

### ✅ Testing list_fuzzyFilterSortFileWithGrepAndGawk

❯ `SEARCH_STRING=ea list_fuzzyFilterSortFileWithGrepAndGawk /words SEARCH_STRING /out1 /out2`

❯ `fs::head /out1 10`

> The result is the same as the pure bash implementation.

