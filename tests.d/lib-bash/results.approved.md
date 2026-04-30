# Test suite lib-bash

## Test script 00.lib-bash

### ✅ Testing bash::catchErrors

❯ `bash::catchErrors echo This\ should\ not\ fail`

**Standard output**:

```text
This should not fail
```

❯ `bash::catchErrors testFunction`

Returned code: `1`

**Error output**:

```text
INFO     This is a test function.
$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-bash/00.lib-bash.sh: line 43: ((: 0 / 0: division by 0 (error token is "0")
INFO     This line will be executed since we catch errors.
$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-bash/00.lib-bash.sh: line 45: ((: 0 / 0: division by 0 (error token is "0")
INFO     Again.
```

```text
GLOBAL_ERROR_TRAP_LAST_ERROR_CODE='1'
GLOBAL_ERROR_TRAP_ERROR_CODES=(
[0]='1'
[1]='1'
)
GLOBAL_ERROR_TRAP_ERROR_STACKS=(
[0]='Error code ⌜1⌝ for the command:
╭ ((0 / 0))
├─ in log::printCallStack() at core:10
├─ in log::error() at core:100
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
'
[1]='Error code ⌜1⌝ for the command:
╭ ((0 / 0))
├─ in log::printCallStack() at core:10
├─ in log::error() at core:100
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
'
)
```

### ✅ Testing bash::isVariableCachedWithValue

❯ `bash::isVariableCachedWithValue VAR1 val1 VAR2 val2`

Returned code: `1`

❯ `bash::isVariableCachedWithValue VAR1 val1`

❯ `bash::isVariableCachedWithValue VAR1 val2`

Returned code: `1`

❯ `bash::clearCachedVariables`

❯ `bash::isVariableCachedWithValue VAR2 val2`

❯ `bash::clearCachedVariables VAR2`

❯ `bash::isVariableCachedWithValue VAR2 val2`

Returned code: `1`

❯ `bash::isVariableCachedWithValue VAR2 val2`

### ✅ Testing bash::runInSubshell

❯ `bash::runInSubshell log::info hello`

**Error output**:

```text
INFO     hello
```

Returned variables:

```text
REPLY_CODE='0'
```

❯ `bash::runInSubshell subshellThatFails`

**Error output**:

```text
$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-bash/00.lib-bash.sh: line 81: ((: 0 / 0: division by 0 (error token is "0")
CMDERR   Error code ⌜1⌝ for the command:
╭ ((0 / 0))
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
```

Returned variables:

```text
REPLY_CODE='1'
```

❯ `bash::runInSubshell subshellThatFails`

**Error output**:

```text
$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-bash/00.lib-bash.sh: line 81: ((: 0 / 0: division by 0 (error token is "0")
CMDERR   Error code ⌜1⌝ for the command:
╭ ((0 / 0))
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
```

Returned variables:

```text
REPLY_CODE='1'
```

❯ `_OPTION_EXIT_ON_FAIL=true bash::runInSubshell subshellThatFails`

Exited with code: `1`

**Error output**:

```text
$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-bash/00.lib-bash.sh: line 81: ((: 0 / 0: division by 0 (error token is "0")
CMDERR   Error code ⌜1⌝ for the command:
╭ ((0 / 0))
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
```

❯ `bash::runInSubshell subshellThatExits`

Returned variables:

```text
REPLY_CODE='2'
```

### ✅ Testing bash::isFdValid

❯ `bash::isFdValid 2`

❯ `bash::isFdValid /tmp/valet-temp`

❯ `bash::isFdValid 999`

Returned code: `1`

❯ `bash::isFdValid /unknown/file/path`

Returned code: `1`

### ✅ Testing bash::getFunctionDefinitionWithGlobalVars

❯ `declare -f test_function_to_reexport`

**Standard output**:

```text
test_function_to_reexport () 
{ 
    local -i firstArg=$1;
    local secondArg="${2}";
    local -A thirdArg="${3:-egez}";
    local -a fourth="${4?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}";
    if ((firstArg == 0)); then
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

❯ `echo ${REPLY}`

**Standard output**:

```text
new_name () 
{ 
    if ((FIRST_ARG == 0)); then
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

❯ `echo ${REPLY}`

**Standard output**:

```text
new_name () 
{ 
    local -i firstArg=$1;
    local secondArg="${2}";
    local -A thirdArg="${3:-egez}";
    local -a fourth="${4?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}";
    if ((firstArg == 0)); then
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

### ✅ Testing bash::injectCodeInFunction

❯ `declare -f simpleFunction`

**Standard output**:

```text
simpleFunction () 
{ 
    :
}
```

❯ `bash::injectCodeInFunction simpleFunction echo\ \'injected\ at\ the\ beginning\!\' injectAtBeginning=true`

❯ `echo ${REPLY}; echo ${REPLY2};`

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

❯ `echo ${REPLY}; echo ${REPLY2};`

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

❯ `echo ${REPLY}; echo ${REPLY2};`

**Standard output**:

```text
function newName() {
echo 'injected in a new function!'
}

```

### ✅ Testing bash::sleep

❯ `bash::sleep 0.001`

### ✅ Testing bash::readStdIn

❯ `bash::readStdIn <<<'coucou'`

Returned variables:

```text
REPLY='coucou
'
```

❯ `bash::readStdIn`

Returned variables:

```text
REPLY=''
```

### ✅ Testing bash::countArgs

❯ `bash::countArgs arg1 arg2 arg3`

Returned variables:

```text
REPLY='3'
```

❯ `bash::countArgs ${PWD}/resources/*`

Returned variables:

```text
REPLY='1'
```

### ✅ Testing bash::getMissingVariables

❯ `bash::getMissingVariables`

Returned code: `1`

❯ `ABC=ok`

❯ `bash::getMissingVariables GLOBAL_TEST_TEMP_FILE dfg ABC NOP`

Returned variables:

```text
REPLY_ARRAY=(
[0]='dfg'
[1]='NOP'
)
```

### ✅ Testing bash::getMissingCommands

❯ `bash::getMissingCommands`

Returned code: `1`

❯ `bash::getMissingCommands NONEXISTINGSTUFF bash::getMissingCommands rm YETANOTHERONEMISSING`

Returned variables:

```text
REPLY_ARRAY=(
[0]='NONEXISTINGSTUFF'
[1]='YETANOTHERONEMISSING'
)
```

### ✅ Testing bash::isCommand

❯ `bash::isCommand NONEXISTINGSTUFF`

Returned code: `1`

❯ `bash::isCommand rm`

### ✅ Testing bash::isFunction

❯ `bash::isFunction func1`

Returned code: `1`

❯ `bash::isFunction func1`

### ✅ Testing bash::getBuiltinOutput

❯ `bash::getBuiltinOutput echo coucou`

Returned variables:

```text
REPLY_CODE='0'
REPLY='coucou
'
```

❯ `bash::getBuiltinOutput declare -f bash::getBuiltinOutput`

Returned variables:

```text
REPLY_CODE='0'
REPLY='bash::getBuiltinOutput () 
{ 
    local IFS='"'"' '"'"';
    REPLY="";
    if "${@}" &> "${GLOBAL_TEMPORARY_STDOUT_FILE}"; then
        IFS='"'"''"'"' read -rd '"'"''"'"' REPLY < "${GLOBAL_TEMPORARY_STDOUT_FILE}" || :;
        REPLY_CODE=0;
    else
        REPLY_CODE=$?;
        IFS='"'"''"'"' read -rd '"'"''"'"' REPLY < "${GLOBAL_TEMPORARY_STDOUT_FILE}" || :;
    fi
}
'
```

❯ `bash::getBuiltinOutput false`

Returned variables:

```text
REPLY_CODE='1'
REPLY=''
```

❯ `bash::getBuiltinOutput testOutput`

Returned variables:

```text
REPLY_CODE='42'
REPLY='This is stdout
This is stderr
'
```

### ✅ Testing bash::pushd and bash::popd

❯ `bash::pushd /tmp`

Current directory after pushd: /tmp

❯ `bash::popd`

Current directory after pushd: $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-bash

❯ `bash::popd`

Exited with code: `1`

**Error output**:

```text
FAIL     Failed to change the current directory, the directory stack is empty.
```

❯ `bash::pushd non-existing-directory`

Exited with code: `1`

**Error output**:

```text
FAIL     Failed to change the current directory to ⌜non-existing-directory⌝.
```

❯ `bash::popd`

Exited with code: `1`

**Error output**:

```text
FAIL     Failed to change the current directory to ⌜still-not-existing⌝.
```

