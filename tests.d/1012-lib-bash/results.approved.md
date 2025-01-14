# Test suite 1012-lib-bash

## Test script 00.tests

### Testing bash::getFunctionDefinitionWithGlobalVars

Exit code: `0`

**Standard** output:

```plaintext
test_function_to_reexport () 
{ 
    local -i firstArg=$1;
    local secondArg="${2}";
    local -A thirdArg="${3:-egez}";
    if (( firstArg == 0 )); then
        echo "cool";
    fi;
    if [[ "${secondArg}" == "cool" ]]; then
        echo "${secondArg}";
    fi;
    if [[ "${thirdArg[cool]}" == "cool" ]]; then
        echo "${thirdArg[cool]}";
    fi
}

→ bash::getFunctionDefinitionWithGlobalVars test_function_to_reexport new_name FIRST_ARG SECOND_ARG THIRD_ARG
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
    fi
}


→ bash::getFunctionDefinitionWithGlobalVars test_function_to_reexport new_name
new_name () 
{ 
    local -i firstArg=$1;
    local secondArg="${2}";
    local -A thirdArg="${3:-egez}";
    if (( firstArg == 0 )); then
        echo "cool";
    fi;
    if [[ "${secondArg}" == "cool" ]]; then
        echo "${secondArg}";
    fi;
    if [[ "${thirdArg[cool]}" == "cool" ]]; then
        echo "${thirdArg[cool]}";
    fi
}

```

