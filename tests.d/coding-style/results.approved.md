# Test suite coding-style

## Test script 00.coding-style

### ✅ Testing with a function with finite arguments

❯ `functionWithFiniteArgs`

Exited with code: `1`

**Error output**:

```text
$GLOBAL_INSTALLATION_DIRECTORY/tests.d/coding-style/00.coding-style.sh: line 47: 1: unbound variable
```

❯ `functionWithFiniteArgs argument1 argument2`

**Standard output**:

```text
local a= 
declare -- IFS=" "
declare -- a=""
declare -- arg1="argument1"
declare -- arg2="argument2"
declare -- myOption="1"
declare -- myOption2="2"
```

❯ `functionWithFiniteArgs argument1 argument2 myOption=one`

**Standard output**:

```text
local a= 'myOption=one'
declare -- IFS=" "
declare -- a=""
declare -- arg1="argument1"
declare -- arg2="argument2"
declare -- myOption="one"
declare -- myOption2="2"
```

❯ `functionWithFiniteArgs argument1 argument2 myOption=one myOption2=my\ value`

**Standard output**:

```text
local a= 'myOption=one' 'myOption2=my value'
declare -- IFS=" "
declare -- a=""
declare -- arg1="argument1"
declare -- arg2="argument2"
declare -- myOption="one"
declare -- myOption2="my value"
```

❯ `functionWithFiniteArgs argument1 argument2 unknownOption=unknownValue`

**Standard output**:

```text
local a= 'unknownOption=unknownValue'
declare -- IFS=" "
declare -- a=""
declare -- arg1="argument1"
declare -- arg2="argument2"
declare -- myOption="1"
declare -- myOption2="2"
declare -- unknownOption="unknownValue"
```

### ✅ Testing with a function with infinite arguments

❯ `functionWithInfiniteArgs`

Exited with code: `1`

**Error output**:

```text
$GLOBAL_INSTALLATION_DIRECTORY/tests.d/coding-style/00.coding-style.sh: line 61: 1: unbound variable
```

❯ `functionWithInfiniteArgs argument1 argument2`

**Standard output**:

```text
:
declare -- arg1="argument1"
declare -- arg2="argument2"
declare -- myOption="1"
declare -- myOption2="2"
remaining arguments: ''
```

❯ `functionWithInfiniteArgs argument1 argument2 myOption=one`

**Standard output**:

```text
:
declare -- arg1="argument1"
declare -- arg2="argument2"
declare -- myOption="1"
declare -- myOption2="2"
remaining arguments: 'myOption=one'
```

❯ `functionWithInfiniteArgs argument1 argument2 --- myOption=one`

**Standard output**:

```text
local 'myOption=one'; set -- "${@:1:0}"
declare -- arg1="argument1"
declare -- arg2="argument2"
declare -- myOption="one"
declare -- myOption2="2"
remaining arguments: ''
```

❯ `functionWithInfiniteArgs argument1 argument2 1 2 3 --- myOption=one myOption2=my\ value`

**Standard output**:

```text
local 'myOption=one' 'myOption2=my value'; set -- "${@:1:3}"
declare -- arg1="argument1"
declare -- arg2="argument2"
declare -- myOption="one"
declare -- myOption2="my value"
remaining arguments: '1 2 3'
```

