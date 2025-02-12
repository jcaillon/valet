# Test suite lib-log

## Test script 00.log

### ✅ Testing log::init

❯ `log::init`

```text
GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG='local -n messageToPrint="${messageVariableName}"


printf "%-8s%s%s\n" "${level:-}" " " "${messageToPrint:-}"  1>&2'
GLOBAL_LOG_PRINT_STATEMENT_STANDARD='printf "%s" "${toPrint}" 1>&2'
GLOBAL_LOG_WRAP_PADDING='         '
```

❯ `VALET_CONFIG_LOG_DISABLE_HIGHLIGHT=true VALET_CONFIG_LOG_DISABLE_WRAP=false log::init`

```text
GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG='local RETURNED_VALUE RETURNED_VALUE2
local -n messageToPrint=RETURNED_VALUE
string::wrapWords "${messageVariableName}" 9999 "         " 9990


printf "%-8s%s%s\n" "${level:-}" " " "${messageToPrint:-}"  1>&2'
GLOBAL_LOG_PRINT_STATEMENT_STANDARD='printf "%s" "${toPrint}" 1>&2'
GLOBAL_LOG_WRAP_PADDING='         '
```

❯ `VALET_CONFIG_LOG_PATTERN=abc VALET_CONFIG_LOG_FD=5 log::init`

```text
GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG='local -n messageToPrint="${messageVariableName}"


printf "%s\n" "abc"  1>&5'
GLOBAL_LOG_PRINT_STATEMENT_STANDARD='printf "%s" "${toPrint}" 1>&5'
GLOBAL_LOG_WRAP_PADDING='   '
```

❯ `VALET_CONFIG_LOG_FORMATTED_EXTRA_EVAL=local\ extra=1 log::init`

```text
GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG='local -n messageToPrint="${messageVariableName}"

local extra=1
printf "%-8s%s%s\n" "${level:-}" " " "${messageToPrint:-}"  1>&2'
GLOBAL_LOG_PRINT_STATEMENT_STANDARD='printf "%s" "${toPrint}" 1>&2'
GLOBAL_LOG_WRAP_PADDING='         '
```

❯ `VALET_CONFIG_LOG_FD=/file VALET_CONFIG_LOG_TO_DIRECTORY=tmp log::init`

```text
GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG='local -n messageToPrint="${messageVariableName}"


printf "%-8s%s%s\n" "${level:-}" " " "${messageToPrint:-}"  1>>"/file"
printf "%-8s%s%s\n" "${level:-}" " " "${messageToPrint:-}"  1>>"tmp/valet-1987-05-25T01-00-00+0000.log"'
GLOBAL_LOG_PRINT_STATEMENT_STANDARD='printf "%s" "${toPrint}" 1>>"/file"
printf "%s" "${toPrint}" 1>>"tmp/valet-1987-05-25T01-00-00+0000.log"'
GLOBAL_LOG_WRAP_PADDING='         '
```

❯ `VALET_CONFIG_LOG_FD=/file VALET_CONFIG_LOG_TO_DIRECTORY=tmp VALET_CONFIG_LOG_FILENAME_PATTERN=logFile=a log::init`

```text
GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG='local -n messageToPrint="${messageVariableName}"


printf "%-8s%s%s\n" "${level:-}" " " "${messageToPrint:-}"  1>>"/file"
printf "%-8s%s%s\n" "${level:-}" " " "${messageToPrint:-}"  1>>"tmp/a"'
GLOBAL_LOG_PRINT_STATEMENT_STANDARD='printf "%s" "${toPrint}" 1>>"/file"
printf "%s" "${toPrint}" 1>>"tmp/a"'
GLOBAL_LOG_WRAP_PADDING='         '
```

### ✅ Testing log::parseLogPattern

❯ `log::parseLogPattern static\ string`

Returned variables:

```text
RETURNED_VALUE='%s\n'
RETURNED_VALUE2='"static string" '
RETURNED_VALUE3='13'
```

❯ `log::parseLogPattern $'static\nstring'`

Returned variables:

```text
RETURNED_VALUE='%s\n'
RETURNED_VALUE2='"static
string" '
RETURNED_VALUE3='6'
```

❯ `log::parseLogPattern $'static\n<message>'`

Returned variables:

```text
RETURNED_VALUE='%s%s\n'
RETURNED_VALUE2='"static
" "${messageToPrint:-}" '
RETURNED_VALUE3='0'
```

