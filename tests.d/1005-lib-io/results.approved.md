# Test suite 1005-lib-io

## Test script 00.tests

### Testing io::toAbsolutePath

Exit code: `0`

**Standard** output:

```plaintext
→ io::toAbsolutePath ${PWD}/01.invoke.sh
$GLOBAL_VALET_HOME/tests.d/1005-lib-io/01.invoke.sh

→ io::toAbsolutePath 01.invoke.sh
$GLOBAL_VALET_HOME/tests.d/1005-lib-io/01.invoke.sh

→ io::toAbsolutePath ../1004-lib-system/00.tests.sh
$GLOBAL_VALET_HOME/tests.d/1004-lib-system/00.tests.sh

→ io::toAbsolutePath resources
$GLOBAL_VALET_HOME/tests.d/1005-lib-io/resources

→ io::toAbsolutePath ./01.invoke.sh
$GLOBAL_VALET_HOME/tests.d/1005-lib-io/01.invoke.sh

→ io::toAbsolutePath ./resources
$GLOBAL_VALET_HOME/tests.d/1005-lib-io/resources

→ io::toAbsolutePath missing-file
$GLOBAL_VALET_HOME/tests.d/1005-lib-io/missing-file
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

### Testing io::createFilePathIfNeeded

Exit code: `0`

**Standard** output:

```plaintext
→ io::createFilePathIfNeeded 'resources/dir/subdir/file1'
$GLOBAL_VALET_HOME/tests.d/1005-lib-io/resources/dir/subdir/file1
File created successfully!
```

### Testing io::sleep

Exit code: `0`

**Standard** output:

```plaintext
→ io::sleep 0.001
```

### Testing io::cat

Exit code: `0`

**Standard** output:

```plaintext
→ io::cat 'resources/file-to-read'
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

### Testing io::readStdIn

Exit code: `0`

**Standard** output:

```plaintext
→ io::readStdIn <<<'coucou'
coucou

→ io::readStdIn

```

### Testing io::countArgs

Exit code: `0`

**Standard** output:

```plaintext
→ io::countArgs 'arg1' 'arg2' 'arg3'
3
→ io::countArgs $PWD/*
2
```

## Test script 01.invoke

### Testing io::invoke5, should return 1, input stream from string

Exit code: `1`

**Standard** output:

```plaintext
→ io::invoke5 false 0 false inputStreamValue fakeexec --std-in --error
io::invoke function ended with exit code ⌈1⌉.
stdout from file:
⌈▶ called fakeexec --std-in --error
▶ fakeexec input stream was:
⌈inputStreamValue
⌉⌉
stderr from file:
⌈This is an error output from fakeexec
returning 1 from fakeexec⌉

```

### Testing io::invoke5, should fail

Exit code: `1`

**Standard** output:

```plaintext
→ io::invoke5 true 0 false inputStreamValue fakeexec --std-in --error
exitcode=1
```

**Error** output:

```log
TRACE    Fakeexec standard output stream:
   1 ░ ▶ called fakeexec --std-in --error
   2 ░ ▶ fakeexec input stream was:
   3 ░ ⌈inputStreamValue
   4 ░ ⌉
TRACE    Fakeexec standard error stream:
   1 ░ This is an error output from fakeexec
   2 ░ returning 1 from fakeexec
ERROR    The command ⌜fakeexec⌝ originally ended with exit code ⌜1⌝.
```

### Testing io::invoke5, should translate error 1 to 0

Exit code: `0`

**Standard** output:

```plaintext
→ io::invoke5 true 0,1,2 true '' fakeexec --error
io::invoke function ended with exit code ⌈0⌉.
stdout from file:
⌈▶ called fakeexec --error
▶ fakeexec input stream was:
⌈⌉⌉
stderr from file:
⌈This is an error output from fakeexec
returning 1 from fakeexec⌉

```

### Testing io::invoke5var, input stream for file, should get stdout/stderr from var

Exit code: `0`

