# Test suite lib-string

## Test script 00.tests

### ✅ Testing string::getField

```text
str='field1 field2 field3'
```

❯ `string::getField str 0 \ `

Returned variables:

```text
RETURNED_VALUE='field1'
```

❯ `string::getField str 1 \ `

Returned variables:

```text
RETURNED_VALUE='field2'
```

❯ `string::getField str 2 ,`

Returned variables:

```text
RETURNED_VALUE=''
```

❯ `string::getField str 4 ,`

Returned variables:

```text
RETURNED_VALUE=''
```

```text
str='line1 hm I wonder
line2 does it work on lines?
line3 seems so'
```

❯ `string::getField str 2 $'\n'`

Returned variables:

```text
RETURNED_VALUE='line3 seems so'
```

### ✅ Testing string::convertCamelCaseToSnakeCase

❯ `str=thisIsATest0 string::convertCamelCaseToSnakeCase str`

Returned variables:

```text
RETURNED_VALUE='THIS_IS_A_TEST0'
```

❯ `str=AnotherTest string::convertCamelCaseToSnakeCase str`

Returned variables:

```text
RETURNED_VALUE='ANOTHER_TEST'
```

### ✅ Testing string::convertKebabCaseToSnakeCase

❯ `str=this-is-a-test0 string::convertKebabCaseToSnakeCase str`

Returned variables:

```text
RETURNED_VALUE='THIS_IS_A_TEST0'
```

❯ `str=--another-test string::convertKebabCaseToSnakeCase str`

Returned variables:

```text
RETURNED_VALUE='ANOTHER_TEST'
```

### ✅ Testing string::convertKebabCaseToCamelCase

❯ `str=this-is-a-test0 string::convertKebabCaseToCamelCase str`

Returned variables:

```text
RETURNED_VALUE='thisIsATest0'
```

❯ `str=--another-test string::convertKebabCaseToCamelCase str`

Returned variables:

```text
RETURNED_VALUE='anotherTest'
```

❯ `str=--anotherTest string::convertKebabCaseToCamelCase str`

Returned variables:

```text
RETURNED_VALUE='anothertest'
```

❯ `str=--last-- string::convertKebabCaseToCamelCase str`

Returned variables:

```text
RETURNED_VALUE='last'
```

### ✅ Testing string::trimAll

```text
MY_STRING='  a  super test  '
```

❯ `string::trimAll MY_STRING`

```text
MY_STRING='a super test'
```

```text
MY_STRING='this is a command  '
```

❯ `string::trimAll MY_STRING`

```text
MY_STRING='this is a command'
```

```text
MY_STRING='	
this is a 	command  '
```

❯ `string::trimAll MY_STRING`

```text
MY_STRING='this is a command'
```

### ✅ Testing string::trimEdges

```text
MY_STRING='  hello  world  '
```

❯ `string::trimEdges MY_STRING`

```text
MY_STRING='hello  world'
```

```text
MY_STRING='hello  '
```

❯ `string::trimEdges MY_STRING`

```text
MY_STRING='hello'
```

```text
MY_STRING='  hello'
```

❯ `string::trimEdges MY_STRING`

```text
MY_STRING='hello'
```

```text
MY_STRING='
	  hello
	 '
```

❯ `string::trimEdges MY_STRING`

```text
MY_STRING='hello'
```

### ✅ Testing string::getIndexOf function

❯ `str=hello string::getIndexOf str l`

Returned variables:

```text
RETURNED_VALUE='2'
```

❯ `str=hello string::getIndexOf str he`

Returned variables:

```text
RETURNED_VALUE='0'
```

❯ `str=hello string::getIndexOf str he 10`

Returned variables:

```text
RETURNED_VALUE='-1'
```

❯ `str=yes-yes string::getIndexOf str ye 1`

Returned variables:

```text
RETURNED_VALUE='4'
```

❯ `str=yes-yes string::getIndexOf str yes 5`

Returned variables:

```text
RETURNED_VALUE='-1'
```

### ✅ Testing string::extractBetween function

❯ `str=hello string::extractBetween str e o`

Returned variables:

```text
RETURNED_VALUE='ll'
```

❯ `str=hello string::extractBetween str e ''`

Returned variables:

```text
RETURNED_VALUE='llo'
```

❯ `str=hello string::extractBetween str h a`

Returned variables:

```text
RETURNED_VALUE=''
```

```text
MULTI_LINES_TEXT2='1 line one
2 line two
3 line three
4 line four'
```

❯ `string::extractBetween MULTI_LINES_TEXT2 $'one\n' 4`

Returned variables:

```text
RETURNED_VALUE='2 line two
3 line three
'
```

❯ `string::extractBetween MULTI_LINES_TEXT2 2\  $'\n'`

Returned variables:

```text
RETURNED_VALUE='line two'
```

### ✅ Testing string::count function

❯ `str=name,firstname,address string::count str ,`

Returned variables:

```text
RETURNED_VALUE='2'
```

❯ `str=bonjour\ mon\ bon\ ami\,\ bonne\ journée\! string::count str bo`

