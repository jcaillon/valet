# Test suite lib-yaml

## Test script 00.lib-yaml

### ✅ Testing yaml::parseFile function

> cat `resources/ok/any-indent.yaml`

```text
normal:
  - item    : Super Hoop
    quantity:
     1
  - >
   Sammy Sosa completed another
   fine season with great stats.

     63 Home Runs
     0.288 Batting Average

   What a year!
  -
      name: Mark McGwire
      hr:   65
      avg:  0.278
  - |1
    explicit
  - |
    explicit
  - >4
        explicit
  -   # commm
   key: 1
key:
 1indent:
   now2:
    and1again:
        now4: v
    arr:
      - 1
      - 2
      -
         3
    arr2:
     - 1
     - 2
     - 3
```

❯ `yaml::parseFile resources/ok/any-indent.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='1'
['key.1indent.now2.and1again.now4']='v'
['key.1indent.now2.arr.length']='3'
['key.1indent.now2.arr2.length']='3'
['key.1indent.now2.arr2[0]']='1'
['key.1indent.now2.arr2[0].tag']='!!int'
['key.1indent.now2.arr2[1]']='2'
['key.1indent.now2.arr2[1].tag']='!!int'
['key.1indent.now2.arr2[2]']='3'
['key.1indent.now2.arr2[2].tag']='!!int'
['key.1indent.now2.arr[0]']='1'
['key.1indent.now2.arr[0].tag']='!!int'
['key.1indent.now2.arr[1]']='2'
['key.1indent.now2.arr[1].tag']='!!int'
['key.1indent.now2.arr[2]']='3'
['key.1indent.now2.arr[2].tag']='!!int'
['normal.length']='7'
['normal[0].item']='Super Hoop'
['normal[0].quantity']='1'
['normal[0].quantity.tag']='!!int'
['normal[1]']='Sammy Sosa completed another fine season with great stats.

  63 Home Runs
  0.288 Batting Average

What a year!
'
['normal[2].avg']='0.278'
['normal[2].avg.tag']='!!float'
['normal[2].hr']='65'
['normal[2].hr.tag']='!!int'
['normal[2].name']='Mark McGwire'
['normal[3]']=' explicit
'
['normal[4]']='explicit
'
['normal[5]']='  explicit
'
['normal[6].key']='1'
['normal[6].key.tag']='!!int'
)
```

> cat `resources/ok/arrays.yaml`

```text
#                  | keyPaths                           |  keyIndentLevels  | arrayIndexes
# -----------------|------------------------------------|-------------------|--------------
nested:           # (nested)                            | (0)               | (-1)
  arr:            # (nested arr)                        | (0 2)             | (-1 -1)
  - key: thing    # (nested arr [0].key)                | (0 2 4)           | (-1 -1 0)
  arr2:           # (nested arr2)                       | (0 2)             | (-1 -1)
    - name: obj1  # (nested arr2 [0].name)              | (0 2 6)           | (-1 0 -1)
      array:      # (nested arr2 [0].array)             | (0 2 6)           | (-1 0 -1)
      - thing     # (nested arr2 [0].array [0])         | (0 2 6 8)         | (-1 0 0 -1)
      - stuff     # (nested arr2 [0].array [1])         | (0 2 6 8)         | (-1 0 1 -1)
      - arr:      # (nested arr2 [0].array [2].arr)     | (0 2 6 8)         | (-1 0 1 -1)
        - here    # (nested arr2 [0].array [2].arr [0]) | (0 2 6 8 10)      | (-1 0 1 0 -1)
    - name: obj2  # (nested arr2 [1].name)              | (0 2 6)           | (-1 1 -1)
thing: |-         # (thing)                             | (0)               | (-1)
  first line
    second line with indent
last: value       # (last)                              | (0)               | (-1)
```

❯ `yaml::parseFile resources/ok/arrays.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='1'
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

> cat `resources/ok/flow-collections.yaml`

```text
hi: [
  "double

  quoted", 'single
            quoted',

  plain
  text, [ nested, ],
  single: pair,
  ]
