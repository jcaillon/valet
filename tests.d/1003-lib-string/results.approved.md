# Test suite 1003-lib-string

## Test script 00.tests

### Testing string::cutField

Exit code: `0`

**Standard output**:

```text
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

**Standard output**:

```text
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

**Error output**:

```text
ERROR    Failed to compare versions ⌜1.2a.3⌝ and ⌜1.2.3derp⌝ because they are not valid semantic versions.
```

### Testing string::bumpSemanticVersion

Exit code: `0`

**Standard output**:

```text
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

**Error output**:

```text
ERROR    Failed to bump the version ⌜aze⌝ because it is not valid semantic version.
```

### Testing string::kebabCaseToSnakeCase

Exit code: `0`

**Standard output**:

```text
→ string::kebabCaseToSnakeCase this-is-a-test0
THIS_IS_A_TEST0

→ string::kebabCaseToSnakeCase --another-test
ANOTHER_TEST
```

### Testing string::kebabCaseToSnakeCase

Exit code: `0`

**Standard output**:

```text
→ string::kebabCaseToSnakeCase this-is-a-test0
THIS_IS_A_TEST0

→ string::kebabCaseToSnakeCase --another-test
ANOTHER_TEST
```

### Testing string::kebabCaseToCamelCase

Exit code: `0`

**Standard output**:

```text
→ string::kebabCaseToCamelCase this-is-a-test0
thisIsATest0

→ string::kebabCaseToCamelCase --another-test
anotherTest

→ string::kebabCaseToSnakeCase --last--
last
```

### Testing string::trimAll

Exit code: `0`

**Standard output**:

```text
→ string::trimAll '  a  super test  '
⌜a super test⌝

→ string::trimAll 'this is a command  '
⌜this is a command⌝

→ string::trimAll '\t\nthis is a \tcommand  '
⌜this is a command⌝
```

### Testing string::trim function

Exit code: `0`

**Standard output**:

```text
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

**Standard output**:

```text
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

**Standard output**:

```text
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

**Standard output**:

```text
→ string::count 'name,firstname,address' ','
⌜2⌝

→ string::count 'bonjour mon bon ami, bonne journée!' 'bo'
⌜3⌝
```

### Testing string::split function

Exit code: `0`

**Standard output**:

```text
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

**Standard output**:

```text
→ string::regexGetFirst 'name: julien' 'name:[[:space:]]*([[:alnum:]]*)'
julien
```

### Testing string::microsecondsToHuman function

Exit code: `0`

**Standard output**:

```text
→ string::microsecondsToHuman 18243002234 'Hours: %HH
Minutes: %MM
Seconds: %SS
Milliseconds: %LL
Microseconds: %UU

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
Microseconds: 234

Hours: 5
Minutes: 4
Seconds: 3
Milliseconds: 2
Microseconds: 234

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

**Standard output**:

```text
→ string::wrapText "${shortText}" 20
------------------------------
You don't [36m[36m[36mget better[39m[39m[39m
on the days when you
feel like going. You
get better on the 
days when you don't 
want to go, but you 
go anyway. If you 
can [34movercome the 
negative energy[39m 
coming from your 
tired body or 
unmotivated mind, 
you will grow and 
become better. It 
won't be the best 
workout you have, 
you won't accomplish
as much as what you 
usually do when you 
actually feel good, 
but that doesn't 
matter. Growth is a 
long term game, and 
the crappy days are 
more important.

As long as I focus 
on what I feel and 
don't worry about 
where I'm going, it 
works out. Having no
expectations but 
being open to 
everything is what 
makes wonderful 
things happen. If I 
don't worry, there's
no obstruction and 
life flows easily. 
It sounds 
impractical, but 
'Expect nothing; be 
open to everything' 
is really all it is.
01234567890123456789
on new line 01234567
890123456789234 line
new line.

https://en.wikipedia
.org/wiki/Veganism

There were 2 new 
lines before this.
```

### Wrapping text at column 50 with padding of 4 on new lines

Exit code: `0`

**Standard output**:

```text
→ string::wrapText "${shortText}" 90 '    '
------------------------------------------------------------------------------------------
You don't [36m[36m[36mget better[39m[39m[39m on the days when you feel 
    like going. You get better on the days when 
    you don't want to go, but you go anyway. If 
    you can [34movercome the negative energy[39m coming 
    from your tired body or unmotivated mind, you 
    will grow and become better. It won't be the 
    best workout you have, you won't accomplish as
    much as what you usually do when you actually 
    feel good, but that doesn't matter. Growth is 
    a long term game, and the crappy days are more
    important.
    
    As long as I focus on what I feel and don't 
    worry about where I'm going, it works out. 
    Having no expectations but being open to 
    everything is what makes wonderful things 
    happen. If I don't worry, there's no 
    obstruction and life flows easily. It sounds 
    impractical, but 'Expect nothing; be open to 
    everything' is really all it is. 
    01234567890123456789 on new line 
    01234567890123456789234 line new line.
    
    https://en.wikipedia.org/wiki/Veganism
    
    There were 2 new lines before this.
```

