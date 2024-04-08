# Test suite 1003-lib-string

## Test script 00.tests

### Testing string::bumpSemanticVersion

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

### Testing string::kebabCaseToSnakeCase

Exit code: `0`

**Standard** output:

```plaintext
→ string::kebabCaseToSnakeCase this-is-a-test0
THIS_IS_A_TEST0

→ string::kebabCaseToSnakeCase --another-test
ANOTHER_TEST
```

### Testing string::kebabCaseToSnakeCase

Exit code: `0`

**Standard** output:

```plaintext
→ string::kebabCaseToSnakeCase this-is-a-test0
THIS_IS_A_TEST0

→ string::kebabCaseToSnakeCase --another-test
ANOTHER_TEST
```

### Testing string::kebabCaseToCamelCase

Exit code: `0`

**Standard** output:

```plaintext
→ string::kebabCaseToCamelCase this-is-a-test0
thisIsATest0

→ string::kebabCaseToCamelCase --another-test
anotherTest
```

### Testing string::trimAll

Exit code: `0`

**Standard** output:

```plaintext
→ string::trimAll '  a  super test  '
a super test

→ string::trimAll 'this is a command  '
this is a command
```

### Testing string::cutField

Exit code: `0`

**Standard** output:

```plaintext
→ string::cutField "field1 field2 field3" 1 " "
field1

→ string::cutField "field1 field2 field3" 2 " "
field2

→ string::cutField "field1 field2 field3" 3 " "
field3

→ string::cutField "field1 field2 field3" 4 " "
field3

→ string::cutField "line1 hm I wonder
line2 does it work on lines?
line3 seems so" 2 $'\n'
line2 does it work on lines?
```

### Testing string::indexOf function

Exit code: `0`

**Standard** output:

```plaintext
→ string::indexOf 'hello' 'l'
2=2

→ string::indexOf 'hello' 'he'
yeah
0=0

→ string::indexOf 'hello' 'he' 10
nop
-1=-1

→ string::indexOf 'yesyes' 'ye' 1
3=3

→ string::indexOf 'yesyes' 'yes' 3
yeah
3=3

→ string::indexOf 'yesyes' 'yes' 5
-1=-1

```

### Testing string::extractBetween function

Exit code: `0`

**Standard** output:

```plaintext
→ string::extractBetween 'hello' 'e' 'o'
ll=⌈ll⌉

→ string::extractBetween 'hello' '' 'l'
he=⌈he⌉

→ string::extractBetween 'hello' 'e' ''
llo=⌈llo⌉

→ string::extractBetween 'hello' 'a' ''
=⌈⌉

→ string::extractBetween 'hello' 'h' 'a'
yeah
=⌈⌉

multilinetext="1 line one
2 line two
3 line three
4 line four"

→ string::extractBetween "${multilinetext}" "one"$'\n' '4'
line 2 and 3=⌈2 line two
3 line three
⌉

→ string::extractBetween "${multilinetext}" "2 " $'\n'
line two=⌈line two⌉
```
