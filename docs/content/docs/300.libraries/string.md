---
title: 📂 string
cascade:
  type: docs
url: /docs/libraries/string
---

## string::convertCamelCaseToSnakeCase

This function convert a camelCase string to a SNAKE_CASE string.
It uses pure bash.
Removes all leading underscores.

- $1: **string variable name** _as string_:
      The variable name that contains the string to convert.

Returns:

- ${RETURNED_VALUE}: the extracted field

```bash
MY_STRING="myCamelCaseString"
string::convertCamelCaseToSnakeCase MY_STRING
echo "${RETURNED_VALUE}"
```

## string::convertKebabCaseToCamelCase

This function convert a kebab-case string to a camelCase string.
It uses pure bash.
Removes all leading dashes.

- $1: **string variable name** _as string_:
      The variable name that contains the string to convert.

Returns:

- ${RETURNED_VALUE}: the extracted field

```bash
MY_STRING="my-kebab-case-string"
string::convertKebabCaseToCamelCase MY_STRING
echo "${RETURNED_VALUE}"
```

## string::convertKebabCaseToSnakeCase

This function convert a kebab-case string to a SNAKE_CASE string.
It uses pure bash.
Removes all leading dashes.

- $1: **string variable name** _as string_:
      The variable name that contains the string to convert.

Returns:

- ${RETURNED_VALUE}: the extracted field

```bash
MY_STRING="my-kebab-case-string"
string::convertKebabCaseToSnakeCase MY_STRING
echo "${RETURNED_VALUE}"
```

## string::count

Counts the number of occurrences of a substring in a string.

- $1: **string variable name** _as string_:
      The variable name that contains the string in which to count occurrences.
- $2: **substring** _as string_:
      the substring to count

Returns:

- ${RETURNED_VALUE}: the number of occurrences

```bash
MY_STRING="name,first_name,address"
string::count MY_STRING ","
echo "${RETURNED_VALUE}"
```

> This is faster than looping over the string and check the substring.

## string::doForEachLine

Execute a callback function for each item (e.g. line) of a string.
The string is split using a separator (default to a new line) and
the callback function is called for each item.

- $1: **string variable name** _as string_:
      The name of the variable containing the string.
- $2: **callback function** _as string_:
      The name of the function to execute for each item (line).
      The function is called with the following arguments:

      - $1: the current item (line) content

      The function must return 0 if we should continue to the next line, 1 otherwise.
      (defaults to empty)
- $3: separator _as string_:
      (optional) Can be set using the variable `_OPTION_SEPARATOR`.
      The separator character to use.
      (defaults to newline if not provided)

```bash
string::doForEachLine myString myCallback
```

> This function provides a convenient way to avoid using a "here string" and handles extra
> newlines (which is not the case with a "for loop" using parameter expansion and IFS=$'\n').
> Here string is significantly slower than using this.

## string::extractBetween

Extract the text between two strings within a string.
Search for the first occurrence of the start string and the first occurrence
(after the start index) of the end string.
Both start and end strings are excluded in the extracted text.
Both start and end strings must be found to extract something.

- $1: **string variable name** _as string_:
      The variable name that contains the string from which to extract a text.
- $2: **start string** _as string_:
      the start string
      (if empty, then it will extract from the beginning of the string)
- $3: **end string** _as string_:
      the end string
      (if empty, then it will extract until the end of the string)

Returns:

- ${RETURNED_VALUE}: the extracted text

```bash
MY_STRING="This is a long text"
string::extractBetween MY_STRING "is a " " text"
local extractedText="${RETURNED_VALUE}"
```

## string::getField

Allows to get the nth element of a string separated by a given separator.
This is the equivalent of the cut command "cut -d"${separator}" -f"${fieldNumber}""
but it uses pure bash to go faster.

- $1: **string variable name** _as string_:
      The variable name that contains the string to extract from.
- $2: **field number** _as int_:
      The field number to get (starting at 0).
- $3: separator _as string_:
      The separator to use.
      (defaults to tab if not provided)

Returns:

- ${RETURNED_VALUE}: the extracted field

```bash
MY_STRING="field1 field2 field3"
string::getField MY_STRING 1 " "
echo "${RETURNED_VALUE}"
```

> This is faster than:
>
> - using read into an array from a here string
> - using bash parameter expansion to remove before/after the separator

## string::getIndexOf

Find the first index of a string within another string.

- $1: **string variable name** _as string_:
      The variable name that contains the string from which to find an index.
- $2: **search** _as string_:
      the string to search
- $3: start index _as int_:
      (optional) the starting index
      (defaults to 0)

Returns:

- ${RETURNED_VALUE}: the index of the substring in the string or -1 if not found.

```bash
MY_STRING="This is a long text"
string::getIndexOf MY_STRING "long"
echo "${RETURNED_VALUE}"
```

## string::head

Get the first nth items (e.g. lines) of a string.

- $1: **string variable name** _as string_:
      The variable name that contains the string from which to get the first occurrences.
- $2: **nb items** _as int_:
      The number of items (lines) to extract.
- $3: separator _as string_:
      (optional) Can be set using the variable `_OPTION_SEPARATOR`.
      The separator character to use.
      (defaults to newline if not provided)

Returns:

- ${RETURNED_VALUE}: The extracted string.

```bash
MY_STRING="line1"$'\n'"line2"$'\n'"line3"
string::head MY_STRING 2
echo "${RETURNED_VALUE}"
```

## string::highlight

Highlight characters in a string.

