# Test suite lib-string

## Test script 00.tests

### ✅ Testing string::removeTextFormatting

❯ `string::removeTextFormatting _myString`

```text
_myString='My text with some text formatting and some more textunreadable stuff. Inluding some 123;55;25524 bit colors and some 28 bit colors.'
```

### ✅ Testing string::convertToHex

❯ `_myString=d071ec191f6e98a9c78b6d502c823d8e5adcfdf83d0ea55ebc7f242b29ce8301 string::convertToHex _myString`

Returned variables:

```text
REPLY='64303731656331393166366539386139633738623664353032633832336438653561646366646638336430656135356562633766323432623239636538333031'
```

### ✅ Testing string::removeSgrCodes

❯ `string::removeSgrCodes _myStringWithSgrCodes`

```text
_myStringWithSgrCodes='word!'
```

### ✅ Testing string::getField

```text
_MY_STRING='field1 field2 field3'
```

❯ `string::getField _MY_STRING 0 \ `

Returned variables:

```text
REPLY='field1'
```

❯ `string::getField _MY_STRING 1 \ `

Returned variables:

```text
REPLY='field2'
```

❯ `string::getField _MY_STRING 2 ,`

Returned variables:

```text
REPLY=''
```

❯ `string::getField _MY_STRING 4 ,`

Returned variables:

```text
REPLY=''
```

```text
_MY_STRING='line1 hm I wonder
line2 does it work on lines?
line3 seems so'
```

❯ `string::getField _MY_STRING 2 $'\n'`

Returned variables:

```text
REPLY='line3 seems so'
```

### ✅ Testing string::convertCamelCaseToSnakeCase

❯ `_MY_STRING=thisIsATest0 string::convertCamelCaseToSnakeCase _MY_STRING`

Returned variables:

```text
REPLY='THIS_IS_A_TEST0'
```

❯ `_MY_STRING=AnotherTest string::convertCamelCaseToSnakeCase _MY_STRING`

Returned variables:

```text
REPLY='ANOTHER_TEST'
```

### ✅ Testing string::convertKebabCaseToSnakeCase

❯ `_MY_STRING=this-is-a-test0 string::convertKebabCaseToSnakeCase _MY_STRING`

Returned variables:

```text
REPLY='THIS_IS_A_TEST0'
```

❯ `_MY_STRING=--another-test string::convertKebabCaseToSnakeCase _MY_STRING`

Returned variables:

```text
REPLY='ANOTHER_TEST'
```

### ✅ Testing string::convertKebabCaseToCamelCase

❯ `_MY_STRING=this-is-a-test0 string::convertKebabCaseToCamelCase _MY_STRING`

Returned variables:

```text
REPLY='thisIsATest0'
```

❯ `_MY_STRING=--another-test string::convertKebabCaseToCamelCase _MY_STRING`

Returned variables:

```text
REPLY='anotherTest'
```

❯ `_MY_STRING=--anotherTest string::convertKebabCaseToCamelCase _MY_STRING`

Returned variables:

```text
REPLY='anothertest'
```

❯ `_MY_STRING=--last-- string::convertKebabCaseToCamelCase _MY_STRING`

Returned variables:

```text
REPLY='last'
```

### ✅ Testing string::trimAll

```text
MY_STRING='  a  super test  '
```

❯ `string::trimAll MY_STRING`

Returned variables:

```text
REPLY='a super test'
```

```text
MY_STRING='this is a command  '
```

❯ `string::trimAll MY_STRING`

Returned variables:

```text
REPLY='this is a command'
```

```text
MY_STRING='	
this is a 	command  '
```

❯ `string::trimAll MY_STRING`

Returned variables:

```text
REPLY='this is a command'
```

### ✅ Testing string::trimEdges

```text
MY_STRING='  hello  world  '
```

❯ `string::trimEdges MY_STRING`

Returned variables:

```text
REPLY='hello  world'
```

```text
MY_STRING='_-_-_hello_-_'
```

❯ `string::trimEdges MY_STRING _-`

Returned variables:

```text
REPLY='hello'
```

```text
MY_STRING='  hello'
```

❯ `string::trimEdges MY_STRING`

Returned variables:

```text
REPLY='hello'
```

```text
MY_STRING='
	  hello
	 '
```

❯ `string::trimEdges MY_STRING`

Returned variables:

```text
REPLY='hello'
```

### ✅ Testing string::getIndexOf function

❯ `_MY_STRING=hello string::getIndexOf _MY_STRING l`

Returned variables:

```text
REPLY='2'
```

❯ `_MY_STRING=hello string::getIndexOf _MY_STRING he`

Returned variables:

```text
REPLY='0'
```

❯ `_MY_STRING=hello string::getIndexOf _MY_STRING he 10`

Returned variables:

```text
REPLY='-1'
```

❯ `_MY_STRING=yes-yes string::getIndexOf _MY_STRING ye 1`

Returned variables:

```text
REPLY='4'
```

❯ `_MY_STRING=yes-yes string::getIndexOf _MY_STRING yes 5`

Returned variables:

```text
REPLY='-1'
```

### ✅ Testing string::extractBetween function

❯ `_MY_STRING=hello string::extractBetween _MY_STRING e o`

Returned variables:

```text
REPLY='ll'
```

❯ `_MY_STRING=hello string::extractBetween _MY_STRING e ''`

Returned variables:

```text
REPLY='llo'
```

❯ `_MY_STRING=hello string::extractBetween _MY_STRING h a`

