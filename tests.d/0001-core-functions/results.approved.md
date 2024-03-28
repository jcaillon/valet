# Test suite 0001-core-functions

## Test script 99.tests

### Wrapping text at column 30 with no padding

Exit code: 0

**Standard** output:

```plaintext
→  wrapText "${shortText}" 30
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
→  wrapText "${shortText}" 90 4 false
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
→  wrapText "${shortText}" 90 2 true
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
→  cutF "field1 field2 field3" 1 " "
field1

→  cutF "field1 field2 field3" 2 " "
field2

→  cutF "field1 field2 field3" 3 " "
field3

→  cutF "field1 field2 field3" 4 " "
field3

→  cutF "line1 hm I wonder
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

### Testing invoke

Exit code: 0

**Standard** output:

```plaintext
--------------------------------------------------------
_TEMPORARY_DIRECTORY = /tmp
----
truc = /tmp/f11-0
createTempFile = /tmp/f12-1
createTempFile = /tmp/d3-1
--------------------------------------------------------
--------------------------------------------------------
_TEMPORARY_DIRECTORY = /tmp
----
truc = /tmp/f13-1
createTempFile = /tmp/f14-2
createTempFile = /tmp/d3-2
--------------------------------------------------------
--------------------------------------------------------
_TEMPORARY_DIRECTORY = /tmp
----
truc = /tmp/f14-1
createTempFile = /tmp/f15-2
createTempFile = /tmp/d4-2
--------------------------------------------------------
```

