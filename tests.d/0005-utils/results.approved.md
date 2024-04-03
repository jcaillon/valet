# Test suite 0005-utils

## Test script 00.utils

### Testing bumpSemanticVersion

Exit code: 0

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
```

### Testing kebabCaseToSnakeCase

Exit code: 0

**Standard** output:

```plaintext
→ kebabCaseToSnakeCase this-is-a-test0
THIS_IS_A_TEST0

→ kebabCaseToSnakeCase --another-test
ANOTHER_TEST
```

### Testing kebabCaseToSnakeCase

Exit code: 0

**Standard** output:

```plaintext
→ kebabCaseToSnakeCase this-is-a-test0
THIS_IS_A_TEST0

→ kebabCaseToSnakeCase --another-test
ANOTHER_TEST
```

### Testing kebabCaseToCamelCase

Exit code: 0

**Standard** output:

```plaintext
→ kebabCaseToCamelCase this-is-a-test0
thisIsATest0

→ kebabCaseToCamelCase --another-test
anotherTest
```

### Testing trimAll

Exit code: 0

**Standard** output:

```plaintext
→ trimAll '  a  super test  '
a super test

→ trimAll 'this is a command  '
this is a command
```

### Testing toAbsolutePath

Exit code: 0

**Standard** output:

```plaintext
→ toAbsolutePath ${PWD}/00.utils.sh
$VALET_HOME/tests.d/0005-utils/00.utils.sh

→ toAbsolutePath 00.utils.sh
$VALET_HOME/tests.d/0005-utils/00.utils.sh

→ toAbsolutePath ./00.utils.sh
$VALET_HOME/tests.d/0005-utils/00.utils.sh

→ toAbsolutePath ../0003-self/00.utils.sh
$VALET_HOME/tests.d/0005-utils/00.utils.sh
```

### Testing sortArray

Exit code: 0

**Standard** output:

```plaintext
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="conventional" [3]="baby" [4]="holiday" [5]="abundant" [6]="deliver" [7]="position" [8]="economics")
→ sortArray MYARRAY
declare -a MYARRAY=([0]="abundant" [1]="baby" [2]="breakdown" [3]="constitutional" [4]="conventional" [5]="deliver" [6]="economics" [7]="holiday" [8]="position")
```

### Testing appendToArrayIfNotPresent

Exit code: 0

**Standard** output:

```plaintext
declare -a MYARRAY=([0]="breakdown" [1]="constitutional")
→ appendToArrayIfNotPresent MYARRAY 'deliver'
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="deliver")

→ appendToArrayIfNotPresent MYARRAY 'deliver' 'holiday'
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="deliver")

→ appendToArrayIfNotPresent MYARRAY 'deliver' 'holiday' 'economics'
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="deliver")
```

### Testing isInArray

Exit code: 0

**Standard** output:

```plaintext
declare -a MYARRAY=([0]="breakdown" [1]="constitutional" [2]="deliver" [3]="position" [4]="economics")
→ isInArray MYARRAY 'deliver'
0

→ isInArray MYARRAY 'holiday'
1
```

