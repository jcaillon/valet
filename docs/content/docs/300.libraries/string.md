---
title: 📂 string
cascade:
  type: docs
url: /docs/libraries/string
---

## ⚡ string::count

Counts the number of occurrences of a substring in a string.

Inputs:

- `$1`: **string variable name** _as string_:

  The variable name that contains the string in which to count occurrences.

- `$2`: **substring** _as string_:

  the substring to count

Returns:

- `${REPLY}`: the number of occurrences

Example usage:

```bash
MY_STRING="name,first_name,address"
string::count MY_STRING ","
echo "${REPLY}"
```

> This is faster than looping over the string and check the substring.

## ⚡ string::doForEachLine

Execute a callback function for each item (e.g. line) of a string.
The string is split using a separator (default to a new line) and
the callback function is called for each item.

Inputs:

- `$1`: **string variable name** _as string_:

  The name of the variable containing the string.

- `$2`: **callback function** _as string_:

  The name of the function to execute for each item (line).
  The function is called with the following arguments:

  - $1: the current item (line) content

  The function must return 0 if we should continue to the next line, 1 otherwise.

  (defaults to "")

- `${separator}` _as string_:

  (optional) The separator character to use.

  (defaults to $'\n')

Example usage:

```bash
string::doForEachLine myString myCallback
```

> This function provides a convenient way to avoid using a "here string" and handles extra
> newlines (which is not the case with a "for loop" using parameter expansion and IFS=$'\n').
> Here string is significantly slower than using this.

## ⚡ string::extractBetween

Extract the text between two strings within a string.
Search for the first occurrence of the start string and the first occurrence
(after the start index) of the end string.
Both start and end strings are excluded in the extracted text.
Both start and end strings must be found to extract something.

Inputs:

- `$1`: **string variable name** _as string_:

  The variable name that contains the string from which to extract a text.

- `$2`: **start string** _as string_:

  the start string
  (if empty, then it will extract from the beginning of the string)

- `$3`: **end string** _as string_:

  the end string
  (if empty, then it will extract until the end of the string)

Returns:

- `${REPLY}`: the extracted text

Example usage:

```bash
MY_STRING="This is a long text"
string::extractBetween MY_STRING "is a " " text"
local extractedText="${REPLY}"
```

## ⚡ string::getCamelCase

This function convert a SNAKE_CASE or kebab-case string to a camelCase string.

Inputs:

- `$1`: **string variable name** _as string_:

  The variable name that contains the string to convert.

Returns:

- `${REPLY}`: The converted string

Example usage:

```bash
MY_STRING="my-kebab-case"
string::getCamelCase MY_STRING
echo "${REPLY}"
```

## ⚡ string::getField

Allows to get the nth element of a string separated by a given separator.
This is the equivalent of the cut command "cut -d"${separator}" -f"${fieldNumber}""
but it uses pure bash to go faster.

Inputs:

- `$1`: **string variable name** _as string_:

  The variable name that contains the string to extract from.

- `$2`: **field number** _as int_:

  The field number to get (starting at 0).

- `${separator}` _as string_:

  The separator to use.

  (defaults to $'\t')

Returns:

- `${REPLY}`: the extracted field

Example usage:

```bash
MY_STRING="field1 field2 field3"
string::getField MY_STRING 1 separator=" "
echo "${REPLY}"
```

> This is faster than:
>
> - using read into an array from a here string
> - using bash parameter expansion to remove before/after the separator

## ⚡ string::getFormattedHeader

Get a formatted header string with a given width.
The header is composed of a left/middle/right part(s).
The header is padded with a given character to fit the given width.
The parts are trimmed if too long but they are prioritized in this order: middle, left, right
(middle will take all the space necessary, then left, then right).

Inputs:

- `$1`: **format** _as string_:

  The format of the header.
  It must include two | characters to separate the left, middle and right parts.
  Any part can be empty.
  Example: "left|middle|right"

- `${width}` _as int_:

  The total width of the header.

  (defaults to "GLOBAL_COLUMNS")

- `${paddingChar}` _as string_:

  (optional) The character to use for padding.

  (defaults to " ")

- `${paddingStyle}` _as string_:

  (optional) The style (ANSI escape codes) to apply the padding characters.

  (defaults to "")

- `${paddingStyleReset}` _as string_:

  (optional) The style (ANSI escape codes) to apply at the end of the padding characters.

  (defaults to "")

- `${partWidths}` _as string_:

  (optional) The actual widths of each part separated by |.
  If not provided, the actual width of each part will be computed automatically,
  not taking into account invisible characters (like ANSI escape codes).
  Example: "10|20|10"

  (defaults to "")

- `${noEllipsis}` _as bool_:

  (optional) If set to true, no ellipsis will be added when a part is trimmed.

  (defaults to false)

