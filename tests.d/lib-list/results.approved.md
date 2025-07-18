# Test suite lib-list

## Test script 00.tests

### ✅ Testing list::getCurrentItemDisplayableString

```text
_LIST_STYLE_LETTER_HIGHLIGHT='>'
_LIST_STYLE_LETTER_HIGHLIGHT_RESET='<'
_LIST_ITEM_WIDTH='5'
_LIST_FILTER_STRING='eLor'
_LIST_CURRENT_ITEM='HellO wOrld'
```

❯ `list::getCurrentItemDisplayableString`

Returned variables:

```text
REPLY='0'
```

`H>e<>l<l…`

```text
_LIST_ITEM_WIDTH='15'
_LIST_CURRENT_ITEM='HellO wOrld'
```

❯ `list::getCurrentItemDisplayableString`

Returned variables:

```text
REPLY='4'
```

`H>e<>l<l>O< wO>r<ld`

```text
_LIST_ITEM_WIDTH='10'
_LIST_CURRENT_ITEM='[36mHellO[0m wOrld'
```

❯ `list::getCurrentItemDisplayableString`

Returned variables:

```text
REPLY='0'
```

`[36mH>e<>l<l>O<[0m wO>r<…`

```text
_LIST_ITEM_WIDTH='11'
_LIST_CURRENT_ITEM='[36mHellO[0m wOrld'
```

❯ `list::getCurrentItemDisplayableString`

Returned variables:

```text
REPLY='0'
```

`[36mH>e<>l<l>O<[0m wO>r<ld`

```text
_LIST_STYLE_LETTER_HIGHLIGHT='[4m'
_LIST_STYLE_LETTER_HIGHLIGHT_RESET='[24m'
_LIST_ITEM_WIDTH='71'
_LIST_FILTER_STRING='abomamwesspp'
_LIST_CURRENT_ITEM='[7m[35md[27m[39m[7m[35mi[27m[39msable the [93mmonitor mode to avoid[39m the "Terminated" message with exit code once the spinner is stopped'
```

❯ `list::getCurrentItemDisplayableString`

Returned variables:

```text
REPLY='0'
```

`[7m[35md[27m[39m[7m[35mi[27m[39ms[4ma[24m[4mb[24mle the [93mm[4mo[24mnitor [4mm[24mode to [4ma[24mvoid[39m the "Ter[4mm[24minated" message [4mw[24mith [4me[24mxit c…`

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

