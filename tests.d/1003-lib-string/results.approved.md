# Test suite 1003-lib-string

## Test script 00.tests

### Testing string::cutField

Exit code: `0`

**Standard** output:

```plaintext
→ string::cutField 'field1 field2 field3' 0 ' '
field1

→ string::cutField 'field1 field2 field3' 1 ' '
field2

→ string::cutField 'field1,field2,field3' 2 ','
field3

→ string::cutField 'field1,field2,field3' 4 ','


→ string::cutField 'line1 hm I wonder
line2 does it work on lines?
line3 seems so' 2 $'\n'
line3 seems so
```

### Testing string::compareSemanticVersion function

Exit code: `0`

**Standard** output:

```plaintext
→ string::compareSemanticVersion '1.2.3' '1.2.3'
0

→ string::compareSemanticVersion '1.2.3-alpha' '1.2.4+az123'
-1

→ string::compareSemanticVersion '1.2.3' '1.2.2'
1

→ string::compareSemanticVersion '2.2.3' '1.2.3-alpha'
1

→ string::compareSemanticVersion '1.2.3+a1212' '1.3.3'
-1

→ string::compareSemanticVersion '1.2.3-alpha+a123123' '1.2.3-alpha+123zer'
0

→ string::compareSemanticVersion '1.2a.3' '1.2.3derp'
Failed as expected
```

**Error** output:

```log
ERROR    Failed to compare versions ⌜1.2a.3⌝ and ⌜1.2.3derp⌝ because they are not valid semantic versions.
```

### Testing string::bumpSemanticVersion

Exit code: `0`

**Standard** output:

```plaintext
→ bumping 0.0.0 minor
0.1.0

→ bumping 1.2.3-alpha+zae345 major
2.0.0

→ bumping 1.2.3-alpha+zae345 minor
1.3.0

→ bumping 1.2.3-alpha+zae345 patch
1.2.4

→ bumping 1.2.3-alpha+zae345 major false
2.0.0-alpha+zae345

→ bumping 1.2.3-alpha patch false
1.2.157-alpha

→ bumping aze patch false
Failed as expected
```

**Error** output:

```log
ERROR    Failed to bump the version ⌜aze⌝ because it is not valid semantic version.
```

### Testing string::kebabCaseToSnakeCase

Exit code: `0`

**Standard** output:

```plaintext
→ string::kebabCaseToSnakeCase this-is-a-test0
THIS_IS_A_TEST0

→ string::kebabCaseToSnakeCase --another-test
ANOTHER_TEST
```

### Testing string::kebabCaseToSnakeCase

Exit code: `0`

**Standard** output:

```plaintext
→ string::kebabCaseToSnakeCase this-is-a-test0
THIS_IS_A_TEST0

→ string::kebabCaseToSnakeCase --another-test
ANOTHER_TEST
```

### Testing string::kebabCaseToCamelCase

Exit code: `0`

**Standard** output:

```plaintext
→ string::kebabCaseToCamelCase this-is-a-test0
thisIsATest0

→ string::kebabCaseToCamelCase --another-test
anotherTest

→ string::kebabCaseToSnakeCase --last--
last
```

### Testing string::trimAll

Exit code: `0`

**Standard** output:

```plaintext
→ string::trimAll '  a  super test  '
⌜a super test⌝

→ string::trimAll 'this is a command  '
⌜this is a command⌝

→ string::trimAll '\t\nthis is a \tcommand  '
⌜this is a command⌝
```

### Testing string::trim function

Exit code: `0`

**Standard** output:

```plaintext
→ string::trim '  hello  world  '
⌜hello  world⌝

→ string::trim 'hello  '
⌜hello⌝

→ string::trim '  hello'
⌜hello⌝

→ string::trim $'\n'$'\t''  hello'$'\n'$'\t'' '
⌜hello⌝
```

### Testing string::indexOf function

Exit code: `0`

**Standard** output:

```plaintext
→ string::indexOf 'hello' 'l'
2

→ string::indexOf 'hello' 'he'
0

→ string::indexOf 'hello' 'he' 10
-1

→ string::indexOf 'yesyes' 'ye' 1
3

→ string::indexOf 'yesyes' 'yes' 3
3

→ string::indexOf 'yesyes' 'yes' 5
-1

```