Returned variables:

```text
REPLY=''
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
REPLY='2 line two
3 line three
'
```

❯ `string::extractBetween MULTI_LINES_TEXT2 2\  $'\n'`

Returned variables:

```text
REPLY='line two'
```

### ✅ Testing string::count function

❯ `_MY_STRING=name,firstname,address string::count _MY_STRING ,`

Returned variables:

```text
REPLY='2'
```

❯ `_MY_STRING=bonjour\ mon\ bon\ ami\,\ bonne\ journée\! string::count _MY_STRING bo`

Returned variables:

```text
REPLY='3'
```

### ✅ Testing string::split function

❯ `_MY_STRING=name:firstname:address string::split _MY_STRING :`

Returned variables:

```text
REPLY_ARRAY=(
[0]='name'
[1]='firstname'
[2]='address'
)
```

❯ `_MY_STRING=one:two,three string::split _MY_STRING :,`

Returned variables:

```text
REPLY_ARRAY=(
[0]='one'
[1]='two'
[2]='three'
)
```

### ✅ Testing string::wrapWords

Wrapping text at column 30 with no padding

❯ `string::wrapWords MULTI_LINES_TEXT 30`

Returned variables:

```text
REPLY='You don`t [36m[36m[36mget better[39m[39m[39m on the 
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
```

Wrapping text at column 50 with padding of 4 on new lines

❯ `string::wrapWords MULTI_LINES_TEXT 50 \ \ \ \ `

Returned variables:

```text
REPLY='You don`t [36m[36m[36mget better[39m[39m[39m on the days when you feel 
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

❯ `string::wrapWords MULTI_LINES_TEXT 20 \ \ \  17`

Returned variables:

```text
REPLY='You don`t [36m[36m[36mget 
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
```

Wrapping words, shortcut because the message is a short single line

❯ `_MY_STRING=A\ message. string::wrapWords _MY_STRING 80`

Returned variables:

```text
REPLY='A message.'
```

Wrapping words, no shortcut!

❯ `_MY_STRING=A\ message. string::wrapWords _MY_STRING 80 '' 5`

Returned variables:

```text
REPLY='A 
message.'
```

Wrapping words

```text
MY_STRING='A message.
A new line'
```

❯ `string::wrapWords MY_STRING 13 [36m░░░[0m 10`

Returned variables:

```text
REPLY='A message.
[36m░░░[0mA new line'
```

### ✅ Testing string::wrapCharacters

Wrapping characters at column 20 with padding of 3 on all lines

❯ `string::wrapCharacters MULTI_LINES_TEXT 20 \ \ \  17`

Returned variables:

```text
REPLY='You don`t [36m[36m[36mget bet
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
REPLY2='1'
```

Wrapping characters at 20, no other options

❯ `string::wrapCharacters MULTI_LINES_TEXT 20`

Returned variables:

```text
REPLY='You don`t [36m[36m[36mget better[39m[39m[39m
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
REPLY2='15'
```

Wrapping characters

```text
MY_STRING='01234567890123456789234'
```

❯ `string::wrapCharacters MY_STRING 17 \ \ \  1`

Returned variables:

```text
REPLY='0
   12345678901234
   56789234'
REPLY2='8'
```

Wrapping characters

```text
MY_STRING='A message.
A new line'
```

❯ `string::wrapCharacters MY_STRING 13 [36m░░░[0m 10`

Returned variables:

```text
REPLY='A message.
[36m░░░[0mA new line'
REPLY2='0'
```

Wrapping characters, spaces at the beginning of the line are kept

```text
MY_STRING='  Start With spaces that must be kept! Other spaces can be ignored at wrapping.
  Also start with spaces'
```

❯ `string::wrapCharacters MY_STRING 17 \ \ \  14`

Returned variables:

```text
REPLY='  Start With s
   paces that mus
   t be kept! Oth
   er spaces can 
   be ignored at 
   wrapping.
     Also start w
   ith spaces'
REPLY2='10'
```

```text
MY_STRING='Message'
```

❯ `string::wrapCharacters MY_STRING 3`

Returned variables:

```text
REPLY='Mes
sag
e'
REPLY2='1'
```

### ✅ Testing string::highlight

❯ `MY_STRING=This\ is\ a\ Text\ to\ highlight. MY_CHARS=ttttt string::highlight MY_STRING MY_CHARS`

Returned variables:

```text
REPLY='>T<his is a >T<ex>t< >t<o highligh>t<.'
```

❯ `MY_STRING=This\ is\ a\ texT\ to\ highlight. MY_CHARS=TTTTT string::highlight MY_STRING MY_CHARS '>' '<'`

Returned variables:

```text
REPLY='>T<his is a >t<ex>T< >t<o highligh>t<.'
```

❯ `MY_STRING= MY_CHARS=ttttt string::highlight MY_STRING MY_CHARS`

Returned variables:

```text
REPLY=''
```

❯ `MY_STRING=This\ is\ a\ text\ to\ highlight. MY_CHARS= string::highlight MY_STRING MY_CHARS`

Returned variables:

```text
REPLY='This is a text to highlight.'
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
REPLY='1 line one
2 line two
'
```

Testing string::head with 0 line

❯ `string::head MULTI_LINES_TEXT2 0`

Returned variables:

```text
REPLY=''
```

Testing string::head with 10 lines

❯ `string::head MULTI_LINES_TEXT2 10`

Returned variables:

```text
REPLY='1 line one
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

