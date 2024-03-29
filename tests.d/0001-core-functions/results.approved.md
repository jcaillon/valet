# Test suite 0001-core-functions

## Test script 01.invoke

### Testing invoke5, executable are taken in priority from VALET_BIN_PATH, input stream from file

Exit code: 0

**Standard** output:

```plaintext
→ invoke5 false 0 true "${tmpFile}" fakeexec --std-in --option argument1 argument2
Invoke function ended with exit code ⌈1⌉.
stdout from file:
⌈⌉
stderr from file:
⌈ERROR    Command not found: ⌜fakeexec⌝.
Please check your ⌜PATH⌝ variable.⌉

```

### Testing invoke5, should return 1, input stream from string

Exit code: 0

**Standard** output:

```plaintext
→ invoke5 false 0 false inputStreamValue fakeexec2 --std-in --error
Invoke function ended with exit code ⌈1⌉.
stdout from file:
⌈▶ called fakeexec2 --std-in --error
▶ fakeexec2 input stream was:
⌈inputStreamValue⌉⌉
stderr from file:
⌈This is an error output from fakeexec2
returning 1 from fakeexec2⌉

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
ERROR    The command ⌜fakeexec2⌝ originally ended with exit code ⌜1⌝.
Standard output:
⌜▶ called fakeexec2 --std-in --error
▶ fakeexec2 input stream was:
⌈inputStreamValue⌉⌝
Error output:
⌜This is an error output from fakeexec2
returning 1 from fakeexec2⌝
```

### Testing invoke5, should translate error 1 to 0

Exit code: 0

**Standard** output:

```plaintext
→ invoke5 true 0,1,2 true '' fakeexec2 --error
Invoke function ended with exit code ⌈0⌉.
stdout from file:
⌈▶ called fakeexec2 --error
▶ fakeexec2 input stream was:
⌈⌉⌉
stderr from file:
⌈This is an error output from fakeexec2
returning 1 from fakeexec2⌉

```

### Testing invoke5var, should get stdout/stderr from var

Exit code: 0

**Standard** output:

```plaintext
→ invoke5var false 0 true '' fakeexec2
Invoke function ended with exit code ⌈0⌉.
stdout from var:
⌈▶ called fakeexec2 
▶ fakeexec2 input stream was:
⌈⌉
⌉
stderr from var:
⌈This is an error output from fakeexec2
⌉

```

### Testing invoke5, with debug mode on

Exit code: 0

**Standard** output:

```plaintext
→ invoke5 false 0 false inputStreamValue fakeexec2 --std-in --error
Invoke function ended with exit code ⌈1⌉.
stdout from file:
⌈▶ called fakeexec2 --std-in --error
▶ fakeexec2 input stream was:
⌈inputStreamValue⌉⌉
stderr from file:
⌈This is an error output from fakeexec2
returning 1 from fakeexec2⌉

```

**Error** output:

```log
DEBUG    Executing the command ⌜fakeexec2⌝.
Fail if it fails: ⌜false⌝
Acceptable error codes: ⌜0⌝
Standard stream from file: ⌜false⌝
Standard stream: ⌜inputStreamValue⌝
Extra parameters: ⌜--std-in --error⌝
DEBUG    The command ⌜fakeexec2⌝ originally ended with exit code ⌜1⌝.
Standard output:
⌜▶ called fakeexec2 --std-in --error
▶ fakeexec2 input stream was:
⌈inputStreamValue⌉⌝
Error output:
⌜This is an error output from fakeexec2
returning 1 from fakeexec2⌝
```

### Testing invoke3, output to files

Exit code: 0

**Standard** output:

```plaintext
→ invoke3 false 0 fakeexec2 --option argument1 argument2
Invoke function ended with exit code ⌈0⌉.
stdout from file:
⌈▶ called fakeexec2 --option argument1 argument2
▶ fakeexec2 input stream was:
⌈⌉⌉
stderr from file:
⌈This is an error output from fakeexec2⌉

```

### Testing invoke3var, output to var

Exit code: 0

**Standard** output:

```plaintext
→ invoke3var false 0 fakeexec2 --option argument1 argument2
Invoke function ended with exit code ⌈0⌉.
stdout from var:
⌈▶ called fakeexec2 --option argument1 argument2
▶ fakeexec2 input stream was:
⌈⌉
⌉
stderr from var:
⌈This is an error output from fakeexec2
⌉

```