### Testing string::extractBetween function

Exit code: `0`

**Standard** output:

```plaintext
→ string::extractBetween 'hello' 'e' 'o'
⌜ll⌝

→ string::extractBetween 'hello' '' 'l'
⌜he⌝

→ string::extractBetween 'hello' 'e' ''
⌜llo⌝

→ string::extractBetween 'hello' 'a' ''
⌜⌝

→ string::extractBetween 'hello' 'h' 'a'
⌜⌝

multilinetext="1 line one
2 line two
3 line three
4 line four"

→ string::extractBetween "${multilinetext}" "one"$'\n' '4'
⌜2 line two
3 line three
⌝

→ string::extractBetween "${multilinetext}" "2 " $'\n'
⌜line two⌝
```

### Testing string::count function

Exit code: `0`

**Standard** output:

```plaintext
→ string::count 'name,firstname,address' ','
⌜2⌝

→ string::count 'bonjour mon bon ami, bonne journée!' 'bo'
⌜3⌝
```

### Testing string::split function

Exit code: `0`

**Standard** output:

```plaintext
→ string:::split 'name:firstname:address' ':'
name
firstname
address

→ string::split 'one\ntwo\nthree' '\n'
one
two
three
```

### Testing string::regexGetFirst function

Exit code: `0`

**Standard** output:

```plaintext
→ string::regexGetFirst 'name: julien' 'name:[[:space:]]*([[:alnum:]]*)'
julien
```

### Testing string::microsecondsToHuman function

Exit code: `0`

**Standard** output:

```plaintext
→ string::microsecondsToHuman 18243002234 'Hours: %HH
Minutes: %MM
Seconds: %SS
Milliseconds: %LL

Hours: %h
Minutes: %m
Seconds: %s
Milliseconds: %l
Microseconds: %u

Total minutes: %M
Total seconds: %S
Total milliseconds: %L
Total microseconds: %U'

Hours: 05
Minutes: 04
Seconds: 03
Milliseconds: 002

Hours: 5
Minutes: 4
Seconds: 3
Milliseconds: 2
Microseconds: 2234

Total minutes: 304
Total seconds: 18243
Total milliseconds: 4320003002
Total microseconds: 18243002234

→ string::microsecondsToHuman 18243002234
05:04:03

→ _OPTION_FORMAT='%U' string::microsecondsToHuman 18243002234
18243002234
```

### Wrapping text at column 30 with no padding

Exit code: `0`

**Standard** output:

```plaintext
→ string::wrapText "${shortText}" 30
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

Exit code: `0`

**Standard** output:

```plaintext
→ string::wrapText "${shortText}" 90 4 false
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

Exit code: `0`

**Standard** output:

```plaintext
→ string::wrapText "${shortText}" 90 2 true
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

### Wrapping characters at column 30 with new line prefix

Exit code: `0`

**Standard** output:

```plaintext
→ string::wrapCharacters "${shortText}" 30 "  " 28
------------------------------
You don't get better on the da
  ys when you feel like going.
   You get better on the days 
  when you don't want to go, b
  ut you go anyway. If you can
   overcome the negative energ
  y coming from your tired bod
  y or unmotivated mind, you w
  ill grow and become better. 
  It won't be the best workout
   you have, you won't accompl
  ish as much as what you usua
  lly do when you actually fee
  l good, but that doesn't mat
  ter. Growth is a long term g
  ame, and the crappy days are
   more important.
```

### Wrapping characters at 20, no other options

Exit code: `0`

**Standard** output:

```plaintext
→ string::wrapCharacters "${shortText}" 20
--------------------
You don't get better
 on the days when yo
u feel like going. Y
ou get better on the
 days when you don't
 want to go, but you
 go anyway. If you c
an overcome the nega
tive energy coming f
rom your tired body 
or unmotivated mind,
 you will grow and b
ecome better. It won
't be the best worko
ut you have, you won
't accomplish as muc
h as what you usuall
y do when you actual
ly feel good, but th
at doesn't matter. G
rowth is a long term
 game, and the crapp
y days are more impo
rtant.
```

