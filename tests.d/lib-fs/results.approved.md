# Test suite lib-io

## Test script 00.tests

### ✅ Testing fs::toAbsolutePath

❯ `fs::toAbsolutePath $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/01.invoke.sh`

Returned variables:

```text
RETURNED_VALUE='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/01.invoke.sh'
```

❯ `fs::toAbsolutePath .`

Returned variables:

```text
RETURNED_VALUE='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io'
```

❯ `fs::toAbsolutePath ..`

Returned variables:

```text
RETURNED_VALUE='$GLOBAL_INSTALLATION_DIRECTORY/tests.d'
```

❯ `fs::toAbsolutePath 01.invoke.s`

Returned variables:

```text
RETURNED_VALUE='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/01.invoke.s'
```

❯ `fs::toAbsolutePath ../1004-lib-system/00.tests.sh`

Returned variables:

```text
RETURNED_VALUE='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/../1004-lib-system/00.tests.sh'
```

❯ `fs::toAbsolutePath resources`

Returned variables:

```text
RETURNED_VALUE='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources'
```

❯ `fs::toAbsolutePath ./01.invoke.sh`

Returned variables:

```text
RETURNED_VALUE='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/01.invoke.sh'
```

❯ `fs::toAbsolutePath ./resources`

Returned variables:

```text
RETURNED_VALUE='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources'
```

❯ `fs::toAbsolutePath missing-file`

Returned variables:

```text
RETURNED_VALUE='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/missing-file'
```

### ✅ Testing fs::readFile

❯ `fs::readFile resources/file-to-read 22`

Returned variables:

```text
RETURNED_VALUE='# Explore why veganism'
```

❯ `fs::readFile resources/file-to-read`

Returned variables:

```text
RETURNED_VALUE='# Explore why veganism is kinder to animals, to people and to our planet'"'"'s future.

Source: <https://www.vegansociety.com/go-vegan/why-go-vegan>

## For the animals

Preventing the exploitation of animals is not the only reason for becoming vegan, but for many it remains the key factor in their decision to go vegan and stay vegan. Having emotional attachments with animals may form part of that reason, while many believe that all sentient creatures have a right to life and freedom. Specifics aside, avoiding animal products is one of the most obvious ways you can take a stand against animal cruelty and animal exploitation everywhere. Read a detailed overview on why being vegan demonstrates true compassion for animals.

## For your health

Well-planned vegan diets follow healthy eating guidelines, and contain all the nutrients that our bodies need. Both the British Dietetic Association and the American Academy of Nutrition and Dietetics recognise that they are suitable for every age and stage of life. Some research has linked that there are certain health benefits to vegan diets with lower blood pressure and cholesterol, and lower rates of heart disease, type 2 diabetes and some types of cancer.

Going vegan is a great opportunity to learn more about nutrition and cooking, and improve your diet. Getting your nutrients from plant foods allows more room in your diet for health-promoting options like whole grains, fruit, nuts, seeds and vegetables, which are packed full of beneficial fibre, vitamins and minerals.

## For the environment

From recycling our household rubbish to cycling to work, we'"'"'re all aware of ways to live a greener life. One of the most effective things an individual can do to lower their carbon footprint is to avoid all animal products. This goes way beyond the problem of cow flatulence and air pollution!
Why is meat and dairy so bad for the environment?

The production of meat and other animal derived products places a heavy burden on the environment. The vast amount of grain feed required for meat production is a significant contributor to deforestation, habitat loss and species extinction. In Brazil alone, the equivalent of 5.6 million acres of land is used to grow soya beans for animals in Europe. This land contributes to developing world malnutrition by driving impoverished populations to grow cash crops for animal feed, rather than food for themselves. On the other hand, considerably lower quantities of crops and water are required to sustain a vegan diet, making the switch to veganism one of the easiest, most enjoyable and most effective ways to reduce our impact on the environment. For more on how veganism is the way forward for the environment, see our environment section.

## For people

Just like veganism is the sustainable option when it comes to looking after our planet, plant-based living is also a more sustainable way of feeding the human family. A plant-based diet requires only one third of the land needed to support a meat and dairy diet. With rising global food and water insecurity due to a myriad of environmental and socio-economic problems, there'"'"'s never been a better time to adopt a more sustainable way of living. Avoiding animal products is not just one of the simplest ways an individual can reduce the strain on food as well as other resources, it'"'"'s the simplest way to take a stand against inefficient food systems which disproportionately affect the poorest people all over the world. Read more about how vegan diets can help people.'
```

### ✅ Testing fs::createDirectoryIfNeeded

