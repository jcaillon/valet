# Test suite lib-data

## Test script 00.lib-data

### ✅ Testing data::deserialize from non-existing file

❯ `data::deserialize non-existing`

Returned variables:

```text
REPLY_CODE='1'
REPLY=''
```

### ✅ Testing data::serialize with file name

❯ `data::serialize my-variables my_array my_string my_integer my_associative_array`

Returned variables:

```text
REPLY='/tmp/valet.valet.d/my-variables'
```

### ✅ Testing data::serialize with file name under a folder

❯ `data::serialize folder/my-variables my_array my_string my_integer my_associative_array`

Returned variables:

```text
REPLY='/tmp/valet.valet.d/folder/my-variables'
```

### ✅ Testing data::deserialize with file name

❯ `data::deserialize my-variables`

Returned variables:

```text
REPLY_CODE='0'
REPLY='declare -a my_array=([0]="first" [1]=$'"'"'second\nwith new lines'"'"' [2]="third")
declare -- my_string=$'"'"'a\nword\tplease'"'"'
declare -i my_integer="2"
declare -A my_associative_array=([key]="value" )
'
```

### ✅ Testing data::serialize with file path

❯ `data::serialize /tmp/valet-temp my_string`

Returned variables:

```text
REPLY='/tmp/valet-temp'
```

### ✅ Testing data::deserialize with file path

❯ `data::deserialize /tmp/valet-temp`

Returned variables:

```text
REPLY_CODE='0'
REPLY='declare -- my_string=$'"'"'a\nword\tplease'"'"'
'
```

