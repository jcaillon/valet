# Test suite 0010-lib-array

## Test script 00.tests

### Testing sortArray

Exit code: `0`

**Standard** output:

```plaintext
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="conventional" [3]="baby" [4]="holiday" [5]="abundant" [6]="deliver" [7]="position" [8]="economics")

→ sortArray MYARRAY
declare -a MYARRAY=([0]="abundant" [1]="baby" [2]="breakdown" [3]="constitutional" [4]="conventional" [5]="deliver" [6]="economics" [7]="holiday" [8]="position")
```

### Testing appendToArrayIfNotPresent

Exit code: `0`

**Standard** output:

```plaintext
declare -a MYARRAY=([0]="breakdown" [1]="constitutional")

→ appendToArrayIfNotPresent MYARRAY 'deliver'
0
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="deliver")

→ appendToArrayIfNotPresent MYARRAY 'deliver' 'holiday'
1
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="deliver")

→ appendToArrayIfNotPresent MYARRAY 'deliver' 'holiday' 'economics'
1
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="deliver")
```

### Testing isInArray

Exit code: `0`

**Standard** output:

```plaintext
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="deliver" [3]="position" [4]="economics")

→ isInArray MYARRAY 'deliver'
0

→ isInArray MYARRAY 'holiday'
1
```

### Testing makeArraysSameSize

Exit code: `0`

**Standard** output:

```plaintext
declare -a array1=([0]="a" [1]="b" [2]="c")
declare -a array2=([0]="" [1]="2")
declare -a array3=([0]="x" [1]="y" [2]="z" [3]="w")

→ makeArraysSameSize array1 array2 array3 array4
declare -a array1=([0]="a" [1]="b" [2]="c" [3]="")
declare -a array2=([0]="" [1]="2" [2]="" [3]="")
declare -a array3=([0]="x" [1]="y" [2]="z" [3]="w")
declare -a array4=([0]="" [1]="" [2]="" [3]="")
```