thing:
- {
    one : two,
    three: four,
    five: [
      [ [ "val" ]],
      { key: { arr: [ k: v, { k2: v2 }]}},
      tricky:stuff
    ]
  }
- [ 1, "quoted", key: value, { key2: val2 }, : nullkey  , :simplevalue ]
- {five: six,seven : 8, key: [1, { sub: k, arr: [ sub2 ] }]}
- k: 1
ff:
  {
  null value,
  another null value:,
  k: {null2:},
  k2: [null3:,null4:],
  "": empty key
  }
types1: [
    1.23015e+3, 12.3015e+02, 1230.15, -.inf, .nan,
    0o14, +12345, -9, 78, 0xC,
    true, FALSE, TruE,
    NULL, null, ~,
    123.456.345
  ]
types2: {
    "bool": {
      "b1": false,
      "b2": TRUE,
      "b3": FalSe
    },
    "float": {
      "exponential": 1230.15,
      "fixed": 1230.15,
      "negative infinity": -.inf,
      "not a number": .nan,
      "scientific": 1230.15
    },
    "int": {
      "baseten": 78,
      "hexadecimal": 12,
      "octal": 12,
      "signed": 12345,
      "signed2": -9
    },
    "null": {
      "null":,
      "null2": Null,
      "null3": ~
    },
    "string": {
      "anythingElse": "ergezrg",
      "notFloat": "123.456.345"
    }
  }
