# Test suite lib-exe

## Test script 00.tests

For these tests, we will use a special command `fake` defined as such:

❯ `declare -f fake`

**Standard output**:

```text
fake () 
{ 
    local inputStreamContent;
    if [[ $* == *"--std-in"* ]]; then
        bash::readStdIn;
        inputStreamContent="${RETURNED_VALUE}";
    fi;
    local IFS=" ";
    echo "🙈 mocking fake $*";
    if [[ -n ${inputStreamContent:-} ]]; then
        echo "Input stream: <${inputStreamContent}>";
    fi;
    echo "INFO: log line from fake mock" 1>&2;
    if [[ $* == *"--error"* ]]; then
        echo "ERROR: returning error from fake" 1>&2;
        return 1;
    fi
}
```

### ✅ Testing exe::invoke5

Input stream from string, returns an error:

❯ `exe::invoke5 false 0 false 'input_stream' fake --std-in --error`

Returned code: `1`

Returned variables:

```text
RETURNED_VALUE='🙈 mocking fake --std-in --error
Input stream: <input_stream
>
'
RETURNED_VALUE2='INFO: log line from fake mock
ERROR: returning error from fake
'
```

Input stream from string, fails (exit):

❯ `exe::invoke5 true 0 false 'input_stream' fake --std-in --error`

Exited with code: `1`

**Error output**:

```text
TRACE    Fake standard output stream:
   1 ░ 🙈 mocking fake --std-in --error
   2 ░ Input stream: <input_stream
   3 ░ >
TRACE    Fake standard error stream:
   1 ░ INFO: log line from fake mock
   2 ░ ERROR: returning error from fake
ERROR    The command ⌜fake⌝ originally ended with exit code ⌜1⌝.
```

Make error 1 acceptable:

❯ `exe::invoke5 true 0,1,2 true '' fake --error`

Returned variables:

```text
RETURNED_VALUE='🙈 mocking fake --error
'
RETURNED_VALUE2='INFO: log line from fake mock
ERROR: returning error from fake
'
```

Normal, return everything as variables:

❯ `exe::invoke5 true '' '' '' fake`

Returned variables:

```text
RETURNED_VALUE='🙈 mocking fake 
'
RETURNED_VALUE2='INFO: log line from fake mock
'
```

Input stream for file, return everything as files:

❯ `exe::invokef5 false 0 true /tmp/valet-temp fake --std-in`

Returned variables:

```text
RETURNED_VALUE='/tmp/valet-stdout.f'
RETURNED_VALUE2='/tmp/valet-stderr.f'
```

❯ `fs::cat /tmp/valet-stdout.f`

**Standard output**:

```text
🙈 mocking fake --std-in
Input stream: <Input stream content from a file>

```

❯ `fs::cat /tmp/valet-stderr.f`

**Standard output**:

```text
INFO: log line from fake mock

```

### ✅ Testing exe::invoke2

❯ `exe::invoke2 false fake --option argument1 argument2`

Returned variables:

```text
RETURNED_VALUE='🙈 mocking fake --option argument1 argument2
'
RETURNED_VALUE2='INFO: log line from fake mock
'
```

❯ `exe::invoke2 false fake --error`

Returned code: `1`

Returned variables:

```text
RETURNED_VALUE='🙈 mocking fake --error
'
RETURNED_VALUE2='INFO: log line from fake mock
ERROR: returning error from fake
'
```

❯ `exe::invoke2 true fake --error`

Exited with code: `1`

**Error output**:

```text
TRACE    Fake standard output stream:
   1 ░ 🙈 mocking fake --error
TRACE    Fake standard error stream:
   1 ░ INFO: log line from fake mock
   2 ░ ERROR: returning error from fake
ERROR    The command ⌜fake⌝ originally ended with exit code ⌜1⌝.
```

❯ `exe::invokef2 false fake --option argument1 argument2`

Returned variables:

```text
RETURNED_VALUE='/tmp/valet-stdout.f'
RETURNED_VALUE2='/tmp/valet-stderr.f'
```

### ✅ Testing exe::invoke

❯ `exe::invoke fake --error`

Exited with code: `1`

**Error output**:

```text
TRACE    Fake standard output stream:
   1 ░ 🙈 mocking fake --error
TRACE    Fake standard error stream:
   1 ░ INFO: log line from fake mock
   2 ░ ERROR: returning error from fake
ERROR    The command ⌜fake⌝ originally ended with exit code ⌜1⌝.
```

❯ `exe::invoke fake --option argument1 argument2`

Returned variables:

```text
RETURNED_VALUE='🙈 mocking fake --option argument1 argument2
'
RETURNED_VALUE2='INFO: log line from fake mock
'
```

### ✅ Testing exe::invoke2piped

❯ `exe::invoke2piped true 'input_stream' fake --std-in --option argument1 argument2`

Returned variables:

```text
RETURNED_VALUE='🙈 mocking fake --std-in --option argument1 argument2
Input stream: <input_stream
>
'
RETURNED_VALUE2='INFO: log line from fake mock
'
```

❯ `exe::invokef2piped true 'input_stream' fake --std-in --option argument1 argument2`

Returned variables:

```text
RETURNED_VALUE='/tmp/valet-stdout.f'
RETURNED_VALUE2='/tmp/valet-stderr.f'
```

### ✅ Testing exe::captureOutput

❯ `exe::captureOutput echo coucou`

Returned variables:

```text
RETURNED_VALUE='coucou
'
```

❯ `exe::captureOutput declare -f exe::captureOutput`

Returned variables:

```text
RETURNED_VALUE='exe::captureOutput () 
{ 
    local IFS='"'"' '"'"';
    "${@}" &> "${GLOBAL_TEMPORARY_STDOUT_FILE}" || return 1;
    RETURNED_VALUE="";
    IFS='"'"''"'"' read -rd '"'"''"'"' RETURNED_VALUE < "${GLOBAL_TEMPORARY_STDOUT_FILE}" || :
}
'
```

❯ `exe::captureOutput [[ 1 -eq 0 ]]`

Returned code: `1`

