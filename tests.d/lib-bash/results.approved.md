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

Returned variables:

```text
RETURNED_VALUE=$'new_name () \n{ \n    if (( FIRST_ARG == 0 )); then\n        echo "cool";\n    fi;\n    if [[ "${SECOND_ARG}" == "cool" ]]; then\n        echo "${SECOND_ARG}";\n    fi;\n    if [[ "${THIRD_ARG[cool]}" == "cool" ]]; then\n        echo "${THIRD_ARG[cool]}";\n    fi;\n    if [[ "${FOURTH_ARG[cool]}" == "cool" ]]; then\n        echo "${FOURTH_ARG[cool]}";\n    fi\n}\n'
```

### ✅ Testing bash::getFunctionDefinitionWithGlobalVars without arguments

❯ `bash::getFunctionDefinitionWithGlobalVars test_function_to_reexport new_name`

Returned variables:

```text
RETURNED_VALUE=$'new_name () \n{ \n    local -i firstArg=$1;\n    local secondArg="${2}";\n    local -A thirdArg="${3:-egez}";\n    local -a fourth="${4?"The function ⌜${FUNCNAME:-?}⌝ requires more arguments."}";\n    if (( firstArg == 0 )); then\n        echo "cool";\n    fi;\n    if [[ "${secondArg}" == "cool" ]]; then\n        echo "${secondArg}";\n    fi;\n    if [[ "${thirdArg[cool]}" == "cool" ]]; then\n        echo "${thirdArg[cool]}";\n    fi;\n    if [[ "${fourth[cool]}" == "cool" ]]; then\n        echo "${fourth[cool]}";\n    fi\n}\n'
```

