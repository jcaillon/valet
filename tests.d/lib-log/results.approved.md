# Test suite lib-log

## Test script 00.log

### ✅ Testing log::createPrintFunction

```text
VALET_CONFIG_ENABLE_COLORS='true'
VALET_CONFIG_ENABLE_NERDFONT_ICONS='true'
VALET_CONFIG_LOG_DISABLE_TIME='false'
VALET_CONFIG_LOG_COLUMNS='50'
VALET_CONFIG_LOG_DISABLE_WRAP='false'
VALET_CONFIG_LOG_ENABLE_TIMESTAMP='true'
TZ='Etc/GMT+0'
EPOCHSECONDS='548902800'
EPOCHREALTIME='548902800.000000'
```

❯ `log::createPrintFunction`

❯ `eval ${GLOBAL_LOG_PRINT_FUNCTION}`

### ✅ Testing log::print

❯ `log::print SUCCESS  OK 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567`

**Error output**:

```text
1987-05-25_01:00:00 CSUOK       CDE 012345678901234567890123456789
                    012345678901234567890123456789
                    012345678901234567890123456789
                    012345678901234567890123456789
                    012345678901234567890123456789
                    012345678901234567890123456789
                    012345678901234567890123456789
                    012345678901234567890123456789
                    012345678901234567890123456789
                    01234567
                    012345678901234567890123456789
                    012345678901234567890123456789
                    012345678901234567890123456789
                    012345678901234567890123456789
                    012345678901234567890123456789
                    012345678901234567890123456789
                    012345678901234567890123456789
                    012345678901234567890123456789
                    012345678901234567890123456789
                    01234567
```

```text
VALET_CONFIG_ENABLE_COLORS='false'
VALET_CONFIG_ENABLE_NERDFONT_ICONS='false'
VALET_CONFIG_LOG_DISABLE_TIME='true'
VALET_CONFIG_LOG_COLUMNS='40'
```

❯ `log::createPrintFunction`

❯ `eval ${GLOBAL_LOG_PRINT_FUNCTION}`

❯ `log::info Next\ up\ is\ a\ big\ line\ with\ a\ lot\ of\ numbers\ not\ separated\ by\ spaces.\ Which\ means\ they\ will\ be\ truncated\ by\ characters\ and\ not\ by\ word\ boundaries\ like\ this\ sentence. 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567`

**Error output**:

```text
INFO     Next up is a big line with a 
         lot of numbers not separated by
         spaces. Which means they will 
         be truncated by characters and 
         not by word boundaries like 
         this sentence.
         0123456789012345678901234567890
         1234567890123456789012345678901
         2345678901234567890123456789012
         3456789012345678901234567890123
         4567890123456789012345678901234
         5678901234567890123456789012345
         6789012345678901234567890123456
         7890123456789012345678901234567
         890123456789012345678901234567
         0123456789012345678901234567890
         1234567890123456789012345678901
         2345678901234567890123456789012
         3456789012345678901234567890123
         4567890123456789012345678901234
         5678901234567890123456789012345
         6789012345678901234567890123456
         7890123456789012345678901234567
         890123456789012345678901234567
```

### ✅ Testing log::printFile

❯ `log::printFile file-to-read 2`

**Error output**:

```text
            1 ░ What is Lorem Ipsum?
            2 ░ 
            … ░ (truncated)
```

❯ `log::printFile file-to-read`

**Error output**:

```text
            1 ░ What is Lorem Ipsum?
            2 ░ 
            3 ░ Lorem Ipsum is simply du
              ░ mmy text of the printing
              ░ and typesetting industry
              ░ .
            4 ░ Lorem Ipsum has been the
              ░ industry's standard dumm
              ░ y text ever since the 15
              ░ 00s, when an unknown pri
              ░ nter took a galley of ty
              ░ pe and scrambled it to m
              ░ ake a type specimen book
              ░ .
            5 ░ It has survived not only
              ░ five centuries, but also
              ░ the leap into electronic
              ░ typesetting, remaining e
              ░ ssentially unchanged.
            6 ░ It was popularised in th
              ░ e 1960s with the release
              ░ of Letraset sheets conta
              ░ ining Lorem Ipsum passag
              ░ es, and more recently wi
              ░ th desktop publishing so
              ░ ftware like Aldus PageMa
              ░ ker including versions o
              ░ f Lorem Ipsum.
            7 ░ 
            8 ░ 012345678901234567890123
              ░ 456789012345678901234567
              ░ 890123456789012345678901
              ░ 234567890123456789012345
              ░ 678901234567890123456789
              ░ 012345678901234567890123
              ░ 456789012345678901234567
              ░ 890123456789012345678901
              ░ 234567890123456789012345
              ░ 678901234567890123456789
              ░ 012345678901234567890123
              ░ 456789012345678901234567
              ░ 890123456789012345678901
              ░ 234567890123456789012345
              ░ 678901234567890123456789
              ░ 012345678901234567890123
              ░ 456789012345678901234567
              ░ 890123456789012345678901
              ░ 234567890123456789012345
              ░ 678901234567890123456789
              ░ 012345678901234567890123
              ░ 456789012345678901234567
              ░ 89
            9 ░ 
           10 ░ Why do we use it?
           11 ░ 
           12 ░ It is a long established
              ░ fact that a reader will 
              ░ be distracted by the rea
              ░ dable content of a page 
              ░ when looking at its layo
              ░ ut.
           13 ░ The point of using Lorem
              ░ Ipsum is that it has a m
              ░ ore-or-less normal distr
              ░ ibution of letters, as o
              ░ pposed to using 'Content
              ░ here, content here', mak
              ░ ing it look like readabl
              ░ e English.
           14 ░ Many desktop publishing 
              ░ packages and web page ed
              ░ itors now use Lorem Ipsu
              ░ m as their default model
              ░ text, and a search for '
              ░ lorem ipsum' will uncove
              ░ r many web sites still i
              ░ n their infancy.
           15 ░ Various versions have ev
              ░ olved over the years, so
              ░ metimes by accident, som
              ░ etimes on purpose (injec
              ░ ted humour and the like)
              ░ .
```

```text
text='What is Lorem Ipsum?

Lorem Ipsum is simply dummy text of the printing and typesetting industry.
Lorem Ipsum has been the industry'"'"'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.
It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789

Why do we use it?

It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.
The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using '"'"'Content here, content here'"'"', making it look like readable English.
Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for '"'"'lorem ipsum'"'"' will uncover many web sites still in their infancy.
Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).'
```

### ✅ Testing log::printFileString

❯ `log::printFileString "${text}" 2`

**Error output**:

```text
            1 ░ What is Lorem Ipsum?
            2 ░ 
            … ░ (truncated)
```

❯ `log::printFileString "${text}"`

**Error output**:

```text
            1 ░ What is Lorem Ipsum?
            2 ░ 
            3 ░ Lorem Ipsum is simply du
              ░ mmy text of the printing
              ░ and typesetting industry
              ░ .
            4 ░ Lorem Ipsum has been the
              ░ industry's standard dumm
              ░ y text ever since the 15
              ░ 00s, when an unknown pri
              ░ nter took a galley of ty
              ░ pe and scrambled it to m
              ░ ake a type specimen book
              ░ .
            5 ░ It has survived not only
              ░ five centuries, but also
              ░ the leap into electronic
              ░ typesetting, remaining e
              ░ ssentially unchanged.
            6 ░ It was popularised in th
              ░ e 1960s with the release
              ░ of Letraset sheets conta
              ░ ining Lorem Ipsum passag
              ░ es, and more recently wi
              ░ th desktop publishing so
              ░ ftware like Aldus PageMa
              ░ ker including versions o
              ░ f Lorem Ipsum.
            7 ░ 
            8 ░ 012345678901234567890123
              ░ 456789012345678901234567
              ░ 890123456789012345678901
              ░ 234567890123456789012345
              ░ 678901234567890123456789
              ░ 012345678901234567890123
              ░ 456789012345678901234567
              ░ 890123456789012345678901
              ░ 234567890123456789012345
              ░ 678901234567890123456789
              ░ 012345678901234567890123
              ░ 456789012345678901234567
              ░ 890123456789012345678901
              ░ 234567890123456789012345
              ░ 678901234567890123456789
              ░ 012345678901234567890123
              ░ 456789012345678901234567
              ░ 890123456789012345678901
              ░ 234567890123456789012345
              ░ 678901234567890123456789
              ░ 012345678901234567890123
              ░ 456789012345678901234567
              ░ 89
            9 ░ 
           10 ░ Why do we use it?
           11 ░ 
           12 ░ It is a long established
              ░ fact that a reader will 
              ░ be distracted by the rea
              ░ dable content of a page 
              ░ when looking at its layo
              ░ ut.
           13 ░ The point of using Lorem
              ░ Ipsum is that it has a m
              ░ ore-or-less normal distr
              ░ ibution of letters, as o
              ░ pposed to using 'Content
              ░ here, content here', mak
              ░ ing it look like readabl
              ░ e English.
           14 ░ Many desktop publishing 
              ░ packages and web page ed
              ░ itors now use Lorem Ipsu
              ░ m as their default model
              ░ text, and a search for '
              ░ lorem ipsum' will uncove
              ░ r many web sites still i
              ░ n their infancy.
           15 ░ Various versions have ev
              ░ olved over the years, so
              ░ metimes by accident, som
              ░ etimes on purpose (injec
              ░ ted humour and the like)
              ░ .
```

