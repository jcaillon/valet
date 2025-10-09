# Test suite lib-string

## Test script 00.tests

### ✅ Testing string::join

```text
myArray=(
[0]='one'
[1]='two'
[2]='3'
[3]='four'
[4]='5'
)
```

❯ `string::join myArray`

Returned variables:

```text
REPLY='one
two
3
four
5'
```

❯ `string::join myArray separator=@`

Returned variables:

```text
REPLY='one@two@3@four@5'
```

❯ `string::join myArray separator=`

Returned code: `1`

Returned variables:

```text
REPLY='onetwo3four5'
```

❯ `string::join myArray $'separator=\n  - '`

Returned code: `1`

Returned variables:

```text
REPLY='one
  - two
  - 3
  - four
  - 5'
```

### ✅ Testing string::truncateWithEllipsis

```text
MY_STRING='This is a test string'
```

❯ `string::truncateWithEllipsis MY_STRING maxLength=11`

Returned variables:

```text
REPLY='0'
```

```text
MY_STRING='This is a …'
```

```text
MY_STRING='This is a test string'
```

❯ `string::truncateWithEllipsis MY_STRING maxLength=11`

Returned variables:

```text
REPLY='0'
```

```text
MY_STRING='This is a …'
```

```text
MY_STRING='This is a test string'
```

❯ `string::truncateWithEllipsis MY_STRING maxLength=11 noEllipsis=true`

Returned variables:

```text
REPLY='0'
```

```text
MY_STRING='This is a t'
```

```text
MY_STRING='This is a test string'
```

❯ `string::truncateWithEllipsis MY_STRING maxLength=40`

Returned variables:

```text
REPLY='19'
```

```text
MY_STRING='This is a test string'
```

```text
MY_STRING='This is a test string'
```

❯ `string::truncateWithEllipsis MY_STRING maxLength=21`

Returned variables:

```text
REPLY='0'
```

```text
MY_STRING='This is a test string'
```

```text
MY_STRING='This is a test string'
```

❯ `string::truncateWithEllipsis MY_STRING maxLength=0`

Returned variables:

```text
REPLY='0'
```

```text
MY_STRING=''
```

```text
MY_STRING='This is a test string'
```

❯ `string::truncateWithEllipsis MY_STRING maxLength=1`

Returned variables:

```text
REPLY='0'
```

```text
MY_STRING='…'
```

```text
MY_STRING='This is a test string'
```

❯ `string::truncateWithEllipsis MY_STRING maxLength=2`

Returned variables:

```text
REPLY='0'
```

```text
MY_STRING='T…'
```

**Standard output**:

```text
REPLY=1 → abcde
REPLY=0 → abcde
REPLY=0 → abc…
REPLY=0 → ab…
REPLY=0 → a…
REPLY=0 → …
REPLY=0 → 
```

### ✅ Testing string::getFormattedHeader

❯ `string::getFormattedHeader 'left|middle|right' width=50`

Returned variables:

```text
REPLY='left                  middle                 right'
REPLY2='4|6|5'
REPLY_ARRAY=(
[0]='4'
[1]='6'
[2]='5'
)
```

### ✅ Testing string::getFormattedHeader combinations

**Standard output**:

```text
4|6|5      left__________________middle_________________right
0|6|0      ______________________middle______________________
0|6|5      ______________________middle_________________right
4|6|0      left__________________middle______________________
4|0|0      left______________________________________________
0|0|5      _____________________________________________right
4|6|5      left___middle__right
4|6|5      left___middle_right
4|6|5      left__middle_right
4|6|5      left__middleright
4|6|5      left_middleright
4|6|3      left_middlerig…
4|6|3      leftmiddlerig…
4|6|2      leftmiddleri…
2|6|2      le…middleri…
2|6|1      le…middler…
1|6|1      l…middler…
1|6|0      l…middle_
0|6|0      _middle_
0|6|0      _middle
0|6|0      middle
0|4|0      midd…
0|3|0      mid…
0|2|0      mi…
0|1|0      m…
0|0|0      …
0|0|0      
4|6|5      left[1;34m___[0mmiddle[1;34m__[0mright
4|6|5      left[1;34m___[0mmiddle[1;34m_[0mright
4|6|5      left[1;34m__[0mmiddle[1;34m_[0mright
4|6|5      left[1;34m__[0mmiddle[1;34m[0mright
4|6|5      left[1;34m_[0mmiddle[1;34m[0mright
4|6|3      left[1;34m_[0mmiddlerig…
4|6|3      left[1;34m[0mmiddlerig…
4|6|2      left[1;34m[0mmiddleri…
2|6|2      le…middleri…
2|6|1      le…middler…
1|6|1      l…middler…
1|6|0      l…middle[1;34m_[0m
0|6|0      [1;34m_[0mmiddle[1;34m_[0m
0|6|0      [1;34m_[0mmiddle
0|6|0      middle
0|4|0      midd…
0|3|0      mid…
0|2|0      mi…
0|1|0      m…
0|0|0      …
0|0|0      
4|6|5      left___middle__right
4|6|5      left___middle_right
4|6|5      left__middle_right
4|6|5      left__middleright
4|6|5      left_middleright
4|6|4      left_middlerigh
4|6|4      leftmiddlerigh
4|6|3      leftmiddlerig
3|6|3      lefmiddlerig
3|6|2      lefmiddleri
2|6|2      lemiddleri
2|6|1      lemiddler
1|6|1      lmiddler
1|6|0      lmiddle
0|6|0      middle
0|5|0      middl
0|4|0      midd
0|3|0      mid
0|2|0      mi
0|1|0      m
0|0|0      
1|1|1      @[1;34m________________________[0m%[1;34m_______________________[0m+
4|6|5      left[1;34m..................[0mmiddle[1;34m.................[0mright
```

### ✅ Testing string::getKebabCase

❯ `echo "${tests[*]"`

**Standard output**:

```text
thisIsATest01
AnotherTest
--*Another!test--
_SNAKE_CASE
__SNAKE__CASE__
kebab---case
--kebab-case--
```

❯ `for test in ${tests[@]}; do string::getKebabCase test; echo "${REPLY}"; done`

**Standard output**:

```text
this-is-a-test01
another-test
another-test
snake-case
snake-case
kebab-case
kebab-case
```

### ✅ Testing string::getSnakeCase

❯ `echo "${tests[*]"`

**Standard output**:

```text
thisIsATest01
AnotherTest
--*Another!test--
_SNAKE_CASE
__SNAKE__CASE__
kebab---case
--kebab-case--
```

❯ `for test in ${tests[@]}; do string::getSnakeCase test; echo "${REPLY}"; done`

**Standard output**:

```text
THIS_IS_A_TEST01
ANOTHER_TEST
ANOTHER_TEST
SNAKE_CASE
SNAKE_CASE
KEBAB_CASE
KEBAB_CASE
```

### ✅ Testing string::getCamelCase

❯ `echo "${tests[*]"`

**Standard output**:

```text
thisIsATest01
AnotherTest
--*Another!test--
_SNAKE_CASE
__SNAKE__CASE__
kebab---case
--kebab-case--
```

❯ `for test in ${tests[@]}; do string::getCamelCase test; echo "${REPLY}"; done`

**Standard output**:

```text
thisIsATest01
anotherTest
anothertest
snakeCase
snakeCase
kebabCase
kebabCase
```

### ✅ Testing string::numberToUniqueId

❯ `string::numberToUniqueId 0109`

Returned variables:

```text
REPLY='xezu'
```

❯ `string::numberToUniqueId 345`

Returned variables:

```text
REPLY='mun'
```

❯ `string::numberToUniqueId 2000`

Returned variables:

```text
REPLY='daxa'
```

❯ `string::numberToUniqueId 8976`

Returned variables:

```text
REPLY='wule'
```

❯ `string::numberToUniqueId 12003`

Returned variables:

```text
REPLY='bixaf'
```

❯ `string::numberToUniqueId 34567`

Returned variables:

```text
REPLY='muter'
```

### ✅ Testing string::removeTextFormatting

❯ `string::removeTextFormatting _myString`

```text
_myString='My text with some text formatting and some more textunreadable stuff. Inluding some 123;55;25524 bit colors and some 28 bit colors.'
```

❯ `string::removeTextFormatting _myString`

```text
_myString='wo[107mrd wo[107mrd!'
```

