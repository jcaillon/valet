# Test suite lib-array

## Test script 00.lib-array

### ✅ Testing array::sort

```text
MY_ARRAY=(
[0]='breakdown'
[1]='constitutional'
[2]='conventional'
[3]='baby'
[4]='holiday'
[5]='abundant'
[6]='deliver'
[7]='position'
[8]='economics'
)
```

❯ `array::sort MY_ARRAY`

```text
MY_ARRAY=(
[0]='abundant'
[1]='baby'
[2]='breakdown'
[3]='constitutional'
[4]='conventional'
[5]='deliver'
[6]='economics'
[7]='holiday'
[8]='position'
)
```

Testing with an empty array:

❯ `array::sort MY_ARRAY`

```text
MY_ARRAY=(
)
```

### ✅ Testing array::sortWithCriteria

```text
MY_ARRAY=(
[0]='a'
[1]='b'
[2]='c'
[3]='d'
[4]='e'
[5]='f'
[6]='g'
)
MY_CRITERIA1=(
[0]='3'
[1]='2'
[2]='2'
[3]='1'
[4]='1'
[5]='4'
[6]='0'
)
MY_CRITERIA2=(
[0]='1'
[1]='3'
[2]='2'
[3]='5'
[4]='0'
[5]='2'
[6]='9'
)
```

❯ `array::sortWithCriteria MY_ARRAY MY_CRITERIA1 MY_CRITERIA2`

Returned variables:

```text
REPLY_ARRAY=(
[0]='6'
[1]='4'
[2]='3'
[3]='2'
[4]='1'
[5]='0'
[6]='5'
)
```

```text
MY_ARRAY=(
[0]='g'
[1]='e'
[2]='d'
[3]='c'
[4]='b'
[5]='a'
[6]='f'
)
```

**Standard output**:

```text
got:      g e d c b a f
expected: g e d c b a f
```

### ✅ Testing array::appendIfNotPresent

```text
MY_ARRAY=(
[0]='breakdown'
[1]='constitutional'
)
```

❯ `MY_VALUE=deliver array::appendIfNotPresent MY_ARRAY MY_VALUE`

```text
MY_ARRAY=(
[0]='breakdown'
[1]='constitutional'
[2]='deliver'
)
```

❯ `MY_VALUE=breakdown array::appendIfNotPresent MY_ARRAY MY_VALUE`

Returned code: `1`

```text
MY_ARRAY=(
[0]='breakdown'
[1]='constitutional'
[2]='deliver'
)
```

### ✅ Testing array::contains

```text
MY_ARRAY=(
[0]='breakdown'
[1]='deliver'
[2]='economics'
)
```

❯ `MY_VALUE=deliver array::contains MY_ARRAY MY_VALUE`

```text
MY_ARRAY=(
[0]='breakdown'
[1]='deliver'
[2]='economics'
)
```

❯ `MY_VALUE=holiday array::contains MY_ARRAY MY_VALUE`

Returned code: `1`

```text
MY_ARRAY=(
[0]='breakdown'
[1]='deliver'
[2]='economics'
)
```

### ✅ Testing array::remove

```text
MY_ARRAY=(
[0]='breakdown'
[1]='deliver'
[2]='economics'
)
```

❯ `MY_VALUE=deliver array::remove MY_ARRAY MY_VALUE`

```text
MY_ARRAY=(
[0]='breakdown'
[2]='economics'
)
```

❯ `MY_VALUE=holiday array::remove MY_ARRAY MY_VALUE`

Returned code: `1`

```text
MY_ARRAY=(
[0]='breakdown'
[2]='economics'
)
```

```text
MY_ASSOCIATIVE_ARRAY=(
[deliver]='2'
[breakdown]='1'
[economics]='3'
)
```

❯ `MY_VALUE=1 array::remove MY_ASSOCIATIVE_ARRAY MY_VALUE`

```text
MY_ASSOCIATIVE_ARRAY=(
[deliver]='2'
[economics]='3'
)
```

### ✅ Testing array::makeArraysSameSize

```text
MY_ARRAY1=(
[0]='a'
[1]='b'
[2]='c'
)
MY_ARRAY2=(
[0]=''
[1]='2'
)
MY_ARRAY3=(
[0]='x'
[1]='y'
[2]='z'
[3]='w'
)
```

❯ `array::makeArraysSameSize MY_ARRAY1 MY_ARRAY2 MY_ARRAY3 MY_ARRAY4`

```text
MY_ARRAY1=(
[0]='a'
[1]='b'
[2]='c'
[3]=''
)
MY_ARRAY2=(
[0]=''
[1]='2'
[2]=''
[3]=''
)
MY_ARRAY3=(
[0]='x'
[1]='y'
[2]='z'
[3]='w'
)
MY_ARRAY4=(
[0]=''
[1]=''
[2]=''
[3]=''
)
```

### ✅ Testing array::fuzzyFilterSort

```text
MY_ARRAY=(
[0]='one the'
[1]='the breakdown'
[2]='constitutional'
[3]='conventional'
[4]='hold the baby'
[5]='holiday inn'
[6]='deliver'
[7]='eLv1'
[8]='eLv'
[9]='abundant'
[10]='make a living'
[11]='the d day'
[12]='elevator'
)
```

❯ `SEARCH_STRING=the array::fuzzyFilterSort MY_ARRAY SEARCH_STRING`

Returned variables:

```text
REPLY_ARRAY=(
[0]='the breakdown'
[1]='the d day'
[2]='one the'
[3]='hold the baby'
)
REPLY_ARRAY2=(
[0]='1'
[1]='11'
[2]='0'
[3]='4'
)
```

❯ `shopt -s nocasematch`

❯ `SEARCH_STRING=ELV array::fuzzyFilterSort MY_ARRAY SEARCH_STRING`

Returned variables:

```text
REPLY_ARRAY=(
[0]='eLv'
[1]='eLv1'
[2]='elevator'
[3]='deliver'
[4]='make a living'
)
REPLY_ARRAY2=(
[0]='8'
[1]='7'
[2]='12'
[3]='6'
[4]='10'
)
```