❯ `log::parseLogPattern \<colorFaded\>\<time\>\<colorDefault\>\ \<levelColor\>\<level\>\ \<icon\>\<colorDefault\>\ PID=\<pid\>\ SHLVL=\<subshell\>\ \<function\>\{8s\}@\<source\>:\<line\>\ \<message\>`

Returned variables:

```text
RETURNED_VALUE='%(%H:%M:%S)T%s%s%-8s%s%s%-5d%s%-2d%s%8s%s%-10s%s%-4s%s%s\n'
RETURNED_VALUE2='"${EPOCHSECONDS}" " " "${levelColor:-}" "${level:-}" " " " PID=" "${BASHPID}" " SHLVL=" "${BASH_SUBSHELL}" " " "${FUNCNAME[2]:${#FUNCNAME[2]} - 8 > 0 ? ${#FUNCNAME[2]} - 8 : 0}" "@" "${BASH_SOURCE[2]:${#BASH_SOURCE[2]} - 10 > 0 ? ${#BASH_SOURCE[2]} - 10 : 0}" ":" "${BASH_LINENO[1]:${#BASH_LINENO[1]} - 4 > 0 ? ${#BASH_LINENO[1]} - 4 : 0}" " " "${messageToPrint:-}" '
RETURNED_VALUE3='63'
```

❯ `VALET_CONFIG_ENABLE_NERDFONT_ICONS=true log::parseLogPattern \<icon\>\ \<message\>`

Returned variables:

```text
RETURNED_VALUE='%-4s%s%s\n'
RETURNED_VALUE2='"${icon:-}" " " "${messageToPrint:-}" '
RETURNED_VALUE3='3'
```

❯ `VALET_CONFIG_ENABLE_NERDFONT_ICONS=false log::parseLogPattern \<icon\>\ \<message\>`

Returned variables:

```text
RETURNED_VALUE='%s%s\n'
RETURNED_VALUE2='" " "${messageToPrint:-}" '
RETURNED_VALUE3='1'
```

❯ `log::parseLogPattern \<colorFaded\>\{9s\}\ \<time\>\{\(%FT%H:%M:%S%z\)T\}\ \<levelColor\>\{9s\}\ \<level\>\{9s\}\ \<icon\>\{9s\}\ \<varCOLOR_DEBUG\>\{9s\}\ \<pid\>\{9s\}\ \<subshell\>\{9s\}\ \<function\>\{9s\}\ \<source\>\{9s\}\ \<line\>\{9s\}`

Returned variables:

```text
RETURNED_VALUE='%s%(%FT%H:%M:%S%z)T%s%s%s%9s%s%s%9s%s%9s%s%9s%s%9s%s%9s%s%9s\n'
RETURNED_VALUE2='" " "${EPOCHSECONDS}" " " "${levelColor:-}" " " "${level:-}" " " " " "${COLOR_DEBUG:-}" " " "${BASHPID}" " " "${BASH_SUBSHELL}" " " "${FUNCNAME[2]:${#FUNCNAME[2]} - 9 > 0 ? ${#FUNCNAME[2]} - 9 : 0}" " " "${BASH_SOURCE[2]:${#BASH_SOURCE[2]} - 9 > 0 ? ${#BASH_SOURCE[2]} - 9 : 0}" " " "${BASH_LINENO[1]:${#BASH_LINENO[1]} - 9 > 0 ? ${#BASH_LINENO[1]} - 9 : 0}" '
RETURNED_VALUE3='97'
```

### ✅ Testing with no formatting

❯ `log::init`

❯ `core::colorInit`

### ✅ Testing log::printRaw

❯ `log::printRaw hello`

**Error output**:

```text
hello
```

❯ `log::printRaw _world`

**Error output**:

```text
_world
```

### ✅ Testing log::printString

❯ `log::printString Next\ up\ is\ a\ big\ line\ with\ a\ lot\ of\ numbers\ not\ separated\ by\ spaces.\ Which\ means\ they\ will\ be\ truncated\ by\ characters\ and\ not\ by\ word\ boundaries\ like\ this\ sentence.`

**Error output**:

```text
Next up is a big line with a lot of numbers not separated by spaces. Which means they will be truncated by characters and not by word boundaries like this sentence.
```

### ✅ Testing log::info