### ✅ Testing string::getHexRepresentation

❯ `_myString=d071ec191f6e98a9c78b6d502c823d8e5adcfdf83d0ea55ebc7f242b29ce8301 string::getHexRepresentation _myString`

Returned variables:

```text
REPLY='64303731656331393166366539386139633738623664353032633832336438653561646366646638336430656135356562633766323432623239636538333031'
```

### ✅ Testing string::getField

```text
_MY_STRING='field1 field2 field3'
```

❯ `string::getField _MY_STRING 0 separator=\ `

Returned variables:

```text
REPLY='field1'
```

❯ `string::getField _MY_STRING 1 separator=\ `

Returned variables:

```text
REPLY='field2'
```

❯ `string::getField _MY_STRING 2 separator=,`

Returned variables:

```text
REPLY=''
```

❯ `string::getField _MY_STRING 4 separator=,`

Returned variables:

```text
REPLY=''
```

```text
_MY_STRING='line1 hm I wonder
line2 does it work on lines?
line3 seems so'
```

❯ `string::getField _MY_STRING 2 $'separator=\n'`

Returned variables:

```text
REPLY='line3 seems so'
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
MY_STRING='_-_-_hello_-_'
```

❯ `string::trimEdges MY_STRING charsToTrim=_-`

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

❯ `_MY_STRING=hello string::getIndexOf _MY_STRING he startingIndex=10`

Returned variables:

```text
REPLY='-1'
```

❯ `_MY_STRING=yes-yes string::getIndexOf _MY_STRING ye startingIndex=1`

Returned variables:

```text
REPLY='4'
```

❯ `_MY_STRING=yes-yes string::getIndexOf _MY_STRING yes startingIndex=5`

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

❯ `string::split _MY_STRING $'\n'`

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

❯ `string::wrapWords MULTI_LINES_TEXT width=30`

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

❯ `string::wrapWords MULTI_LINES_TEXT width=50 newLinePadString=\ \ \ \ `

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

❯ `string::wrapWords MULTI_LINES_TEXT width=20 newLinePadString=\ \ \  firstLineWidth=17`

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

```text
MY_STRING='A message.'
```

❯ `string::wrapWords MY_STRING width=80`

Returned variables:

```text
REPLY='A message.'
```

Wrapping words, no shortcut!

```text
MY_STRING='A message.'
```

❯ `string::wrapWords MY_STRING width=80 newLinePadString= firstLineWidth=5`

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

❯ `string::wrapWords MY_STRING width=13 newLinePadString=[36m░░░[0m firstLineWidth=10`

Returned variables:

```text
REPLY='A message.
[36m░░░[0mA new line'
```

### ✅ Testing string::wrapCharacters

Wrapping characters at column 20 with padding of 3 on all lines

❯ `string::wrapCharacters MULTI_LINES_TEXT width=20 newLinePadString=\ \ \  firstLineWidth=17`

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

❯ `string::wrapCharacters MULTI_LINES_TEXT width=20`

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

❯ `string::wrapCharacters MY_STRING width=17 newLinePadString=\ \ \  firstLineWidth=1`

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

❯ `string::wrapCharacters MY_STRING width=13 newLinePadString=[36m░░░[0m firstLineWidth=10`

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

❯ `string::wrapCharacters MY_STRING width=17 newLinePadString=\ \ \  firstLineWidth=14`

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

❯ `string::wrapCharacters MY_STRING width=3`

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
REPLY='[95mT[0mhis is a [95mT[0mex[95mt[0m [95mt[0mo highligh[95mt[0m.'
```

❯ `MY_STRING=This\ is\ a\ texT\ to\ highlight. MY_CHARS=TTTTT string::highlight MY_STRING MY_CHARS highlightCode='>' resetCode='<'`

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
2 line two'
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
4 line four'
```

Testing string::head with 10 lines

❯ `MY_STRING=1\ 2\ 3\ 4 string::head MY_STRING 2 separator=\ `

Returned variables:

```text
REPLY='1 2'
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

❯ `MY_STRING=1\ 2\ 3 string::doForEachLine MY_STRING forEachLine separator=\ `

**Standard output**:

```text
Line: '1'
Line: '2'
Line: '3'
```

