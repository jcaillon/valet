# Test suite lib-variable

## Test script 00.lib-variable

### ✅ Testing variable::deserialize from non-existing file

❯ `variable::deserialize non-existing`

Returned variables:

```text
REPLY_CODE='1'
REPLY=''
```

### ✅ Testing variable::serialize with file name

❯ `variable::serialize my-variables my_array my_string my_integer my_associative_array`

Returned variables:

```text
REPLY='/tmp/valet.valet.d/my-variables'
```

### ✅ Testing variable::serialize with file name under a folder

❯ `variable::serialize folder/my-variables my_array my_string my_integer my_associative_array`

Returned variables:

```text
REPLY='/tmp/valet.valet.d/folder/my-variables'
```

### ✅ Testing variable::deserialize with file name

❯ `variable::deserialize my-variables`

Returned variables:

```text
REPLY_CODE='0'
REPLY='declare -a my_array=([0]="first" [1]=$'"'"'second\nwith new lines'"'"' [2]="third")
declare -- my_string=$'"'"'a\nword\tplease'"'"'
declare -i my_integer="2"
declare -A my_associative_array=([key]="value" )
'
```

### ✅ Testing variable::serialize with file path

❯ `variable::serialize /tmp/valet-temp my_string`

Returned variables:

```text
REPLY='/tmp/valet-temp'
```

### ✅ Testing variable::deserialize with file path

❯ `variable::deserialize /tmp/valet-temp`

Returned variables:

```text
REPLY_CODE='0'
REPLY='declare -- my_string=$'"'"'a\nword\tplease'"'"'
'
```

### ✅ Testing variable::isCachedWithValue

❯ `variable::isCachedWithValue VAR1 val1 VAR2 val2`

Returned code: `1`

❯ `variable::isCachedWithValue VAR1 val1`

❯ `variable::isCachedWithValue VAR1 val2`

Returned code: `1`

❯ `variable::clearCachedVariables`

❯ `variable::isCachedWithValue VAR2 val2`

Returned code: `1`

❯ `variable::clearCachedVariables VAR2`

❯ `variable::isCachedWithValue VAR2 val2`

Returned code: `1`

❯ `variable::isCachedWithValue VAR2 val2`

### ✅ Testing variable::isMissing

❯ `variable::isMissing`

Returned code: `1`

❯ `ABC=ok`

❯ `variable::isMissing GLOBAL_TEST_TEMP_FILE dfg ABC NOP`

Returned variables:

```text
REPLY_ARRAY=(
[0]='dfg'
[1]='NOP'
)
```

