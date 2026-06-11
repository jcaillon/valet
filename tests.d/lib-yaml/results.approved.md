# Test suite lib-yaml

## Test script 00.lib-yaml

### ✅ Testing yaml::parseFile function

❯ `yaml::parseFile resources/arrays.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['last']='value'
['nested.arr.length']='1'
['nested.arr2.length']='2'
['nested.arr2[0].array.length']='3'
['nested.arr2[0].array[0]']='thing'
['nested.arr2[0].array[1]']='stuff'
['nested.arr2[0].array[2].arr.length']='1'
['nested.arr2[0].array[2].arr[0]']='here'
['nested.arr2[0].name']='obj1'
['nested.arr2[1].name']='obj2'
['nested.arr[0].key']='thing'
['thing']='first line
  second line with indent'
)
```

❯ `yaml::parseFile resources/simple.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['"key with spaces"']='value'
['"key:with:colons"']='value'
['"num[0].key"']='1'
['arr.length']='2'
['arr[0]']='thing'
['arr[1]']='stuff:with:colons'
['endingMultiline']='first line
second line
'
['key']='https://example.com'
['nested.arr.length']='4'
['nested.arr[0].array.length']='2'
['nested.arr[0].array[0]']='thing'
['nested.arr[0].array[1].arr.length']='2'
['nested.arr[0].array[1].arr[0]']='1'
['nested.arr[0].array[1].arr[1]']='2'
['nested.arr[0].name']='obj1'
['nested.arr[0].value']='123'
['nested.arr[1].name']='obj2'
['nested.arr[1].properties.length']='2'
['nested.arr[1].properties[0]']='1'
['nested.arr[1].properties[1]']='2'
['nested.arr[1].value']='456'
['nested.arr[2]']='coucou text'
['nested.arr[3]']='nom mais allo'
['nested.thing']='true'
['num.length']='1'
['num[0].key']='2'
['strings.content']='Or we
can auto
convert line breaks
to save space'
['strings.double_quoted']='line1
line2	unicode:❤'
['strings.folded']='a word please ?'
['strings.multiline_folded']='a

this text is folded into a single line
'
['strings.multiline_literal']='line one
line two
  indented
'
['strings.plain']='hello world'
['strings.single_quoted']='hello '"'"'world'"'"' #notacomment'
['strings.with_single_quote']='C'"'"'est "quoi'
)
```

