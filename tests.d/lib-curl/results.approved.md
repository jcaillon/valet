# Test suite lib-curl

## Test script 00.curl

### ✅ Testing curl::toFile

Writing to an output file:

❯ `curl::toFile true 200 /tmp/valet-temp --code 200 https://fuu`

Returned variables:

```text
RETURNED_VALUE=$'(curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-temp --code 200 https://fuu\n'
RETURNED_VALUE2='200'
```

❯ `io::cat /tmp/valet-temp`

**Standard output**:

```text
(request body response) Writing stuff to file because the --output option was given.
```

Getting a 500 error with fail mode on:

❯ `curl::toFile true 200 /tmp/valet-temp --code 500 https://fuu`

Exited with code: `1`

**Error output**:

```text
TRACE    Curl error output stream:
   1 ░ (curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-temp --code 500 https://fuu
   2 ░ 
ERROR    The http return code ⌜500⌝ is not acceptable for url ⌜https://fuu⌝.
```

Getting a 500 error with fail mode off:

❯ `curl::toFile false 200 /tmp/valet-temp --code 500 https://fuu`

Exited with code: `1`

Returned variables:

```text
RETURNED_VALUE=$'(curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-temp --code 500 https://fuu\n'
RETURNED_VALUE2='500'
```

Getting an acceptable 400 error with fail mode:

❯ `curl::toFile true 200,400,401 /tmp/valet-temp --code 400 https://fuu`

Returned variables:

```text
RETURNED_VALUE=$'(curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-temp --code 400 https://fuu\n'
RETURNED_VALUE2='400'
```

Getting an acceptable 201 with debug mode on

❯ `log::setLevel debug`

**Error output**:

```text
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
```

❯ `curl::toFile false '' /tmp/valet-temp --code 201 https://fuu`

**Error output**:

```text
DEBUG    Executing the command ⌜curl⌝ with arguments (quoted): 
'--silent' '--show-error' '--location' '--write-out' '%{response_code}' '--output' '/tmp/valet-temp' '--code' '201' 'https://fuu'
DEBUG    The command ⌜curl⌝ originally ended with exit code ⌜0⌝.
DEBUG    The curl command for url ⌜https://fuu⌝ ended with exit code ⌜0⌝, the http return code was ⌜201⌝.
DEBUG    The http return code ⌜201⌝ is acceptable and exit code has been reset to 0 from ⌜0⌝.
```

Returned variables:

```text
RETURNED_VALUE=$'(curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-temp --code 201 https://fuu\n'
RETURNED_VALUE2='201'
```

❯ `log::setLevel info`

### ✅ Testing curl::toVar

Getting 200:

❯ `curl::toVar true 200 /tmp/valet-temp --code 200 https://fuu`

Returned variables:

```text
RETURNED_VALUE='(request body response) Writing stuff to file because the --output option was given.'
RETURNED_VALUE2=$'(curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-work.f /tmp/valet-temp --code 200 https://fuu\n'
RETURNED_VALUE3='200'
```

Getting 500 with fail mode off:

❯ `curl::toVar false '' /tmp/valet-temp --code 500 https://fuu`

Exited with code: `1`

Getting 500 with fail mode on:

❯ `curl::toVar true 200 /tmp/valet-temp --code 500 https://fuu`

Exited with code: `1`

**Error output**:

```text
TRACE    Curl error output stream:
   1 ░ (curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-work.f /tmp/valet-temp --code 500 https://fuu
   2 ░ 
ERROR    The http return code ⌜500⌝ is not acceptable for url ⌜https://fuu⌝.
```

Getting 200 with no content and debug mode on:

❯ `log::setLevel debug`

**Error output**:

```text
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
```

❯ `curl::toVar true 200 /tmp/valet-temp --code 200 https://fuu`

**Error output**:

```text
DEBUG    Executing the command ⌜curl⌝ with arguments (quoted): 
'--silent' '--show-error' '--location' '--write-out' '%{response_code}' '--output' '/tmp/valet-work.f' '/tmp/valet-temp' '--code' '200' 'https://fuu'
DEBUG    The command ⌜curl⌝ originally ended with exit code ⌜0⌝.
DEBUG    The curl command for url ⌜https://fuu⌝ ended with exit code ⌜0⌝, the http return code was ⌜200⌝.
DEBUG    The http return code ⌜200⌝ is acceptable and exit code has been reset to 0 from ⌜0⌝.
```

Returned variables:

```text
RETURNED_VALUE=''
RETURNED_VALUE2=$'(curl logs) mocking curl --silent --show-error --location --write-out %{response_code} --output /tmp/valet-work.f /tmp/valet-temp --code 200 https://fuu\n'
RETURNED_VALUE3='200'
```

❯ `log::setLevel info`

