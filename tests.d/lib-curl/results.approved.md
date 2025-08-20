# Test suite lib-curl

## Test script 00.curl

### ✅ Testing curl::download

Writing to an output file:

❯ `curl::download https://fuu --code 200 --- failOnError=true acceptableCodes=200 output=/tmp/valet-temp`

Returned variables:

```text
REPLY_CODE='0'
REPLY='/tmp/valet-temp'
REPLY2='(curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-temp --code 200 https://fuu
'
REPLY3='200'
```

❯ `fs::cat /tmp/valet-temp`

**Standard output**:

```text
(request body response) Writing stuff to file because the --output option was given.
```

Downloading to a temp file:

❯ `curl::download https://fuu --code 200 --- failOnError=true acceptableCodes=200`

Returned variables:

```text
REPLY_CODE='0'
REPLY='/tmp/valet.d/f1-2'
REPLY2='(curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet.d/f1-2 --code 200 https://fuu
'
REPLY3='200'
```

Getting a 500 error with fail mode on:

❯ `curl::download https://fuu --code 500 --- failOnError=true acceptableCodes=200 output=/tmp/valet-temp`

Exited with code: `1`

**Error output**:

```text
TRACE    Curl error output stream:
/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--curl-stderr
   1 ░ (curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-temp --code 500 https://fuu
   2 ░ 
FAIL     The http return code ⌜500⌝ is not acceptable for url ⌜https://fuu⌝ (acceptable codes are: 200).
```

Getting a 500 error with fail mode off:

❯ `curl::download https://fuu --code 500 --- acceptableCodes=200 output=/tmp/valet-temp`

Returned variables:

```text
REPLY_CODE='1'
REPLY='/tmp/valet-temp'
REPLY2='(curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-temp --code 500 https://fuu
'
REPLY3='500'
```

Getting an acceptable 400 error with fail mode:

❯ `curl::download https://fuu --code 400 --- failOnError=true acceptableCodes=200,400,401 output=/tmp/valet-temp`

Returned variables:

```text
REPLY_CODE='0'
REPLY='/tmp/valet-temp'
REPLY2='(curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-temp --code 400 https://fuu
'
REPLY3='400'
```

Getting an acceptable 201 with debug mode on

❯ `log::setLevel debug`

**Error output**:

```text
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
```

❯ `curl::download https://fuu --code 201 --- failOnError=false output=/tmp/valet-temp`

**Error output**:

```text
DEBUG    Executing the command curl.
DEBUG    The command curl ended with exit code 0 in 10.000s.
DEBUG    The curl command for url ⌜https://fuu⌝ ended with exit code ⌜0⌝, the http return code was ⌜201⌝.
DEBUG    The http return code ⌜201⌝ is acceptable and exit code has been reset to 0 from ⌜0⌝.
```

Returned variables:

```text
REPLY_CODE='0'
REPLY='/tmp/valet-temp'
REPLY2='(curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-temp --code 201 https://fuu
'
REPLY3='201'
```

❯ `log::setLevel info`

### ✅ Testing curl::request

Getting 200:

❯ `curl::request https://fuu --code 200 --- failOnError=true acceptableCodes=200`

Returned variables:

```text
REPLY_CODE='0'
REPLY='(request body response) Writing stuff to file because the --output option was given.'
REPLY2='(curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-work.f --code 200 https://fuu
'
REPLY3='200'
```

Getting 500 with fail mode off:

❯ `curl::request https://fuu --code 500 --- failOnError=false`

Returned variables:

```text
REPLY_CODE='0'
REPLY='(request body response) Writing stuff to file because the --output option was given.'
REPLY2='(curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-work.f --code 500 https://fuu
'
REPLY3='500'
```

Getting 500 with fail mode on:

❯ `curl::request https://fuu --code 500 --- failOnError=true acceptableCodes=200`

Exited with code: `1`

**Error output**:

```text
TRACE    Curl error output stream:
/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--curl-stderr
   1 ░ (curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet.d/job-work.f --code 500 https://fuu
   2 ░ 
FAIL     The http return code ⌜500⌝ is not acceptable for url ⌜https://fuu⌝ (acceptable codes are: 200).
```

Getting 200 with no content and debug mode on:

❯ `log::setLevel debug`

**Error output**:

```text
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
```

❯ `curl::request https://fuu --code 200 --- failOnError=true acceptableCodes=200`

**Error output**:

```text
DEBUG    Executing the command curl.
DEBUG    The command curl ended with exit code 0 in 16.000s.
DEBUG    The curl command for url ⌜https://fuu⌝ ended with exit code ⌜0⌝, the http return code was ⌜200⌝.
DEBUG    The http return code ⌜200⌝ is acceptable and exit code has been reset to 0 from ⌜0⌝.
```

Returned variables:

```text
REPLY_CODE='0'
REPLY=''
REPLY2='(curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-work.f --code 200 https://fuu
'
REPLY3='200'
```

❯ `log::setLevel info`

