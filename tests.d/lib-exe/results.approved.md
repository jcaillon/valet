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
        inputStreamContent="${REPLY}";
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
REPLY='🙈 mocking fake --std-in --error
Input stream: <input_stream
>
'
REPLY2='INFO: log line from fake mock
ERROR: returning error from fake
'
```

Input stream from string, fails (exit):

❯ `exe::invoke5 true 0 false 'input_stream' fake --std-in --error`

Exited with code: `1`

**Error output**:

```text
TRACE    Fake standard output stream:
⌜/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--fake-stdout⌝
   1 ░ 🙈 mocking fake --std-in --error
   2 ░ Input stream: <input_stream
   3 ░ >
TRACE    Fake standard error stream:
⌜/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--fake-stderr⌝
   1 ░ INFO: log line from fake mock
   2 ░ ERROR: returning error from fake
FAIL     The command ⌜fake⌝ ended with exit code ⌜1⌝ in ⌜4.000s⌝.
```

Make error 1 acceptable:

❯ `exe::invoke5 true 0,1,2 true '' fake --error`

Returned variables:

```text
REPLY='🙈 mocking fake --error
'
REPLY2='INFO: log line from fake mock
ERROR: returning error from fake
'
```

Normal, return everything as variables:

❯ `exe::invoke5 true '' '' '' fake`

Returned variables:

```text
REPLY='🙈 mocking fake 
'
REPLY2='INFO: log line from fake mock
'
```

Normal, does not redirect outputs:

❯ `exe::invoke5 true '' '' '' fake`

**Standard output**:

```text
🙈 mocking fake 
```

**Error output**:

```text
INFO: log line from fake mock
```

Input stream for file, return everything as files:

❯ `exe::invokef5 false 0 true /tmp/valet-temp fake --std-in`

Returned variables:

```text
REPLY='/tmp/valet-stdout.f'
REPLY2='/tmp/valet-stderr.f'
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
REPLY='🙈 mocking fake --option argument1 argument2
'
REPLY2='INFO: log line from fake mock
'
```

❯ `exe::invoke2 false fake --error`

Returned code: `1`

Returned variables:

```text
REPLY='🙈 mocking fake --error
'
REPLY2='INFO: log line from fake mock
ERROR: returning error from fake
'
```

❯ `exe::invoke2 true fake --error`

Exited with code: `1`

**Error output**:

```text
TRACE    Fake standard output stream:
⌜/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--fake-stdout⌝
   1 ░ 🙈 mocking fake --error
TRACE    Fake standard error stream:
⌜/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--fake-stderr⌝
   1 ░ INFO: log line from fake mock
   2 ░ ERROR: returning error from fake
FAIL     The command ⌜fake⌝ ended with exit code ⌜1⌝ in ⌜16.000s⌝.
```

❯ `exe::invokef2 false fake --option argument1 argument2`

Returned variables:

```text
REPLY='/tmp/valet-stdout.f'
REPLY2='/tmp/valet-stderr.f'
```

❯ `exe::invoket2 false fake --option argument1 argument2`

**Standard output**:

```text
🙈 mocking fake --option argument1 argument2
```

**Error output**:

```text
INFO: log line from fake mock
```

### ✅ Testing exe::invoke

❯ `exe::invoke fake --error`

Exited with code: `1`

**Error output**:

```text
TRACE    Fake standard output stream:
⌜/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--fake-stdout⌝
   1 ░ 🙈 mocking fake --error
TRACE    Fake standard error stream:
⌜/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--fake-stderr⌝
   1 ░ INFO: log line from fake mock
   2 ░ ERROR: returning error from fake
FAIL     The command ⌜fake⌝ ended with exit code ⌜1⌝ in ⌜20.000s⌝.
```

❯ `exe::invoke fake --option argument1 argument2`

Returned variables:

```text
REPLY='🙈 mocking fake --option argument1 argument2
'
REPLY2='INFO: log line from fake mock
'
```

### ✅ Testing exe::invoke3piped

❯ `exe::invoke3piped true 'input_stream' fake --std-in --option argument1 argument2`

Returned variables:

```text
REPLY='🙈 mocking fake --std-in --option argument1 argument2
Input stream: <input_stream
>
'
REPLY2='INFO: log line from fake mock
'
```

❯ `exe::invokef3piped true 'input_stream' fake --std-in --option argument1 argument2`

Returned variables:

```text
REPLY='/tmp/valet-stdout.f'
REPLY2='/tmp/valet-stderr.f'
```