### Testing invoke, should fail

Exit code: 1

**Standard** output:

```plaintext
→ invoke fakeexec2 --error
```

**Error** output:

```log
ERROR    The command ⌜fakeexec2⌝ originally ended with exit code ⌜1⌝.
Standard output:
⌜▶ called fakeexec2 --error
▶ fakeexec2 input stream was:
⌈⌉⌝
Error output:
⌜This is an error output from fakeexec2
returning 1 from fakeexec2⌝
```

### Testing invoke, output to var

Exit code: 0

**Standard** output:

```plaintext
→ invoke fakeexec2 --option argument1 argument2
Invoke function ended with exit code ⌈0⌉.
stdout from file:
⌈▶ called fakeexec2 --option argument1 argument2
▶ fakeexec2 input stream was:
⌈⌉⌉
stderr from file:
⌈This is an error output from fakeexec2⌉

```

## Test script 02.kurl

### Testing kurlFile, should write to file

Exit code: 0

**Standard** output:

```plaintext
→ kurlFile false '' "${tmpFile}" --code 200 -curlOption1 --fakeOpt2 https://hello.com
kurlFile false function ended with exit code ⌈0⌉.
http return code was ⌈200⌉
Content of downloaded file:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 200 -curlOption1 --fakeOpt2 https://hello.com
⌉
```

### Testing kurlFile, http code 500 not acceptable return 1

Exit code: 0

**Standard** output:

```plaintext
→ kurlFile false '' "${tmpFile}" --code 500 https://hello.com
kurlFile false function ended with exit code ⌈1⌉.
http return code was ⌈500⌉
Content of downloaded file:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 500 https://hello.com
⌉
```

### Testing kurlFile, http code 500 not acceptable fails

Exit code: 0

**Standard** output:

```plaintext
→ kurlFile true '' "${tmpFile}" --code 500 https://hello.com
```

**Error** output:

```log
ERROR    The http return code ⌜500⌝ is not acceptable for url ⌜https://hello.com⌝.
Error output:
⌜▶ called curl --silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 500 https://hello.com
⌝
```

### Testing kurlFile, http code 500 is now acceptable return 0

Exit code: 0

**Standard** output:

```plaintext
→ kurlFile false '300,500,999' "${tmpFile}" --code 500 https://hello.com
kurlFile false function ended with exit code ⌈0⌉.
http return code was ⌈500⌉
Content of downloaded file:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 500 https://hello.com
⌉
```

### Testing kurlFile, testing debug mode https code 400

Exit code: 0

**Standard** output:

```plaintext
→ kurlFile false '' "${tmpFile}" --code 400 --error https://hello.com/bla --otherOpt
kurlFile false function ended with exit code ⌈1⌉.
http return code was ⌈400⌉
Content of downloaded file:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 400 --error https://hello.com/bla --otherOpt
Returning 1 from curl.
⌉
```

**Error** output:

```log
DEBUG    Executing the command ⌜curl⌝.
Fail if it fails: ⌜false⌝
Acceptable error codes: ⌜0⌝
Standard stream from file: ⌜false⌝
Standard stream: ⌜⌝
Extra parameters: ⌜--silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 400 --error https://hello.com/bla --otherOpt⌝
DEBUG    The command ⌜curl⌝ originally ended with exit code ⌜1⌝.
Standard output:
⌜400⌝
Error output:
⌜▶ called curl --silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 400 --error https://hello.com/bla --otherOpt
Returning 1 from curl.⌝
DEBUG    The curl command for url ⌜https://hello.com/bla⌝ ended with exit code ⌜1⌝, the http return code was ⌜400⌝.
DEBUG    The http return code ⌜400⌝ is not acceptable for url ⌜https://hello.com/bla⌝.
```

### Testing kurlFile, testing debug mode http code 200

Exit code: 0

**Standard** output:

```plaintext
→ kurlFile false '' "${tmpFile}" --code 200 http://hello.com
kurlFile false function ended with exit code ⌈0⌉.
http return code was ⌈200⌉
Content of downloaded file:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 200 http://hello.com
⌉
```

**Error** output:

