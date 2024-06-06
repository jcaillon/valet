---
title: 📂 string
cascade:
  type: docs
url: /docs/libraries/string
---

## string::wrapSentence

Allows to soft wrap the given sentence (without new lines) at the given width.
Optionally applies a prefix on each new line.

- $1: the text to wrap
- $2: the width to wrap the text at
- $3: the prefix to apply to each new line (default to "")

Returns:

- `RETURNED_VALUE`: the wrapped text

```bash
string::wrapSentence "This is a long text that should be wrapped at 20 characters." 20
local wrappedText="${RETURNED_VALUE}"
```

> - This function is written in pure bash and is faster than calling the fold command.
> - This function effectively trims all the extra spaces in the text (leading, trailing but also in the middle).


## string::split

Split a string into an array using a separator.

- $1: the string to split
- $2: the separator (must be a single character!)

Returns:

- `RETURNED_ARRAY`: the array of strings

```bash
string::split "name,firstname,address" "," && local -a array=("${RETURNED_ARRAY[@]}")
```

> This is faster than using read into an array from a here string.


## string::extractBetween

Extract the text between two strings within a string.
Search for the first occurence of the start string and the first occurence
(after the start index) of the end string.
Both start and end strings are excluded in the extracted text.
Both start and end strings must be found to extract something.

- $1: the string in which to search
- $2: the start string (if empty, then it will extract from the beginning of the string)
- $3: the end string (if empty, then it will extract until the end of the string)

Returns:

- `RETURNED_VALUE`: the extracted text

```bash
string::extractBetween "This is a long text" "is a " " text"
local extractedText="${RETURNED_VALUE}"
```


## string::wrapCharacters

Allows to hard wrap the given string (without new lines) at the given width.
Wrapping is done at character boundaries without taking spaces into consideration.
Optionally applies a prefix on each new line.

- $1: the text to wrap
- $2: the width to wrap the text at
- $3: (optional) the prefix to apply to each new line (default to "")
- $4: (optional) the width to wrap the text for each new line (default to the width)

Returns:

- `RETURNED_VALUE`: the wrapped string

```bash
string::wrapCharacters "This is a long text that should be wrapped at 20 characters." 20 ---
local wrappedString="${RETURNED_VALUE}"
```

> This function is written in pure bash and is faster than calling the fold command.


## string::count

Counts the number of occurences of a substring in a string.

- $1: the string in which to search
- $2: the substring to count

Returns:

- `RETURNED_VALUE`: the number of occurences

```bash
string::count "name,firstname,address" "," && local count="${RETURNED_VALUE}"
```

> This is faster than looping over the string and check the substring.


## string::indexOf

Find the first index of a string within another string.

- $1: the string in which to search
- $2: the string to search
- $3: the starting index (default to 0)

Returns:

- `RETURNED_VALUE`: the index of the substring in the string or -1 if not found.

```bash
string::indexOf "This is a long text" "long" && local index="${RETURNED_VALUE}"
string::indexOf "This is a long text" "long" 10 && local index="${RETURNED_VALUE}"
```


## string::camelCaseToSnakeCase

This function convert a camelCase string to a SNAKE_CASE string.
It uses pure bash.
Removes all leading underscores.

- $1: The camelCase string to convert.

Returns:

- `RETURNED_VALUE`: The SNAKE_CASE string.

```bash
string::camelCaseToSnakeCase "myCamelCaseString" && local mySnakeCaseString="${RETURNED_VALUE}"
```


## string::cutField

Allows to get the nth element of a string separated by a given separator.
This is the equivalent of the cut command "cut -d"${separator}" -f"${fieldNumber}""
but it uses pure bash to go faster.

- $1: the string to cut
- $2: the field number to get (starting at 0)
- $3: the separator (default to tab if not provided)

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


## string::trimAll

Trim all whitespaces and truncate spaces.

- $1: The string to trim.

Returns:

- `RETURNED_VALUE`: The trimmed string.

```bash
string::trimAll "   example   string    " && local trimmedString="${RETURNED_VALUE}"
```


## string::bumpSemanticVersion

This function allows to bump a semantic version formatted like:
major.minor.patch-prerelease+build

- $1: the version to bump
- $2: the level to bump (major, minor, patch)
- $3: clear the prerelease and build (optional, defaults to true)

Returns:

- `RETURNED_VALUE`: the new version string

```bash
string::bumpSemanticVersion "1.2.3-prerelease+build" "major"
local newVersion="${RETURNED_VALUE}"
```


## string::regexGetFirst

Matches a string against a regex and returns the first capture group of the matched string.

- $1: the string to match
- $2: the regex

Returns:

- `RETURNED_VALUE`: the first capture group in the matched string.
                    Empty if no match.

```bash
string::regexGetFirst "name: julien" "name:(.*)"
echo "${RETURNED_VALUE}"
```

> Regex wiki: https://en.wikibooks.org/wiki/Regular_Expressions/POSIX-Extended_Regular_Expressions


## string::kebabCaseToCamelCase

This function convert a kebab-case string to a camelCase string.
It uses pure bash.
Removes all leading dashes.

- $1: The kebab-case string to convert.

Returns:

- `RETURNED_VALUE`: The camelCase string.

```bash
string::kebabCaseToCamelCase "my-kebab-case-string" && local myCamelCaseString="${RETURNED_VALUE}"
```


## string::trim

Trim leading and trailing whitespaces.

-$1: The string to trim.

Returns:

- `RETURNED_VALUE`: The trimmed string.

```bash
string::trim "   example string    " && local trimmedString="${RETURNED_VALUE}"
```


## string::kebabCaseToSnakeCase

This function convert a kebab-case string to a SNAKE_CASE string.
It uses pure bash.
Removes all leading dashes.

- $1: The kebab-case string to convert.

Returns:

- `RETURNED_VALUE`: The SNAKE_CASE string.

```bash
string::kebabCaseToSnakeCase "my-kebab-case-string" && local mySnakeCaseString="${RETURNED_VALUE}"
```




> Documentation generated for the version 0.17.112 (2024-06-06).
