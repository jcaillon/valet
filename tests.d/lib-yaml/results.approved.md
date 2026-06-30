# Test suite lib-yaml

## Test script 00.lib-yaml

### ✅ Testing yaml::parseFile function

> cat `resources/ok/any-indent.yaml`

```text
normal:
  - item    : Super Hoop
    quantity: 1
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
      - 3
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
['@.length']='0'
['key.1indent.now2.and1again.now4']='v'
['key.1indent.now2.arr.length']='3'
['key.1indent.now2.arr2.length']='3'
['key.1indent.now2.arr2[0]']='1'
['key.1indent.now2.arr2[1]']='2'
['key.1indent.now2.arr2[2]']='3'
['key.1indent.now2.arr[0]']='1'
['key.1indent.now2.arr[1]']='2'
['key.1indent.now2.arr[2]']='3'
['normal.length']='7'
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
['@.length']='0'
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
['@[1].key']='thing'
['@[2].key']='thing2'
['@[3].key']='thing3'
)
```

> cat `resources/ok/nulls.yaml`

```text
null   key   :
k:
   null:
nullkeyattheend:
```

❯ `yaml::parseFile resources/ok/nulls.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='0'
['k.null']='null'
['null   key']='null'
['nullkeyattheend']='null'
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
['@.length']='0'
['empty']=''
['k']='word1 word2" word3'
['k2']='line1
line2'
['key  with colons   ::']='null'
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
['@.length']='0'
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
['@.length']='0'
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
```

> cat `resources/ok/single-line-nested-arrays.yaml`

```text
- - baz
  - k: v
  -        - a
           - b
  - 2
- 1
```

❯ `yaml::parseFile resources/ok/single-line-nested-arrays.yaml`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='0'
['[0].length']='4'
['[0][0]']='baz'
['[0][1].k']='v'
['[0][2].length']='2'
['[0][2][0]']='a'
['[0][2][1]']='b'
['[0][3]']='2'
['[1]']='1'
['length']='2'
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
['@.length']='0'
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
['@.length']='0'
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
['@.length']='0'
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
['@[1]']='text'
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
['@.length']='0'
['@[0].length']='2'
['@[0][0].length']='4'
['@[0][0][0]']='baz'
['@[0][0][1].k']='v'
['@[0][0][2].length']='2'
['@[0][0][2][0]']='a'
['@[0][0][2][1]']='b'
['@[0][0][3]']='2'
['@[0][1]']='1'
)
```

❯ `yaml::parseFile resources/ok/any-indent.yaml prefixFirstDoc=true`

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY_MAP=(
['@.length']='0'
['@[0].key.1indent.now2.and1again.now4']='v'
['@[0].key.1indent.now2.arr.length']='3'
['@[0].key.1indent.now2.arr2.length']='3'
['@[0].key.1indent.now2.arr2[0]']='1'
['@[0].key.1indent.now2.arr2[1]']='2'
['@[0].key.1indent.now2.arr2[2]']='3'
['@[0].key.1indent.now2.arr[0]']='1'
['@[0].key.1indent.now2.arr[1]']='2'
['@[0].key.1indent.now2.arr[2]']='3'
['@[0].normal.length']='7'
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
```