Returns:

- `${REPLY}`: the formatted header string
- `${REPLY2}`: the actual widths of each part separated by | (same format as partWidths argument)
- `${REPLY_ARRAY}`: the actual widths of each part

Example usage:

```bash
string::getFormattedHeader "Left|Middle|Right" width=50 paddingChar="-" paddingStyle=$'\e[1;34m' paddingStyleReset=$'\e[0m'
echo "${REPLY}"
```

## ⚡ string::getHexRepresentation

Convert a string to its hexadecimal representation.

Inputs:

- `$1`: **string variable name** _as string_:

  The variable name that contains the string to convert.

Returns:

- `${REPLY}`: the hexadecimal representation of the string

Example usage:

```bash
MY_STRING="This is a string"
string::getHexRepresentation MY_STRING
echo "${REPLY}"
```

## ⚡ string::getIndexOf

Find the first index of a string within another string.

Inputs:

- `$1`: **string variable name** _as string_:

  The variable name that contains the string from which to find an index.

- `$2`: **search** _as string_:

  the string to search

- `${startingIndex}` _as int_:

  (optional) the starting index

  (defaults to 0)

Returns:

- `${REPLY}`: the index of the substring in the string or -1 if not found.

Example usage:

```bash
MY_STRING="This is a long text"
string::getIndexOf MY_STRING "long" startingIndex=2
string::getIndexOf MY_STRING "long"
echo "${REPLY}"
```

## ⚡ string::getKebabCase

This function convert a camelCase, PascalCase or SNAKE_CASE string to a kebab-case string.
Removes all leading/trailing dashes.

Inputs:

- `$1`: **string variable name** _as string_:

  The variable name that contains the string to convert.

Returns:

- `${REPLY}`: The converted string

Example usage:

```bash
MY_STRING="myCamelCaseString"
string::getKebabCase MY_STRING
echo "${REPLY}"
```

## ⚡ string::getSnakeCase

This function convert a camelCase, PascalCase or kebab-case string to a SNAKE_CASE string.
Removes all leading/trailing underscores.

Inputs:

- `$1`: **string variable name** _as string_:

  The variable name that contains the string to convert.

Returns:

- `${REPLY}`: The converted string

Example usage:

```bash
MY_STRING="myCamelCaseString"
string::getSnakeCase MY_STRING
echo "${REPLY}"
```

## ⚡ string::head

Get the first nth items (e.g. lines) of a string.

Inputs:

- `$1`: **string variable name** _as string_:

  The variable name that contains the string from which to get the first occurrences.

- `$2`: **nb items** _as int_:

  The number of items (lines) to extract.

- `${separator}` _as string_:

  (optional) The separator character to use.

  (defaults to $'\n')

Returns:

- `${REPLY}`: The extracted string.

Example usage:

```bash
MY_STRING="line1"$'\n'"line2"$'\n'"line3"
string::head MY_STRING 2
echo "${REPLY}"
```

## ⚡ string::highlight

Highlight characters in a string.

Inputs:

- `$1`: **text variable name** _as string_:

  The variable name that contains the text to highlight.

- `$2`: **characters variable name** _as string_:

  The variable name that contains characters to highlight.

- `${highlightCode}` _as string_:

  (optional) The ANSI code to use for highlighting.
  The default value can be set using the variable STYLE_COLOR_ACCENT.

  (defaults to $'\e'"[95m"}")

- `${resetCode}` _as string_:

  (optional) The ANSI code to use for resetting the highlighting.
  The default value can be set using the variable STYLE_COLOR_DEFAULT.

  (defaults to $'\e'"[0m")

Returns:

- `${REPLY}`: the highlighted text

Example usage:

```bash
string::highlight "This is a text to highlight." "ttttt"
echo "${REPLY}"
```

> - All characters to highlight must be found in the same order in the matched line.
> - This functions is case insensitive.

## ⚡ string::numberToUniqueId

Converts a number into a unique and human readable string of the same length.

Inputs:

- `$1`: **number** _as int_:

  The number to convert.

Returns:

- `${REPLY}`: the unique string.

Example usage:

```bash
string::numberToUniqueId 12345
echo "${REPLY}"
```

## ⚡ string::removeTextFormatting

Removes all text formatting from the given string.
This includes colors, bold, underline, etc.

Inputs:

- `$1`: **text variable name** _as string_:

  The variable name that contains the text to remove formatting from.

Example usage:

```bash
string::removeTextFormatting "myText"
echo "${myText}"
```

## ⚡ string::split

Split a string into an array using a separator.

Inputs:

- `$1`: **string variable name** _as string_:

  The variable name that contains the string to split.

