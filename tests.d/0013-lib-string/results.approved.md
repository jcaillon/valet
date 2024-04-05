# Test suite 0013-lib-string

## Test script 00.tests

### Testing bumpSemanticVersion

Exit code: `0`

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

Exit code: `0`

**Standard** output:

```plaintext
→ kebabCaseToSnakeCase this-is-a-test0
THIS_IS_A_TEST0

→ kebabCaseToSnakeCase --another-test
ANOTHER_TEST
```

### Testing kebabCaseToSnakeCase

Exit code: `0`

**Standard** output:

```plaintext
→ kebabCaseToSnakeCase this-is-a-test0
THIS_IS_A_TEST0

→ kebabCaseToSnakeCase --another-test
ANOTHER_TEST
```

### Testing kebabCaseToCamelCase

Exit code: `0`

**Standard** output:

```plaintext
→ kebabCaseToCamelCase this-is-a-test0
thisIsATest0

→ kebabCaseToCamelCase --another-test
anotherTest
```

### Testing trimAll

Exit code: `0`

**Standard** output:

```plaintext
→ trimAll '  a  super test  '
a super test

→ trimAll 'this is a command  '
this is a command
```

### Testing cutF

Exit code: `0`

**Standard** output:

```plaintext
→ cutF "field1 field2 field3" 1 " "
field1

→ cutF "field1 field2 field3" 2 " "
field2

→ cutF "field1 field2 field3" 3 " "
field3

→ cutF "field1 field2 field3" 4 " "
field3

→ cutF "line1 hm I wonder
line2 does it work on lines?
line3 seems so" 2 $'\n'
line2 does it work on lines?
```

### Testing indexOf function

Exit code: `0`

**Standard** output:

```plaintext
→ indexOf 'hello' 'l'
2=2

→ indexOf 'hello' 'he'
yeah
0=0

→ indexOf 'hello' 'he' 10
nop
-1=-1

→ indexOf 'yesyes' 'ye' 1
3=3

→ indexOf 'yesyes' 'yes' 3
yeah
3=3

→ indexOf 'yesyes' 'yes' 5
-1=-1

```

### Testing extractBetween function

Exit code: `0`

**Standard** output:

```plaintext
→ extractBetween 'hello' 'e' 'o'
ll=⌈ll⌉

→ extractBetween 'hello' '' 'l'
he=⌈he⌉

→ extractBetween 'hello' 'e' ''
llo=⌈llo⌉

→ extractBetween 'hello' 'a' ''
=⌈⌉

→ extractBetween 'hello' 'h' 'a'
yeah
=⌈⌉

multilinetext="1 line one
2 line two
3 line three
4 line four"

→ extractBetween "$multilinetext" "one"$'\n' '4'
line 2 and 3=⌈2 line two
3 line three
⌉

→ extractBetween "$multilinetext" "2 " $'\n'
line two=⌈line two⌉
```