```log
DEBUG    Executing the command ⌜curl⌝.
Fail if it fails: ⌜false⌝
Acceptable error codes: ⌜0⌝
Standard stream from file: ⌜false⌝
Standard stream: ⌜⌝
Extra parameters: ⌜--silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 200 http://hello.com⌝
DEBUG    The command ⌜curl⌝ originally ended with exit code ⌜0⌝.
The error code ⌜0⌝ is acceptable and has been reset to 0.
Standard output:
⌜200⌝
Error output:
⌜▶ called curl --silent --show-error --location --write-out %{http_code} --output /tmp/kurl-test --code 200 http://hello.com⌝
DEBUG    The curl command for url ⌜http://hello.com⌝ ended with exit code ⌜0⌝, the http return code was ⌜200⌝.
DEBUG    The http return code ⌜200⌝ is acceptable and exit code has been reset to 0 from ⌜0⌝.
```

### Testing kurl, with no content http code 200

Exit code: 0

**Standard** output:

```plaintext
→ kurl false '' --code 200 http://hello.com
kurl function ended with exit code ⌈0⌉.
http return code was ⌈200⌉
stdout:
⌈⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{http_code} --output /tmp/valet-work --code 200 http://hello.com
⌉
```

### Testing kurl, with no content http code 500, fails

Exit code: 0

**Standard** output:

```plaintext
→ kurl false '' --code 500 http://hello.com
```

**Error** output:

```log
ERROR    The http return code ⌜500⌝ is not acceptable for url ⌜http://hello.com⌝.
Error output:
⌜▶ called curl --silent --show-error --location --write-out %{http_code} --output /tmp/valet-work --code 500 http://hello.com
⌝
```

### Testing kurl, debug mode, with content http code 400

Exit code: 0

**Standard** output:

```plaintext
→ kurl false '' --code 400 http://hello.com
kurl function ended with exit code ⌈1⌉.
http return code was ⌈400⌉
stdout:
⌈Writing stuff to file because the --output option was given.⌉
stderr:
⌈▶ called curl --silent --show-error --location --write-out %{http_code} --output /tmp/valet-work --code 400 http://hello.com
⌉
```

**Error** output:

```log
DEBUG    Executing the command ⌜curl⌝.
Fail if it fails: ⌜false⌝
Acceptable error codes: ⌜0⌝
Standard stream from file: ⌜false⌝
Standard stream: ⌜⌝
Extra parameters: ⌜--silent --show-error --location --write-out %{http_code} --output /tmp/valet-work --code 400 http://hello.com⌝
DEBUG    The command ⌜curl⌝ originally ended with exit code ⌜0⌝.
The error code ⌜0⌝ is acceptable and has been reset to 0.
Standard output:
⌜400⌝
Error output:
⌜▶ called curl --silent --show-error --location --write-out %{http_code} --output /tmp/valet-work --code 400 http://hello.com⌝
DEBUG    The curl command for url ⌜http://hello.com⌝ ended with exit code ⌜0⌝, the http return code was ⌜400⌝.
DEBUG    The http return code ⌜400⌝ is not acceptable for url ⌜http://hello.com⌝.
```

## Test script 03.string-manipulation

### Testing indexOf function

Exit code: 0

**Standard** output:

```plaintext
→ indexOf 'hello' 'l'
2=2

→ indexOf 'hello' 'he'
yeah
0=0

→ indexOf 'hello' 'he' 10
nop
-1=-1

→ indexOf 'yesyes' 'ye' 1
3=3

→ indexOf 'yesyes' 'yes' 3
yeah
3=3

→ indexOf 'yesyes' 'yes' 5
-1=-1

```

### Testing extractBetween function

Exit code: 0

**Standard** output:

```plaintext
→ extractBetween 'hello' 'e' 'o'
ll=⌈ll⌉

→ extractBetween 'hello' '' 'l'
he=⌈he⌉

→ extractBetween 'hello' 'e' ''
llo=⌈llo⌉

→ extractBetween 'hello' 'a' ''
=⌈⌉

→ extractBetween 'hello' 'h' 'a'
yeah
=⌈⌉

multilinetext="1 line one
2 line two
3 line three
4 line four"

→ extractBetween "$multilinetext" "one"$'\n' '4'
line 2 and 3=⌈2 line two
3 line three
⌉

→ extractBetween "$multilinetext" "2 " $'\n'
line two=⌈line two⌉
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

### Testing getOsName

Exit code: 0

**Standard** output:

```plaintext
→ OSTYPE=linux-bsd getOsName
linux

→ OSTYPE=msys getOsName
windows

→ OSTYPE=darwin-stuff getOsName
darwin

→ OSTYPE=nop getOsName
unknown

```

