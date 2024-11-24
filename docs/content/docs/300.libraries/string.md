---
title: 📂 string
cascade:
  type: docs
url: /docs/libraries/string
---

## string::bumpSemanticVersion

This function allows to bump a semantic version formatted like:
major.minor.patch-prerelease+build

- $1: **version** _as string_:
      the version to bump
- $2: **level** _as string_:
      the level to bump (major, minor, patch)
- $3: clear build and prerelease _as bool_:
      (optional) clear the prerelease and build
      (defaults to true)

Returns:

- `RETURNED_VALUE`: the new version string

```bash
string::bumpSemanticVersion "1.2.3-prerelease+build" "major"
local newVersion="${RETURNED_VALUE}"
```


## string::camelCaseToSnakeCase

This function convert a camelCase string to a SNAKE_CASE string.
It uses pure bash.
Removes all leading underscores.

- $1: **camelCase string** _as string_:
      The camelCase string to convert.

Returns:

- `RETURNED_VALUE`: The SNAKE_CASE string.

```bash
string::camelCaseToSnakeCase "myCamelCaseString" && local mySnakeCaseString="${RETURNED_VALUE}"
```


## string::compareSemanticVersion

This function allows to compare two semantic versions formatted like:
major.minor.patch-prerelease+build

- $1: **version1** _as string_:
      the first version to compare
- $2: **version2** _as string_:
      the second version to compare

Returns:

- `RETURNED_VALUE`:
  - 0 if the versions are equal,
  - 1 if version1 is greater,
  - -1 if version2 is greater

```bash
string::compareSemanticVersion "2.3.4-prerelease+build" "1.2.3-prerelease+build"
local comparison="${RETURNED_VALUE}"
```

> The prerelease and build are ignored in the comparison.


## string::count

Counts the number of occurences of a substring in a string.

- $1: **string** _as string_:
      the string in which to search
- $2: **substring** _as string_:
      the substring to count

Returns:

- `RETURNED_VALUE`: the number of occurences

```bash
string::count "name,firstname,address" "," && local count="${RETURNED_VALUE}"
```

> This is faster than looping over the string and check the substring.


## string::cutField

Allows to get the nth element of a string separated by a given separator.
This is the equivalent of the cut command "cut -d"${separator}" -f"${fieldNumber}""
but it uses pure bash to go faster.

- $1: **string to cut** _as string_:
      the string to cut
- $2: **field number** _as int_:
      the field number to get (starting at 0)
- $3: separator _as string_:
      the separator
      (defaults to tab if not provided)

Returns:

- `RETURNED_VALUE`: the extracted field

```bash
string::cutField "field1 field2 field3" 1 " " && local field="${RETURNED_VALUE}"
printf '%s' "${field}" # will output "field2"
```

> This is faster than:
>
> - using read into an array from a here string
> - using bash parameter expansion to remove before/after the separator


## string::extractBetween

Extract the text between two strings within a string.
Search for the first occurence of the start string and the first occurence
(after the start index) of the end string.
Both start and end strings are excluded in the extracted text.
Both start and end strings must be found to extract something.

- $1: **string** _as string_:
      the string in which to search
- $2: **start string** _as string_:
      the start string
      (if empty, then it will extract from the beginning of the string)
- $3: **end string** _as string_:
      the end string
      (if empty, then it will extract until the end of the string)

Returns:

- `RETURNED_VALUE`: the extracted text

```bash
string::extractBetween "This is a long text" "is a " " text"
local extractedText="${RETURNED_VALUE}"
```


## string::indexOf

Find the first index of a string within another string.

- $1: **string** _as string_:
      the string in which to search
- $2: **search** _as string_:
      the string to search
- $3: start index _as int_:
      (optional) the starting index
      (defaults to 0)

Returns:

- `RETURNED_VALUE`: the index of the substring in the string or -1 if not found.

```bash
string::indexOf "This is a long text" "long" && local index="${RETURNED_VALUE}"
string::indexOf "This is a long text" "long" 10 && local index="${RETURNED_VALUE}"
```


## string::kebabCaseToCamelCase

This function convert a kebab-case string to a camelCase string.
It uses pure bash.
Removes all leading dashes.

- $1: **kebab-case string** _as string_:
      The kebab-case string to convert.

Returns:

- `RETURNED_VALUE`: The camelCase string.

```bash
string::kebabCaseToCamelCase "my-kebab-case-string" && local myCamelCaseString="${RETURNED_VALUE}"
```


