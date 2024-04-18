# Test suite 1005-lib-io

## Test script 00.tests

### Testing io::toAbsolutePath

Exit code: `0`

**Standard** output:

```plaintext
→ io::toAbsolutePath ${PWD}/fakeexec
$GLOBAL_VALET_HOME/tests.d/1005-lib-io/fakeexec

→ io::toAbsolutePath fakeexec
$GLOBAL_VALET_HOME/tests.d/1005-lib-io/fakeexec

→ io::toAbsolutePath ./fakeexec
$GLOBAL_VALET_HOME/tests.d/1005-lib-io/fakeexec

→ io::toAbsolutePath ../0003-self/fakeexec
$GLOBAL_VALET_HOME/tests.d/1005-lib-io/fakeexec
```

### Testing io::captureOutput

Exit code: `0`

**Standard** output:

```plaintext
→ io::captureOutput echo "Hello world!"
Hello world!


→ io::captureOutput outputTextToStdErr
This is an error message

```

### Testing io::readFile limited to x chars

Exit code: `0`

**Standard** output:

```plaintext
→ io::readFile 'resources/file-to-read' 100
# Explore why veganism is kinder to animals, to people and to our planet's future.

Source: <https:/
```

### Testing io::readFile unlimited

Exit code: `0`

**Standard** output:

```plaintext
→ io::readFile 'resources/file-to-read'
# Explore why veganism is kinder to animals, to people and to our planet's future.

Source: <https://www.vegansociety.com/go-vegan/why-go-vegan>

## For the animals

Preventing the exploitation of animals is not the only reason for becoming vegan, but for many it remains the key factor in their decision to go vegan and stay vegan. Having emotional attachments with animals may form part of that reason, while many believe that all sentient creatures have a right to life and freedom. Specifics aside, avoiding animal products is one of the most obvious ways you can take a stand against animal cruelty and animal exploitation everywhere. Read a detailed overview on why being vegan demonstrates true compassion for animals.

## For your health

Well-planned vegan diets follow healthy eating guidelines, and contain all the nutrients that our bodies need. Both the British Dietetic Association and the American Academy of Nutrition and Dietetics recognise that they are suitable for every age and stage of life. Some research has linked that there are certain health benefits to vegan diets with lower blood pressure and cholesterol, and lower rates of heart disease, type 2 diabetes and some types of cancer.

Going vegan is a great opportunity to learn more about nutrition and cooking, and improve your diet. Getting your nutrients from plant foods allows more room in your diet for health-promoting options like whole grains, fruit, nuts, seeds and vegetables, which are packed full of beneficial fibre, vitamins and minerals.

## For the environment

From recycling our household rubbish to cycling to work, we're all aware of ways to live a greener life. One of the most effective things an individual can do to lower their carbon footprint is to avoid all animal products. This goes way beyond the problem of cow flatulence and air pollution!
Why is meat and dairy so bad for the environment?

The production of meat and other animal derived products places a heavy burden on the environment. The vast amount of grain feed required for meat production is a significant contributor to deforestation, habitat loss and species extinction. In Brazil alone, the equivalent of 5.6 million acres of land is used to grow soya beans for animals in Europe. This land contributes to developing world malnutrition by driving impoverished populations to grow cash crops for animal feed, rather than food for themselves. On the other hand, considerably lower quantities of crops and water are required to sustain a vegan diet, making the switch to veganism one of the easiest, most enjoyable and most effective ways to reduce our impact on the environment. For more on how veganism is the way forward for the environment, see our environment section.

## For people

Just like veganism is the sustainable option when it comes to looking after our planet, plant-based living is also a more sustainable way of feeding the human family. A plant-based diet requires only one third of the land needed to support a meat and dairy diet. With rising global food and water insecurity due to a myriad of environmental and socio-economic problems, there's never been a better time to adopt a more sustainable way of living. Avoiding animal products is not just one of the simplest ways an individual can reduce the strain on food as well as other resources, it's the simplest way to take a stand against inefficient food systems which disproportionately affect the poorest people all over the world. Read more about how vegan diets can help people.

```

## Test script 01.invoke

### Testing io::invoke5, executable are taken in priority from VALET_CONFIG_BIN_PATH, input stream from file

Exit code: `0`

**Standard** output:

```plaintext
→ io::invoke5 false 0 true "${tmpFile}" fakeexec --std-in --option argument1 argument2
io::invoke function ended with exit code ⌈0⌉.
stdout from file:
⌈▶ called fakeexec --std-in --option argument1 argument2
▶ fakeexec input stream was:
⌈Input stream content from a file⌉⌉
stderr from file:
⌈This is an error output from fakeexec⌉

```

