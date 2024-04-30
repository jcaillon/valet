# Test suite 1000-core-functions

## Test script 00.tests

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

### Testing array::fuzzyFilter

Exit code: `0`

**Standard** output:

```plaintext
declare -a lines=([0]="this is a word" [1]="very unbelievable" [2]="unbelievable" [3]="self mock1" [4]="self mock2" [5]="ublievable")

→ array::fuzzyFilter evle lines
declare -a RETURNED_ARRAY=([0]="very unbelievable" [1]="unbelievable" [2]="ublievable")
declare -a RETURNED_ARRAY2=([0]="1" [1]="3" [2]="4")
declare -a RETURNED_ARRAY3=([0]="0" [1]="0" [2]="0")

→ array::fuzzyFilter SC2 lines
declare -a RETURNED_ARRAY=([0]="self mock2")
declare -a RETURNED_ARRAY2=([0]="0")
declare -a RETURNED_ARRAY3=([0]="1")

→ array::fuzzyFilter u lines
declare -a RETURNED_ARRAY=([0]="very unbelievable" [1]="unbelievable" [2]="ublievable")
declare -a RETURNED_ARRAY2=([0]="5" [1]="0" [2]="0")
declare -a RETURNED_ARRAY3=([0]="5" [1]="0" [2]="0")

→ array::fuzzyFilter seLf lines
declare -a RETURNED_ARRAY=([0]="self mock1" [1]="self mock2")
declare -a RETURNED_ARRAY2=([0]="0" [1]="0")
declare -a RETURNED_ARRAY3=([0]="0" [1]="0")

→ array::fuzzyFilter nomatch lines
declare -a RETURNED_ARRAY=()
declare -a RETURNED_ARRAY2=()
declare -a RETURNED_ARRAY3=()
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

