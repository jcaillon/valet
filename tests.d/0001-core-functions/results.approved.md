# Test suite 0001-core-functions

## Test script 01.invoke

### Testing invoke5, executable are taken in priority from VALET_BIN_PATH, input stream from file

Exit code: 0

**Standard** output:

```plaintext
→ invoke5 false 0 true "${tmpFile}" fakeexec --std-in --option argument1 argument2
Invoke function ended with exit code ⌜0⌝.
⌜stdout from file⌝:
▶ called fakexec
Input stream was:
---
Input stream content from a file
---
Arguments were:
--std-in --option argument1 argument2
⌜stderr from file⌝:
This is an error output from fakeexec

```

### Testing invoke5, should return 1, input stream from string

Exit code: 0

**Standard** output:

```plaintext
→ invoke5 false 0 false inputStreamValue fakeexec2 --std-in --error
Invoke function ended with exit code ⌜1⌝.
⌜stdout from file⌝:
▶ called fakeexec2
Input stream was:
---
inputStreamValue
---
Arguments were:
--std-in --error
⌜stderr from file⌝:
This is an error output from fakeexec2
returning 1 from fakeexec2

```

### Testing invoke5, should fail

Exit code: 0

**Standard** output:

```plaintext
→ invoke5 true 0 false inputStreamValue fakeexec2 --std-in --error
exitcode=1
```

**Error** output:

```log
ERROR    The command ⌜fakeexec2⌝ failed with exit code ⌜1⌝.
⌜stdout⌝:
▶ called fakeexec2
Input stream was:
---
inputStreamValue
---
Arguments were:
--std-in --error
⌜stderr⌝:
This is an error output from fakeexec2
returning 1 from fakeexec2
```

### Testing invoke5, should translate error 1 to 0

Exit code: 0

**Standard** output:

```plaintext
→ invoke5 true 0,1,2 true '' fakeexec2 --error
Invoke function ended with exit code ⌜0⌝.
⌜stdout from file⌝:
▶ called fakeexec2
Input stream was:
---

---
Arguments were:
--error
⌜stderr from file⌝:
This is an error output from fakeexec2
returning 1 from fakeexec2

```

### Testing invoke5var, should get stdout/stderr from var

Exit code: 0

**Standard** output:

```plaintext
→ invoke5var false 0 true '' fakeexec2
Invoke function ended with exit code ⌜0⌝.
⌜stdout from var⌝:
▶ called fakeexec2
Input stream was:
---

---
Arguments were:


⌜stderr from var⌝:
This is an error output from fakeexec2


```

### Testing invoke5, with debug mode on

Exit code: 0

**Standard** output:

```plaintext
→ invoke5 false 0 false inputStreamValue fakeexec2 --std-in --error
Invoke function ended with exit code ⌜1⌝.
⌜stdout from file⌝:
▶ called fakeexec2
Input stream was:
---
inputStreamValue
---
Arguments were:
--std-in --error
⌜stderr from file⌝:
This is an error output from fakeexec2
returning 1 from fakeexec2

```

**Error** output:

```log
DEBUG    Executing the command ⌜fakeexec2⌝.
Fail if it fails: ⌜false⌝
Acceptable error codes: ⌜0⌝
Standard stream from file: ⌜false⌝
Standard stream: ⌜inputStreamValue⌝
Extra parameters: ⌜--std-in --error⌝

DEBUG    The command ⌜fakeexec2⌝ ended with exit code ⌜1⌝.
⌜stdout⌝:
▶ called fakeexec2
Input stream was:
---
inputStreamValue
---
Arguments were:
--std-in --error
⌜stderr⌝:
This is an error output from fakeexec2
returning 1 from fakeexec2
```

### Testing invoke3, output to files

Exit code: 0

**Standard** output:

```plaintext
→ invoke3 false 0 fakeexec2 --option argument1 argument2
Invoke function ended with exit code ⌜0⌝.
⌜stdout from file⌝:
▶ called fakeexec2
Input stream was:
---

---
Arguments were:
--option argument1 argument2
⌜stderr from file⌝:
This is an error output from fakeexec2

```

### Testing invoke3var, output to var

Exit code: 0

**Standard** output:

```plaintext
→ invoke3var false 0 fakeexec2 --option argument1 argument2
Invoke function ended with exit code ⌜0⌝.
⌜stdout from var⌝:
▶ called fakeexec2
Input stream was:
---

---
Arguments were:
--option argument1 argument2

⌜stderr from var⌝:
This is an error output from fakeexec2


```

## Test script 02.kurl

### Testing kurlFile, empty stderr, should write to file

Exit code: 0

**Standard** output:

```plaintext
→ kurlFile '' "${tmpFile}" -curlOption1 --fakeOpt2 https://hello.com
kurlFile function ended with exit code ⌜1⌝.
http return code was ⌜⌝
⌜Content of downloaded file⌝:
Writing stuff to file because the --output option was given.
⌜stderr⌝:
▶ called curl
Arguments were:
--silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test -curlOption1 --fakeOpt2 https://hello.com
```