## Test script 01.log-level

### ✅ Testing log levels

```text
VALET_CONFIG_ENABLE_COLORS='false'
VALET_CONFIG_ENABLE_NERDFONT_ICONS='false'
VALET_CONFIG_LOG_DISABLE_TIME='true'
VALET_CONFIG_LOG_COLUMNS='30'
VALET_CONFIG_LOG_DISABLE_WRAP='false'
GLOBAL_STACK_FUNCTION_NAMES=(
[0]='log::printCallStack'
[1]='log::error'
[2]='myCmd::subFunction'
[3]='myCmd::function'
)
GLOBAL_STACK_SOURCE_FILES=(
[0]=''
[1]='core'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-log/path/to/subFunction.sh'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/tests.d/lib-log/path/to/function.sh'
)
GLOBAL_STACK_LINE_NUMBERS=(
[0]='100'
[1]='200'
[2]='300'
)
```

❯ `log::createPrintFunction`

❯ `eval ${GLOBAL_LOG_PRINT_FUNCTION}`

❯ `log::setLevel trace`

**Error output**:

```text
DEBUG    Log level set to 
         trace.
WARNING  Beware that debug log
         level might lead to 
         secret leak, use it 
         only if necessary.
```

❯ `log::getLevel`

Returned variables:

```text
RETURNED_VALUE='trace'
```

❯ `log::isTraceEnabled`

❯ `log::isDebugEnabled`

❯ `log::error This\ is\ an\ error\ message.`

**Error output**:

```text
ERROR    This is an error 
         message.
         ├─ in myCmd::subFunct
         │  ion() at tests.d/l
         │  ib-log/path/to/sub
         │  Function.sh:200
         └─ in myCmd::function
            () at tests.d/lib-
            log/path/to/functi
            on.sh:300
```

❯ `log::warning This\ is\ a\ warning\ message.`

**Error output**:

```text
WARNING  This is a warning 
         message.
```

❯ `log::success This\ is\ an\ success\ message.`

**Error output**:

```text
SUCCESS  This is an success 
         message.
```

❯ `log::info This\ is\ an\ info\ message.`

**Error output**:

```text
INFO     This is an info 
         message.
```

❯ `log::debug This\ is\ a\ debug\ message.`

**Error output**:

```text
DEBUG    This is a debug 
         message.
```

❯ `log::trace This\ is\ a\ trace\ message.`

**Error output**:

```text
TRACE    This is a trace 
         message.
```

❯ `log::errorTrace This\ is\ a\ errorTrace\ message\,\ always\ shown.`

**Error output**:

```text
TRACE    This is a errorTrace 
         message, always 
         shown.
```

❯ `log::setLevel debug`

**Error output**:

```text
DEBUG    Log level set to 
         debug.
WARNING  Beware that debug log
         level might lead to 
         secret leak, use it 
         only if necessary.
```

❯ `log::getLevel`

Returned variables:

```text
RETURNED_VALUE='debug'
```

❯ `log::isTraceEnabled`

Returned code: `1`

❯ `log::isDebugEnabled`

❯ `log::error This\ is\ an\ error\ message.`

**Error output**:

```text
ERROR    This is an error 
         message.
         ├─ in myCmd::subFunct
         │  ion() at tests.d/l
         │  ib-log/path/to/sub
         │  Function.sh:200
         └─ in myCmd::function
            () at tests.d/lib-
            log/path/to/functi
            on.sh:300
```

❯ `log::warning This\ is\ a\ warning\ message.`

**Error output**:

```text
WARNING  This is a warning 
         message.
```

❯ `log::success This\ is\ an\ success\ message.`

**Error output**:

```text
SUCCESS  This is an success 
         message.
```

❯ `log::info This\ is\ an\ info\ message.`