**Standard** output:

```plaintext
→ io::invoke5var false 0 true 'tmpFile' fakeexec --std-in
io::invoke function ended with exit code ⌈0⌉.
stdout from var:
⌈▶ called fakeexec --std-in
▶ fakeexec input stream was:
⌈Input stream content from a file
⌉
⌉
stderr from var:
⌈This is an error output from fakeexec
⌉

```

### Testing io::invoke5, with trace mode on

Exit code: `1`

**Standard** output:

```plaintext
→ io::invoke5 false 0 false inputStreamValue fakeexec --std-in --error
io::invoke function ended with exit code ⌈1⌉.
stdout from file:
⌈▶ called fakeexec --std-in --error
▶ fakeexec input stream was:
⌈inputStreamValue
⌉⌉
stderr from file:
⌈This is an error output from fakeexec
returning 1 from fakeexec⌉

```

**Error** output:

```log
DEBUG    Log level set to trace.
DEBUG    Executing the command ⌜fakeexec⌝ with arguments (quoted): 
'--std-in' '--error'
TRACE    Fakeexec standard input from string:
   1 ░ inputStreamValue
TRACE    Fakeexec standard output stream:
   1 ░ ▶ called fakeexec --std-in --error
   2 ░ ▶ fakeexec input stream was:
   3 ░ ⌈inputStreamValue
   4 ░ ⌉
TRACE    Fakeexec standard error stream:
   1 ░ This is an error output from fakeexec
   2 ░ returning 1 from fakeexec
DEBUG    The command ⌜fakeexec⌝ originally ended with exit code ⌜1⌝.
```

### Testing io::invoke3, output to files

Exit code: `0`

**Standard** output:

```plaintext
→ io::invoke3 false 0 fakeexec --option argument1 argument2
io::invoke function ended with exit code ⌈0⌉.
stdout from file:
⌈▶ called fakeexec --option argument1 argument2
▶ fakeexec input stream was:
⌈⌉⌉
stderr from file:
⌈This is an error output from fakeexec⌉

```

### Testing io::invoke3var, output to var

Exit code: `0`

**Standard** output:

```plaintext
→ io::invoke3var false 0 fakeexec --option argument1 argument2
io::invoke function ended with exit code ⌈0⌉.
stdout from var:
⌈▶ called fakeexec --option argument1 argument2
▶ fakeexec input stream was:
⌈⌉
⌉
stderr from var:
⌈This is an error output from fakeexec
⌉

```

### Testing io::invoke, should fail

Exit code: `1`

**Standard** output:

```plaintext
→ io::invoke fakeexec --error
```

**Error** output:

```log
TRACE    Fakeexec standard output stream:
   1 ░ ▶ called fakeexec --error
   2 ░ ▶ fakeexec input stream was:
   3 ░ ⌈⌉
TRACE    Fakeexec standard error stream:
   1 ░ This is an error output from fakeexec
   2 ░ returning 1 from fakeexec
ERROR    The command ⌜fakeexec⌝ originally ended with exit code ⌜1⌝.
```

### Testing io::invoke, output to var

Exit code: `0`

**Standard** output:

```plaintext
→ io::invoke fakeexec --option argument1 argument2
io::invoke function ended with exit code ⌈0⌉.
stdout from var:
⌈▶ called fakeexec --option argument1 argument2
▶ fakeexec input stream was:
⌈⌉
⌉
stderr from var:
⌈This is an error output from fakeexec
⌉

```

### Testing io::invokePiped, stdin as string, output to var

Exit code: `0`

**Standard** output:

```plaintext
→ io::invokePiped 'this is an stdin' fakeexec --std-in --option argument1 argument2
io::invoke function ended with exit code ⌈0⌉.
stdout from var:
⌈▶ called fakeexec --std-in --option argument1 argument2
▶ fakeexec input stream was:
⌈this is an stdin
⌉
⌉
stderr from var:
⌈This is an error output from fakeexec
⌉

```