other: { # comment !!
  fu: { nested: "val '\": quoted
  string

  newline" }, 'tro"''is': "quatre",    ? key     with         spaces   : value

  with      spaces     as
  well
  ,
  ?    key
  with

  spaces
  }
```

❯ `yaml::parseFile resources/ok/flow-collections.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='1'
['ff.""']='empty key'
['ff.another null value']='null'
['ff.another null value.tag']='!!null'
['ff.k.null2']='null'
['ff.k.null2.tag']='!!null'
['ff.k2[0].null3']='null'
['ff.k2[0].null3.tag']='!!null'
['ff.k2[1].null4']='null'
['ff.k2[1].null4.tag']='!!null'
['ff.null value']='null'
['ff.null value.tag']='!!null'
['hi[0]']='double
quoted'
['hi[1]']='single quoted'
['hi[2]']='plain text'
['hi[3][0]']='nested'
['hi[4].single']='pair'
['other.fu.nested']='val '"'"'": quoted string
newline'
['other.key     with         spaces']='value
with      spaces     as well'
['other.key with
spaces']='null'
['other.key with
spaces.tag']='!!null'
['other.tro"'is']='quatre'
['thing.length']='4'
['thing[0].five[0][0][0]']='val'
['thing[0].five[1].key.arr[0].k']='v'
['thing[0].five[1].key.arr[1].k2']='v2'
['thing[0].five[2]']='tricky:stuff'
['thing[0].one']='two'
['thing[0].three']='four'
['thing[1][0]']='1'
['thing[1][0].tag']='!!int'
['thing[1][1]']='quoted'
['thing[1][2].key']='value'
['thing[1][3].key2']='val2'
['thing[1][4].null']='nullkey'
['thing[1][5]']=':simplevalue'
['thing[2].five']='six'
['thing[2].key[0]']='1'
['thing[2].key[0].tag']='!!int'
['thing[2].key[1].arr[0]']='sub2'
['thing[2].key[1].sub']='k'
['thing[2].seven']='8'
['thing[2].seven.tag']='!!int'
['thing[3].k']='1'
['thing[3].k.tag']='!!int'
['types1[0]']='1.23015e+3'
['types1[0].tag']='!!float'
['types1[10]']='true'
['types1[10].tag']='!!bool'
['types1[11]']='FALSE'
['types1[11].tag']='!!bool'
['types1[12]']='TruE'
['types1[12].tag']='!!bool'
['types1[13]']='NULL'
['types1[13].tag']='!!null'
['types1[14]']='null'
['types1[14].tag']='!!null'
['types1[15]']='~'
['types1[15].tag']='!!null'
['types1[16]']='123.456.345'
['types1[1]']='12.3015e+02'
['types1[1].tag']='!!float'
['types1[2]']='1230.15'
['types1[2].tag']='!!float'
['types1[3]']='-.inf'
['types1[3].tag']='!!float'
['types1[4]']='.nan'
['types1[4].tag']='!!float'
['types1[5]']='0o14'
['types1[5].tag']='!!int'
['types1[6]']='+12345'
['types1[6].tag']='!!int'
['types1[7]']='-9'
['types1[7].tag']='!!int'
['types1[8]']='78'
['types1[8].tag']='!!int'
['types1[9]']='0xC'
['types1[9].tag']='!!int'
['types2.bool.b1']='false'
['types2.bool.b1.tag']='!!bool'
['types2.bool.b2']='TRUE'
['types2.bool.b2.tag']='!!bool'
['types2.bool.b3']='FalSe'
['types2.bool.b3.tag']='!!bool'
['types2.float.exponential']='1230.15'
['types2.float.exponential.tag']='!!float'
['types2.float.fixed']='1230.15'
['types2.float.fixed.tag']='!!float'
['types2.float.negative infinity']='-.inf'
['types2.float.negative infinity.tag']='!!float'
['types2.float.not a number']='.nan'
['types2.float.not a number.tag']='!!float'
['types2.float.scientific']='1230.15'
['types2.float.scientific.tag']='!!float'
['types2.int.baseten']='78'
['types2.int.baseten.tag']='!!int'
['types2.int.hexadecimal']='12'
['types2.int.hexadecimal.tag']='!!int'
['types2.int.octal']='12'
['types2.int.octal.tag']='!!int'
['types2.int.signed']='12345'
['types2.int.signed.tag']='!!int'
['types2.int.signed2']='-9'
['types2.int.signed2.tag']='!!int'
['types2.null.null']='null'
['types2.null.null.tag']='!!null'
['types2.null.null2']='Null'
['types2.null.null2.tag']='!!null'
['types2.null.null3']='~'
['types2.null.null3.tag']='!!null'
['types2.string.anythingElse']='ergezrg'
['types2.string.notFloat']='123.456.345'
)
```

> cat `resources/ok/json-root-object.yaml`

```text
{
  "config": {
    "features": {
      "autoSave": true,
      "maxItems": 100,
      "notifications": false
    },
    "language": "en",
    "theme": "dark"
  },
  "description": "Privacy-first developer toolbox",
  "metadata": null,
  "name": "ToolBox",
  "tools": [
    "JSON Formatter",
    "Base64",
    "QR Code",
    "Hash Generator"
  ],
  "users": [
    {
      "active": true,
      "id": 1,
      "name": "Alice",
      "scores": [
        95,
        88,
        72
      ]
    },
    {
      "active": false,
      "id": 2,
      "name": "Bob",
      "scores": [
        60,
        75
      ]
    }
  ],
  "version": "1.0.0"
}
```

❯ `yaml::parseFile resources/ok/json-root-object.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='1'
['config.features.autoSave']='true'
['config.features.autoSave.tag']='!!bool'
['config.features.maxItems']='100'
['config.features.maxItems.tag']='!!int'
['config.features.notifications']='false'
['config.features.notifications.tag']='!!bool'
['config.language']='en'
['config.theme']='dark'
['description']='Privacy-first developer toolbox'
['metadata']='null'
['metadata.tag']='!!null'
['name']='ToolBox'
['tools[0]']='JSON Formatter'
['tools[1]']='Base64'
['tools[2]']='QR Code'
['tools[3]']='Hash Generator'
['users[0].active']='true'
['users[0].active.tag']='!!bool'
['users[0].id']='1'
['users[0].id.tag']='!!int'
['users[0].name']='Alice'
['users[0].scores[0]']='95'
['users[0].scores[0].tag']='!!int'
['users[0].scores[1]']='88'
['users[0].scores[1].tag']='!!int'
['users[0].scores[2]']='72'
['users[0].scores[2].tag']='!!int'
['users[1].active']='false'
['users[1].active.tag']='!!bool'
['users[1].id']='2'
['users[1].id.tag']='!!int'
['users[1].name']='Bob'
['users[1].scores[0]']='60'
['users[1].scores[0].tag']='!!int'
['users[1].scores[1]']='75'
['users[1].scores[1].tag']='!!int'
['version']='1.0.0'
)
```

> cat `resources/ok/multidoc.yaml`

```text
---
key: thing
---
key: thing2
---
key: thing3
```

❯ `yaml::parseFile resources/ok/multidoc.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='3'
['@[1].key']='thing2'
['@[2].key']='thing3'
['key']='thing'
)
```

> cat `resources/ok/nulls.yaml`

```text
null   key   :
k:
   null:
nullkeybeforenewdoc:
---
nullkeyattheend:
```

❯ `yaml::parseFile resources/ok/nulls.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='2'
['@[1].nullkeyattheend']='null'
['@[1].nullkeyattheend.tag']='!!null'
['k.null']='null'
['k.null.tag']='!!null'
['null   key']='null'
['null   key.tag']='!!null'
['nullkeybeforenewdoc']='null'
['nullkeybeforenewdoc.tag']='!!null'
)
```

> cat `resources/ok/quoted-multiline-value.yaml`

```text
key  with colons   :::
key with spaces    :    ok
"":
"empty": ""