### Testing io::invoke5, should return 1, input stream from string

Exit code: `1`

**Standard** output:

```plaintext
→ io::invoke5 false 0 false inputStreamValue fakeexec2 --std-in --error
io::invoke function ended with exit code ⌈1⌉.
stdout from file:
⌈▶ called fakeexec2 --std-in --error
▶ fakeexec2 input stream was:
⌈inputStreamValue⌉⌉
stderr from file:
⌈This is an error output from fakeexec2
returning 1 from fakeexec2⌉

```

### Testing io::invoke5, should fail

Exit code: `1`

**Standard** output:

```plaintext
→ io::invoke5 true 0 false inputStreamValue fakeexec2 --std-in --error
exitcode=1
```

**Error** output:

```log
ERROR    The command ⌜fakeexec2⌝ originally ended with exit code ⌜1⌝.
Standard output:
⌜▶ called fakeexec2 --std-in --error
▶ fakeexec2 input stream was:
⌈inputStreamValue⌉
⌝
Error output:
⌜This is an error output from fakeexec2
returning 1 from fakeexec2
⌝
```

### Testing io::invoke5, should translate error 1 to 0

Exit code: `0`

**Standard** output:

```plaintext
→ io::invoke5 true 0,1,2 true '' fakeexec2 --error
io::invoke function ended with exit code ⌈0⌉.
stdout from file:
⌈▶ called fakeexec2 --error
▶ fakeexec2 input stream was:
⌈⌉⌉
stderr from file:
⌈This is an error output from fakeexec2
returning 1 from fakeexec2⌉

```

### Testing io::invoke5var, should get stdout/stderr from var

Exit code: `0`

**Standard** output:

```plaintext
→ io::invoke5var false 0 true '' fakeexec2
io::invoke function ended with exit code ⌈0⌉.
stdout from var:
⌈▶ called fakeexec2 
▶ fakeexec2 input stream was:
⌈⌉
⌉
stderr from var:
⌈This is an error output from fakeexec2
⌉

```

### Testing io::invoke5, with debug mode on

Exit code: `1`

**Standard** output:

```plaintext
→ io::invoke5 false 0 false inputStreamValue fakeexec2 --std-in --error
io::invoke function ended with exit code ⌈1⌉.
stdout from file:
⌈▶ called fakeexec2 --std-in --error
▶ fakeexec2 input stream was:
⌈inputStreamValue⌉⌉
stderr from file:
⌈This is an error output from fakeexec2
returning 1 from fakeexec2⌉

```

**Error** output:

```log
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Executing the command ⌜fakeexec2⌝.
Fail if it fails: ⌜false⌝
Acceptable error codes: ⌜0⌝
Standard stream from file: ⌜false⌝
Standard stream: ⌜inputStreamValue⌝
Extra parameters: ⌜--std-in --error⌝
DEBUG    The command ⌜fakeexec2⌝ originally ended with exit code ⌜1⌝.
Standard output:
⌜▶ called fakeexec2 --std-in --error
▶ fakeexec2 input stream was:
⌈inputStreamValue⌉
⌝
Error output:
⌜This is an error output from fakeexec2
returning 1 from fakeexec2
⌝
```

### Testing io::invoke3, output to files

Exit code: `0`

**Standard** output:

```plaintext
→ io::invoke3 false 0 fakeexec2 --option argument1 argument2
io::invoke function ended with exit code ⌈0⌉.
stdout from file:
⌈▶ called fakeexec2 --option argument1 argument2
▶ fakeexec2 input stream was:
⌈⌉⌉
stderr from file:
⌈This is an error output from fakeexec2⌉

```

**Error** output:

```log
DEBUG    Executing the command ⌜fakeexec2⌝.
Fail if it fails: ⌜false⌝
Acceptable error codes: ⌜0⌝
Standard stream from file: ⌜⌝
Standard stream: ⌜⌝
Extra parameters: ⌜--option argument1 argument2⌝
DEBUG    The command ⌜fakeexec2⌝ originally ended with exit code ⌜0⌝.
The error code ⌜0⌝ is acceptable and has been reset to 0.
Standard output:
⌜▶ called fakeexec2 --option argument1 argument2
▶ fakeexec2 input stream was:
⌈⌉
⌝
Error output:
⌜This is an error output from fakeexec2
⌝
```

### Testing io::invoke3var, output to var