Returned variables:

```text
RETURNED_VALUE='3'
```

### ✅ Testing string::split function

❯ `str=name:firstname:address string::split str :`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='name'
[1]='firstname'
[2]='address'
)
```

❯ `str=one:two,three string::split str :,`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='one'
[1]='two'
[2]='three'
)
```

### ✅ Testing string::wrapWords

Wrapping text at column 30 with no padding

❯ `string::wrapWords "${MULTI_LINES_TEXT}" 30`

Returned variables:

```text
RETURNED_VALUE='You don`t [36m[36m[36mget better[39m[39m[39m on the 
days when you feel like going.
You get better on the days 
when you don`t want to go, but
you go anyway. If you can 
[34movercome the negative energy[39m 
coming from your tired body or
unmotivated mind, you will 
grow and become better. It 
won`t be the best workout you 
have, you won`t accomplish as 
much as what you usually do 
when you actually feel good, 
but that doesn`t matter. 
Growth is a long term game, 
and the crappy days are more 
important.

As long as I focus on what I 
feel and don`t worry about 
where I`m going, it works out.
Having no expectations but 
being open to everything is 
what makes wonderful things 
happen. If I don`t worry, 
there`s no obstruction and 
life flows easily. It sounds 
impractical, but `Expect 
nothing; be open to 
everything` is really all it 
is. 01234567890123456789 on 
new line 
01234567890123456789234 line 
new line.

https://en.wikipedia.org/wiki/
Veganism

There were 2 new lines before 
this.'
RETURNED_VALUE2='8'
```

Wrapping text at column 50 with padding of 4 on new lines

❯ `string::wrapWords "${MULTI_LINES_TEXT}" 50 \ \ \ \ `

Returned variables:

```text
RETURNED_VALUE='You don`t [36m[36m[36mget better[39m[39m[39m on the days when you feel 
    like going. You get better on the days when 
    you don`t want to go, but you go anyway. If 
    you can [34movercome the negative energy[39m coming 
    from your tired body or unmotivated mind, you 
    will grow and become better. It won`t be the 
    best workout you have, you won`t accomplish as
    much as what you usually do when you actually 
    feel good, but that doesn`t matter. Growth is 
    a long term game, and the crappy days are more
    important.
    
    As long as I focus on what I feel and don`t 
    worry about where I`m going, it works out. 
    Having no expectations but being open to 
    everything is what makes wonderful things 
    happen. If I don`t worry, there`s no 
    obstruction and life flows easily. It sounds 
    impractical, but `Expect nothing; be open to 
    everything` is really all it is. 
    01234567890123456789 on new line 
    01234567890123456789234 line new line.
    
    https://en.wikipedia.org/wiki/Veganism
    
    There were 2 new lines before this.'
```

Wrapping text at column 20 with padding of 3 on all lines

❯ `string::wrapWords "${MULTI_LINES_TEXT}" 20 \ \ \  17`

Returned variables:

```text
RETURNED_VALUE='You don`t [36m[36m[36mget 
   better[39m[39m[39m on the 
   days when you 
   feel like going. 
   You get better on
   the days when you
   don`t want to go,
   but you go 
   anyway. If you 
   can [34movercome the 
   negative energy[39m 
   coming from your 
   tired body or 
   unmotivated mind,
   you will grow and
   become better. It
   won`t be the best
   workout you have,
   you won`t 
   accomplish as 
   much as what you 
   usually do when 
   you actually feel
   good, but that 
   doesn`t matter. 
   Growth is a long 
   term game, and 
   the crappy days 
   are more 
   important.
   
   As long as I 
   focus on what I 
   feel and don`t 
   worry about where
   I`m going, it 
   works out. Having
   no expectations 
   but being open to
   everything is 
   what makes 
   wonderful things 
   happen. If I 
   don`t worry, 
   there`s no 
   obstruction and 
   life flows 
   easily. It sounds
   impractical, but 
   `Expect nothing; 
   be open to 
   everything` is 
   really all it is.
   01234567890123456
   789 on new line 0
   12345678901234567
   89234 line new 
   line.
   
   https://en.wikipe
   dia.org/wiki/Vega
   nism
   
   There were 2 new 
   lines before 
   this.'
RETURNED_VALUE2='4'
```

Wrapping words, shortcut because the message is a short single line

❯ `string::wrapWords A\ message. 80`

Returned variables:

```text
RETURNED_VALUE='A message.'
```

Wrapping words, no shortcut!

❯ `string::wrapWords A\ message. 80 '' 5`

Returned variables:

```text
RETURNED_VALUE='A 
message.'
```

Wrapping words

❯ `string::wrapWords $'A message.\nA new line' 13 [36m░░░[0m 10`

Returned variables:

```text
RETURNED_VALUE='A message.
[36m░░░[0mA new line'
```

### ✅ Testing string::wrapCharacters

Wrapping characters at column 20 with padding of 3 on all lines

❯ `string::wrapCharacters "${MULTI_LINES_TEXT}" 20 \ \ \  17`

Returned variables:

```text
RETURNED_VALUE='You don`t [36m[36m[36mget bet
   ter[39m[39m[39m on the days w
   hen you feel like
   going. You get be
   tter on the days 
   when you don`t wa
   nt to go, but you
   go anyway. If you
   can [34movercome the 
   negative energy[39m c
   oming from your t
   ired body or unmo
   tivated mind, you
   will grow and bec
   ome better. It wo
   n`t be the best w
   orkout you have, 
   you won`t accompl
   ish as much as wh
   at you usually do
   when you actually
   feel good, but th
   at doesn`t matter
   . Growth is a lon
   g term game, and 
   the crappy days a
   re more important
   .
   
   As long as I focu
   s on what I feel 
   and don`t worry a
   bout where I`m go
   ing, it works out
   . Having no expec
   tations but being
   open to everythin
   g is what makes w
   onderful things h
   appen. If I don`t
   worry, there`s no
   obstruction and l
   ife flows easily.
   It sounds impract
   ical, but `Expect
   nothing; be open 
   to everything` is
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
   .'
RETURNED_VALUE2='1'
```

Wrapping characters at 20, no other options

❯ `string::wrapCharacters "${MULTI_LINES_TEXT}" 20`

Returned variables:

```text
RETURNED_VALUE='You don`t [36m[36m[36mget better[39m[39m[39m
on the days when you
feel like going. You
get better on the da
ys when you don`t wa
nt to go, but you go
anyway. If you can [34mo
vercome the negative
energy[39m coming from y
our tired body or un
motivated mind, you 
will grow and become
better. It won`t be 
the best workout you
have, you won`t acco
mplish as much as wh
at you usually do wh
en you actually feel
good, but that doesn
`t matter. Growth is
a long term game, an
d the crappy days ar
e more important.

As long as I focus o
n what I feel and do
n`t worry about wher
e I`m going, it work
s out. Having no exp
ectations but being 
open to everything i
s what makes wonderf
ul things happen. If
I don`t worry, there
`s no obstruction an
d life flows easily.
It sounds impractica
l, but `Expect nothi
ng; be open to every
thing` is really all
it is. 0123456789012
3456789 on new line 
01234567890123456789
234 line new line.

https://en.wikipedia
.org/wiki/Veganism

There were 2 new lin
es before this.'
RETURNED_VALUE2='15'
```

Wrapping characters

❯ `string::wrapCharacters 01234567890123456789234 17 \ \ \  1`

Returned variables:

```text
RETURNED_VALUE='0
   12345678901234
   56789234'
RETURNED_VALUE2='8'
```

Wrapping characters

❯ `string::wrapCharacters $'A message.\nA new line' 13 [36m░░░[0m 10`

Returned variables:

```text
RETURNED_VALUE='A message.
[36m░░░[0mA new line'
RETURNED_VALUE2='0'
```

Wrapping characters, spaces at the beginning of the line are kept

❯ `string::wrapCharacters $'  Start With spaces that must be kept! Other spaces can be ignored at wrapping.\n  Also start with spaces' 17 \ \ \  14`

Returned variables:

```text
RETURNED_VALUE='  Start With s
   paces that mus
   t be kept! Oth
   er spaces can 
   be ignored at 
   wrapping.
     Also start w
   ith spaces'
RETURNED_VALUE2='10'
```

### ✅ Testing string::highlight

❯ `string::highlight This\ is\ a\ Text\ to\ highlight. ttttt`

Returned variables:

```text
RETURNED_VALUE='CHITCDEhis is a CHITCDEexCHItCDE CHItCDEo highlighCHItCDE.'
```

❯ `string::highlight This\ is\ a\ texT\ to\ highlight. TTTTT '>' '<'`

Returned variables:

```text
RETURNED_VALUE='>T<his is a >t<ex>T< >t<o highligh>t<.'
```

❯ `string::highlight '' ttttt`

Returned variables:

```text
RETURNED_VALUE=''
```

❯ `string::highlight This\ is\ a\ text\ to\ highlight. ''`

Returned variables:

```text
RETURNED_VALUE='This is a text to highlight.'
```

### ✅ Testing string::head

```text
MULTI_LINES_TEXT2='1 line one
2 line two
3 line three
4 line four'
```

Testing string::head with 2 lines

❯ `string::head MULTI_LINES_TEXT2 2`

Returned variables:

```text
RETURNED_VALUE='1 line one
2 line two
'
```

Testing string::head with 0 line

❯ `string::head MULTI_LINES_TEXT2 0`

Returned variables:

```text
RETURNED_VALUE=''
```

Testing string::head with 10 lines

❯ `string::head MULTI_LINES_TEXT2 10`

Returned variables:

```text
RETURNED_VALUE='1 line one
2 line two
3 line three
4 line four
'
```

### ✅ Testing string::doForEachLine

❯ `string::doForEachLine MULTI_LINES_TEXT3 forEachLine`

**Standard output**:

```text
Line: '1 line one'
Line: ''
Line: '3 line three'
Line: '4 line four'
```

