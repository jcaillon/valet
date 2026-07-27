# Test suite lib-yaml

## Test script 00.lib-yaml

### ✅ Testing yaml::parseFile function

> cat `resources/ok/a-complete-example.yaml`

```text
%YAML 1.2
---
coordinates: &point
  x: 1
  y: 2
element:
  alias: !!str 3
  description: |
    This is a multi-line description
    that can span multiple lines.
  labels: >-
    front
    red
    bold
  name: &name example
  opacity: 0.567
  parent: null
  position: *point
  tags:
    - # first tag
      tag1
    - tag2
    - *name
    - # another tag
      # with key/value
      key:
        # value
        tag4
  visible: true
jsonLike: {
    "key": value,
    arr: [ "Support json like syntax (yaml flow collections)", ],
  }
sphere:
  <<: [ *point ]
  z: 1
  r: 9.23
---
simple scalar
---
nullValue:
secondNullValue:
```

❯ `yaml::parseFile resources/ok/a-complete-example.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@[1]']='simple scalar'
['@[1].nullValue']='null'
['@[1].secondNullValue']='null'
['coordinates.x']='1'
['coordinates.y']='2'
['element.alias']='3'
['element.description']='This is a multi-line description
that can span multiple lines.
'
['element.labels']='front red bold'
['element.name']='example'
['element.opacity']='0.567'
['element.parent']='null'
['element.position.x']='1'
['element.position.y']='2'
['element.tags[0]']='tag1'
['element.tags[1]']='tag2'
['element.tags[2]']='example'
['element.tags[3].key']='tag4'
['element.visible']='true'
['jsonLike.arr[0]']='Support json like syntax (yaml flow collections)'
['jsonLike.key']='value'
['sphere.r']='9.23'
['sphere.x']='1'
['sphere.y']='2'
['sphere.z']='1'
)
REPLY_MAP2=(
['@.length']='2'
['@[1].nullValue']='!!null'
['@[1].secondNullValue']='!!null'
['coordinates.x']='!!int'
['coordinates.y']='!!int'
['element.opacity']='!!float'
['element.parent']='!!null'
['element.position.x']='!!int'
['element.position.y']='!!int'
['element.tags.length']='4'
['element.visible']='!!bool'
['jsonLike.arr.length']='1'
['sphere.r']='!!float'
['sphere.x']='!!int'
['sphere.y']='!!int'
['sphere.z']='!!int'
)
```

> cat `resources/ok/aliases.yaml`

```text
- key: !!str  &val1 value 1
- anotherKey:   *val1
- overrideKey1:
  - &val1 value 2
- anotherKey2: *val1
- int1: &int1  !!int 1
- copiedInt: *int1
- obj1suffix: &array1
  - *val1
  - true
- obj1: &obj1
    key1: value 1
    key2: *array1
- obj2: *obj1
```

❯ `yaml::parseFile resources/ok/aliases.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['[0].key']='value 1'
['[1].anotherKey']='value 1'
['[2].overrideKey1[0]']='value 2'
['[3].anotherKey2']='value 2'
['[4].int1']='1'
['[5].copiedInt']='1'
['[6].obj1suffix[0]']='value 2'
['[6].obj1suffix[1]']='true'
['[7].obj1.key1']='value 1'
['[7].obj1.key2[0]']='value 2'
['[7].obj1.key2[1]']='true'
['[8].obj2.key1']='value 1'
['[8].obj2.key2[0]']='value 2'
['[8].obj2.key2[1]']='true'
)
REPLY_MAP2=(
['@.length']='1'
['[2].overrideKey1.length']='1'
['[4].int1']='!!int'
['[5].copiedInt']='!!int'
['[6].obj1suffix.length']='2'
['[6].obj1suffix[1]']='!!bool'
['[7].obj1.key2.length']='2'
['[7].obj1.key2[1]']='!!bool'
['[8].obj2.key2.length']='2'
['[8].obj2.key2[1]']='!!bool'
['length']='9'
)
```

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
['key.1indent.now2.and1again.now4']='v'
['key.1indent.now2.arr2[0]']='1'
['key.1indent.now2.arr2[1]']='2'
['key.1indent.now2.arr2[2]']='3'
['key.1indent.now2.arr[0]']='1'
['key.1indent.now2.arr[1]']='2'
['key.1indent.now2.arr[2]']='3'
['normal[0].item']='Super Hoop'
['normal[0].quantity']='1'
['normal[1]']='Sammy Sosa completed another fine season with great stats.

  63 Home Runs
  0.288 Batting Average