❯ `log::info Next\ up\ is\ a\ big\ line\ with\ a\ lot\ of\ numbers\ not\ separated\ by\ spaces.\ Which\ means\ they\ will\ be\ truncated\ by\ characters\ and\ not\ by\ word\ boundaries\ like\ this\ sentence. 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567`

**Error output**:

```text
INFO     Next up is a big line with a lot of numbers not separated by spaces. Which means they will be truncated by characters and not by word boundaries like this sentence.
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
```

### ✅ Testing log::printFile

❯ `log::printFile file-to-read 2`

**Error output**:

```text
   1 ░ What is Lorem Ipsum?
   2 ░ 
     ░ (truncated)
```

❯ `log::printFile file-to-read`

**Error output**:

```text
   1 ░ What is Lorem Ipsum?
   2 ░ 
   3 ░ Lorem Ipsum is simply dummy text of the printing and typesetting industry.
   4 ░ Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
   5 ░ It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.
   6 ░ It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
   7 ░ 
   8 ░ 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
   9 ░ 
  10 ░ Why do we use it?
  11 ░ 
  12 ░ It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.
  13 ░ The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.
  14 ░ Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.
  15 ░ Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).
```

### ✅ Testing log::printFileString

❯ `log::printFileString "${text}" 2`

**Error output**:

```text
   1 ░ What is Lorem Ipsum?
   2 ░ 
     ░ (truncated)
```

❯ `log::printFileString "${text}"`

**Error output**:

```text
   1 ░ What is Lorem Ipsum?
   2 ░ 
   3 ░ Lorem Ipsum is simply dummy text of the printing and typesetting industry.
   4 ░ Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
   5 ░ It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.
   6 ░ It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
   7 ░ 
   8 ░ 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
   9 ░ 
  10 ░ Why do we use it?
  11 ░ 
  12 ░ It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.
  13 ░ The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.
  14 ░ Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.
  15 ░ Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).
```

### ✅ Testing with full formatting

```text
VALET_CONFIG_ENABLE_COLORS='true'
VALET_CONFIG_ENABLE_NERDFONT_ICONS='true'
VALET_CONFIG_LOG_PATTERN='<colorFaded>{9s} <time>{(%FT%H:%M:%S%z)T} <levelColor>{9s} <level>{9s} <icon>{9s} <message>'
VALET_CONFIG_LOG_COLUMNS='90'
VALET_CONFIG_LOG_DISABLE_WRAP='false'
VALET_CONFIG_LOG_DISABLE_HIGHLIGHT='false'
TZ='Etc/GMT+0'
EPOCHSECONDS='548902800'
EPOCHREALTIME='548902800.000000'
```

❯ `log::init`

❯ `core::colorInit`

### ✅ Testing log::printRaw

❯ `log::printRaw hello`

**Error output**:

```text
hello
```

❯ `log::printRaw _world`

**Error output**:

```text
_world
```

### ✅ Testing log::printString

❯ `log::printString Next\ up\ is\ a\ big\ line\ with\ a\ lot\ of\ numbers\ not\ separated\ by\ spaces.\ Which\ means\ they\ will\ be\ truncated\ by\ characters\ and\ not\ by\ word\ boundaries\ like\ this\ sentence.`

**Error output**:

```text
                                             Next up is a big line with a lot of numbers n
                                             ot separated by spaces. Which means they will
                                             be truncated by characters and not by word bo
                                             undaries like this sentence.
```

### ✅ Testing log::info

❯ `log::info Next\ up\ is\ a\ big\ line\ with\ a\ lot\ of\ numbers\ not\ separated\ by\ spaces.\ Which\ means\ they\ will\ be\ truncated\ by\ characters\ and\ not\ by\ word\ boundaries\ like\ this\ sentence. 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567`

**Error output**:

```text
 1987-05-25T01:00:00+0000 CIN      INFO        II Next up is a big line with a lot of numbers 
                                             not separated by spaces. Which means they 
                                             will be truncated by characters and not by 
                                             word boundaries like this sentence.
                                             012345678901234567890123456789012345678901234
                                             567890123456789012345678901234567890123456789
                                             012345678901234567890123456789012345678901234
                                             567890123456789012345678901234567890123456789
                                             012345678901234567890123456789012345678901234
                                             567890123456789012345678901234567890123456789
                                             01234567
                                             012345678901234567890123456789012345678901234
                                             567890123456789012345678901234567890123456789
                                             012345678901234567890123456789012345678901234
                                             567890123456789012345678901234567890123456789
                                             012345678901234567890123456789012345678901234
                                             567890123456789012345678901234567890123456789
                                             01234567
```

