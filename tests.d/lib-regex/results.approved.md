# Test suite lib-regex

## Test script 00.tests

### ✅ Testing regex::escapeRegexSpecialChars function

❯ `regex::escapeRegexSpecialChars \\\^\$.\|\?\*+\[\]\{\}\(\)`

Returned variables:

```text
REPLY='\\\^\$\.\|\?\*\+\[\]\{\}\(\)'
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
REPLY_ARRAY=(
[0]='name: marc'
[1]='name:   john'
[2]='name:julien'
)
```

❯ `regex::getMatches _MY_STRING 'name:[[:space:]]*([[:alnum:]]*)' replacement=\\c\\1 max=2`

Returned variables:

```text
REPLY_ARRAY=(
[0]='0marc'
[1]='1john'
)
```

❯ `regex::getMatches _MY_STRING 'name:[[:space:]]*([[:alnum:]]*)' replacement=\\1 max=0`

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

❯ `regex::replace _MY_STRING 'name:[[:space:]]*([[:alnum:]]*)' \\c=\\1\  max=2 onlyMatches=true`

```text
_MY_STRING='0=marc 1=john '
```

❯ `regex::replace _MY_STRING '- name:[[:space:]]*([[:alnum:]]*)[^-]+' \\c=\\1\ `

```text
_MY_STRING='---
0=marc 1=john 2=julien '
```

```text
_MY_STRING='This is the year 2000, madness rules the world.'
```

❯ `regex::replace _MY_STRING '[0-9]{4}' 2025`

```text
_MY_STRING='This is the year 2025, madness rules the world.'
```

❯ `regex::replace _MY_STRING '^(This) is.*$' \\1\ is\ working.`

```text
_MY_STRING='This is working.'
```

❯ `regex::replace _MY_STRING '^(This) is.*$' \\1\ is\ working. max=0`

```text
_MY_STRING='This is the year 2000, madness rules the world.'
```

❯ `regex::replace _MY_STRING '^(This) is.*$' \\1\ is\ working. max=0 onlyMatches=true`

```text
_MY_STRING=''
```

### ✅ Testing regex::getFirstGroup function

❯ `MY_STRING=name:\ julien regex::getFirstGroup MY_STRING 'name:[[:space:]]*([[:alnum:]]*)'`

Returned variables:

```text
REPLY='julien'
```

