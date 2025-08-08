# Test suite lib-exe

## Test script 00.lib-exe

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
    echo "INFO: log line from fake mock to stderr" 1>&2;
    if [[ $* == *"--error"* ]]; then
        echo "ERROR: returning error from fake" 1>&2;
        return 1;
    fi
}
```

### ✅ Testing exe::invoke

Normal invocation:

❯ `exe::invoke fake`

Returned variables:

```text
REPLY_CODE='0'
REPLY='🙈 mocking fake 
'
REPLY2='INFO: log line from fake mock to stderr
'
```

Error, fails (exit):

❯ `exe::invoke fake --error`

Exited with code: `1`

**Error output**:

```text
TRACE    Fake standard output stream:
/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--fake-stdout
   1 ░ 🙈 mocking fake --error
TRACE    Fake standard error stream:
/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--fake-stderr
   1 ░ INFO: log line from fake mock to stderr
   2 ░ ERROR: returning error from fake
FAIL     The command fake ended with exit code 1 in 4.000s.
```

Error but with no fail option:

❯ `exe::invoke fake --error --- noFail=true`

Returned variables:

```text
REPLY_CODE='1'
REPLY='🙈 mocking fake --error
'
REPLY2='INFO: log line from fake mock to stderr
ERROR: returning error from fake
'
```

Input stream from string:

❯ `exe::invoke fake --std-in --- noFail=true stdin=input_stream`

Returned variables:

```text
REPLY_CODE='0'
REPLY='🙈 mocking fake --std-in
Input stream: <input_stream
>
'
REPLY2='INFO: log line from fake mock to stderr
'
```

Input stream from string with trace mode:

❯ `exe::invoke fake --std-in --- noFail=true stdin=input_stream`

**Error output**:

```text
TRACE    Executing the command fake with arguments: 
--std-in
TRACE    The command will be executed as:
"${executable}" "${@}" <<<'input_stream' 1>"/tmp/valet-stdout.f" 2>"/tmp/valet-stderr.f"
TRACE    Options: noFail=true, acceptableCodes=0, replyPathOnly=false
TRACE    Fake standard input from string:
/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--fake-stdin
TRACE    Fake standard output stream:
/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--fake-stdout
   1 ░ 🙈 mocking fake --std-in
   2 ░ Input stream: <input_stream
   3 ░ >
TRACE    Fake standard error stream:
/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--fake-stderr
   1 ░ INFO: log line from fake mock to stderr
DEBUG    The command fake ended with exit code 0 in 8.000s.
```

Returned variables:

```text
REPLY_CODE='0'
REPLY='🙈 mocking fake --std-in
Input stream: <input_stream
>
'
REPLY2='INFO: log line from fake mock to stderr
'
```

Input stream for file:

❯ `exe::invoke fake --std-in --- stdinFile=/tmp/valet-temp`

Returned variables:

```text
REPLY_CODE='0'
REPLY='🙈 mocking fake --std-in
Input stream: <Input stream content from a file>
'
REPLY2='INFO: log line from fake mock to stderr
'
```

Make error 1 acceptable:

❯ `exe::invoke fake --error --- acceptableCodes=1`

Returned variables:

```text
REPLY_CODE='0'
REPLY='🙈 mocking fake --error
'
REPLY2='INFO: log line from fake mock to stderr
ERROR: returning error from fake
'
```

Do not redirect the output:

❯ `exe::invoke fake --- noRedirection=true`

**Standard output**:

```text
🙈 mocking fake 
```

**Error output**:

```text
INFO: log line from fake mock to stderr
```

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY2=''
```

Return the paths instead of content:

❯ `exe::invoke fake --- replyPathOnly=true`

Returned variables:

```text
REPLY_CODE='0'
REPLY='/tmp/valet-stdout.f'
REPLY2='/tmp/valet-stderr.f'
```

Use custom files:

❯ `exe::invoke fake --- replyPathOnly=true stderrPath=/tmp/valet.d/f1-2 stdoutPath=/tmp/valet-temp`

Returned variables:

```text
REPLY_CODE='0'
REPLY='/tmp/valet-temp'
REPLY2='/tmp/valet.d/f1-2'
```

❯ `fs::cat /tmp/valet-temp`

**Standard output**:

```text
🙈 mocking fake 

```

Append output:

❯ `exe::invoke fake --- appendRedirect=true stdoutPath=/tmp/valet-temp`

Returned variables:

```text
REPLY_CODE='0'
REPLY='🙈 mocking fake 
🙈 mocking fake 
'
REPLY2='INFO: log line from fake mock to stderr
INFO: log line from fake mock to stderr
'
```

Group redirects:

❯ `exe::invoke fake --- groupRedirect=true stdoutPath=/tmp/valet-temp`

Returned variables:

```text
REPLY_CODE='0'
REPLY='🙈 mocking fake 
INFO: log line from fake mock to stderr
'
REPLY2='🙈 mocking fake 
INFO: log line from fake mock to stderr
'
```

