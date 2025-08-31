---
title: 📂 regex
cascade:
  type: docs
url: /docs/libraries/regex
---

## ⚡ regex::escapeRegexSpecialChars

Escapes special characters in a string to be used as a regex.

Inputs:

- `$1`: **string to escape** _as string_:

  The string to escape.

Returns:

- `${REPLY}`: The escaped string.

Example usage:

```bash
regex::escapeRegexSpecialChars "a.(b)"
echo "${REPLY}"
```

## ⚡ regex::getFirstGroup

Matches a string against a regex and returns the first captured group of the first match.

Inputs:

- `$1`: **string variable name** _as string_:

  The variable name containing the string to match.

- `$2`: **regex** _as string_:

  The regex to use for the match.

Returns:

- `${REPLY}`: The first capture group in the matched string.
                 Empty if no match.

Example usage:

```bash
MY_STRING="name: julien"
regex::getFirstGroup MY_STRING "name:(.*)"
echo "${REPLY}"
```

> Regex wiki: https://en.wikibooks.org/wiki/Regular_Expressions/POSIX-Extended_Regular_Expressions

## ⚡ regex::getFuzzySearchRegexFromSearchString

Allows to get a regex that can be used to fuzzy search a string.
the -> '([^t]*)(t[^h]*h[^e]*e)'

Inputs:

- `$1`: **search string** _as string_:

  The variable name containing the search string to match.

Returns:

- `${_STRING_FUZZY_FILTER_REGEX}`: the regex

Example usage:

```bash
regex::getFuzzySearchRegexFromSearchString SEARCH_STRING
echo "${_STRING_FUZZY_FILTER_REGEX}"
```

## ⚡ regex::getMatches

Returns an array containing all the matched for a regex in a string.

Inputs:

- `$1`: **string variable name** _as string_:

  The variable name containing the string to match.

- `$2`: **regex** _as string_:

  The regex to use for the match.

- `${replacement}` _as string_:

  (optional) The replacement string to use on each match.

  - Use \x to refer to the x-th capture group.
  - Use \c to refer to replacement counter.

  Set to an empty string to keep the matches as they are.

  (defaults to "")

- `${max}` _as int_:

  (optional) The number of matches to return.
  Set to -1 for unlimited replacements.

  (defaults to -1)

Returns:

- `${REPLY_ARRAY[@]}`: An array containing all the matches.

Example usage:

```bash
MY_STRING="name: julien, name: john"
regex::getMatches MY_STRING "name: (.*)"
regex::getMatches MY_STRING "name: (.*)" max=1
for match in "${REPLY_ARRAY[@]}"; do
  echo "${match}"
done
```

> Regex wiki: https://en.wikibooks.org/wiki/Regular_Expressions/POSIX-Extended_Regular_Expressions

## ⚡ regex::replace

Replaces strings within a string using a regex (replaces in place).

Inputs:

- `$1`: **string variable name** _as string_:

  The variable name containing the string in which to do replacements.

- `$2`: **regex** _as string_:

  The regex to use for the match.

- `$3`: **replacement string** _as string_:

  The replacement string.
  Use \x to refer to the x-th capture group.
  Use \c to refer to replacement counter.

- `${max}` _as int_:

  (optional) The number of replacements to do.
  Set to -1 for unlimited replacements.

  (defaults to -1)

- `${onlyMatches}` _as bool_:

  (optional) Instead of replacing with the regex, we keep only the matches.
  This can be used to extract information from a string.

  (defaults to false)


Example usage:

```bash
MY_STRING="name: julien"
regex::replace MY_STRING "name: (.*)" "\1"
regex::replace MY_STRING "name: (.*)" "\1" maxCount=1 onlyMatches=true
echo "${MY_STRING}"
```

> Regex wiki: https://en.wikibooks.org/wiki/Regular_Expressions/POSIX-Extended_Regular_Expressions

> [!IMPORTANT]
> Documentation generated for the version 0.32.168 (2025-08-31).