### Testing kurlFile, http code 500 not acceptable return 1

Exit code: 0

**Standard** output:

```plaintext
→ kurlFile '' "${tmpFile}" --code 500 https://hello.com
kurlFile function ended with exit code ⌜1⌝.
http return code was ⌜500⌝
⌜Content of downloaded file⌝:
Writing stuff to file because the --output option was given.
⌜stderr⌝:
▶ called curl
Arguments were:
--silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 500 https://hello.com
```

### Testing kurlFile, http code 500 is now acceptable return 0

Exit code: 0

**Standard** output:

```plaintext
→ kurlFile '300,500,999' "${tmpFile}" --code 500 https://hello.com
kurlFile function ended with exit code ⌜0⌝.
http return code was ⌜500⌝
⌜Content of downloaded file⌝:
Writing stuff to file because the --output option was given.
⌜stderr⌝:
▶ called curl
Arguments were:
--silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 500 https://hello.com
```

### Testing kurlFile, testing debug mode https code 400

Exit code: 0

**Standard** output:

```plaintext
→ kurlFile '' "${tmpFile}" --code 400 --error https://hello.com/bla --otherOpt
kurlFile function ended with exit code ⌜1⌝.
http return code was ⌜400⌝
⌜Content of downloaded file⌝:
Writing stuff to file because the --output option was given.
⌜stderr⌝:
▶ called curl
Arguments were:
--silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 400 --error https://hello.com/bla --otherOptReturning 1 from curl.

```

**Error** output:

```log
DEBUG    Executing the command ⌜curl⌝.
Fail if it fails: ⌜false⌝
Acceptable error codes: ⌜0⌝
Standard stream from file: ⌜false⌝
Standard stream: ⌜⌝
Extra parameters: ⌜--silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 400 --error https://hello.com/bla --otherOpt⌝

DEBUG    The command ⌜curl⌝ ended with exit code ⌜1⌝.
⌜stdout⌝:
400
⌜stderr⌝:
▶ called curl
Arguments were:
--silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 400 --error https://hello.com/bla --otherOptReturning 1 from curl.
DEBUG    The curl command for url ⌜https://hello.com/bla⌝ ended with exit code ⌜1⌝, the http return code was ⌜400⌝.
⌜stderr⌝:
▶ called curl
Arguments were:
--silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 400 --error https://hello.com/bla --otherOptReturning 1 from curl.

DEBUG    The http return code ⌜400⌝ is not acceptable and exit code has set to 1 from ⌜1⌝.
```

### Testing kurlFile, testing debug mode http code 200

Exit code: 0

**Standard** output:

```plaintext
→ kurlFile '' "${tmpFile}" --code 200 http://hello.com
kurlFile function ended with exit code ⌜0⌝.
http return code was ⌜200⌝
⌜Content of downloaded file⌝:
Writing stuff to file because the --output option was given.
⌜stderr⌝:
▶ called curl
Arguments were:
--silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 200 http://hello.com
```

**Error** output:

```log
DEBUG    Executing the command ⌜curl⌝.
Fail if it fails: ⌜false⌝
Acceptable error codes: ⌜0⌝
Standard stream from file: ⌜false⌝
Standard stream: ⌜⌝
Extra parameters: ⌜--silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 200 http://hello.com⌝

DEBUG    The command ⌜curl⌝ ended with exit code ⌜0⌝.
⌜stdout⌝:
200
⌜stderr⌝:
▶ called curl
Arguments were:
--silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 200 http://hello.com
DEBUG    The error code ⌜0⌝ is acceptable and has been reset to 0.
DEBUG    The curl command for url ⌜http://hello.com⌝ ended with exit code ⌜0⌝, the http return code was ⌜200⌝.
⌜stderr⌝:
▶ called curl
Arguments were:
--silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 200 http://hello.com
DEBUG    The http return code ⌜200⌝ is acceptable and exit code has been reset to 0 from ⌜0⌝.
```

### Testing kurl, with no content http code 200

Exit code: 0

**Standard** output:

```plaintext
→ kurl '' --code 200 http://hello.com
kurl function ended with exit code ⌜0⌝.
http return code was ⌜200⌝
⌜stdout⌝:

⌜stderr⌝:
▶ called curl
Arguments were:
--silent --show-error --location --write-out %{http_code} --output /tmp/valet-work --code 200 http://hello.com
```

### Testing kurl, debug mode, with content http code 400

Exit code: 0

**Standard** output:

```plaintext
→ kurl '' --code 400 http://hello.com
kurl function ended with exit code ⌜1⌝.
http return code was ⌜400⌝
⌜stdout⌝:
Writing stuff to file because the --output option was given.
⌜stderr⌝:
▶ called curl
Arguments were:
--silent --show-error --location --write-out %{http_code} --output /tmp/valet-work --code 400 http://hello.com
```

**Error** output:

```log
DEBUG    Executing the command ⌜curl⌝.
Fail if it fails: ⌜false⌝
Acceptable error codes: ⌜0⌝
Standard stream from file: ⌜false⌝
Standard stream: ⌜⌝
Extra parameters: ⌜--silent --show-error --location --write-out %{http_code} --output /tmp/valet-work --code 400 http://hello.com⌝

DEBUG    The command ⌜curl⌝ ended with exit code ⌜0⌝.
⌜stdout⌝:
400
⌜stderr⌝:
▶ called curl
Arguments were:
--silent --show-error --location --write-out %{http_code} --output /tmp/valet-work --code 400 http://hello.com
DEBUG    The error code ⌜0⌝ is acceptable and has been reset to 0.
DEBUG    The curl command for url ⌜http://hello.com⌝ ended with exit code ⌜0⌝, the http return code was ⌜400⌝.
⌜stderr⌝:
▶ called curl
Arguments were:
--silent --show-error --location --write-out %{http_code} --output /tmp/valet-work --code 400 http://hello.com
DEBUG    The http return code ⌜400⌝ is not acceptable and exit code has set to 1 from ⌜1⌝.
DEBUG    ⌜curl stdout⌝:
Writing stuff to file because the --output option was given.
```

## Test script 99.tests

### Wrapping text at column 30 with no padding

Exit code: 0

**Standard** output:

```plaintext
→ wrapText "${shortText}" 30
------------------------------
You don't get better on the 
days when you feel like going.
You get better on the days 
when you don't want to go, but
you go anyway. If you can 
overcome the negative energy 
coming from your tired body or
unmotivated mind, you will 
grow and become better. It 
won't be the best workout you 
have, you won't accomplish as 
much as what you usually do 
when you actually feel good, 
but that doesn't matter. 
Growth is a long term game, 
and the crappy days are more 
important.

As long as I focus on what I 
feel and don't worry about 
where I'm going, it works out.
Having no expectations but 
being open to everything is 
what makes wonderful things 
happen. If I don't worry, 
there's no obstruction and 
life flows easily. It sounds 
impractical, but 'Expect 
nothing; be open to 
everything' is really all it 
is.


There were 2 new lines before 
this.
```

### Wrapping text at column 90 with padding of 4 on new lines

Exit code: 0

**Standard** output:

```plaintext
→ wrapText "${shortText}" 90 4 false
------------------------------------------------------------------------------------------
You don't get better on the days when you feel like going. You get better on the days 
    when you don't want to go, but you go anyway. If you can overcome the negative energy 
    coming from your tired body or unmotivated mind, you will grow and become better. It 
    won't be the best workout you have, you won't accomplish as much as what you usually 
    do when you actually feel good, but that doesn't matter. Growth is a long term game, 
    and the crappy days are more important.
    
    As long as I focus on what I feel and don't worry about where I'm going, it works out.
    Having no expectations but being open to everything is what makes wonderful things 
    happen. If I don't worry, there's no obstruction and life flows easily. It sounds 
    impractical, but 'Expect nothing; be open to everything' is really all it is.
    
    
    There were 2 new lines before this.
```

### Wrapping text at column 90 with padding of 2 on all lines

Exit code: 0

**Standard** output:

```plaintext
→ wrapText "${shortText}" 90 2 true
------------------------------------------------------------------------------------------
  You don't get better on the days when you feel like going. You get better on the days 
  when you don't want to go, but you go anyway. If you can overcome the negative energy 
  coming from your tired body or unmotivated mind, you will grow and become better. It 
  won't be the best workout you have, you won't accomplish as much as what you usually do 
  when you actually feel good, but that doesn't matter. Growth is a long term game, and 
  the crappy days are more important.
  
  As long as I focus on what I feel and don't worry about where I'm going, it works out. 
  Having no expectations but being open to everything is what makes wonderful things 
  happen. If I don't worry, there's no obstruction and life flows easily. It sounds 
  impractical, but 'Expect nothing; be open to everything' is really all it is.
  
  
  There were 2 new lines before this.
```

### Testing cutF

Exit code: 0

**Standard** output:

```plaintext
→ cutF "field1 field2 field3" 1 " "
field1

→ cutF "field1 field2 field3" 2 " "
field2

→ cutF "field1 field2 field3" 3 " "
field3

→ cutF "field1 field2 field3" 4 " "
field3

→ cutF "line1 hm I wonder
line2 does it work on lines?
line3 seems so" 2 $'\n'
line2 does it work on lines?
```

### Testing fuzzyMatch

Exit code: 0

**Standard** output:

```plaintext
lines="l1 this is a word
l2 very unbelievable
l2 unbelievable
l3 showcase command1
l4 showcase command2
l5 ublievable"

→ fuzzyMatch evle "${lines}"
l2 very unbelievable

→ fuzzyMatch sh2 "${lines}"
l4 showcase command2

# should prioritize lower index of u
→ fuzzyMatch u "${lines}"
l2 unbelievable

# should be the first equal match
→ fuzzyMatch showcase "${lines}"
l3 showcase command1

# should prioritize lower distance between letters
→ fuzzyMatch lubl "${lines}"
l5 ublievable
```