- $1: **text variable name** _as string_:
      The variable name that contains the text to highlight.
- $2: **characters variable name** _as string_:
      The variable name that contains characters to highlight.
- $3: highlight ansi code _as string_:
      (optional) Can be set using the variable `_OPTION_HIGHLIGHT_ANSI`.
      The ANSI code to use for highlighting.
      (defaults to STYLE_COLOR_ACCENT)
- $4: reset ansi code _as string_:
      (optional) Can be set using the variable `_OPTION_RESET_ANSI`.
      The ANSI code to use for resetting the highlighting.
      (defaults to STYLE_COLOR_DEFAULT)

Returns:

- ${RETURNED_VALUE}: the highlighted text

```bash
string::highlight "This is a text to highlight." "ttttt"
echo "${RETURNED_VALUE}"
```

> - All characters to highlight must be found in the same order in the matched line.
> - This functions is case insensitive.

## string::removeSgrCodes

Remove all SGR (Select Graphic Rendition) codes from a string.

- $1: **string variable name** _as string_:
      The variable name that contains the string to clean.

Returns:

- ${RETURNED_VALUE}: the cleaned string

```bash
MY_STRING="This is a string with SGR codes"$'\e[0m'
string::removeSgrCodes MY_STRING
echo "${RETURNED_VALUE}"
```

## string::split

Split a string into an array using a separator.

- $1: **string variable name** _as string_:
      The variable name that contains the string to split.
- $2: **separators** _as string_:
      The separator characters to use.

Returns:

- ${RETURNED_ARRAY[@]}: the array of strings

```bash
MY_STRING="name,first_name,address"
string::split MY_STRING ","
ARRAY=("${RETURNED_ARRAY[@]}")
```

> This is faster than using read into an array from a here string.

## string::trimAll

Trim all whitespaces and truncate spaces.

- $1: **string variable name** _as string_:
      The variable name that contains the string to trim.

Returns:

- ${RETURNED_VALUE}: the extracted field

```bash
MY_STRING="   example "$'\t'"  string    "$'\n'
string::trimAll MY_STRING
echo "${RETURNED_VALUE}"
```

## string::trimEdges

Trim leading and trailing characters (defaults to whitespaces).

- $1: **string variable name** _as string_:
      The variable name that contains the string to trim.
- $2: characters to trim _as string_:
      The characters to trim.
      (defaults to " "$'\t'$'\n')

Returns:

- ${RETURNED_VALUE}: the extracted field

```bash
MY_STRING="   example  string    "
string::trimEdges MY_STRING
echo "${RETURNED_VALUE}"
```

## string::wrapCharacters

Allows to hard wrap the given string at the given width.
Wrapping is done at character boundaries, see string::warpText for word wrapping.
Optionally appends padding characters on each new line.

- $1: **text variable name** _as string_:
      The variable name that contains the text to wrap.
- $2: wrap width _as string_:
      (optional) Can be set using the variable `_OPTION_WRAP_WIDTH`.
      The width to wrap the text at.
      Note that length of the optional padding characters are subtracted from the
      width to make sure the text fits in the given width.
      (defaults to GLOBAL_COLUMNS)
- $3: padding characters _as string_:
      (optional) Can be set using the variable `_OPTION_PADDING_CHARS`.
      The characters to apply as padding on the left of each new line.
      E.g. '  ' will add 2 spaces on the left of each new line.
      (defaults to "")
- $4: first line width _as int_:
      (optional) Can be set using the variable `_OPTION_FIRST_LINE_WIDTH`.
      The width to use for the first line.
      (defaults to the width)

Returns:

- ${RETURNED_VALUE}: the wrapped string
- ${RETURNED_VALUE2}: the length taken on the last line

```bash
string::wrapCharacters "This is a long text that should be wrapped at 20 characters." 20 --- 5
echo "${RETURNED_VALUE}"
```

> - This function is written in pure bash and is faster than calling the fold command.
> - It considers escape sequence for text formatting and does not count them as visible characters.
> - Leading spaces after a newly wrapped line are removed.

## string::wrapWords

Allows to soft wrap the given text at the given width.
Wrapping is done at word boundaries.
Optionally appends padding characters on each new line.

- $1: **text variable name** _as string_:
      The variable name that contains the text to wrap.
- $2: wrap width _as string_:
      (optional) Can be set using the variable `_OPTION_WRAP_WIDTH`.
      The width to wrap the text at.
      Note that length of the optional padding characters are subtracted from the
      width to make sure the text fits in the given width.
      (defaults to GLOBAL_COLUMNS)
- $3: padding characters _as string_:
      (optional) Can be set using the variable `_OPTION_PADDING_CHARS`.
      The characters to apply as padding on the left of each new line.
      E.g. '  ' will add 2 spaces on the left of each new line.
      (defaults to 0)
- $4: first line width _as int_:
      (optional) Can be set using the variable `_OPTION_FIRST_LINE_WIDTH`.
      The width to use for the first line.
      (defaults to the width)

Returns:

- ${RETURNED_VALUE}: the wrapped text

```bash
string::wrapWords "This is a long text that should be wrapped at 20 characters." 20 '  ' 5
echo "${RETURNED_VALUE}"
```

> - This function is written in pure bash and is faster than calling the fold command.
> - This function effectively trims all the extra spaces in the text (leading, trailing but also in the middle).
> - It considers escape sequence for text formatting and does not count them as visible characters.

> Documentation generated for the version 0.28.3846 (2025-03-18).
