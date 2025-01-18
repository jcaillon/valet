# Test suite lib-curl

## Test script 00.curl

### Testing curl::toFile, should write to file



Exit code: `0`

**Standard output**:

```text
→ curl::toFile false '' "${tmpFile}" --code 200 -curlOption1 --fakeOpt2 https://fuu
curl::toFile false function ended with exit code ⌈0⌉.
http return code was ⌈200⌉
Content of downloaded file:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet.d/curl-test --code 200 -curlOption1 --fakeOpt2 https://fuu
⌉
```

### Testing curl::toFile, http code 500 not acceptable return 1



Exit code: `1`

**Standard output**:

```text
→ curl::toFile false '' "${tmpFile}" --code 500 https://fuu
curl::toFile false function ended with exit code ⌈1⌉.
http return code was ⌈500⌉
Content of downloaded file:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet.d/curl-test --code 500 https://fuu
⌉
```

### Testing curl::toFile, http code 500 not acceptable fails



Exit code: `1`

**Standard output**:

```text
→ curl::toFile true '' "${tmpFile}" --code 500 https://fuu
```

**Error output**:

```text
TRACE    Curl error output stream:
   1 ░ ▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet.d/curl-test --code 500 https://fuu
   2 ░ 
ERROR    The http return code ⌜500⌝ is not acceptable for url ⌜https://fuu⌝.
```

### Testing curl::toFile, http code 500 is now acceptable return 0



Exit code: `0`

**Standard output**:

```text
→ curl::toFile false '300,500,999' "${tmpFile}" --code 500 https://fuu
curl::toFile false function ended with exit code ⌈0⌉.
http return code was ⌈500⌉
Content of downloaded file:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet.d/curl-test --code 500 https://fuu
⌉
```

### Testing curl::toFile, testing debug mode https code 400



Exit code: `1`

**Standard output**:

```text
→ curl::toFile false '' "${tmpFile}" --code 400 --error https://fuu/bla --otherOpt
curl::toFile false function ended with exit code ⌈1⌉.
http return code was ⌈400⌉
Content of downloaded file:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet.d/curl-test --code 400 --error https://fuu/bla --otherOpt
Returning 1 from curl.
⌉
```

**Error output**:

```text
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Executing the command ⌜curl⌝ with arguments (quoted): 
'--silent' '--show-error' '--location' '--write-out' '%{response_code}' '--output' '/tmp/valet.d/curl-test' '--code' '400' '--error' 'https://fuu/bla' '--otherOpt'
DEBUG    The command ⌜curl⌝ originally ended with exit code ⌜1⌝.
DEBUG    The curl command for url ⌜https://fuu/bla⌝ ended with exit code ⌜1⌝, the http return code was ⌜400⌝.
TRACE    Curl error output stream:
   1 ░ ▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet.d/curl-test --code 400 --error https://fuu/bla --otherOpt
   2 ░ Returning 1 from curl.
   3 ░ 
DEBUG    The http return code ⌜400⌝ is not acceptable for url ⌜https://fuu/bla⌝.
```

### Testing curl::toFile, testing debug mode http code 200



Exit code: `0`

**Standard output**:

```text
→ curl::toFile false '' "${tmpFile}" --code 200 http://fuu
curl::toFile false function ended with exit code ⌈0⌉.
http return code was ⌈200⌉
Content of downloaded file:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet.d/curl-test --code 200 http://fuu
⌉
```

**Error output**:

```text
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Executing the command ⌜curl⌝ with arguments (quoted): 
'--silent' '--show-error' '--location' '--write-out' '%{response_code}' '--output' '/tmp/valet.d/curl-test' '--code' '200' 'http://fuu'
DEBUG    The command ⌜curl⌝ originally ended with exit code ⌜0⌝.
DEBUG    The curl command for url ⌜http://fuu⌝ ended with exit code ⌜0⌝, the http return code was ⌜200⌝.
DEBUG    The http return code ⌜200⌝ is acceptable and exit code has been reset to 0 from ⌜0⌝.
```

### Testing curl, with no content http code 200



Exit code: `0`

**Standard output**:

```text
→ curl::toVar false '' --code 200 http://hello.com
curl::toVar function ended with exit code ⌈0⌉.
http return code was ⌈200⌉
stdout:
⌈⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-work.f --code 200 http://hello.com
⌉
```

### Testing curl, with no content http code 500, fails



Exit code: `1`

**Standard output**:

```text
→ curl::toVar false '' --code 500 http://hello.com
```

**Error output**:

```text
TRACE    Curl error output stream:
   1 ░ ▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-work.f --code 500 http://hello.com
   2 ░ 
ERROR    The http return code ⌜500⌝ is not acceptable for url ⌜http://hello.com⌝.
```

### Testing curl, debug mode, with content http code 400



Exit code: `1`

**Standard output**:

```text
→ curl::toVar false '' --code 400 http://hello.com
curl::toVar function ended with exit code ⌈1⌉.
http return code was ⌈400⌉
stdout:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-work.f --code 400 http://hello.com
⌉
```

**Error output**:

```text
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Executing the command ⌜curl⌝ with arguments (quoted): 
'--silent' '--show-error' '--location' '--write-out' '%{response_code}' '--output' '/tmp/valet-work.f' '--code' '400' 'http://hello.com'
DEBUG    The command ⌜curl⌝ originally ended with exit code ⌜0⌝.
DEBUG    The curl command for url ⌜http://hello.com⌝ ended with exit code ⌜0⌝, the http return code was ⌜400⌝.
TRACE    Curl error output stream:
   1 ░ ▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-work.f --code 400 http://hello.com
   2 ░ 
DEBUG    The http return code ⌜400⌝ is not acceptable for url ⌜http://hello.com⌝.
```

