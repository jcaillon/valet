# Test suite lib-fs

## Test script 00.lib-fs

### ✅ Testing fs::getCommandPath

❯ `fs::getCommandPath script.sh`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/script.sh'
```

❯ `fs::getCommandPath script2`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/script2.sh'
```

❯ `fs::getCommandPath unknown-command1`

Returned variables:

```text
REPLY=''
```

### ✅ Testing fs::getScriptDirectory

❯ `fs::getScriptDirectory`

**Standard output**:

```text
$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs
```

❯ `source resources/script.sh`

**Standard output**:

```text
$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources
```

### ✅ Testing fs::writeToFile

❯ `fs::writeToFile resources/gitignored/file1 _content`

❯ `fs::writeToFile resources/gitignored/file1 _content append=true`

❯ `fs::cat resources/gitignored/file1`

**Standard output**:

```text
Hello, World!
```

### ✅ Testing fs::createTempFile and fs::createTempDirectory

❯ `fs::createTempFile pathOnly=true`

Returned variables:

```text
REPLY='/tmp/valet.d/f1-2'
```

The file path was returned but the file does not exist.

❯ `fs::createTempDirectory pathOnly=true`

Returned variables:

```text
REPLY='/tmp/valet.d/d1-2'
```

The directory path was returned but the directory does not exist.

### ✅ Testing fs::getFileLineCount

❯ `fs::getFileLineCount resources/file-to-read`

Returned variables:

```text
REPLY='24'
```

❯ `fs::getFileLineCount resources/file-with-final-eol`

Returned variables:

```text
REPLY='2'
```

❯ `VALET_CONFIG_STRICT_PURE_BASH=true fs::getFileLineCount resources/file-to-read`

Returned variables:

```text
REPLY='24'
```

### ✅ Testing fs::getAbsolutePath

❯ `fs::getAbsolutePath $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/01.invoke.sh`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/01.invoke.sh'
```

❯ `fs::getAbsolutePath .`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs'
```

❯ `fs::getAbsolutePath ..`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/tests.d'
```

❯ `fs::getAbsolutePath 01.invoke.s`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/01.invoke.s'
```

❯ `fs::getAbsolutePath ../1004-lib-system/00.tests.sh`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/../1004-lib-system/00.tests.sh'
```

❯ `fs::getAbsolutePath resources`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources'
```

❯ `fs::getAbsolutePath ./01.invoke.sh`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/01.invoke.sh'
```

❯ `fs::getAbsolutePath ./resources`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources'
```

❯ `fs::getAbsolutePath missing-file`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/missing-file'
```

❯ `fs::getAbsolutePath $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/01.invoke.sh realpath=true`

Returned variables:

```text
REPLY='mocked pwd/01.invoke.sh'
```

### ✅ Testing fs::readFile

❯ `fs::readFile resources/file-to-read maxCharacters=22`

Returned variables:

```text
REPLY='# Explore why veganism'
```

❯ `fs::readFile resources/file-to-read`

Returned variables:

```text
REPLY='# Explore why veganism is kinder to animals, to people and to our planet'"'"'s future.

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
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/dir/subdir'
```

This next command will fail because the directory already exists (it is a file).

❯ `fs::createDirectoryIfNeeded resources/dir/subdir/file1`

Exited with code: `1`

**Error output**:

```text
mkdir: cannot create directory '$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/dir/subdir/file1': File exists
FAIL     Failed to create the directory ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/dir/subdir/file1⌝.
```

❯ `fs::createDirectoryIfNeeded resources/gitignored/derp`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/gitignored/derp'
```

Directory created successfully!

### ✅ Testing fs::createFileIfNeeded

❯ `fs::createFileIfNeeded resources/dir/subdir/file1`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/dir/subdir/file1'
```

❯ `fs::createFileIfNeeded resources/gitignored/allo/file1`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/gitignored/allo/file1'
```

File created successfully!

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
REPLY='# Explore why veganism is kinder to animals, to people and to our planet'"'"'s future.

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

### ✅ Testing fs::isDirectoryWritable

❯ `fs::isDirectoryWritable /tmp`

❯ `fs::isDirectoryWritable /tmp testFileName=test-file`

### ✅ Testing fs::createLink

❯ `fs::createLink file1 target/link1`

❯ `fs::createLink file1 target/link2 hardlink=true`

❯ `fs::createLink file2 target/link3 hardlink=true`

❯ `fs::createLink folder1 target/folder-link1`

❯ `fs::createLink folder1 target/existing-folder-link2`

Exited with code: `1`

**Error output**:

```text
FAIL     Failed to create a link to ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/gitignored/folder1⌝ ← ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/gitignored/target/existing-folder-link2⌝, the link pathname already exists.
```

❯ `fs::createLink file1 target/existing-folder-link2`

Exited with code: `1`

**Error output**:

```text
FAIL     Failed to create a link to ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/gitignored/file1⌝ ← ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/gitignored/target/existing-folder-link2⌝, the link pathname already exists.
```

❯ `fs::createLink folder1 target/existing-folder-link2 force=true`

❯ `fs::createLink folder1 target/existing-file3`

Exited with code: `1`

**Error output**:

```text
FAIL     Failed to create a link to ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/gitignored/folder1⌝ ← ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/gitignored/target/existing-file3⌝, the link pathname already exists.
```

❯ `fs::createLink file1 target/existing-file3`

Exited with code: `1`

**Error output**:

```text
FAIL     Failed to create a link to ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/gitignored/file1⌝ ← ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/gitignored/target/existing-file3⌝, the link pathname already exists.
```

❯ `fs::createLink file1 target/existing-file3 force=true`

### ✅ Testing fs::isValidLink

❯ `fs::isValidLink file1 target/link1`

❯ `fs::isValidLink file1 target/link2 hardlink=true`