## string::kebabCaseToSnakeCase

This function convert a kebab-case string to a SNAKE_CASE string.
It uses pure bash.
Removes all leading dashes.

- $1: **kebab-case string** _as string_:
      The kebab-case string to convert.

Returns:

- `RETURNED_VALUE`: The SNAKE_CASE string.

```bash
string::kebabCaseToSnakeCase "my-kebab-case-string" && local mySnakeCaseString="${RETURNED_VALUE}"
```


## string::microsecondsToHuman

Convert microseconds to human readable format.

- $1: **microseconds** _as int_:
      the microseconds to convert
- $2: **format** _as string_:
     the format to use (defaults to "HH:MM:SS")
     Usable formats:
     - %HH: hours
     - %MM: minutes
     - %SS: seconds
     - %LL: milliseconds
     - %h: hours without leading zero
     - %m: minutes without leading zero
     - %s: seconds without leading zero
     - %l: milliseconds without leading zero
     - %u: microseconds without leading zero
     - %M: total minutes
     - %S: total seconds
     - %L: total milliseconds
     - %U: total microseconds

Returns:

- `RETURNED_VALUE`: the human readable format

```bash
string::microsecondsToHuman 123456789
echo "${RETURNED_VALUE}"
```


## string::regexGetFirst

Matches a string against a regex and returns the first capture group of the matched string.

- $1: **string** _as string_:
      the string to match
- $2: **regex** _as string_:
      the regex

Returns:

- `RETURNED_VALUE`: the first capture group in the matched string.
                    Empty if no match.

```bash
string::regexGetFirst "name: julien" "name:(.*)"
echo "${RETURNED_VALUE}"
```

> Regex wiki: https://en.wikibooks.org/wiki/Regular_Expressions/POSIX-Extended_Regular_Expressions


## string::split

Split a string into an array using a separator.

- $1: **string** _as string_:
      the string to split
- $2: **separator** _as string_:
      the separator (must be a single character!)

Returns:

- `RETURNED_ARRAY`: the array of strings

```bash
string::split "name,firstname,address" "," && local -a array=("${RETURNED_ARRAY[@]}")
```

> This is faster than using read into an array from a here string.


## string::trim

Trim leading and trailing whitespaces.

- $1: **string to trim** _as string_:
      The string to trim.

Returns:

- `RETURNED_VALUE`: The trimmed string.

```bash
string::trim "   example string    " && local trimmedString="${RETURNED_VALUE}"
```


## string::trimAll

Trim all whitespaces and truncate spaces.

- $1: **string to trim** _as string_:
      The string to trim.

Returns:

- `RETURNED_VALUE`: The trimmed string.

```bash
string::trimAll "   example   string    " && local trimmedString="${RETURNED_VALUE}"
```


## string::wrapCharacters

Allows to hard wrap the given string (without new lines) at the given width.
Wrapping is done at character boundaries without taking spaces into consideration.
Optionally applies a prefix on each new line.

- $1: **text** _as string_:
      the text to wrap
- $2: wrap width _as string_:
      (optional) the width to wrap the text at
      (defaults to GLOBAL_COLUMNS)
- $3: new line pad string _as string_:
      (optional) the prefix to apply to each new line
      (defaults to "")
- $4: new line wrap width _as string_:
      (optional) the width to wrap the text for each new line
      (defaults to the width)

Returns:

- `RETURNED_VALUE`: the wrapped string

```bash
string::wrapCharacters "This is a long text that should be wrapped at 20 characters." 20 ---
local wrappedString="${RETURNED_VALUE}"
```

> This function is written in pure bash and is faster than calling the fold command.


## string::wrapSentence

Allows to soft wrap the given sentence (without new lines) at the given width.
Optionally applies a prefix on each new line.

- $1: **text** _as string_:
      the text to wrap
- $2: wrap width _as int_:
      (optional) the width to wrap the text at
      (defaults to GLOBAL_COLUMNS)
- $3:*new line pad string _as string_:
      (optional) the prefix to apply to each new line
      (defaults to "")

Returns:

- `RETURNED_VALUE`: the wrapped text

```bash
string::wrapSentence "This is a long text that should be wrapped at 20 characters." 20
local wrappedText="${RETURNED_VALUE}"
```

> - This function is written in pure bash and is faster than calling the fold command.
> - This function effectively trims all the extra spaces in the text (leading, trailing but also in the middle).




> Documentation generated for the version 0.24.6 (2024-11-24).
