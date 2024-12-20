# Test suite 1006-lib-array

## Test script 00.tests

### testArray::ing array::sort

Exit code: `0`

**Standard** output:

```plaintext
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="conventional" [3]="baby" [4]="holiday" [5]="abundant" [6]="deliver" [7]="position" [8]="economics")

→ array::sort MYARRAY
declare -a MYARRAY=([0]="abundant" [1]="baby" [2]="breakdown" [3]="constitutional" [4]="conventional" [5]="deliver" [6]="economics" [7]="holiday" [8]="position")
```

### testArray::ing array::appendIfNotPresent

Exit code: `0`

**Standard** output:

```plaintext
declare -a MYARRAY=([0]="breakdown" [1]="constitutional")

→ array::appendIfNotPresent MYARRAY 'deliver'
0
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="deliver")

→ array::appendIfNotPresent MYARRAY 'breakdown'
Failed as expected
0
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="deliver")

→ array::appendIfNotPresent MYARRAY 'holiday'
0
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="deliver" [3]="holiday")
```

### testArray::ing array::isInArray

Exit code: `0`

**Standard** output:

```plaintext
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="deliver" [3]="position" [4]="economics")

→ array::isInArray MYARRAY 'deliver'
0

→ array::isInArray MYARRAY 'holiday'
1
```

### testArray::ing array::makeArraysSameSize

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

### tesing array::sortWithCriteria

Exit code: `0`

**Standard** output:

```plaintext
declare -a myArray=([0]="a" [1]="b" [2]="c" [3]="d" [4]="e" [5]="f" [6]="g")
declare -a criteria1=([0]="3" [1]="2" [2]="2" [3]="1" [4]="1" [5]="4" [6]="0")
declare -a criteria2=([0]="1" [1]="3" [2]="2" [3]="5" [4]="0" [5]="2" [6]="9")

→ array::sortWithCriteria myArray criteria1 criteria2
declare -a RETURNED_ARRAY=([0]="6" [1]="4" [2]="3" [3]="2" [4]="1" [5]="0" [6]="5")
declare -a myArray=([0]="g" [1]="e" [2]="d" [3]="c" [4]="b" [5]="a" [6]="f")
expected: g e d c b a f
declare -a ARRAY_MATCHES=([0]="one the" [1]="the breakdown" [2]="holding the baby" [3]="the d day")
declare -a ARRAY_INDEXES=([0]="4" [1]="0" [2]="8" [3]="0")
declare -a ARRAY_DISTANCES=([0]="0" [1]="0" [2]="0" [3]="0")

→ array::sortWithCriteria ARRAY_MATCHES ARRAY_INDEXES ARRAY_DISTANCES
declare -a RETURNED_ARRAY=([0]="1" [1]="3" [2]="0" [3]="2")
declare -a ARRAY_MATCHES=([0]="the breakdown" [1]="the d day" [2]="one the" [3]="holding the baby")
```

### testing array::fuzzyFilterSort

Exit code: `0`

**Standard** output:

```plaintext
declare -a myArray=([0]="one the" [1]="the breakdown" [2]="constitutional" [3]="conventional" [4]="hold the baby" [5]="holiday inn" [6]="deliver" [7]="abundant" [8]="make a living" [9]="the d day" [10]="elevator")

→ array::fuzzyFilterSort the myArray
declare -a RETURNED_ARRAY=([0]="the breakdown" [1]="the d day" [2]="one the" [3]="hold the baby")
declare -a RETURNED_ARRAY2=([0]="1" [1]="9" [2]="0" [3]="4")

→ array::fuzzyFilterSort elv myArray ⌜ ⌝
declare -a RETURNED_ARRAY=([0]="⌜e⌝⌜l⌝e⌜v⌝ator" [1]="d⌜e⌝⌜l⌝i⌜v⌝er" [2]="mak⌜e⌝ a ⌜l⌝i⌜v⌝ing")
declare -a RETURNED_ARRAY2=([0]="10" [1]="6" [2]="8")

declare -a myArray=([0]="On the" [1]="One of the most beautiful" [2]="One of this happy end" [3]="thaerty" [4]="thazrerty")

→ array::fuzzyFilterSort the myArray ⌜ ⌝ 6
declare -a RETURNED_ARRAY=([0]="⌜t⌝⌜h⌝a⌜e⌝r…" [1]="⌜t⌝⌜h⌝azr…" [2]="On ⌜t⌝⌜h⌝⌜e⌝" [3]="…⌜t⌝⌜h⌝⌜e⌝ …" [4]="…⌜t⌝⌜h⌝is…")
declare -a RETURNED_ARRAY2=([0]="3" [1]="4" [2]="0" [3]="1" [4]="2")
```