- `$2`: **separators** _as string_:

  The separator characters to use.

Returns:

- `${REPLY_ARRAY[@]}`: the array of strings

Example usage:

```bash
MY_STRING="name,first_name,address"
string::split MY_STRING ","
ARRAY=("${REPLY_ARRAY[@]}")
```

> This is faster than using read into an array from a here string.

## ⚡ string::trimAll

Trim all whitespaces and truncate spaces.
The replacement is done in place, for the given variable.

Inputs:

- `$1`: **string variable name** _as string_:

  The variable name that contains the string to trim.

Example usage:

```bash
MY_STRING="   example "$'\t'"  string    "$'\n'
string::trimAll MY_STRING
echo "${MY_STRING}"
```

## ⚡ string::trimEdges

Trim leading and trailing characters (defaults to whitespaces).
The replacement is done in place, for the given variable.

Inputs:

- `$1`: **string variable name** _as string_:

  The variable name that contains the string to trim.

- `${charsToTrim}` _as string_:

  The characters to trim.

  (defaults to $' \t\n')

Example usage:

```bash
MY_STRING="   example  string    "
string::trimEdges MY_STRING
echo "${MY_STRING}"
```

## ⚡ string::truncateWithEllipsis

Truncate a string to a given length and add an ellipsis if truncated.
This function takes into account invisible characters (ANSI escape codes for text formatting).
The truncation is done in place, for the given variable.

Inputs:

- `$1`: **string variable name** _as string_:

  The variable name that contains the string to truncate.

- `${maxLength}` _as int_:

  The maximum length of the string.

  (defaults to "GLOBAL_COLUMNS")

- `${noEllipsis}` _as bool_:

  (optional) If set to true, no ellipsis will be added when the string is truncated.

  (defaults to false)

Returns:
- `${REPLY}`: the space left after truncation

Example usage:

```bash
MY_STRING="This is a long string that might need to be truncated"
string::truncateWithEllipsis MY_STRING maxLength=20
echo "${REPLY}"
```

## ⚡ string::wrapCharacters

Allows to hard wrap the given string at the given width.
Wrapping is done at character boundaries, see string::warpText for word wrapping.
Optionally appends padding characters on each new line.

Inputs:

- `$1`: **text variable name** _as string_:

  The variable name that contains the text to wrap.

- `${width}` _as string_:

  (optional) The width to wrap the text at.
  Note that length of the new line pad string is subtracted from the
  width to make sure the text fits in the given width.

  (defaults to "${GLOBAL_COLUMNS}")

- `${newLinePadString}` _as string_:

  (optional) The characters to apply as padding on the left of each new line.
  E.g. '  ' will add 2 spaces on the left of each new line.

  (defaults to 0)

- `${firstLineWidth}` _as int_:

  (optional) The width to use for the first line.

  (defaults to "${width}")

Returns:

- `${REPLY}`: the wrapped string
- `${REPLY2}`: the length taken on the last line

Example usage:

```bash
string::wrapCharacters "This-is-a-long-text"
string::wrapCharacters "This-is-a-long-text-that-should-be-wrapped-at-20-characters." width=20 newLinePadString="---" firstLineWidth=5
echo "${REPLY}"
```

> - This function is written in pure bash and is faster than calling the fold command.
> - It considers escape sequence for text formatting and does not count them as visible characters.
> - Leading spaces after a newly wrapped line are removed.

## ⚡ string::wrapWords

Allows to soft wrap the given text at the given width.
Wrapping is done at word boundaries.
Optionally appends padding characters on each new line.

Inputs:

- `$1`: **text variable name** _as string_:

  The variable name that contains the text to wrap.

- `${width}` _as string_:

  (optional) The width to wrap the text at.
  Note that length of the new line pad string is subtracted from the
  width to make sure the text fits in the given width.

  (defaults to "${GLOBAL_COLUMNS}")

- `${newLinePadString}` _as string_:

  (optional) The characters to apply as padding on the left of each new line.
  E.g. '  ' will add 2 spaces on the left of each new line.

  (defaults to 0)

- `${firstLineWidth}` _as int_:

  (optional) The width to use for the first line.

  (defaults to "${width}")

Returns:

- `${REPLY}`: the wrapped text

Example usage:

```bash
string::wrapWords "This is a long text."
string::wrapWords "This is a long text wrapped at 20 characters." width=20 newLinePadString="---" firstLineWidth=20
echo "${REPLY}"
```

> - This function is written in pure bash and is faster than calling the fold command.
> - This function effectively trims all the extra spaces in the text (leading, trailing but also in the middle).
> - It considers escape sequence for text formatting and does not count them as visible characters.

> [!IMPORTANT]
> Documentation generated for the version 0.35.114 (2025-10-03).
