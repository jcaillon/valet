# Test suite lib-regex

## Test script 00.tests

### ✅ Testing regex::getFirstGroup function

❯ `MY_STRING=name:\ julien regex::getFirstGroup MY_STRING 'name:[[:space:]]*([[:alnum:]]*)'`

Returned variables:

```text
RETURNED_VALUE='julien'
```