❯ `fs::createDirectoryIfNeeded resources/dir/subdir`

Returned variables:

```text
RETURNED_VALUE='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/dir/subdir'
```

This next command will fail because the directory already exists (it is a file).

❯ `fs::createDirectoryIfNeeded resources/dir/subdir/file1`

Exited with code: `1`

**Error output**:

```text
mkdir: cannot create directory ‘$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/dir/subdir/file1’: File exists
ERROR    Failed to create the directory ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/dir/subdir/file1⌝.
```

❯ `fs::createDirectoryIfNeeded resources/gitignored/derp`

Returned variables:

```text
RETURNED_VALUE='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/gitignored/derp'
```

Directory created successfully!

### ✅ Testing fs::createFilePathIfNeeded

❯ `fs::createFilePathIfNeeded resources/dir/subdir/file1`

Returned variables:

```text
RETURNED_VALUE='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/dir/subdir/file1'
```

❯ `fs::createFilePathIfNeeded resources/gitignored/allo/file1`

Returned variables:

```text
RETURNED_VALUE='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/gitignored/allo/file1'
```

File created successfully!

### ✅ Testing exe::sleep

❯ `exe::sleep 0.001`

### ✅ Testing fs::cat

❯ `fs::cat resources/file-to-read`

**Standard output**:

```text
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

Returned variables:

```text
RETURNED_VALUE='# Explore why veganism is kinder to animals, to people and to our planet'"'"'s future.

Source: <https://www.vegansociety.com/go-vegan/why-go-vegan>

## For the animals

Preventing the exploitation of animals is not the only reason for becoming vegan, but for many it remains the key factor in their decision to go vegan and stay vegan. Having emotional attachments with animals may form part of that reason, while many believe that all sentient creatures have a right to life and freedom. Specifics aside, avoiding animal products is one of the most obvious ways you can take a stand against animal cruelty and animal exploitation everywhere. Read a detailed overview on why being vegan demonstrates true compassion for animals.

## For your health

Well-planned vegan diets follow healthy eating guidelines, and contain all the nutrients that our bodies need. Both the British Dietetic Association and the American Academy of Nutrition and Dietetics recognise that they are suitable for every age and stage of life. Some research has linked that there are certain health benefits to vegan diets with lower blood pressure and cholesterol, and lower rates of heart disease, type 2 diabetes and some types of cancer.

Going vegan is a great opportunity to learn more about nutrition and cooking, and improve your diet. Getting your nutrients from plant foods allows more room in your diet for health-promoting options like whole grains, fruit, nuts, seeds and vegetables, which are packed full of beneficial fibre, vitamins and minerals.

## For the environment

From recycling our household rubbish to cycling to work, we'"'"'re all aware of ways to live a greener life. One of the most effective things an individual can do to lower their carbon footprint is to avoid all animal products. This goes way beyond the problem of cow flatulence and air pollution!
Why is meat and dairy so bad for the environment?

The production of meat and other animal derived products places a heavy burden on the environment. The vast amount of grain feed required for meat production is a significant contributor to deforestation, habitat loss and species extinction. In Brazil alone, the equivalent of 5.6 million acres of land is used to grow soya beans for animals in Europe. This land contributes to developing world malnutrition by driving impoverished populations to grow cash crops for animal feed, rather than food for themselves. On the other hand, considerably lower quantities of crops and water are required to sustain a vegan diet, making the switch to veganism one of the easiest, most enjoyable and most effective ways to reduce our impact on the environment. For more on how veganism is the way forward for the environment, see our environment section.

## For people