k: "word1
 word2\"
 word3"
k2: "line1

   line2"
nested:
  arr:
    - '


line1
   line2

'
    - "
word1


word2\"
 word3
    "
  k3: 'v
a
  l''
 u
e'
```

❯ `yaml::parseFile resources/ok/quoted-multiline-value.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['""']='null'
['"".tag']='!!null'
['@.length']='1'
['empty']=''
['k']='word1 word2" word3'
['k2']='line1
line2'
['key  with colons   ::']='null'
['key  with colons   ::.tag']='!!null'
['key with spaces']='ok'
['nested.arr.length']='2'
['nested.arr[0]']='

line1 line2
'
['nested.arr[1]']='word1

word2" word3 '
['nested.k3']='v a l'"'"' u e'
)
```

> cat `resources/ok/root-array.yaml`

```text
- source:
    name: argo-cd
    repo: https://argoproj.github.io/argo-helm
    version: 9.5.15
  targets:
    - oci://srescloud.azurecr.io/helm
- source:
    name: cert-manager
    repo: https://charts.jetstack.io
    version: v1.14.5
  targets:
    - oci://srescloud.azurecr.io/helm
    - oci://secondtarget.azurecr.io/helm
    - oci://thirdtarget.azurecr.io/helm
- source:
    name: cilium
    repo: https://helm.cilium.io/
    version: 1.19.4
  targets:
    - oci://thing.azurecr.io/helm
```

❯ `yaml::parseFile resources/ok/root-array.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='1'
['[0].source.name']='argo-cd'
['[0].source.repo']='https://argoproj.github.io/argo-helm'
['[0].source.version']='9.5.15'
['[0].targets.length']='1'
['[0].targets[0]']='oci://srescloud.azurecr.io/helm'
['[1].source.name']='cert-manager'
['[1].source.repo']='https://charts.jetstack.io'
['[1].source.version']='v1.14.5'
['[1].targets.length']='3'
['[1].targets[0]']='oci://srescloud.azurecr.io/helm'
['[1].targets[1]']='oci://secondtarget.azurecr.io/helm'
['[1].targets[2]']='oci://thirdtarget.azurecr.io/helm'
['[2].source.name']='cilium'
['[2].source.repo']='https://helm.cilium.io/'
['[2].source.version']='1.19.4'
['[2].targets.length']='1'
['[2].targets[0]']='oci://thing.azurecr.io/helm'
['length']='3'
)
```

> cat `resources/ok/simple.yaml`

```text
# comment
# Keys with special characters
---
"key with spaces": value
"key:with:colons": value
num[0].key: 1

arr:
- thing
- stuff:with:colons

