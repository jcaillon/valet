# Test suite lib-bash

## Test script 00.tests

### ✅ Testing bash::getFunctionDefinitionWithGlobalVars

❯ `declare -f test_function_to_reexport`

**Standard output**:

```text
test_function_to_reexport () 
{ 
    local -i firstArg=$1;
    local secondArg="${2}";
    local -A thirdArg="${3:-egez}";
    local -a fourth="${4?"The function ⌜${FUNCNAME:-?}⌝ requires more arguments."}";
    if (( firstArg == 0 )); then
        echo "cool";
    fi;
    if [[ "${secondArg}" == "cool" ]]; then
        echo "${secondArg}";
    fi;
    if [[ "${thirdArg[cool]}" == "cool" ]]; then
        echo "${thirdArg[cool]}";
    fi;
    if [[ "${fourth[cool]}" == "cool" ]]; then
        echo "${fourth[cool]}";
    fi
}
```

❯ `bash::getFunctionDefinitionWithGlobalVars test_function_to_reexport new_name FIRST_ARG SECOND_ARG THIRD_ARG FOURTH_ARG`

❯ `echo ${RETURNED_VALUE}`

**Standard output**:

```text
new_name () 
{ 
    if (( FIRST_ARG == 0 )); then
        echo "cool";
    fi;
    if [[ "${SECOND_ARG}" == "cool" ]]; then
        echo "${SECOND_ARG}";
    fi;
    if [[ "${THIRD_ARG[cool]}" == "cool" ]]; then
        echo "${THIRD_ARG[cool]}";
    fi;
    if [[ "${FOURTH_ARG[cool]}" == "cool" ]]; then
        echo "${FOURTH_ARG[cool]}";
    fi
}

```

Testing without arguments

❯ `bash::getFunctionDefinitionWithGlobalVars test_function_to_reexport new_name`

❯ `echo ${RETURNED_VALUE}`

**Standard output**:

```text
new_name () 
{ 
    local -i firstArg=$1;
    local secondArg="${2}";
    local -A thirdArg="${3:-egez}";
    local -a fourth="${4?"The function ⌜${FUNCNAME:-?}⌝ requires more arguments."}";
    if (( firstArg == 0 )); then
        echo "cool";
    fi;
    if [[ "${secondArg}" == "cool" ]]; then
        echo "${secondArg}";
    fi;
    if [[ "${thirdArg[cool]}" == "cool" ]]; then
        echo "${thirdArg[cool]}";
    fi;
    if [[ "${fourth[cool]}" == "cool" ]]; then
        echo "${fourth[cool]}";
    fi
}

```

### ✅ Testing bash::countJobs

❯ `stuff &; stuff &; stuff &`

❯ `bash::countJobs`

Returned variables:

```text
RETURNED_VALUE='3'
```

### ✅ Testing bash::injectCodeInFunction

❯ `declare -f simpleFunction`

**Standard output**:

```text
simpleFunction () 
{ 
    :
}
```

❯ `bash::injectCodeInFunction simpleFunction echo\ \'injected\ at\ the\ beginning\!\' true`

❯ `echo ${RETURNED_VALUE}; echo ${RETURNED_VALUE2};`

**Standard output**:

```text
simpleFunction () 
{
echo 'injected at the beginning!' 
    :
}

simpleFunction () 
{ 
    :
}

```

❯ `bash::injectCodeInFunction simpleFunction echo\ \'injected\ at\ the\ end\!\'`

❯ `echo ${RETURNED_VALUE}; echo ${RETURNED_VALUE2};`

**Standard output**:

```text
simpleFunction () 
{ 
    :
echo 'injected at the end!'
}
simpleFunction () 
{ 
    :
}

```

❯ `bash::injectCodeInFunction newName echo\ \'injected\ in\ a\ new\ function\!\'`

❯ `echo ${RETURNED_VALUE}; echo ${RETURNED_VALUE2};`

**Standard output**:

```text
function newName() {
echo 'injected in a new function!'
}

```