Just like veganism is the sustainable option when it comes to looking after our planet, plant-based living is also a more sustainable way of feeding the human family. A plant-based diet requires only one third of the land needed to support a meat and dairy diet. With rising global food and water insecurity due to a myriad of environmental and socio-economic problems, there'"'"'s never been a better time to adopt a more sustainable way of living. Avoiding animal products is not just one of the simplest ways an individual can reduce the strain on food as well as other resources, it'"'"'s the simplest way to take a stand against inefficient food systems which disproportionately affect the poorest people all over the world. Read more about how vegan diets can help people.'
```

### ✅ Testing exe::readStdIn

❯ `exe::readStdIn <<<'coucou'`

Returned variables:

```text
RETURNED_VALUE='coucou
'
```

❯ `exe::readStdIn`

Returned variables:

```text
RETURNED_VALUE=''
```

### ✅ Testing exe::countArgs

❯ `exe::countArgs arg1 arg2 arg3`

Returned variables:

```text
RETURNED_VALUE='3'
```

❯ `exe::countArgs ${PWD}/resources/*`

Returned variables:

```text
RETURNED_VALUE='3'
```

### ✅ Testing fs::isDirectoryWritable

❯ `fs::isDirectoryWritable /tmp && echo Writable || echo Not\ writable`

**Standard output**:

```text
Writable
```

### ✅ Testing windows::convertPathFromUnix

❯ `windows::convertPathFromUnix /tmp/file`

Returned variables:

```text
RETURNED_VALUE='\tmp\file'
```

❯ `windows::convertPathFromUnix /mnt/d/Users/username`

Returned variables:

```text
RETURNED_VALUE='D:\Users\username'
```

❯ `windows::convertPathFromUnix /c/data/file`

Returned variables:

```text
RETURNED_VALUE='C:\data\file'
```

### ✅ Testing fs::createLink

❯ `fs::createLink resources/gitignored/file resources/gitignored/try/file2 true`

**Standard output**:

```text
🙈 mocking ln: $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/gitignored/file $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/gitignored/try/file2
```

❯ `fs::createLink resources/gitignored/try resources/gitignored/new`

**Standard output**:

```text
🙈 mocking ln: -s $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/gitignored/try $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/gitignored/new
```

### ✅ Testing windows::convertPathToUnix

❯ `windows::convertPathToUnix C:\\Users\\username`

Returned variables:

```text
RETURNED_VALUE='/c/Users/username'
```

❯ `windows::convertPathToUnix D:\\data\\file`

Returned variables:

```text
RETURNED_VALUE='/d/data/file'
```

### ✅ Testing fs::head

❯ `fs::head resources/file-to-read 10`

**Standard output**:

```text
# Explore why veganism is kinder to animals, to people and to our planet's future.

Source: <https://www.vegansociety.com/go-vegan/why-go-vegan>

## For the animals

Preventing the exploitation of animals is not the only reason for becoming vegan, but for many it remains the key factor in their decision to go vegan and stay vegan. Having emotional attachments with animals may form part of that reason, while many believe that all sentient creatures have a right to life and freedom. Specifics aside, avoiding animal products is one of the most obvious ways you can take a stand against animal cruelty and animal exploitation everywhere. Read a detailed overview on why being vegan demonstrates true compassion for animals.

## For your health

```

❯ `fs::head resources/file-to-read 0`

❯ `fs::head resources/file-to-read 99`

**Standard output**:

```text
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

❯ `fs::head resources/file-to-read 3 true`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='# Explore why veganism is kinder to animals, to people and to our planet'"'"'s future.'
[1]=''
[2]='Source: <https://www.vegansociety.com/go-vegan/why-go-vegan>'
)
```

### ✅ Testing exe::captureOutput

❯ `exe::captureOutput echo coucou`

Returned variables:

```text
RETURNED_VALUE='coucou
'
```

❯ `exe::captureOutput declare -f exe::captureOutput`

Returned variables:

```text
RETURNED_VALUE='exe::captureOutput () 
{ 
    local IFS='"'"' '"'"';
    ${@} &> "${GLOBAL_TEMPORARY_STDOUT_FILE}" || return 1;
    RETURNED_VALUE="";
    IFS='"'"''"'"' read -rd '"'"''"'"' RETURNED_VALUE < "${GLOBAL_TEMPORARY_STDOUT_FILE}" || :
}
'
```

❯ `exe::captureOutput [[ 1 -eq 0 ]]`

Returned code: `1`

### ✅ Testing fs::tail

❯ `fs::tail resources/file-to-read 3`

**Standard output**:

```text
## For people

Just like veganism is the sustainable option when it comes to looking after our planet, plant-based living is also a more sustainable way of feeding the human family. A plant-based diet requires only one third of the land needed to support a meat and dairy diet. With rising global food and water insecurity due to a myriad of environmental and socio-economic problems, there's never been a better time to adopt a more sustainable way of living. Avoiding animal products is not just one of the simplest ways an individual can reduce the strain on food as well as other resources, it's the simplest way to take a stand against inefficient food systems which disproportionately affect the poorest people all over the world. Read more about how vegan diets can help people.
```

❯ `fs::tail resources/file-to-read 0`

**Standard output**:

```text

```

❯ `fs::tail resources/file-to-read 99`

**Standard output**:

```text
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

❯ `fs::tail resources/file-to-read 3 true`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='## For people'
[1]=''
[2]='Just like veganism is the sustainable option when it comes to looking after our planet, plant-based living is also a more sustainable way of feeding the human family. A plant-based diet requires only one third of the land needed to support a meat and dairy diet. With rising global food and water insecurity due to a myriad of environmental and socio-economic problems, there'"'"'s never been a better time to adopt a more sustainable way of living. Avoiding animal products is not just one of the simplest ways an individual can reduce the strain on food as well as other resources, it'"'"'s the simplest way to take a stand against inefficient food systems which disproportionately affect the poorest people all over the world. Read more about how vegan diets can help people.'
)
```

## Test script 01.invoke

For these tests, we will use a special command `fake` defined as such:

❯ `declare -f fake`

**Standard output**:

```text
fake () 
{ 
    local inputStreamContent;
    if [[ $* == *"--std-in"* ]]; then
        exe::readStdIn;
        inputStreamContent="${RETURNED_VALUE}";
    fi;
    local IFS=" ";
    echo "🙈 mocking fake $*";
    if [[ -n ${inputStreamContent:-} ]]; then
        echo "Input stream: <${inputStreamContent}>";
    fi;
    echo "INFO: log line from fake mock" 1>&2;
    if [[ $* == *"--error"* ]]; then
        echo "ERROR: returning error from fake" 1>&2;
        return 1;
    fi
}
```

### ✅ Testing exe::invoke5

Input stream from string, returns an error:

❯ `exe::invoke5 false 0 false 'input_stream' fake --std-in --error`

Returned code: `1`

Returned variables:

```text
RETURNED_VALUE='🙈 mocking fake --std-in --error
Input stream: <input_stream
>
'
RETURNED_VALUE2='INFO: log line from fake mock
ERROR: returning error from fake
'
```

Input stream from string, fails (exit):

❯ `exe::invoke5 true 0 false 'input_stream' fake --std-in --error`

Exited with code: `1`

**Error output**:

```text
TRACE    Fake standard output stream:
   1 ░ 🙈 mocking fake --std-in --error
   2 ░ Input stream: <input_stream
   3 ░ >
TRACE    Fake standard error stream:
   1 ░ INFO: log line from fake mock
   2 ░ ERROR: returning error from fake
ERROR    The command ⌜fake⌝ originally ended with exit code ⌜1⌝.
```

Make error 1 acceptable:

❯ `exe::invoke5 true 0,1,2 true '' fake --error`

Returned variables:

```text
RETURNED_VALUE='🙈 mocking fake --error
'
RETURNED_VALUE2='INFO: log line from fake mock
ERROR: returning error from fake
'
```

Normal, return everything as variables:

❯ `exe::invoke5 true '' '' '' fake`

Returned variables:

```text
RETURNED_VALUE='🙈 mocking fake 
'
RETURNED_VALUE2='INFO: log line from fake mock
'
```

Input stream for file, return everything as files:

❯ `exe::invokef5 false 0 true /tmp/valet-temp fake --std-in`

Returned variables:

```text
RETURNED_VALUE='/tmp/valet-stdout.f'
RETURNED_VALUE2='/tmp/valet-stderr.f'
```

❯ `fs::cat /tmp/valet-stdout.f`

**Standard output**:

```text
🙈 mocking fake --std-in
Input stream: <Input stream content from a file>

```

❯ `fs::cat /tmp/valet-stderr.f`

**Standard output**:

```text
INFO: log line from fake mock

```

### ✅ Testing exe::invoke2

❯ `exe::invoke2 false fake --option argument1 argument2`

Returned variables:

```text
RETURNED_VALUE='🙈 mocking fake --option argument1 argument2
'
RETURNED_VALUE2='INFO: log line from fake mock
'
```

❯ `exe::invoke2 false fake --error`

Returned code: `1`

Returned variables:

```text
RETURNED_VALUE='🙈 mocking fake --error
'
RETURNED_VALUE2='INFO: log line from fake mock
ERROR: returning error from fake
'
```

❯ `exe::invoke2 true fake --error`

Exited with code: `1`

**Error output**:

```text
TRACE    Fake standard output stream:
   1 ░ 🙈 mocking fake --error
TRACE    Fake standard error stream:
   1 ░ INFO: log line from fake mock
   2 ░ ERROR: returning error from fake
ERROR    The command ⌜fake⌝ originally ended with exit code ⌜1⌝.
```

❯ `exe::invokef2 false fake --option argument1 argument2`

Returned variables:

```text
RETURNED_VALUE='/tmp/valet-stdout.f'
RETURNED_VALUE2='/tmp/valet-stderr.f'
```

### ✅ Testing exe::invoke

❯ `exe::invoke fake --error`

Exited with code: `1`

**Error output**:

```text
TRACE    Fake standard output stream:
   1 ░ 🙈 mocking fake --error
TRACE    Fake standard error stream:
   1 ░ INFO: log line from fake mock
   2 ░ ERROR: returning error from fake
ERROR    The command ⌜fake⌝ originally ended with exit code ⌜1⌝.
```

❯ `exe::invoke fake --option argument1 argument2`

Returned variables:

```text
RETURNED_VALUE='🙈 mocking fake --option argument1 argument2
'
RETURNED_VALUE2='INFO: log line from fake mock
'
```

### ✅ Testing exe::invoke2piped

❯ `exe::invoke2piped true 'input_stream' fake --std-in --option argument1 argument2`

Returned variables:

```text
RETURNED_VALUE='🙈 mocking fake --std-in --option argument1 argument2
Input stream: <input_stream
>
'
RETURNED_VALUE2='INFO: log line from fake mock
'
```

❯ `exe::invokef2piped true 'input_stream' fake --std-in --option argument1 argument2`

Returned variables:

```text
RETURNED_VALUE='/tmp/valet-stdout.f'
RETURNED_VALUE2='/tmp/valet-stderr.f'
```

## Test script 02.listPaths

### ✅ Testing fs::listPaths

❯ `fs::listPaths $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/file1'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1'
)
```

❯ `fs::listPaths $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search true`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/file1'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/file2'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/subfolder2'
[4]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/subfolder2/file3'
)
```

❯ `fs::listPaths $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search false true`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-file'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/file1'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1'
)
```

❯ `fs::listPaths $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search true true`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-file'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/file1'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1'
[4]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/.hidden3'
[5]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/file10'
[6]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/subfolder4'
[7]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/.hidden-file2'
[8]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/file2'
[9]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/subfolder2'
[10]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/.hidden3/.hidden-file-13'
[11]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/.hidden3/file13'
[12]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/subfolder4/.hidden-file-14'
[13]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/subfolder4/file14'
[14]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/subfolder2/.hidden-file3'
[15]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/subfolder2/file3'
)
```

❯ `declare -f fileNamedFile`

**Standard output**:

```text
fileNamedFile () 
{ 
    if [[ ${1##*/} =~ ^file[[:digit:]]+$ ]]; then
        return 0;
    else
        return 1;
    fi
}
```

❯ `fs::listPaths $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search true true fileNamedFile`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/file1'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/file10'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/file2'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/.hidden3/file13'
[4]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/subfolder4/file14'
[5]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/subfolder2/file3'
)
```