nested:
  arr:
    - name: obj1
      value: 123
      array:
      - thing
      - arr:
        - 1
        - 2
    - name: obj2
      value: 456
      properties:
        - 1
        - 2
    - "coucou text"
    - nom mais allo
  thing: true

key: https://example.com #:

num:
  - key: 2

strings: #comment
  "plain": hello world #comment
  single_quoted    :   'hello ''world'' #notacomment' #comment #zefzef
  with_single_quote:   "C'est \"quoi" #comment
  double_quoted: "line1\nline2\tunicode:\u2764" #comment
  empty: ""
  empty2:
  multiline_literal: | #comment
    line one
    line two
      indented

  multiline_folded: >
    a


    this text
    is folded
    into a single line
  content: |-
    Or we


    can auto
    convert line breaks



    to save space
  foldedWithIndentation: >-
    Sammy Sosa completed another
    fine season with great stats.

      63 Home Runs
      0.288 Batting Average

    What a year!
  keepEol: |+
    this will keep the trailing lines


  folded: >-

    a

    word please
    ?
endingMultiline: |


  first line
  second line
```

❯ `yaml::parseFile resources/ok/simple.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['"num[0].key"']='1'
['"num[0].key".tag']='!!int'
['@.length']='1'
['arr.length']='2'
['arr[0]']='thing'
['arr[1]']='stuff:with:colons'
['endingMultiline']='

first line
second line
'
['key']='https://example.com'
['key with spaces']='value'
['key:with:colons']='value'
['nested.arr.length']='4'
['nested.arr[0].array.length']='2'
['nested.arr[0].array[0]']='thing'
['nested.arr[0].array[1].arr.length']='2'
['nested.arr[0].array[1].arr[0]']='1'
['nested.arr[0].array[1].arr[0].tag']='!!int'
['nested.arr[0].array[1].arr[1]']='2'
['nested.arr[0].array[1].arr[1].tag']='!!int'
['nested.arr[0].name']='obj1'
['nested.arr[0].value']='123'
['nested.arr[0].value.tag']='!!int'
['nested.arr[1].name']='obj2'
['nested.arr[1].properties.length']='2'
['nested.arr[1].properties[0]']='1'
['nested.arr[1].properties[0].tag']='!!int'
['nested.arr[1].properties[1]']='2'
['nested.arr[1].properties[1].tag']='!!int'
['nested.arr[1].value']='456'
['nested.arr[1].value.tag']='!!int'
['nested.arr[2]']='coucou text'
['nested.arr[3]']='nom mais allo'
['nested.thing']='true'
['nested.thing.tag']='!!bool'
['num.length']='1'
['num[0].key']='2'
['num[0].key.tag']='!!int'
['strings.content']='Or we


can auto
convert line breaks



to save space'
['strings.double_quoted']='line1
line2	unicode:❤'
['strings.empty']=''
['strings.empty2']='null'
['strings.empty2.tag']='!!null'
['strings.folded']='
a

word please ?'
['strings.foldedWithIndentation']='Sammy Sosa completed another fine season with great stats.

  63 Home Runs
  0.288 Batting Average

What a year!'
['strings.keepEol']='this will keep the trailing lines


'
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

> cat `resources/ok/single-line-nested-arrays.yaml`

```text
- - baz
  - k: v
  -        - a
           - b
  -   -
       key: ok
  - -
       1
  - 2
- 1
- "- not an array"
```

❯ `yaml::parseFile resources/ok/single-line-nested-arrays.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='1'
['[0].length']='6'
['[0][0]']='baz'
['[0][1].k']='v'
['[0][2].length']='2'
['[0][2][0]']='a'
['[0][2][1]']='b'
['[0][3].length']='1'
['[0][3][0].key']='ok'
['[0][4].length']='1'
['[0][4][0]']='1'
['[0][4][0].tag']='!!int'
['[0][5]']='2'
['[0][5].tag']='!!int'
['[1]']='1'
['[1].tag']='!!int'
['[2]']='- not an array'
['length']='3'
)
```

> cat `resources/ok/single-scalar1.yaml`

```text
my text
```