### Wrapping text at column 20 with padding of 3 on all lines

Exit code: `0`

**Standard output**:

```text
→ string::wrapText "${shortText}" 90 '  ' 88
------------------------------------------------------------------------------------------
  $ {RETURNED_VALUE}
```

### Wrapping words, shortcut because the message is a short single line

Exit code: `0`

**Standard output**:

```text
→ string::wrapText 'A message.' 80
A message.
```

### Wrapping words, no shortcut!

Exit code: `0`

**Standard output**:

```text
→ string::wrapText 'A message.' 80 '' 5
A 
message.
```

### Wrapping words

Exit code: `0`

**Standard output**:

```text
→ string::wrapText 'A message.'$'\n''A new line' 13 '[36m░░░[0m' 10
[36m░░░[0mA message.
[36m░░░[0mA new line
```

### Wrapping characters at column 20 with padding of 3 on all lines

Exit code: `0`

**Standard output**:

```text
→ string::wrapCharacters "${shortText}" 20 "   " 17
--------------------
   You don't [36m[36m[36mget bet
   ter[39m[39m[39m on the days w
   hen you feel like
   going. You get be
   tter on the days 
   when you don't wa
   nt to go, but you
   go anyway. If you
   can [34movercome the 
   negative energy[39m c
   oming from your t
   ired body or unmo
   tivated mind, you
   will grow and bec
   ome better. It wo
   n't be the best w
   orkout you have, 
   you won't accompl
   ish as much as wh
   at you usually do
   when you actually
   feel good, but th
   at doesn't matter
   . Growth is a lon
   g term game, and 
   the crappy days a
   re more important
   .
   
   As long as I focu
   s on what I feel 
   and don't worry a
   bout where I'm go
   ing, it works out
   . Having no expec
   tations but being
   open to everythin
   g is what makes w
   onderful things h
   appen. If I don't
   worry, there's no
   obstruction and l
   ife flows easily.
   It sounds impract
   ical, but 'Expect
   nothing; be open 
   to everything' is
   really all it is.
   01234567890123456
   789 on new line 0
   12345678901234567
   89234 line new li
   ne.
   
   https://en.wikipe
   dia.org/wiki/Vega
   nism
   
   There were 2 new 
   lines before this
   .
```

### Wrapping characters at 20, no other options

Exit code: `0`

**Standard output**:

```text
→ string::wrapCharacters "${shortText}" 20
--------------------
You don't [36m[36m[36mget better[39m[39m[39m
on the days when you
feel like going. You
get better on the da
ys when you don't wa
nt to go, but you go
anyway. If you can [34mo
vercome the negative
energy[39m coming from y
our tired body or un
motivated mind, you 
will grow and become
better. It won't be 
the best workout you
have, you won't acco
mplish as much as wh
at you usually do wh
en you actually feel
good, but that doesn
't matter. Growth is
a long term game, an
d the crappy days ar
e more important.

As long as I focus o
n what I feel and do
n't worry about wher
e I'm going, it work
s out. Having no exp
ectations but being 
open to everything i
s what makes wonderf
ul things happen. If
I don't worry, there
's no obstruction an
d life flows easily.
It sounds impractica
l, but 'Expect nothi
ng; be open to every
thing' is really all
it is. 0123456789012
3456789 on new line 
01234567890123456789
234 line new line.

https://en.wikipedia
.org/wiki/Veganism

There were 2 new lin
es before this.
```

### Wrapping characters

Exit code: `0`

**Standard output**:

```text
→ string::wrapCharacters 01234567890123456789234 17 '   ' 1
-----------------
                0
   12345678901234
   56789234
```

### Wrapping characters

Exit code: `0`

**Standard output**:

```text
→ string::wrapCharacters 'A message.'$'\n''A new line' 13 '[36m░░░[0m' 10
[36m░░░[0mA message.
[36m░░░[0mA new line
```

### Wrapping characters, spaces at the beginning of the line are kept

Exit code: `0`

**Standard output**:

```text
→ string::wrapCharacters '  Start With spaces that must be kept! Other spaces can be ignored at wrapping.'$'\n''  Also start with spaces' 17 '   ' 1
-----------------
     Start With s
   paces that mus
   t be kept! Oth
   er spaces can 
   be ignored at 
   wrapping.
     Also start w
   ith spaces
```

### Testing string::highlight

Exit code: `0`

**Standard output**:

```text
→ string::highlight 'This is a text to highlight.' 'ttttt'
CHITCDEhis is a CHITCDEexCHItCDE CHItCDEo highlighCHItCDE.

→ string::highlight 'This is a text to highlight.' 'TTTTT' '>' '<'
>T<his is a >t<ex>T< >t<o highligh>t<.

→ string::highlight '' 'ttttt'


→ string::highlight 'This is a text to highlight.' ''
This is a text to highlight.
```

