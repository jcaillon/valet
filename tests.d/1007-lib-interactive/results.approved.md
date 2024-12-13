# Test suite 1007-lib-interactive

## Test script 00.tests

### test interactive::promptYesNo with yes

Exit code: `0`

**Standard** output:

```plaintext
echo y | interactive::promptYesNo 'Do you see this message?'
[2m   ┌─[24b─┐[0m
[2m░──┤[0m Do you see this message? [31G[2m│[0m
[2m   └─[24b─┘[0m
[?25l[7m   (Y)ES   [0m      (N)O   [0m[1G[0K[?25h[2m[9G┌─[4b─┐[0m
[2m[9G│[0m Yes. [16G[2m├──░[0m
[2m[9G└─[4b─┘[0m
```

### Testing interactive::promptYesNo

Exit code: `1`

**Standard** output:

```plaintext

echo n | interactive::promptYesNo 'Do you see this message?'
[2m   ┌─[24b─┐[0m
[2m░──┤[0m Do you see this message? [31G[2m│[0m
[2m   └─[24b─┘[0m
[?25l[7m   (Y)ES   [0m      (N)O   [0m[1G[0K[?25h[2m[9G┌─[3b─┐[0m
[2m[9G│[0m No. [15G[2m├──░[0m
[2m[9G└─[3b─┘[0m
```

### test interactive::askForConfirmation with yes

Exit code: `0`

**Standard** output:

```plaintext
echo y | interactive::askForConfirmation 'Please press OK.'
[2m   ┌─[16b─┐[0m
[2m░──┤[0m Please press OK. [23G[2m│[0m
[2m   └─[16b─┘[0m
[?25l[7m   (O)K   [0m[1G[0K[?25h
```

## Test script 01.utilities

### Testing interactive::createSpace

Exit code: `0`

**Standard** output:

```plaintext
interactive::createSpace 5
[?25l[1G[0J



[4F[?25h
```

### Testing interactive::getCursorPosition

Exit code: `0`

**Standard** output:

```plaintext
printf '\e[%sR' '123;456' | interactive::getCursorPosition
CURSOR_LINE: 123; CURSOR_COLUMN: 456
```

### Testing interactiveGetProgressBarString

Exit code: `0`

**Standard** output:

```plaintext
interactiveGetProgressBarString 0 20
⌜                    ⌝

interactiveGetProgressBarString 11 10
⌜█         ⌝

interactiveGetProgressBarString 15 10
⌜█▌        ⌝

interactiveGetProgressBarString 50 10
⌜█████▉    ⌝

interactiveGetProgressBarString 83 20
⌜████████████████▌   ⌝

interactiveGetProgressBarString 100 15
⌜███████████████⌝
```

### Testing interactive::getBestAutocompleteBox

Exit code: `0`

**Standard** output:

```plaintext
GLOBAL_LINES=10
GLOBAL_COLUMNS=10
interactive::getBestAutocompleteBox 1 1 20 20
at (top:left) 2:1, (width x height) 10 x 9
interactive::getBestAutocompleteBox 1 1 20 20 2
at (top:left) 2:1, (width x height) 10 x 2

interactive::getBestAutocompleteBox 1 1 5 5
at (top:left) 2:1, (width x height) 5 x 5

interactive::getBestAutocompleteBox 5 5 6 9
at (top:left) 6:2, (width x height) 9 x 5

interactive::getBestAutocompleteBox 7 7 10 4
at (top:left) 1:7, (width x height) 4 x 6

interactive::getBestAutocompleteBox 7 7 10 10 '' true
at (top:left) 8:1, (width x height) 10 x 3

interactive::getBestAutocompleteBox 1 1 10 10 999 true true 999 5
at (top:left) 2:1, (width x height) 10 x 4


interactive::getBestAutocompleteBox 1 1 20 20 '' '' false 10 10
at (top:left) 1:1, (width x height) 10 x 10

interactive::getBestAutocompleteBox 1 1 20 20 2 '' false
at (top:left) 1:1, (width x height) 10 x 2

interactive::getBestAutocompleteBox 1 1 5 5 '' '' false
at (top:left) 1:1, (width x height) 5 x 5

interactive::getBestAutocompleteBox 5 5 6 9 '' '' false
at (top:left) 5:2, (width x height) 9 x 6

interactive::getBestAutocompleteBox 7 7 10 4 '' '' false
at (top:left) 1:7, (width x height) 4 x 7

interactive::getBestAutocompleteBox 7 7 4 4 '' '' false
at (top:left) 7:7, (width x height) 4 x 4

interactive::getBestAutocompleteBox 7 7 10 10 '' true false
at (top:left) 7:1, (width x height) 10 x 4
```

### Testing interactive::showStringInScreen

Exit code: `0`

**Standard** output:

```plaintext
_PROMPT_STRING_WIDTH=5
interactive::showStringInScreen '' '0' '5'
 ░░ 0
interactive::showStringInScreen 'a' '1' '5'
 ░a░ 1
interactive::showStringInScreen 'ab' '2' '5'
 ░ab░ 2
interactive::showStringInScreen 'abc' '3' '5'
 ░abc░ 3
interactive::showStringInScreen 'abcd' '4' '5'
 ░abcd░ 4
interactive::showStringInScreen 'abcde' '0' '5'
 ░abcde░ 0
interactive::showStringInScreen 'abcdef' '4' '5'
 ░…cdef░ 3
interactive::showStringInScreen 'abcdef' '3' '5'
 ░abcd…░ 3
interactive::showStringInScreen 'abcdef' '1' '5'
 ░abcd…░ 1
interactive::showStringInScreen 'abcde' '5' '5'
 ░…cde░ 4
interactive::showStringInScreen 'abcdef' '6' '5'
 ░…def░ 4
interactive::showStringInScreen 'abcdef' '5' '5'
 ░…cdef░ 4
interactive::showStringInScreen 'abcdef' '4' '5'
 ░…cdef░ 3
interactive::showStringInScreen 'abcdef' '3' '5'
 ░abcd…░ 3
interactive::showStringInScreen 'abcdefghij' '6' '5'
 ░…efg…░ 3
interactive::showStringInScreen 'abcdefghij' '3' '5'
 ░abcd…░ 3
interactive::showStringInScreen 'abcdefghij' '4' '5'
 ░…cde…░ 3
interactive::showStringInScreen 'abcdefghij' '5' '5'
 ░…def…░ 3
interactive::showStringInScreen 'This is a long string that will be displayed in the screen.' '20' '10'
 ░…g string…░ 8
_PROMPT_STRING_WIDTH=4
interactive::showStringInScreen 'bl' '0' '4'
 ░bl░ 0
```