❯ `declare -f folderNamedHidden`

**Standard output**:

```text
folderNamedHidden () 
{ 
    if [[ ${1##*/} == *hidden* ]]; then
        return 0;
    else
        return 1;
    fi
}
```

❯ `fs::listPaths $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search true true folderNamedHidden`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-file'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/.hidden3'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/.hidden-file2'
[4]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/.hidden3/.hidden-file-13'
[5]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/subfolder4/.hidden-file-14'
[6]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/subfolder2/.hidden-file3'
)
```

### ✅ Testing fs::listFiles

❯ `fs::listFiles $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/file1'
)
```

❯ `fs::listFiles $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search true`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/file1'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/file2'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/subfolder2/file3'
)
```

❯ `fs::listFiles $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search true true`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-file'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/file1'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/file10'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/.hidden-file2'
[4]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/file2'
[5]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/.hidden3/.hidden-file-13'
[6]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/.hidden3/file13'
[7]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/subfolder4/.hidden-file-14'
[8]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/subfolder4/file14'
[9]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/subfolder2/.hidden-file3'
[10]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/subfolder2/file3'
)
```

❯ `declare -f fileNamedHidden`

**Standard output**:

```text
fileNamedHidden () 
{ 
    if [[ ${1##*/} == *hidden* ]]; then
        return 0;
    else
        return 1;
    fi
}
```

❯ `fs::listFiles $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search true true folderNamedHidden`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-file'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/file1'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/file10'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/.hidden3/.hidden-file-13'
[4]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/.hidden3/file13'
)
```

### ✅ Testing fs::listDirectories

❯ `fs::listDirectories $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1'
)
```

❯ `fs::listDirectories $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search true`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/subfolder2'
)
```

❯ `fs::listDirectories $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search true true`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/.hidden3'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/subfolder4'
[4]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1/subfolder2'
)
```

❯ `declare -f folderNamedHidden`

**Standard output**:

```text
folderNamedHidden () 
{ 
    if [[ ${1##*/} == *hidden* ]]; then
        return 0;
    else
        return 1;
    fi
}
```

❯ `fs::listDirectories $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search true true folderNamedHidden`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/subfolder1'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/.hidden3'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-io/resources/search/.hidden-subfolder/subfolder4'
)
```