Exit code: `0`

**Standard** output:

```plaintext
→ io::invoke3var false 0 fakeexec2 --option argument1 argument2
io::invoke function ended with exit code ⌈0⌉.
stdout from var:
⌈▶ called fakeexec2 --option argument1 argument2
▶ fakeexec2 input stream was:
⌈⌉
⌉
stderr from var:
⌈This is an error output from fakeexec2
⌉

```

**Error** output:

```log
DEBUG    Executing the command ⌜fakeexec2⌝.
Fail if it fails: ⌜false⌝
Acceptable error codes: ⌜0⌝
Standard stream from file: ⌜⌝
Standard stream: ⌜⌝
Extra parameters: ⌜--option argument1 argument2⌝
DEBUG    The command ⌜fakeexec2⌝ originally ended with exit code ⌜0⌝.
The error code ⌜0⌝ is acceptable and has been reset to 0.
Standard output:
⌜▶ called fakeexec2 --option argument1 argument2
▶ fakeexec2 input stream was:
⌈⌉
⌝
Error output:
⌜This is an error output from fakeexec2
⌝
```

### Testing io::invoke, should fail

Exit code: `1`

**Standard** output:

```plaintext
→ io::invoke fakeexec2 --error
```

**Error** output:

```log
DEBUG    Executing the command ⌜fakeexec2⌝.
Fail if it fails: ⌜true⌝
Acceptable error codes: ⌜0⌝
Standard stream from file: ⌜⌝
Standard stream: ⌜⌝
Extra parameters: ⌜--error⌝
ERROR    The command ⌜fakeexec2⌝ originally ended with exit code ⌜1⌝.
Standard output:
⌜▶ called fakeexec2 --error
▶ fakeexec2 input stream was:
⌈⌉
⌝
Error output:
⌜This is an error output from fakeexec2
returning 1 from fakeexec2
⌝
stack:
├─ In function core::fail() $GLOBAL_VALET_HOME/valet.d/core:XXX
├─ In function io::invoke5() $GLOBAL_VALET_HOME/valet.d/lib-io:XXX
├─ In function io::invoke5var() $GLOBAL_VALET_HOME/valet.d/lib-io:XXX
├─ In function io::invoke() $GLOBAL_VALET_HOME/valet.d/lib-io:XXX
├─ In function testIo::invoke() $GLOBAL_VALET_HOME/tests.d/1005-lib-io/01.invoke.sh:XXX
├─ In function main() $GLOBAL_VALET_HOME/tests.d/1005-lib-io/01.invoke.sh:XXX
├─ In function source() $GLOBAL_VALET_HOME/tests.d/1005-lib-io/01.invoke.sh:XXX
├─ In function source() $GLOBAL_VALET_HOME/valet.d/core:XXX
├─ In function runTest() valet.d/commands.d/self-test-utils:XXX
├─ In function runTestSuites() valet.d/commands.d/self-test-utils:XXX
├─ In function runCoreTests() valet.d/commands.d/self-test-utils:XXX
├─ In function selfTest() valet.d/commands.d/self-test.sh:XXX
├─ In function main::runFunction() $GLOBAL_VALET_HOME/valet.d/main:XXX
├─ In function main::parseMainArguments() $GLOBAL_VALET_HOME/valet.d/main:XXX
└─ In function main() $GLOBAL_VALET_HOME/valet:XXX
```

### Testing io::invoke, output to var

Exit code: `0`

**Standard** output:

```plaintext
→ io::invoke fakeexec2 --option argument1 argument2
io::invoke function ended with exit code ⌈0⌉.
stdout from var:
⌈▶ called fakeexec2 --option argument1 argument2
▶ fakeexec2 input stream was:
⌈⌉
⌉
stderr from var:
⌈This is an error output from fakeexec2
⌉

```

**Error** output:

```log
DEBUG    Executing the command ⌜fakeexec2⌝.
Fail if it fails: ⌜true⌝
Acceptable error codes: ⌜0⌝
Standard stream from file: ⌜⌝
Standard stream: ⌜⌝
Extra parameters: ⌜--option argument1 argument2⌝
DEBUG    The command ⌜fakeexec2⌝ originally ended with exit code ⌜0⌝.
The error code ⌜0⌝ is acceptable and has been reset to 0.
Standard output:
⌜▶ called fakeexec2 --option argument1 argument2
▶ fakeexec2 input stream was:
⌈⌉
⌝
Error output:
⌜This is an error output from fakeexec2
⌝
```