**Error output**:

```text
INFO     This is an info 
         message.
```

❯ `log::debug This\ is\ a\ debug\ message.`

**Error output**:

```text
DEBUG    This is a debug 
         message.
```

❯ `log::trace This\ is\ a\ trace\ message.`

❯ `log::errorTrace This\ is\ a\ errorTrace\ message\,\ always\ shown.`

**Error output**:

```text
TRACE    This is a errorTrace 
         message, always 
         shown.
```

❯ `log::setLevel info`

❯ `log::getLevel`

Returned variables:

```text
RETURNED_VALUE='info'
```

❯ `log::isTraceEnabled`

Returned code: `1`

❯ `log::isDebugEnabled`

Returned code: `1`

❯ `log::error This\ is\ an\ error\ message.`

**Error output**:

```text
ERROR    This is an error 
         message.
```

❯ `log::warning This\ is\ a\ warning\ message.`

**Error output**:

```text
WARNING  This is a warning 
         message.
```

❯ `log::success This\ is\ an\ success\ message.`

**Error output**:

```text
SUCCESS  This is an success 
         message.
```

❯ `log::info This\ is\ an\ info\ message.`

**Error output**:

```text
INFO     This is an info 
         message.
```

❯ `log::debug This\ is\ a\ debug\ message.`

❯ `log::trace This\ is\ a\ trace\ message.`

❯ `log::errorTrace This\ is\ a\ errorTrace\ message\,\ always\ shown.`

**Error output**:

```text
TRACE    This is a errorTrace 
         message, always 
         shown.
```

❯ `log::setLevel success`

❯ `log::getLevel`

Returned variables:

```text
RETURNED_VALUE='success'
```

❯ `log::isTraceEnabled`

Returned code: `1`

❯ `log::isDebugEnabled`

Returned code: `1`

❯ `log::error This\ is\ an\ error\ message.`

**Error output**:

```text
ERROR    This is an error 
         message.
```

❯ `log::warning This\ is\ a\ warning\ message.`

**Error output**:

```text
WARNING  This is a warning 
         message.
```

❯ `log::success This\ is\ an\ success\ message.`

**Error output**:

```text
SUCCESS  This is an success 
         message.
```

❯ `log::info This\ is\ an\ info\ message.`

❯ `log::debug This\ is\ a\ debug\ message.`

❯ `log::trace This\ is\ a\ trace\ message.`

❯ `log::errorTrace This\ is\ a\ errorTrace\ message\,\ always\ shown.`

**Error output**:

```text
TRACE    This is a errorTrace 
         message, always 
         shown.
```

❯ `log::setLevel warning`

❯ `log::getLevel`

Returned variables:

```text
RETURNED_VALUE='warning'
```

❯ `log::isTraceEnabled`

Returned code: `1`

❯ `log::isDebugEnabled`

Returned code: `1`

❯ `log::error This\ is\ an\ error\ message.`

**Error output**:

```text
ERROR    This is an error 
         message.
```

❯ `log::warning This\ is\ a\ warning\ message.`

**Error output**:

```text
WARNING  This is a warning 
         message.
```

❯ `log::success This\ is\ an\ success\ message.`

❯ `log::info This\ is\ an\ info\ message.`

❯ `log::debug This\ is\ a\ debug\ message.`

❯ `log::trace This\ is\ a\ trace\ message.`

❯ `log::errorTrace This\ is\ a\ errorTrace\ message\,\ always\ shown.`

**Error output**:

```text
TRACE    This is a errorTrace 
         message, always 
         shown.
```

❯ `log::setLevel error`

❯ `log::getLevel`

Returned variables:

```text
RETURNED_VALUE='error'
```

❯ `log::isTraceEnabled`

Returned code: `1`

❯ `log::isDebugEnabled`

Returned code: `1`

❯ `log::error This\ is\ an\ error\ message.`

**Error output**:

```text
ERROR    This is an error 
         message.
```

❯ `log::warning This\ is\ a\ warning\ message.`

❯ `log::success This\ is\ an\ success\ message.`

❯ `log::info This\ is\ an\ info\ message.`

❯ `log::debug This\ is\ a\ debug\ message.`

❯ `log::trace This\ is\ a\ trace\ message.`

❯ `log::errorTrace This\ is\ a\ errorTrace\ message\,\ always\ shown.`

**Error output**:

```text
TRACE    This is a errorTrace 
         message, always 
         shown.
```