❯ `yaml::parseFile resources/ok/single-scalar1.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='1'
['@[0]']='my text'
)
```

> cat `resources/ok/single-scalar2.yaml`

```text
|+
 line1
 line2

# end
```

❯ `yaml::parseFile resources/ok/single-scalar2.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='1'
['@[0]']='line1
line2

'
)
```

> cat `resources/ok/single-scalar3.yaml`

```text
"word1
  word2
word3"
```

❯ `yaml::parseFile resources/ok/single-scalar3.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='1'
['@[0]']='word1 word2 word3'
)
```

> cat `resources/ok/single-scalar4.yaml`

```text
--- text
```

❯ `yaml::parseFile resources/ok/single-scalar4.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='1'
['@[0]']='text'
)
```

> cat `resources/ok/tags.yaml`

```text
%YAML 1.2
%TAG !e! tag:example.com,2000:app/
# https://perlpunk.github.io/yaml-test-schema/schemas.html
---
bool: # !!bool
  b1: false # true | True | TRUE | false | False | FALSE
  b2: TRUE
  b3: False
custom:
  application specific tag:      !e!tag     |
    The semantics of the tag
    above may be different for
    different documents.
  picture:   !!binary    xxxx
explicitTypes:
  - ! 123
  - !!str    "123"
  - !!int "123"
  -
    !!float
    "123.45"
  -    !!bool   "true"
  - !!null
float: # !!float
  scientific: 1.23015e+3
  exponential: 12.3015e+02
  fixed: 1230.15 # [-+]? ( \. [0-9]+ | [0-9]+ ( \. [0-9]* )? ) ( [eE] [-+]? [0-9]+ )?
  negative infinity: -.inf # [-+]? \. ( inf | Inf | INF )
  not a number: .nan # \. ( nan | NaN |NAN )
int: # !!int
  octal: 0o14 # 0o [0-7]+
  signed: +12345 # [-+]? [0-9]+
  signed2: -9
  baseten: 78
  hexadecimal: 0xC # 0x [0-9a-fA-F]+
null: # !!null
  null:
  null2: null # null | Null | NULL | ~
  null3: ~
string: # !!str
  anythingElse: ergezrg
  notFloat: 123.456.345
  s:
    !
    example

```

❯ `yaml::parseFile resources/ok/tags.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='1'
['bool.b1']='false'
['bool.b1.tag']='!!bool'
['bool.b2']='TRUE'
['bool.b2.tag']='!!bool'
['bool.b3']='False'
['bool.b3.tag']='!!bool'
['custom.application specific tag']='The semantics of the tag
above may be different for
different documents.
'
['custom.application specific tag.tag']='!e!tag'
['custom.picture']='xxxx'
['custom.picture.tag']='!!binary'
['explicitTypes.length']='6'
['explicitTypes[0]']='123'
['explicitTypes[1]']='123'
['explicitTypes[2]']='123'
['explicitTypes[2].tag']='!!int'
['explicitTypes[3]']='123.45'
['explicitTypes[3].tag']='!!float'
['explicitTypes[4]']='true'
['explicitTypes[4].tag']='!!bool'
['explicitTypes[5]']='null'
['explicitTypes[5].tag']='!!null'
['float.exponential']='12.3015e+02'
['float.exponential.tag']='!!float'
['float.fixed']='1230.15'
['float.fixed.tag']='!!float'
['float.negative infinity']='-.inf'
['float.negative infinity.tag']='!!float'
['float.not a number']='.nan'
['float.not a number.tag']='!!float'
['float.scientific']='1.23015e+3'
['float.scientific.tag']='!!float'
['int.baseten']='78'
['int.baseten.tag']='!!int'
['int.hexadecimal']='0xC'
['int.hexadecimal.tag']='!!int'
['int.octal']='0o14'
['int.octal.tag']='!!int'
['int.signed']='+12345'
['int.signed.tag']='!!int'
['int.signed2']='-9'
['int.signed2.tag']='!!int'
['null.null']='null'
['null.null.tag']='!!null'
['null.null2']='null'
['null.null2.tag']='!!null'
['null.null3']='~'
['null.null3.tag']='!!null'
['string.anythingElse']='ergezrg'
['string.notFloat']='123.456.345'
['string.s']='example'
)
```

