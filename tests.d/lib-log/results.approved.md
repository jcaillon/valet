# Test suite lib-log

## Test script 00.tests

### Testing log level



Exit code: `0`

Error output

```text

→ log::setLevel trace
DEBUG    Log level set to 
         trace.
WARNING  Beware that debug log
         level might lead to 
         secret leak, use it 
         only if necessary.

→ log::getLevel
trace

→ log::isTraceEnabled
0

→ log::isDebugEnabled
0

→ log::error 'This is an error message.'
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

→ log::warning 'This is a warning message.'
WARNING  This is a warning 
         message.

→ log::success 'This is an success message.'
SUCCESS  This is an success 
         message.

→ log::info 'This is an info message.'
INFO     This is an info 
         message.

→ log::debug 'This is a debug message.'
DEBUG    This is a debug 
         message.

→ log::trace 'This is a trace message.'
TRACE    This is a trace 
         message.

→ log::errorTrace 'This is a errorTrace message, always shown.'
TRACE    This is a errorTrace 
         message, always 
         shown.

→ log::setLevel debug
DEBUG    Log level set to 
         debug.
WARNING  Beware that debug log
         level might lead to 
         secret leak, use it 
         only if necessary.

→ log::getLevel
debug

→ log::isTraceEnabled
1

→ log::isDebugEnabled
0

→ log::error 'This is an error message.'
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

→ log::warning 'This is a warning message.'
WARNING  This is a warning 
         message.

→ log::success 'This is an success message.'
SUCCESS  This is an success 
         message.

→ log::info 'This is an info message.'
INFO     This is an info 
         message.

→ log::debug 'This is a debug message.'
DEBUG    This is a debug 
         message.

→ log::trace 'This is a trace message.'

→ log::errorTrace 'This is a errorTrace message, always shown.'
TRACE    This is a errorTrace 
         message, always 
         shown.

→ log::setLevel info

→ log::getLevel
info

→ log::isTraceEnabled
1

→ log::isDebugEnabled
1

→ log::error 'This is an error message.'
ERROR    This is an error 
         message.

→ log::warning 'This is a warning message.'
WARNING  This is a warning 
         message.

→ log::success 'This is an success message.'
SUCCESS  This is an success 
         message.

→ log::info 'This is an info message.'
INFO     This is an info 
         message.

→ log::debug 'This is a debug message.'

→ log::trace 'This is a trace message.'

→ log::errorTrace 'This is a errorTrace message, always shown.'
TRACE    This is a errorTrace 
         message, always 
         shown.

→ log::setLevel success

→ log::getLevel
success

→ log::isTraceEnabled
1

→ log::isDebugEnabled
1

→ log::error 'This is an error message.'
ERROR    This is an error 
         message.

→ log::warning 'This is a warning message.'
WARNING  This is a warning 
         message.

→ log::success 'This is an success message.'
SUCCESS  This is an success 
         message.

→ log::info 'This is an info message.'

→ log::debug 'This is a debug message.'

→ log::trace 'This is a trace message.'

→ log::errorTrace 'This is a errorTrace message, always shown.'
TRACE    This is a errorTrace 
         message, always 
         shown.

→ log::setLevel warning

→ log::getLevel
warning

→ log::isTraceEnabled
1

→ log::isDebugEnabled
1

→ log::error 'This is an error message.'
ERROR    This is an error 
         message.

→ log::warning 'This is a warning message.'
WARNING  This is a warning 
         message.

→ log::success 'This is an success message.'

→ log::info 'This is an info message.'

→ log::debug 'This is a debug message.'

→ log::trace 'This is a trace message.'

→ log::errorTrace 'This is a errorTrace message, always shown.'
TRACE    This is a errorTrace 
         message, always 
         shown.

→ log::setLevel error

→ log::getLevel
error

→ log::isTraceEnabled
1

→ log::isDebugEnabled
1

→ log::error 'This is an error message.'
ERROR    This is an error 
         message.

→ log::warning 'This is a warning message.'

→ log::success 'This is an success message.'

→ log::info 'This is an info message.'

→ log::debug 'This is a debug message.'

→ log::trace 'This is a trace message.'

→ log::errorTrace 'This is a errorTrace message, always shown.'
TRACE    This is a errorTrace 
         message, always 
         shown.
```

### Testing log::xx functions



Exit code: `0`

Error output

```text

→ log::createPrintFunction

→ log::print SUCCESS   OK ...
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

→ log::info ...
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

→ log::printFile file-to-read 2
            1 ░ What is Lorem Ipsum?
            2 ░ 
            … ░ (truncated)

→ log::printFile file-to-read
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

→ log::printFileString "${text}" 2
            1 ░ What is Lorem Ipsum?
            2 ░ 
            … ░ (truncated)

→ log::printFileString "${text}"
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

