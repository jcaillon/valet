---
title: 📂 regex
cascade:
  type: docs
url: /docs/libraries/regex
---

## regex::getFirstGroup

Matches a string against a regex and returns the first captured group of the first match.

- $1: **string variable name** _as string_:
      The variable name containing the string to match.
- $2: **regex** _as string_:
      The regex to use for the match.

Returns:

- ${RETURNED_VALUE}: The first capture group in the matched string.
                     Empty if no match.

```bash
MY_STRING="name: julien"
regex::getFirstGroup MY_STRING "name:(.*)"
echo "${RETURNED_VALUE}"
```

> Regex wiki: https://en.wikibooks.org/wiki/Regular_Expressions/POSIX-Extended_Regular_Expressions

## regex::getMatches

Returns an array containing all the matched for a regex in a string.

- $1: **string variable name** _as string_:
      The variable name containing the string to match.
- $2: **regex** _as string_:
      The regex to use for the match.
- $3: replacement _as string_:
      (optional) Can be set using the variable `_OPTION_REPLACEMENT`.
      The replacement string to use on each match.
      Use \x to refer to the x-th capture group.
      Use \c to refer to replacement counter.
      (default to "", which means no changes will be done on the matches)
- $4: max count _as int_:
      (optional) Can be set using the variable `_OPTION_MAX_COUNT`.
      The number of matches to return.
      (default to -1, which is unlimited)

Returns:

- ${RETURNED_ARRAY[@]}: An array containing all the matches.

```bash
MY_STRING="name: julien, name: john"
regex::getMatches MY_STRING "name: (.*)"
for match in "${RETURNED_ARRAY[@]}"; do
  echo "${match}"
done
```

> Regex wiki: https://en.wikibooks.org/wiki/Regular_Expressions/POSIX-Extended_Regular_Expressions

## regex::replace

Replaces strings within a string using a regex.

- $1: **string variable name** _as string_:
      The variable name containing the string in which to do replacements.
      Replacement is done in place.
- $2: **regex** _as string_:
      The regex to use for the match.
- $3: **replacement** _as string_:
      The replacement string.
      Use \x to refer to the x-th capture group.
      Use \c to refer to replacement counter.
- $4: max count _as int_:
      (optional) Can be set using the variable `_OPTION_MAX_COUNT`.
      The number of replacements to do.
      (default to -1, which is unlimited)
- $5: only matches _as bool_:
      (optional) Can be set using the variable `_OPTION_ONLY_MATCHES`.
      Instead of replacing with the regex, we keep only the matches.
      This can be used to extract information from a string.
      (default to false)

Returns:

- ${RETURNED_VALUE}: The string with replacements.

```bash
MY_STRING="name: julien"
regex::replace MY_STRING "name: (.*)" "\1"
echo "${RETURNED_VALUE}"
```

> Regex wiki: https://en.wikibooks.org/wiki/Regular_Expressions/POSIX-Extended_Regular_Expressions

> Documentation generated for the version 0.28.3846 (2025-03-18).
