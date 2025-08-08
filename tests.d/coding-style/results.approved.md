# Test suite coding-style

## Test script 00.coding-style

### ✅ Testing a function with finite arguments

❯ `functionWithFiniteArgs`

Exited with code: `1`

**Error output**:

```text
$GLOBAL_INSTALLATION_DIRECTORY/tests.d/coding-style/00.coding-style.sh: line 46: 1: unbound variable
ERROR    Exiting subshell depth 3 with code 1, stack:
╭ local arg1="${1}" arg2="${2}" myOption="1" myOption2="2" IFS=' '
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
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

❯ `functionWithFiniteArgs`

Exited with code: `1`

**Error output**:

```text
$GLOBAL_INSTALLATION_DIRECTORY/tests.d/coding-style/00.coding-style.sh: line 46: 1: unbound variable
ERROR    Exiting subshell depth 3 with code 1, stack:
╭ local arg1="${1}" arg2="${2}" myOption="1" myOption2="2" IFS=' '
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
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

❯ `functionWithInfiniteArgs argument1 argument2 ---`

**Standard output**:

```text
set -- "${@:1:0}"
declare -- arg1="argument1"
declare -- arg2="argument2"
declare -- myOption="1"
declare -- myOption2="2"
remaining arguments: ''
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

### ✅ Testing errors in a function with finite arguments

❯ `functionWithFiniteArgs argument1 argument2 1invalid`

Exited with code: `1`

**Error output**:

```text
$GLOBAL_INSTALLATION_DIRECTORY/tests.d/coding-style/00.coding-style.sh: line 52: local: `1invalid': not a valid identifier
CMDERR   Bad options passed to function ⌜functionWithFiniteArgs⌝ .

All options must be passed with the syntax ⌜option=value⌝, i.e.:
░ functionWithFiniteArgs <mandatory arguments> option1=value1 option2=value2


╭ invalid options for ⌜functionWithFiniteArgs⌝: '1invalid'
╰─ in main() at 00.coding-style.sh:300
```

### ✅ Testing errors in a function with infinite arguments

❯ `functionWithInfiniteArgs argument1 argument2 --- 1invalid`

Exited with code: `1`

**Error output**:

```text
$GLOBAL_INSTALLATION_DIRECTORY/tests.d/coding-style/00.coding-style.sh: line 66: local: `1invalid': not a valid identifier
CMDERR   Bad options passed to function ⌜functionWithInfiniteArgs⌝ .

All options must be passed with the syntax ⌜option=value⌝ after a ⌜---⌝ separator, i.e.:
░ functionWithInfiniteArgs <mandatory arguments> --- option1=value1 option2=value2


╭ invalid options for ⌜functionWithInfiniteArgs⌝: '1invalid'
╰─ in main() at 00.coding-style.sh:300
```