### ✅ Testing log::printFile

❯ `log::printFile file-to-read 2`

**Error output**:

```text
                                             CFA   1 ░CDE What is Lorem Ipsum?
                                             CFA   2 ░CDE 
                                             CFA     ░ (truncated)CDE
```

❯ `log::printFile file-to-read`

**Error output**:

```text
                                             CFA   1 ░CDE What is Lorem Ipsum?
                                             CFA   2 ░CDE 
                                             CFA   3 ░CDE Lorem Ipsum is simply dummy text of th
                                                  CFA░CDE e printing and typesetting indus
                                                  CFA░CDE try.
                                             CFA   4 ░CDE Lorem Ipsum has been the industry's st
                                                  CFA░CDE andard dummy text ever since the
                                                  CFA░CDE 1500s, when an unknown printer t
                                                  CFA░CDE ook a galley of type and scrambl
                                                  CFA░CDE ed it to make a type specimen bo
                                                  CFA░CDE ok.
                                             CFA   5 ░CDE It has survived not only five centurie
                                                  CFA░CDE s, but also the leap into electr
                                                  CFA░CDE onic typesetting, remaining esse
                                                  CFA░CDE ntially unchanged.
                                             CFA   6 ░CDE It was popularised in the 1960s with t
                                                  CFA░CDE he release of Letraset sheets co
                                                  CFA░CDE ntaining Lorem Ipsum passages, a
                                                  CFA░CDE nd more recently with desktop pu
                                                  CFA░CDE blishing software like Aldus Pag
                                                  CFA░CDE eMaker including versions of Lor
                                                  CFA░CDE em Ipsum.
                                             CFA   7 ░CDE 
                                             CFA   8 ░CDE 01234567890123456789012345678901234567
                                                  CFA░CDE 89012345678901234567890123456789
                                                  CFA░CDE 01234567890123456789012345678901
                                                  CFA░CDE 23456789012345678901234567890123
                                                  CFA░CDE 45678901234567890123456789012345
                                                  CFA░CDE 67890123456789012345678901234567
                                                  CFA░CDE 89012345678901234567890123456789
                                                  CFA░CDE 01234567890123456789012345678901
                                                  CFA░CDE 23456789012345678901234567890123
                                                  CFA░CDE 45678901234567890123456789012345
                                                  CFA░CDE 67890123456789012345678901234567
                                                  CFA░CDE 89012345678901234567890123456789
                                                  CFA░CDE 01234567890123456789012345678901
                                                  CFA░CDE 23456789012345678901234567890123
                                                  CFA░CDE 45678901234567890123456789012345
                                                  CFA░CDE 67890123456789012345678901234567
                                                  CFA░CDE 890123456789
                                             CFA   9 ░CDE 
                                             CFA  10 ░CDE Why do we use it?
                                             CFA  11 ░CDE 
                                             CFA  12 ░CDE It is a long established fact that a r
                                                  CFA░CDE eader will be distracted by the 
                                                  CFA░CDE readable content of a page when 
                                                  CFA░CDE looking at its layout.
                                             CFA  13 ░CDE The point of using Lorem Ipsum is that
                                                  CFA░CDE it has a more-or-less normal dis
                                                  CFA░CDE tribution of letters, as opposed
                                                  CFA░CDE to using 'Content here, content 
                                                  CFA░CDE here', making it look like reada
                                                  CFA░CDE ble English.
                                             CFA  14 ░CDE Many desktop publishing packages and w
                                                  CFA░CDE eb page editors now use Lorem Ip
                                                  CFA░CDE sum as their default model text,
                                                  CFA░CDE and a search for 'lorem ipsum' w
                                                  CFA░CDE ill uncover many web sites still
                                                  CFA░CDE in their infancy.
                                             CFA  15 ░CDE Various versions have evolved over the
                                                  CFA░CDE years, sometimes by accident, so
                                                  CFA░CDE metimes on purpose (injected hum
                                                  CFA░CDE our and the like).
```

### ✅ Testing log::printFileString

❯ `log::printFileString "${text}" 2`

**Error output**:

```text
                                             CFA   1 ░CDE What is Lorem Ipsum?
                                             CFA   2 ░CDE 
                                             CFA     ░ (truncated)CDE
```

