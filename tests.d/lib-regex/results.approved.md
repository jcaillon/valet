# Test suite lib-regex

## Test script 00.tests

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

❯ `regex::replace _MY_STRING '[0-9]{4}' 2025`

Returned variables:

```text
RETURNED_VALUE='This is the year 2025, madness rules the world.'
```

❯ `regex::replace _MY_STRING '^(This) .*$' \\1\ is\ working.`

Returned variables:

```text
RETURNED_VALUE='This is working.'
```

### ✅ Testing regex::getFirstGroup function

❯ `MY_STRING=name:\ julien regex::getFirstGroup MY_STRING 'name:[[:space:]]*([[:alnum:]]*)'`

Returned variables:

```text
RETURNED_VALUE='julien'
```