❯ `fs::isValidLink folder1 target/folder-link1`

❯ `fs::isValidLink file1 target/link1 hardlink=true`

Returned code: `1`

❯ `fs::isValidLink file1 target/link2`

Returned code: `1`

❯ `fs::isValidLink file1 folder1`

Returned code: `1`

❯ `fs::isValidLink folder1 file1`

Returned code: `1`

❯ `fs::isValidLink file1 non-existing`

Returned code: `1`

❯ `fs::isValidLink file2 target/existing-file3`

Returned code: `1`

❯ `fs::isValidLink file1 target/link3 hardlink=true`

Returned code: `1`

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

❯ `fs::head resources/file-to-read 3 toArray=true`

Returned variables:

```text
REPLY_ARRAY=(
[0]='# Explore why veganism is kinder to animals, to people and to our planet'"'"'s future.'
[1]=''
[2]='  Source: <https://www.vegansociety.com/go-vegan/why-go-vegan>'
)
```

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

❯ `fs::tail resources/file-to-read 3 toArray=true`

Returned variables:

```text
REPLY_ARRAY=(
[0]='## For people'
[1]=''
[2]='Just like veganism is the sustainable option when it comes to looking after our planet, plant-based living is also a more sustainable way of feeding the human family. A plant-based diet requires only one third of the land needed to support a meat and dairy diet. With rising global food and water insecurity due to a myriad of environmental and socio-economic problems, there'"'"'s never been a better time to adopt a more sustainable way of living. Avoiding animal products is not just one of the simplest ways an individual can reduce the strain on food as well as other resources, it'"'"'s the simplest way to take a stand against inefficient food systems which disproportionately affect the poorest people all over the world. Read more about how vegan diets can help people.'
)
```

## Test script 01.listPaths

### ✅ Testing fs::listPaths

❯ `fs::listPaths $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search`

Returned variables:

```text
REPLY_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/file1'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1'
)
```

❯ `fs::listPaths $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search recursive=true`

Returned variables:

```text
REPLY_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/file1'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/file2'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/subfolder2'
[4]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/subfolder2/file3'
)
```

❯ `fs::listPaths $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search includeHidden=true`

Returned variables:

```text
REPLY_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-file'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/file1'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1'
)
```

❯ `fs::listPaths $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search recursive=true includeHidden=true`

Returned variables:

```text
REPLY_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-file'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/file1'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1'
[4]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/.hidden3'
[5]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/file10'
[6]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/subfolder4'
[7]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/.hidden-file2'
[8]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/file2'
[9]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/subfolder2'
[10]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/.hidden3/.hidden-file-13'
[11]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/.hidden3/file13'
[12]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/subfolder4/.hidden-file-14'
[13]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/subfolder4/file14'
[14]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/subfolder2/.hidden-file3'
[15]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/subfolder2/file3'
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

❯ `fs::listPaths $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search recursive=true includeHidden=true filter=fileNamedFile`

Returned variables:

```text
REPLY_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/file1'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/file10'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/file2'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/.hidden3/file13'
[4]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/subfolder4/file14'
[5]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/subfolder2/file3'
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

❯ `fs::listPaths $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search recursive=true includeHidden=true filter=folderNamedHidden`

Returned variables:

```text
REPLY_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-file'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/.hidden3'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/.hidden-file2'
[4]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/.hidden3/.hidden-file-13'
[5]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/subfolder4/.hidden-file-14'
[6]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/subfolder2/.hidden-file3'
)
```

### ✅ Testing fs::listFiles

❯ `fs::listFiles $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search`

Returned variables:

```text
REPLY_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/file1'
)
```

❯ `fs::listFiles $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search recursive=true`

Returned variables:

```text
REPLY_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/file1'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/file2'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/subfolder2/file3'
)
```

❯ `fs::listFiles $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search recursive=true includeHidden=true`

Returned variables:

```text
REPLY_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-file'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/file1'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/file10'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/.hidden-file2'
[4]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/file2'
[5]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/.hidden3/.hidden-file-13'
[6]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/.hidden3/file13'
[7]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/subfolder4/.hidden-file-14'
[8]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/subfolder4/file14'
[9]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/subfolder2/.hidden-file3'
[10]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/subfolder2/file3'
)
```

❯ `declare -f fileNamedContainsHidden`

**Standard output**:

```text
fileNamedContainsHidden () 
{ 
    if [[ ${1##*/} == *hidden* ]]; then
        return 0;
    else
        return 1;
    fi
}
```

❯ `fs::listFiles $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search recursive=true includeHidden=true filter=fileNamedContainsHidden`

Returned variables:

```text
REPLY_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-file'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/.hidden-file2'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/.hidden3/.hidden-file-13'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/subfolder4/.hidden-file-14'
[4]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/subfolder2/.hidden-file3'
)
```

### ✅ Testing fs::listDirectories

❯ `fs::listDirectories $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search`

Returned variables:

```text
REPLY_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1'
)
```

❯ `fs::listDirectories $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search recursive=true`

Returned variables:

```text
REPLY_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/subfolder2'
)
```

❯ `fs::listDirectories $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search recursive=true includeHidden=true`

Returned variables:

```text
REPLY_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/.hidden3'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/subfolder4'
[4]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/subfolder1/subfolder2'
)
```

❯ `declare -f folderNamedContainsHidden`

**Standard output**:

```text
folderNamedContainsHidden () 
{ 
    if [[ ${1##*/} == *hidden* ]]; then
        return 0;
    else
        return 1;
    fi
}
```

❯ `fs::listDirectories $GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search recursive=true includeHidden=true filter=folderNamedContainsHidden`

Returned variables:

```text
REPLY_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-fs/resources/search/.hidden-subfolder/.hidden3'
)
```