> cat `resources/ok/tricky.yaml`

```text
k1: "trap: not value" # trap: not value
k2: 'trap: not value' # trap: not value
k3: # trap: not value
  - "- - not an array" # - - not arrays
  - '- - not an array' # - - not arrays
  - # - - not arrays
    "- - not an array"
```

❯ `yaml::parseFile resources/ok/tricky.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='1'
['k1']='trap: not value'
['k2']='trap: not value'
['k3.length']='3'
['k3[0]']='- - not an array'
['k3[1]']='- - not an array'
['k3[2]']='- - not an array'
)
```

### ✅ Testing KO yaml::parseFile function

> cat `resources/ko/mix-array-key.yaml`

```text
nested:
 - arr: 1
 key: value
```

❯ `yaml::parseFile resources/ko/mix-array-key.yaml`

Exited with code: `1`

**Error output**:

```text
FAIL     Error parsing YAML file ⌜resources/ko/mix-array-key.yaml⌝ at line 3: invalid indentation (expected one of (0.3) but got 1)..
```

### ✅ Testing yaml::parseFile with options

❯ `yaml::parseFile resources/ok/single-line-nested-arrays.yaml prefixFirstDoc=true`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='1'
['@[0].length']='3'
['@[0][0].length']='6'
['@[0][0][0]']='baz'
['@[0][0][1].k']='v'
['@[0][0][2].length']='2'
['@[0][0][2][0]']='a'
['@[0][0][2][1]']='b'
['@[0][0][3].length']='1'
['@[0][0][3][0].key']='ok'
['@[0][0][4].length']='1'
['@[0][0][4][0]']='1'
['@[0][0][4][0].tag']='!!int'
['@[0][0][5]']='2'
['@[0][0][5].tag']='!!int'
['@[0][1]']='1'
['@[0][1].tag']='!!int'
['@[0][2]']='- not an array'
)
```

❯ `yaml::parseFile resources/ok/any-indent.yaml prefixFirstDoc=true`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='1'
['@[0].key.1indent.now2.and1again.now4']='v'
['@[0].key.1indent.now2.arr.length']='3'
['@[0].key.1indent.now2.arr2.length']='3'
['@[0].key.1indent.now2.arr2[0]']='1'
['@[0].key.1indent.now2.arr2[0].tag']='!!int'
['@[0].key.1indent.now2.arr2[1]']='2'
['@[0].key.1indent.now2.arr2[1].tag']='!!int'
['@[0].key.1indent.now2.arr2[2]']='3'
['@[0].key.1indent.now2.arr2[2].tag']='!!int'
['@[0].key.1indent.now2.arr[0]']='1'
['@[0].key.1indent.now2.arr[0].tag']='!!int'
['@[0].key.1indent.now2.arr[1]']='2'
['@[0].key.1indent.now2.arr[1].tag']='!!int'
['@[0].key.1indent.now2.arr[2]']='3'
['@[0].key.1indent.now2.arr[2].tag']='!!int'
['@[0].normal.length']='7'
['@[0].normal[0].item']='Super Hoop'
['@[0].normal[0].quantity']='1'
['@[0].normal[0].quantity.tag']='!!int'
['@[0].normal[1]']='Sammy Sosa completed another fine season with great stats.

  63 Home Runs
  0.288 Batting Average

What a year!
'
['@[0].normal[2].avg']='0.278'
['@[0].normal[2].avg.tag']='!!float'
['@[0].normal[2].hr']='65'
['@[0].normal[2].hr.tag']='!!int'
['@[0].normal[2].name']='Mark McGwire'
['@[0].normal[3]']=' explicit
'
['@[0].normal[4]']='explicit
'
['@[0].normal[5]']='  explicit
'
['@[0].normal[6].key']='1'
['@[0].normal[6].key.tag']='!!int'
)
```

