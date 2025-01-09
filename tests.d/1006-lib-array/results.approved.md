# Test suite 1006-lib-array

## Test script 00.tests

### Testing array::sort

Exit code: `0`

**Standard** output:

```plaintext
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="conventional" [3]="baby" [4]="holiday" [5]="abundant" [6]="deliver" [7]="position" [8]="economics")

→ array::sort MYARRAY
declare -a MYARRAY=([0]="abundant" [1]="baby" [2]="breakdown" [3]="constitutional" [4]="conventional" [5]="deliver" [6]="economics" [7]="holiday" [8]="position")
```

### Testing array::sortWithCriteria

Exit code: `0`

**Standard** output:

```plaintext
declare -a myArray=([0]="a" [1]="b" [2]="c" [3]="d" [4]="e" [5]="f" [6]="g")
declare -a criteria1=([0]="3" [1]="2" [2]="2" [3]="1" [4]="1" [5]="4" [6]="0")
declare -a criteria2=([0]="1" [1]="3" [2]="2" [3]="5" [4]="0" [5]="2" [6]="9")

→ array::sortWithCriteria myArray criteria1 criteria2
declare -a RETURNED_ARRAY=([0]="6" [1]="4" [2]="3" [3]="2" [4]="1" [5]="0" [6]="5")
declare -a myArray=([0]="g" [1]="e" [2]="d" [3]="c" [4]="b" [5]="a" [6]="f")
got:      g e d c b a f
expected: g e d c b a f
```

### Testing array::appendIfNotPresent

Exit code: `0`

**Standard** output:

```plaintext
declare -a MYARRAY=([0]="breakdown" [1]="constitutional")

→ array::appendIfNotPresent MYARRAY 'deliver'
0
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="deliver")

→ array::appendIfNotPresent MYARRAY 'breakdown'
1
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="deliver")

→ array::appendIfNotPresent MYARRAY 'holiday'
0
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="deliver" [3]="holiday")
```

### Testing array::isInArray

Exit code: `0`

**Standard** output:

```plaintext
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="deliver" [3]="position" [4]="economics")

→ array::isInArray MYARRAY 'deliver'
0

→ array::isInArray MYARRAY 'holiday'
1
```

### Testing array::makeArraysSameSize

Exit code: `0`

**Standard** output:

```plaintext
declare -a array1=([0]="a" [1]="b" [2]="c")
declare -a array2=([0]="" [1]="2")
declare -a array3=([0]="x" [1]="y" [2]="z" [3]="w")

→ array::makeArraysSameSize array1 array2 array3 array4
declare -a array1=([0]="a" [1]="b" [2]="c" [3]="")
declare -a array2=([0]="" [1]="2" [2]="" [3]="")
declare -a array3=([0]="x" [1]="y" [2]="z" [3]="w")
declare -a array4=([0]="" [1]="" [2]="" [3]="")
```

### Testing array::fuzzyFilterSort

Exit code: `0`

**Standard** output:

```plaintext
declare -a myArray=([0]="one the" [1]="the breakdown" [2]="constitutional" [3]="conventional" [4]="hold the baby" [5]="holiday inn" [6]="deliver" [7]="eLv1" [8]="eLv" [9]="abundant" [10]="make a living" [11]="the d day" [12]="elevator")

→ array::fuzzyFilterSort the myArray
declare -a RETURNED_ARRAY=([0]="the breakdown" [1]="the d day" [2]="one the" [3]="hold the baby")
declare -a RETURNED_ARRAY2=([0]="1" [1]="11" [2]="0" [3]="4")

→ shopt -s nocasematch; array::fuzzyFilterSort ELV myArray; shopt -u nocasematch
declare -a RETURNED_ARRAY=([0]="eLv" [1]="eLv1" [2]="elevator" [3]="deliver" [4]="make a living")
declare -a RETURNED_ARRAY2=([0]="8" [1]="7" [2]="12" [3]="6" [4]="10")

declare -a myArray=([0]="On the" [1]="One of the most beautiful" [2]="One of this happy end" [3]="thaerty" [4]="thazrerty")

→ array::fuzzyFilterSort the myArray
declare -a RETURNED_ARRAY=([0]="thaerty" [1]="thazrerty" [2]="On the" [3]="One of the most beautiful" [4]="One of this happy end")
declare -a RETURNED_ARRAY2=([0]="3" [1]="4" [2]="0" [3]="1" [4]="2")
```

### Testing that array::fuzzyFilterSortFileWithGrepAndAwk produces the same as fuzzyFilterSort

Exit code: `0`

**Standard** output:

```plaintext
→ array::fuzzyFilterSortFileWithGrepAndAwk words out1 out2
ea
ea1
eat
eavesdropper
Earvin
evades
Ekaterina
Evarts
elated
Edwardsian
extradotal
epexegetical
encyclopediac
beader
pearlashes
weatherbreak
sea-gray
Jeanne
headwords
beagles
decancellated
medakas
mesal
rewarding
rewa-rewa
delates
repacked
defrauded
termatic
remeant
Sequan
geolatry
Kenward
well-ankled
oedema
dehepatize
reproachlessness
kelpware
rerummage
Lemuela
reinflatable
sense-data
perpetrating
veil-wearing
retrofracted
perspicable
yellow-washed
Berkeleianism
rectiserial
semimoderate
Gesellschaft
mesethmoidal
semifictionally
stearolactone
idealizes
ameban
Chevalier
overpainfully
overeater
sterigma
Ctenoplana
preinsurance
plectognath
overcommercialized
pseudosymptomatic
hylean
spreagh
moderantism
underacting
superarrogance
abietate
liberations
hyperanarchy
underlapped
waterward
arrentation
orientation
Asteropaeus
unregularised
intermediates
underspreading
superengrave
aggregation
oxycephaly
protestable
Castella
washerman
ischemia
house-place
apprehendable
palaeontographic
nontechnological
billheads
hyponeas
Dinoceratidae
uninvestable
hatcheryman
antiresonance
unobjectionable
low-breasted
haminoea
blockheaded
Dictyosiphonaceae
The result is the same as the pure bash implementation.
```

