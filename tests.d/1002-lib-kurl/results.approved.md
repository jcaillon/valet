# Test suite 1002-lib-kurl

## Test script 00.kurl

### Testing kurl::toFile, should write to file

Exit code: `0`

**Standard** output:

```plaintext
→ kurl::toFile false '' "${tmpFile}" --code 200 -curlOption1 --fakeOpt2 https://hello.com
kurl::toFile false function ended with exit code ⌈0⌉.
http return code was ⌈200⌉
Content of downloaded file:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet.d/kurl-test --code 200 -curlOption1 --fakeOpt2 https://hello.com
⌉
```

### Testing kurl::toFile, http code 500 not acceptable return 1

Exit code: `1`

**Standard** output:

```plaintext
→ kurl::toFile false '' "${tmpFile}" --code 500 https://hello.com
kurl::toFile false function ended with exit code ⌈1⌉.
http return code was ⌈500⌉
Content of downloaded file:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet.d/kurl-test --code 500 https://hello.com
⌉
```

### Testing kurl::toFile, http code 500 not acceptable fails

Exit code: `1`

**Standard** output:

```plaintext
→ kurl::toFile true '' "${tmpFile}" --code 500 https://hello.com
```

**Error** output:

```log
TRACE    Curl error output stream:
   1 ░ ▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet.d/kurl-test --code 500 https://hello.com
   2 ░ 
ERROR    The http return code ⌜500⌝ is not acceptable for url ⌜https://hello.com⌝.
```

### Testing kurl::toFile, http code 500 is now acceptable return 0

Exit code: `0`

**Standard** output:

```plaintext
→ kurl::toFile false '300,500,999' "${tmpFile}" --code 500 https://hello.com
kurl::toFile false function ended with exit code ⌈0⌉.
http return code was ⌈500⌉
Content of downloaded file:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet.d/kurl-test --code 500 https://hello.com
⌉
```

### Testing kurl::toFile, testing debug mode https code 400

Exit code: `1`

**Standard** output:

```plaintext
→ kurl::toFile false '' "${tmpFile}" --code 400 --error https://hello.com/bla --otherOpt
kurl::toFile false function ended with exit code ⌈1⌉.
http return code was ⌈400⌉
Content of downloaded file:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet.d/kurl-test --code 400 --error https://hello.com/bla --otherOpt
Returning 1 from curl.
⌉
```

**Error** output:

```log
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Executing the command ⌜curl⌝ with arguments (quoted): 
'--silent' '--show-error' '--location' '--write-out' '%{response_code}' '--output' '/tmp/valet.d/kurl-test' '--code' '400' '--error' 'https://hello.com/bla' '--otherOpt'
DEBUG    The command ⌜curl⌝ originally ended with exit code ⌜1⌝.
DEBUG    The curl command for url ⌜https://hello.com/bla⌝ ended with exit code ⌜1⌝, the http return code was ⌜400⌝.
TRACE    Curl error output stream:
   1 ░ ▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet.d/kurl-test --code 400 --error https://hello.com/bla --otherOpt
   2 ░ Returning 1 from curl.
   3 ░ 
DEBUG    The http return code ⌜400⌝ is not acceptable for url ⌜https://hello.com/bla⌝.
```

### Testing kurl::toFile, testing debug mode http code 200

Exit code: `0`

**Standard** output:

```plaintext
→ kurl::toFile false '' "${tmpFile}" --code 200 http://hello.com
kurl::toFile false function ended with exit code ⌈0⌉.
http return code was ⌈200⌉
Content of downloaded file:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet.d/kurl-test --code 200 http://hello.com
⌉
```

**Error** output:

```log
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Executing the command ⌜curl⌝ with arguments (quoted): 
'--silent' '--show-error' '--location' '--write-out' '%{response_code}' '--output' '/tmp/valet.d/kurl-test' '--code' '200' 'http://hello.com'
DEBUG    The command ⌜curl⌝ originally ended with exit code ⌜0⌝.
The error code ⌜0⌝ is acceptable and has been reset to 0.
DEBUG    The curl command for url ⌜http://hello.com⌝ ended with exit code ⌜0⌝, the http return code was ⌜200⌝.
DEBUG    The http return code ⌜200⌝ is acceptable and exit code has been reset to 0 from ⌜0⌝.
```

### Testing kurl, with no content http code 200

Exit code: `0`

**Standard** output:

```plaintext
→ kurl::toVar false '' --code 200 http://hello.com
kurl::toVar function ended with exit code ⌈0⌉.
http return code was ⌈200⌉
stdout:
⌈⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-work --code 200 http://hello.com
⌉
```

### Testing kurl, with no content http code 500, fails

Exit code: `1`

**Standard** output:

```plaintext
→ kurl::toVar false '' --code 500 http://hello.com
```

**Error** output:

```log
TRACE    Curl error output stream:
   1 ░ ▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-work --code 500 http://hello.com
   2 ░ 
ERROR    The http return code ⌜500⌝ is not acceptable for url ⌜http://hello.com⌝.
```

### Testing kurl, debug mode, with content http code 400

Exit code: `1`

**Standard** output:

```plaintext
→ kurl::toVar false '' --code 400 http://hello.com
kurl::toVar function ended with exit code ⌈1⌉.
http return code was ⌈400⌉
stdout:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-work --code 400 http://hello.com
⌉
```

**Error** output:

```log
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Executing the command ⌜curl⌝ with arguments (quoted): 
'--silent' '--show-error' '--location' '--write-out' '%{response_code}' '--output' '/tmp/valet-work' '--code' '400' 'http://hello.com'
DEBUG    The command ⌜curl⌝ originally ended with exit code ⌜0⌝.
The error code ⌜0⌝ is acceptable and has been reset to 0.
DEBUG    The curl command for url ⌜http://hello.com⌝ ended with exit code ⌜0⌝, the http return code was ⌜400⌝.
TRACE    Curl error output stream:
   1 ░ ▶ called curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-work --code 400 http://hello.com
   2 ░ 
DEBUG    The http return code ⌜400⌝ is not acceptable for url ⌜http://hello.com⌝.
```