What a year!
'
['normal[2].avg']='0.278'
['normal[2].hr']='65'
['normal[2].name']='Mark McGwire'
['normal[3]']=' explicit
'
['normal[4]']='explicit
'
['normal[5]']='  explicit
'
['normal[6].key']='1'
)
REPLY_MAP2=(
['@.length']='1'
['key.1indent.now2.arr.length']='3'
['key.1indent.now2.arr2.length']='3'
['key.1indent.now2.arr2[0]']='!!int'
['key.1indent.now2.arr2[1]']='!!int'
['key.1indent.now2.arr2[2]']='!!int'
['key.1indent.now2.arr[0]']='!!int'
['key.1indent.now2.arr[1]']='!!int'
['key.1indent.now2.arr[2]']='!!int'
['normal.length']='7'
['normal[0].quantity']='!!int'
['normal[2].avg']='!!float'
['normal[2].hr']='!!int'
['normal[6].key']='!!int'
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
['last']='value'
['nested.arr2[0].array[0]']='thing'
['nested.arr2[0].array[1]']='stuff'
['nested.arr2[0].array[2].arr[0]']='here'
['nested.arr2[0].name']='obj1'
['nested.arr2[1].name']='obj2'
['nested.arr[0].key']='thing'
['thing']='first line
  second line with indent'
)
REPLY_MAP2=(
['@.length']='1'
['nested.arr.length']='1'
['nested.arr2.length']='2'
['nested.arr2[0].array.length']='3'
['nested.arr2[0].array[2].arr.length']='1'
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
- # test
  a: [
    1,
    2
  ]
  b: 3
- # test
  a: { b: 1}
  c: 2
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
arrayLengths: {
    arr0: [],
    arr1: [ one ],
    arr2: [ 1, 2 ],
    arr3: [ 1, 2, 3, ],
  }
```

❯ `yaml::parseFile resources/ok/flow-collections.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['arrayLengths.arr1[0]']='one'
['arrayLengths.arr2[0]']='1'
['arrayLengths.arr2[1]']='2'
['arrayLengths.arr3[0]']='1'
['arrayLengths.arr3[1]']='2'
['arrayLengths.arr3[2]']='3'
['ff.""']='empty key'
['ff.another null value']='null'
['ff.k.null2']='null'
['ff.k2[0].null3']='null'
['ff.k2[1].null4']='null'
['ff.null value']='null'
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
['other.tro"'is']='quatre'
['thing[0].five[0][0][0]']='val'
['thing[0].five[1].key.arr[0].k']='v'
['thing[0].five[1].key.arr[1].k2']='v2'
['thing[0].five[2]']='tricky:stuff'
['thing[0].one']='two'
['thing[0].three']='four'
['thing[1][0]']='1'
['thing[1][1]']='quoted'
['thing[1][2].key']='value'
['thing[1][3].key2']='val2'
['thing[1][4].null']='nullkey'
['thing[1][5]']=':simplevalue'
['thing[2].five']='six'
['thing[2].key[0]']='1'
['thing[2].key[1].arr[0]']='sub2'
['thing[2].key[1].sub']='k'
['thing[2].seven']='8'
['thing[3].k']='1'
['thing[4].a[0]']='1'
['thing[4].a[1]']='2'
['thing[4].b']='3'
['thing[5].a.b']='1'
['thing[5].c']='2'
['types1[0]']='1.23015e+3'
['types1[10]']='true'
['types1[11]']='FALSE'
['types1[12]']='TruE'
['types1[13]']='NULL'
['types1[14]']='null'
['types1[15]']='~'
['types1[16]']='123.456.345'
['types1[1]']='12.3015e+02'
['types1[2]']='1230.15'
['types1[3]']='-.inf'
['types1[4]']='.nan'
['types1[5]']='0o14'
['types1[6]']='+12345'
['types1[7]']='-9'
['types1[8]']='78'
['types1[9]']='0xC'
['types2.bool.b1']='false'
['types2.bool.b2']='TRUE'
['types2.bool.b3']='FalSe'
['types2.float.exponential']='1230.15'
['types2.float.fixed']='1230.15'
['types2.float.negative infinity']='-.inf'
['types2.float.not a number']='.nan'
['types2.float.scientific']='1230.15'
['types2.int.baseten']='78'
['types2.int.hexadecimal']='12'
['types2.int.octal']='12'
['types2.int.signed']='12345'
['types2.int.signed2']='-9'
['types2.null.null']='null'
['types2.null.null2']='Null'
['types2.null.null3']='~'
['types2.string.anythingElse']='ergezrg'
['types2.string.notFloat']='123.456.345'
)
REPLY_MAP2=(
['@.length']='1'
['arrayLengths.arr0.length']='0'
['arrayLengths.arr1.length']='1'
['arrayLengths.arr2.length']='2'
['arrayLengths.arr2[0]']='!!int'
['arrayLengths.arr2[1]']='!!int'
['arrayLengths.arr3.length']='3'
['arrayLengths.arr3[0]']='!!int'
['arrayLengths.arr3[1]']='!!int'
['arrayLengths.arr3[2]']='!!int'
['ff.another null value']='!!null'
['ff.k.null2']='!!null'
['ff.k2.length']='2'
['ff.k2[0].null3']='!!null'
['ff.k2[1].null4']='!!null'
['ff.null value']='!!null'
['hi.length']='5'
['hi[3].length']='1'
['other.key with
spaces']='!!null'
['thing.length']='6'
['thing[0].five.length']='3'
['thing[0].five[0].length']='1'
['thing[0].five[0][0].length']='1'
['thing[0].five[1].key.arr.length']='2'
['thing[1].length']='6'
['thing[1][0]']='!!int'
['thing[2].key.length']='2'
['thing[2].key[0]']='!!int'
['thing[2].key[1].arr.length']='1'
['thing[2].seven']='!!int'
['thing[3].k']='!!int'
['thing[4].a.length']='2'
['thing[4].a[0]']='!!int'
['thing[4].a[1]']='!!int'
['thing[4].b']='!!int'
['thing[5].a.b']='!!int'
['thing[5].c']='!!int'
['types1.length']='17'
['types1[0]']='!!float'
['types1[10]']='!!bool'
['types1[11]']='!!bool'
['types1[12]']='!!bool'
['types1[13]']='!!null'
['types1[14]']='!!null'
['types1[15]']='!!null'
['types1[1]']='!!float'
['types1[2]']='!!float'
['types1[3]']='!!float'
['types1[4]']='!!float'
['types1[5]']='!!int'
['types1[6]']='!!int'
['types1[7]']='!!int'
['types1[8]']='!!int'
['types1[9]']='!!int'
['types2.bool.b1']='!!bool'
['types2.bool.b2']='!!bool'
['types2.bool.b3']='!!bool'
['types2.float.exponential']='!!float'
['types2.float.fixed']='!!float'
['types2.float.negative infinity']='!!float'
['types2.float.not a number']='!!float'
['types2.float.scientific']='!!float'
['types2.int.baseten']='!!int'
['types2.int.hexadecimal']='!!int'
['types2.int.octal']='!!int'
['types2.int.signed']='!!int'
['types2.int.signed2']='!!int'
['types2.null.null']='!!null'
['types2.null.null2']='!!null'
['types2.null.null3']='!!null'
)
```

> cat `resources/ok/full.yaml`

```text
# Scalars
strings:
  plain: hello world
  single_quoted: 'hello ''world'''
  with_single_quote: "C'est \"quoi"
  double_quoted: "line1\nline2\tunicode:\u2764"
  empty: ""
  multiline_literal: |
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
  to save spac

num[0].zzef: 1
num:
  - zzef: 2

# Keys with special characters
"key with spaces": value
"key:with:colons": value

arr:
  - name: obj1
    value: 123
  - name: obj2
    value: 456
    properties:
      - 1
      - 2

numbers:
  integer: 42
  negative: -17
  zero: 0
  float: 3.14159
  exponent: 1.23e+10

other:
  bool: true

special_strings:
  looks_like_bool: "true"
  looks_like_number: "123"
  colon: "a:b"
  hash: "# not a comment"

# Sequences
sequence:
  - item1
  - item2
  - 123
  - true
  - null
  - [1, 2, 3]
  - {a: 1, b: 2}

# Mixed nesting
nested:
  users:
    - id: 1
      name: Alice
      roles: [admin, user]
    - id: 2
      name: Bob
      roles:
        - user

# Anchors and aliases
defaults: &defaults
  host: localhost
  port: 8080
  ssl: false

server1:
  <<: *defaults
  port: 8081

server2:
  <<: *defaults

# Anchors on sequences
colors: &colors
  - red
  - green
  - blue

favorite_colors: *colors

# Empty collections
empty_sequence: []
empty_mapping: {}
```

❯ `yaml::parseFile resources/ok/full.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['"num[0].zzef"']='1'
['arr[0].name']='obj1'
['arr[0].value']='123'
['arr[1].name']='obj2'
['arr[1].properties[0]']='1'
['arr[1].properties[1]']='2'
['arr[1].value']='456'
['colors[0]']='red'
['colors[1]']='green'
['colors[2]']='blue'
['content']='Or we
can auto
convert line breaks
to save spac'
['defaults.host']='localhost'
['defaults.port']='8080'
['defaults.ssl']='false'
['favorite_colors[0]']='red'
['favorite_colors[1]']='green'
['favorite_colors[2]']='blue'
['key with spaces']='value'
['key:with:colons']='value'
['nested.users[0].id']='1'
['nested.users[0].name']='Alice'
['nested.users[0].roles[0]']='admin'
['nested.users[0].roles[1]']='user'
['nested.users[1].id']='2'
['nested.users[1].name']='Bob'
['nested.users[1].roles[0]']='user'
['num[0].zzef']='2'
['numbers.exponent']='1.23e+10'
['numbers.float']='3.14159'
['numbers.integer']='42'
['numbers.negative']='-17'
['numbers.zero']='0'
['other.bool']='true'
['sequence[0]']='item1'
['sequence[1]']='item2'
['sequence[2]']='123'
['sequence[3]']='true'
['sequence[4]']='null'
['sequence[5][0]']='1'
['sequence[5][1]']='2'
['sequence[5][2]']='3'
['sequence[6].a']='1'
['sequence[6].b']='2'
['server1.host']='localhost'
['server1.port']='8081'
['server1.ssl']='false'
['server2.host']='localhost'
['server2.port']='8080'
['server2.ssl']='false'
['special_strings.colon']='a:b'
['special_strings.hash']='# not a comment'
['special_strings.looks_like_bool']='true'
['special_strings.looks_like_number']='123'
['strings.double_quoted']='line1
line2	unicode:❤'
['strings.empty']=''
['strings.multiline_folded']='a this text is folded into a single line
'
['strings.multiline_literal']='line one
line two
  indented
'
['strings.plain']='hello world'
['strings.single_quoted']='hello '"'"'world'"'"''
['strings.with_single_quote']='C'"'"'est "quoi'
)
REPLY_MAP2=(
['"num[0].zzef"']='!!int'
['@.length']='1'
['arr.length']='2'
['arr[0].value']='!!int'
['arr[1].properties.length']='2'
['arr[1].properties[0]']='!!int'
['arr[1].properties[1]']='!!int'
['arr[1].value']='!!int'
['colors.length']='3'
['defaults.port']='!!int'
['defaults.ssl']='!!bool'
['empty_sequence.length']='0'
['favorite_colors.length']='3'
['nested.users.length']='2'
['nested.users[0].id']='!!int'
['nested.users[0].roles.length']='2'
['nested.users[1].id']='!!int'
['nested.users[1].roles.length']='1'
['num.length']='1'
['num[0].zzef']='!!int'
['numbers.exponent']='!!float'
['numbers.float']='!!float'
['numbers.integer']='!!int'
['numbers.negative']='!!int'
['numbers.zero']='!!int'
['other.bool']='!!bool'
['sequence.length']='7'
['sequence[2]']='!!int'
['sequence[3]']='!!bool'
['sequence[4]']='!!null'
['sequence[5].length']='3'
['sequence[5][0]']='!!int'
['sequence[5][1]']='!!int'
['sequence[5][2]']='!!int'
['sequence[6].a']='!!int'
['sequence[6].b']='!!int'
['server1.port']='!!int'
['server1.ssl']='!!bool'
['server2.port']='!!int'
['server2.ssl']='!!bool'
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
      "scores": []
    },
    {
      "active": true,
      "id": 3,
      "name": "Jack",
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
['config.features.autoSave']='true'
['config.features.maxItems']='100'
['config.features.notifications']='false'
['config.language']='en'
['config.theme']='dark'
['description']='Privacy-first developer toolbox'
['metadata']='null'
['name']='ToolBox'
['tools[0]']='JSON Formatter'
['tools[1]']='Base64'
['tools[2]']='QR Code'
['tools[3]']='Hash Generator'
['users[0].active']='true'
['users[0].id']='1'
['users[0].name']='Alice'
['users[0].scores[0]']='95'
['users[0].scores[1]']='88'
['users[0].scores[2]']='72'
['users[1].active']='false'
['users[1].id']='2'
['users[1].name']='Bob'
['users[2].active']='true'
['users[2].id']='3'
['users[2].name']='Jack'
['users[2].scores[0]']='60'
['users[2].scores[1]']='75'
['version']='1.0.0'
)
REPLY_MAP2=(
['@.length']='1'
['config.features.autoSave']='!!bool'
['config.features.maxItems']='!!int'
['config.features.notifications']='!!bool'
['metadata']='!!null'
['tools.length']='4'
['users.length']='3'
['users[0].active']='!!bool'
['users[0].id']='!!int'
['users[0].scores.length']='3'
['users[0].scores[0]']='!!int'
['users[0].scores[1]']='!!int'
['users[0].scores[2]']='!!int'
['users[1].active']='!!bool'
['users[1].id']='!!int'
['users[1].scores.length']='0'
['users[2].active']='!!bool'
['users[2].id']='!!int'
['users[2].scores.length']='2'
['users[2].scores[0]']='!!int'
['users[2].scores[1]']='!!int'
)
```

> cat `resources/ok/merge-keys.yaml`

```text
---
- &CENTER
  x: 1
  y: 2
- &LEFT { x: 0, y: 2 }
- &BIG { r: 10 }
- &SMALL { r: 1 }

- # Explicit keys
  x: 1
  y: 2
  r: 10
  label: center/big

- # Merge one map
  << : *CENTER
  r: 10
  label: center/big

- # Merge multiple maps
  << : [
      *CENTER,
      *BIG
      ]
  label: center/big

- # Override
  << : [ *BIG, *LEFT, *SMALL ]
  x: 1
  label: left/big

- objects:
    first:
      <<: *CENTER
      r: 9
    second:
      <<: [
        *CENTER,
        *BIG
      ]

- &LIST
  - x: 1
  - "value"
  - []
- <<: *LIST
```

❯ `yaml::parseFile resources/ok/merge-keys.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['[0].x']='1'
['[0].y']='2'
['[10][0].x']='1'
['[10][1]']='value'
['[1].x']='0'
['[1].y']='2'
['[2].r']='10'
['[3].r']='1'
['[4].label']='center/big'
['[4].r']='10'
['[4].x']='1'
['[4].y']='2'
['[5].label']='center/big'
['[5].r']='10'
['[5].x']='1'
['[5].y']='2'
['[6].label']='center/big'
['[6].r']='10'
['[6].x']='1'
['[6].y']='2'
['[7].label']='left/big'
['[7].r']='1'
['[7].x']='1'
['[7].y']='2'
['[8].objects.first.r']='9'
['[8].objects.first.x']='1'
['[8].objects.first.y']='2'
['[8].objects.second.r']='10'
['[8].objects.second.x']='1'
['[8].objects.second.y']='2'
['[9][0].x']='1'
['[9][1]']='value'
)
REPLY_MAP2=(
['@.length']='1'
['[0].x']='!!int'
['[0].y']='!!int'
['[10].length']='3'
['[10][0].x']='!!int'
['[10][2].length']='0'
['[1].x']='!!int'
['[1].y']='!!int'
['[2].r']='!!int'
['[3].r']='!!int'
['[4].r']='!!int'
['[4].x']='!!int'
['[4].y']='!!int'
['[5].r']='!!int'
['[5].x']='!!int'
['[5].y']='!!int'
['[6].r']='!!int'
['[6].x']='!!int'
['[6].y']='!!int'
['[7].r']='!!int'
['[7].x']='!!int'
['[7].y']='!!int'
['[8].objects.first.r']='!!int'
['[8].objects.first.x']='!!int'
['[8].objects.first.y']='!!int'
['[8].objects.second.r']='!!int'
['[8].objects.second.x']='!!int'
['[8].objects.second.y']='!!int'
['[9].length']='3'
['[9][0].x']='!!int'
['[9][2].length']='0'
['length']='11'
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
['@[1].key']='thing2'
['@[2].key']='thing3'
['key']='thing'
)
REPLY_MAP2=(
['@.length']='3'
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
['@[1].nullkeyattheend']='null'
['k.null']='null'
['null   key']='null'
['nullkeybeforenewdoc']='null'
)
REPLY_MAP2=(
['@.length']='2'
['@[1].nullkeyattheend']='!!null'
['k.null']='!!null'
['null   key']='!!null'
['nullkeybeforenewdoc']='!!null'
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
['empty']=''
['k']='word1 word2" word3'
['k2']='line1
line2'
['key  with colons   ::']='null'
['key with spaces']='ok'
['nested.arr[0]']='

line1 line2
'
['nested.arr[1]']='word1

word2" word3 '
['nested.k3']='v a l'"'"' u e'
)
REPLY_MAP2=(
['""']='!!null'
['@.length']='1'
['key  with colons   ::']='!!null'
['nested.arr.length']='2'
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
['[0].source.name']='argo-cd'
['[0].source.repo']='https://argoproj.github.io/argo-helm'
['[0].source.version']='9.5.15'
['[0].targets[0]']='oci://srescloud.azurecr.io/helm'
['[1].source.name']='cert-manager'
['[1].source.repo']='https://charts.jetstack.io'
['[1].source.version']='v1.14.5'
['[1].targets[0]']='oci://srescloud.azurecr.io/helm'
['[1].targets[1]']='oci://secondtarget.azurecr.io/helm'
['[1].targets[2]']='oci://thirdtarget.azurecr.io/helm'
['[2].source.name']='cilium'
['[2].source.repo']='https://helm.cilium.io/'
['[2].source.version']='1.19.4'
['[2].targets[0]']='oci://thing.azurecr.io/helm'
)
REPLY_MAP2=(
['@.length']='1'
['[0].targets.length']='1'
['[1].targets.length']='3'
['[2].targets.length']='1'
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
['arr[0]']='thing'
['arr[1]']='stuff:with:colons'
['endingMultiline']='

first line
second line
'
['key']='https://example.com'
['key with spaces']='value'
['key:with:colons']='value'
['nested.arr[0].array[0]']='thing'
['nested.arr[0].array[1].arr[0]']='1'
['nested.arr[0].array[1].arr[1]']='2'
['nested.arr[0].name']='obj1'
['nested.arr[0].value']='123'
['nested.arr[1].name']='obj2'
['nested.arr[1].properties[0]']='1'
['nested.arr[1].properties[1]']='2'
['nested.arr[1].value']='456'
['nested.arr[2]']='coucou text'
['nested.arr[3]']='nom mais allo'
['nested.thing']='true'
['num[0].key']='2'
['strings.content']='Or we


can auto
convert line breaks



to save space'
['strings.double_quoted']='line1
line2	unicode:❤'
['strings.empty']=''
['strings.empty2']='null'
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
REPLY_MAP2=(
['"num[0].key"']='!!int'
['@.length']='1'
['arr.length']='2'
['nested.arr.length']='4'
['nested.arr[0].array.length']='2'
['nested.arr[0].array[1].arr.length']='2'
['nested.arr[0].array[1].arr[0]']='!!int'
['nested.arr[0].array[1].arr[1]']='!!int'
['nested.arr[0].value']='!!int'
['nested.arr[1].properties.length']='2'
['nested.arr[1].properties[0]']='!!int'
['nested.arr[1].properties[1]']='!!int'
['nested.arr[1].value']='!!int'
['nested.thing']='!!bool'
['num.length']='1'
['num[0].key']='!!int'
['strings.empty2']='!!null'
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
['[0][0]']='baz'
['[0][1].k']='v'
['[0][2][0]']='a'
['[0][2][1]']='b'
['[0][3][0].key']='ok'
['[0][4][0]']='1'
['[0][5]']='2'
['[1]']='1'
['[2]']='- not an array'
)
REPLY_MAP2=(
['@.length']='1'
['[0].length']='6'
['[0][2].length']='2'
['[0][3].length']='1'
['[0][4].length']='1'
['[0][4][0]']='!!int'
['[0][5]']='!!int'
['[1]']='!!int'
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
['@[0]']='my text'
)
REPLY_MAP2=(
['@.length']='1'
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
['@[0]']='line1
line2

'
)
REPLY_MAP2=(
['@.length']='1'
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
['@[0]']='word1 word2 word3'
)
REPLY_MAP2=(
['@.length']='1'
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
['@[0]']='text'
)
REPLY_MAP2=(
['@.length']='1'
)
```

> cat `resources/ok/tags-on-keys.yaml`

```text
obj: !mytype
  resources: !reference [ 1, 2 ]
```

❯ `yaml::parseFile resources/ok/tags-on-keys.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['obj.resources[0]']='1'
['obj.resources[1]']='2'
)
REPLY_MAP2=(
['@.length']='1'
['obj']='!mytype'
['obj.resources']='!reference'
['obj.resources.length']='2'
['obj.resources[0]']='!!int'
['obj.resources[1]']='!!int'
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
['bool.b1']='false'
['bool.b2']='TRUE'
['bool.b3']='False'
['custom.application specific tag']='The semantics of the tag
above may be different for
different documents.
'
['custom.picture']='xxxx'
['explicitTypes[0]']='123'
['explicitTypes[1]']='123'
['explicitTypes[2]']='123'
['explicitTypes[3]']='123.45'
['explicitTypes[4]']='true'
['explicitTypes[5]']='null'
['float.exponential']='12.3015e+02'
['float.fixed']='1230.15'
['float.negative infinity']='-.inf'
['float.not a number']='.nan'
['float.scientific']='1.23015e+3'
['int.baseten']='78'
['int.hexadecimal']='0xC'
['int.octal']='0o14'
['int.signed']='+12345'
['int.signed2']='-9'
['null.null']='null'
['null.null2']='null'
['null.null3']='~'
['string.anythingElse']='ergezrg'
['string.notFloat']='123.456.345'
['string.s']='example'
)
REPLY_MAP2=(
['@.length']='1'
['bool.b1']='!!bool'
['bool.b2']='!!bool'
['bool.b3']='!!bool'
['custom.application specific tag']='!e!tag'
['custom.picture']='!!binary'
['explicitTypes.length']='6'
['explicitTypes[2]']='!!int'
['explicitTypes[3]']='!!float'
['explicitTypes[4]']='!!bool'
['explicitTypes[5]']='!!null'
['float.exponential']='!!float'
['float.fixed']='!!float'
['float.negative infinity']='!!float'
['float.not a number']='!!float'
['float.scientific']='!!float'
['int.baseten']='!!int'
['int.hexadecimal']='!!int'
['int.octal']='!!int'
['int.signed']='!!int'
['int.signed2']='!!int'
['null.null']='!!null'
['null.null2']='!!null'
['null.null3']='!!null'
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
['k1']='trap: not value'
['k2']='trap: not value'
['k3[0]']='- - not an array'
['k3[1]']='- - not an array'
['k3[2]']='- - not an array'
)
REPLY_MAP2=(
['@.length']='1'
['k3.length']='3'
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
['@[0][0][0]']='baz'
['@[0][0][1].k']='v'
['@[0][0][2][0]']='a'
['@[0][0][2][1]']='b'
['@[0][0][3][0].key']='ok'
['@[0][0][4][0]']='1'
['@[0][0][5]']='2'
['@[0][1]']='1'
['@[0][2]']='- not an array'
)
REPLY_MAP2=(
['@.length']='1'
['@[0].length']='3'
['@[0][0].length']='6'
['@[0][0][2].length']='2'
['@[0][0][3].length']='1'
['@[0][0][4].length']='1'
['@[0][0][4][0]']='!!int'
['@[0][0][5]']='!!int'
['@[0][1]']='!!int'
)
```

❯ `yaml::parseFile resources/ok/any-indent.yaml prefixFirstDoc=true`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@[0].key.1indent.now2.and1again.now4']='v'
['@[0].key.1indent.now2.arr2[0]']='1'
['@[0].key.1indent.now2.arr2[1]']='2'
['@[0].key.1indent.now2.arr2[2]']='3'
['@[0].key.1indent.now2.arr[0]']='1'
['@[0].key.1indent.now2.arr[1]']='2'
['@[0].key.1indent.now2.arr[2]']='3'
['@[0].normal[0].item']='Super Hoop'
['@[0].normal[0].quantity']='1'
['@[0].normal[1]']='Sammy Sosa completed another fine season with great stats.

  63 Home Runs
  0.288 Batting Average

What a year!
'
['@[0].normal[2].avg']='0.278'
['@[0].normal[2].hr']='65'
['@[0].normal[2].name']='Mark McGwire'
['@[0].normal[3]']=' explicit
'
['@[0].normal[4]']='explicit
'
['@[0].normal[5]']='  explicit
'
['@[0].normal[6].key']='1'
)
REPLY_MAP2=(
['@.length']='1'
['@[0].key.1indent.now2.arr.length']='3'
['@[0].key.1indent.now2.arr2.length']='3'
['@[0].key.1indent.now2.arr2[0]']='!!int'
['@[0].key.1indent.now2.arr2[1]']='!!int'
['@[0].key.1indent.now2.arr2[2]']='!!int'
['@[0].key.1indent.now2.arr[0]']='!!int'
['@[0].key.1indent.now2.arr[1]']='!!int'
['@[0].key.1indent.now2.arr[2]']='!!int'
['@[0].normal.length']='7'
['@[0].normal[0].quantity']='!!int'
['@[0].normal[2].avg']='!!float'
['@[0].normal[2].hr']='!!int'
['@[0].normal[6].key']='!!int'
)
```

### ✅ Testing yaml::parseFile and yaml::parseString are equal

