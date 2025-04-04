# Test suite lib-regex

## Test script 00.tests

### ✅ Testing regex::getFuzzySearchRegexFromSearchString function

❯ `regex::getFuzzySearchRegexFromSearchString _string`

```text
_string='the'
_STRING_FUZZY_FILTER_REGEX='^([^t]*)(t[^h]*h[^e]*e)(.?)'
```

❯ `regex::getFuzzySearchRegexFromSearchString _string`

```text
_string='\^$.|?*+[]{}()'
_STRING_FUZZY_FILTER_REGEX='^([^\]*)(\\[^^]*\^[^$]*\$[^.]*\.[^|]*\|[^?]*\?[^*]*\*[^+]*\+[^[]*\[[^]]*\][^{]*\{[^}]*\}[^(]*\([^)]*\))(.?)'
```

### ✅ Testing regex::escapeRegexSpecialChars function

❯ `regex::escapeRegexSpecialChars \\\^\$.\|\?\*+\[\]\{\}\(\)`

Returned variables:

```text
RETURNED_VALUE='\\\^\$\.\|\?\*\+\[\]\{\}\(\)'
```

### ✅ Testing regex::getFuzzySearchRegexFromSearchString function

❯ `regex::getFuzzySearchRegexFromSearchString _string`

```text
_string='the'
_STRING_FUZZY_FILTER_REGEX='^([^t]*)(t[^h]*h[^e]*e)(.?)'
```

❯ `regex::getFuzzySearchRegexFromSearchString _string`

```text
_string='\^$.|?*+[]{}()'
_STRING_FUZZY_FILTER_REGEX='^([^\]*)(\\[^^]*\^[^$]*\$[^.]*\.[^|]*\|[^?]*\?[^*]*\*[^+]*\+[^[]*\[[^]]*\][^{]*\{[^}]*\}[^(]*\([^)]*\))(.?)'
```

### ✅ Testing regex::getMatches function

```text
_MY_STRING='---
- name: marc
  city: paris
- name:   john
  city: london
- name:julien
  city: lyon
'
```

❯ `regex::getMatches _MY_STRING 'name:[[:space:]]*([[:alnum:]]*)'`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='name: marc'
[1]='name:   john'
[2]='name:julien'
)
```

❯ `regex::getMatches _MY_STRING 'name:[[:space:]]*([[:alnum:]]*)' \\1 2`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='marc'
[1]='john'
)
```

❯ `regex::getMatches _MY_STRING 'name:[[:space:]]*([[:alnum:]]*)' \\1 0`

### ✅ Testing regex::replace function

```text
_MY_STRING='---
- name: marc
  city: paris
- name:   john
  city: london
- name:julien
  city: lyon
'
```

❯ `regex::replace _MY_STRING 'name:[[:space:]]*([[:alnum:]]*)' \\c=\\1\  2 true`

Returned variables:

```text
RETURNED_VALUE='0=marc 1=john '
```

❯ `regex::replace _MY_STRING '- name:[[:space:]]*([[:alnum:]]*)[^-]+' \\c=\\1\ `

Returned variables:

```text
RETURNED_VALUE='---
0=marc 1=john 2=julien '
```

```text
_MY_STRING='This is the year 2000, madness rules the world.'
```

❯ `regex::replace _MY_STRING '[0-9]{4}' 2025`

Returned variables:

```text
RETURNED_VALUE='This is the year 2025, madness rules the world.'
```

❯ `regex::replace _MY_STRING '^(This) is.*$' \\1\ is\ working.`

Returned variables:

```text
RETURNED_VALUE='This is working.'
```

❯ `regex::replace _MY_STRING '^(This) is.*$' \\1\ is\ working. 0`

Returned variables:

```text
RETURNED_VALUE='This is the year 2000, madness rules the world.'
```

❯ `regex::replace _MY_STRING '^(This) is.*$' \\1\ is\ working. 0 true`

Returned variables:

```text
RETURNED_VALUE=''
```

### ✅ Testing regex::getFirstGroup function

❯ `MY_STRING=name:\ julien regex::getFirstGroup MY_STRING 'name:[[:space:]]*([[:alnum:]]*)'`

Returned variables:

```text
RETURNED_VALUE='julien'
```