❯ `log::printFileString "${text}"`

**Error output**:

```text
                                             CFA   1 ░CDE What is Lorem Ipsum?
                                             CFA   2 ░CDE 
                                             CFA   3 ░CDE Lorem Ipsum is simply dummy text of th
                                                  CFA░CDE e printing and typesetting indus
                                                  CFA░CDE try.
                                             CFA   4 ░CDE Lorem Ipsum has been the industry's st
                                                  CFA░CDE andard dummy text ever since the
                                                  CFA░CDE 1500s, when an unknown printer t
                                                  CFA░CDE ook a galley of type and scrambl
                                                  CFA░CDE ed it to make a type specimen bo
                                                  CFA░CDE ok.
                                             CFA   5 ░CDE It has survived not only five centurie
                                                  CFA░CDE s, but also the leap into electr
                                                  CFA░CDE onic typesetting, remaining esse
                                                  CFA░CDE ntially unchanged.
                                             CFA   6 ░CDE It was popularised in the 1960s with t
                                                  CFA░CDE he release of Letraset sheets co
                                                  CFA░CDE ntaining Lorem Ipsum passages, a
                                                  CFA░CDE nd more recently with desktop pu
                                                  CFA░CDE blishing software like Aldus Pag
                                                  CFA░CDE eMaker including versions of Lor
                                                  CFA░CDE em Ipsum.
                                             CFA   7 ░CDE 
                                             CFA   8 ░CDE 01234567890123456789012345678901234567
                                                  CFA░CDE 89012345678901234567890123456789
                                                  CFA░CDE 01234567890123456789012345678901
                                                  CFA░CDE 23456789012345678901234567890123
                                                  CFA░CDE 45678901234567890123456789012345
                                                  CFA░CDE 67890123456789012345678901234567
                                                  CFA░CDE 89012345678901234567890123456789
                                                  CFA░CDE 01234567890123456789012345678901
                                                  CFA░CDE 23456789012345678901234567890123
                                                  CFA░CDE 45678901234567890123456789012345
                                                  CFA░CDE 67890123456789012345678901234567
                                                  CFA░CDE 89012345678901234567890123456789
                                                  CFA░CDE 01234567890123456789012345678901
                                                  CFA░CDE 23456789012345678901234567890123
                                                  CFA░CDE 45678901234567890123456789012345
                                                  CFA░CDE 67890123456789012345678901234567
                                                  CFA░CDE 890123456789
                                             CFA   9 ░CDE 
                                             CFA  10 ░CDE Why do we use it?
                                             CFA  11 ░CDE 
                                             CFA  12 ░CDE It is a long established fact that a r
                                                  CFA░CDE eader will be distracted by the 
                                                  CFA░CDE readable content of a page when 
                                                  CFA░CDE looking at its layout.
                                             CFA  13 ░CDE The point of using Lorem Ipsum is that
                                                  CFA░CDE it has a more-or-less normal dis
                                                  CFA░CDE tribution of letters, as opposed
                                                  CFA░CDE to using 'Content here, content 
                                                  CFA░CDE here', making it look like reada
                                                  CFA░CDE ble English.
                                             CFA  14 ░CDE Many desktop publishing packages and w
                                                  CFA░CDE eb page editors now use Lorem Ip
                                                  CFA░CDE sum as their default model text,
                                                  CFA░CDE and a search for 'lorem ipsum' w
                                                  CFA░CDE ill uncover many web sites still
                                                  CFA░CDE in their infancy.
                                             CFA  15 ░CDE Various versions have evolved over the
                                                  CFA░CDE years, sometimes by accident, so
                                                  CFA░CDE metimes on purpose (injected hum
                                                  CFA░CDE our and the like).
```

## Test script 01.log-level

### ✅ Testing log levels

❯ `log::init`

❯ `log::setLevel trace`

**Error output**:

```text
DEBUG    Log level set to trace.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
```

### ✅ Testing level trace

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
ERROR    This is an error message.
├─ in myCmd::subFunction() at tests.d/lib-log/path/to/subFunction.sh:200
└─ in myCmd::function() at tests.d/lib-log/path/to/function.sh:300
```

❯ `log::warning This\ is\ a\ warning\ message.`

**Error output**:

```text
WARNING  This is a warning message.
```

❯ `log::success This\ is\ an\ success\ message.`

**Error output**:

```text
SUCCESS  This is an success message.
```

❯ `log::info This\ is\ an\ info\ message.`

**Error output**:

```text
INFO     This is an info message.
```

❯ `log::debug This\ is\ a\ debug\ message.`

**Error output**:

```text
DEBUG    This is a debug message.
```

❯ `log::trace This\ is\ a\ trace\ message.`

**Error output**:

```text
TRACE    This is a trace message.
```

❯ `log::errorTrace This\ is\ a\ errorTrace\ message\,\ always\ shown.`

**Error output**:

```text
TRACE    This is a errorTrace message, always shown.
```

❯ `log::setLevel debug`

**Error output**:

```text
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
```

### ✅ Testing level debug

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
ERROR    This is an error message.
├─ in myCmd::subFunction() at tests.d/lib-log/path/to/subFunction.sh:200
└─ in myCmd::function() at tests.d/lib-log/path/to/function.sh:300
```

❯ `log::warning This\ is\ a\ warning\ message.`

**Error output**:

```text
WARNING  This is a warning message.
```

❯ `log::success This\ is\ an\ success\ message.`

**Error output**:

```text
SUCCESS  This is an success message.
```

❯ `log::info This\ is\ an\ info\ message.`

**Error output**:

```text
INFO     This is an info message.
```

❯ `log::debug This\ is\ a\ debug\ message.`

**Error output**:

```text
DEBUG    This is a debug message.
```

❯ `log::trace This\ is\ a\ trace\ message.`

❯ `log::errorTrace This\ is\ a\ errorTrace\ message\,\ always\ shown.`

**Error output**:

```text
TRACE    This is a errorTrace message, always shown.
```

❯ `log::setLevel info`

### ✅ Testing level info

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
ERROR    This is an error message.
```

❯ `log::warning This\ is\ a\ warning\ message.`

**Error output**:

```text
WARNING  This is a warning message.
```

❯ `log::success This\ is\ an\ success\ message.`

**Error output**:

```text
SUCCESS  This is an success message.
```

❯ `log::info This\ is\ an\ info\ message.`

**Error output**:

```text
INFO     This is an info message.
```

❯ `log::debug This\ is\ a\ debug\ message.`

❯ `log::trace This\ is\ a\ trace\ message.`

❯ `log::errorTrace This\ is\ a\ errorTrace\ message\,\ always\ shown.`

**Error output**:

```text
TRACE    This is a errorTrace message, always shown.
```

❯ `log::setLevel success`

### ✅ Testing level success

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
ERROR    This is an error message.
```

❯ `log::warning This\ is\ a\ warning\ message.`

**Error output**:

```text
WARNING  This is a warning message.
```

❯ `log::success This\ is\ an\ success\ message.`

**Error output**:

```text
SUCCESS  This is an success message.
```

❯ `log::info This\ is\ an\ info\ message.`

❯ `log::debug This\ is\ a\ debug\ message.`

❯ `log::trace This\ is\ a\ trace\ message.`

❯ `log::errorTrace This\ is\ a\ errorTrace\ message\,\ always\ shown.`

**Error output**:

```text
TRACE    This is a errorTrace message, always shown.
```

❯ `log::setLevel warning`

### ✅ Testing level warning

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
ERROR    This is an error message.
```

❯ `log::warning This\ is\ a\ warning\ message.`

**Error output**:

```text
WARNING  This is a warning message.
```

❯ `log::success This\ is\ an\ success\ message.`

❯ `log::info This\ is\ an\ info\ message.`

❯ `log::debug This\ is\ a\ debug\ message.`

❯ `log::trace This\ is\ a\ trace\ message.`

❯ `log::errorTrace This\ is\ a\ errorTrace\ message\,\ always\ shown.`

**Error output**:

```text
TRACE    This is a errorTrace message, always shown.
```

❯ `log::setLevel error`

### ✅ Testing level error

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
ERROR    This is an error message.
```

❯ `log::warning This\ is\ a\ warning\ message.`

❯ `log::success This\ is\ an\ success\ message.`

❯ `log::info This\ is\ an\ info\ message.`

❯ `log::debug This\ is\ a\ debug\ message.`

❯ `log::trace This\ is\ a\ trace\ message.`

❯ `log::errorTrace This\ is\ a\ errorTrace\ message\,\ always\ shown.`

**Error output**:

```text
TRACE    This is a errorTrace message, always shown.
```

