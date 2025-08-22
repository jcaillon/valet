# Test suite lib-log

## Test script 00.log

### ✅ Testing with no formatting

❯ `log::init`

❯ `styles::init`

### ✅ Testing log::printRaw

❯ `log::printRaw _var1`

**Error output**:

```text
hello
```

❯ `log::printRaw _var2`

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

❯ `log::printString \ \ Next\ up\ is\ a\ big\ line\ with\ a\ lot\ of\ numbers\ not\ separated\ by\ spaces.\ Which\ means\ they\ will\ be\ truncated\ by\ characters\ and\ not\ by\ word\ boundaries\ like\ this\ sentence.\ \ `

**Error output**:

```text
  Next up is a big line with a lot of numbers not separated by spaces. Which means they will be truncated by characters and not by word boundaries like this sentence.  
```

### ✅ Testing log::info

❯ `log::info $'Next up is a big line with a lot of numbers not separated by spaces. Which means they will be truncated by characters and not by word boundaries like this sentence.\n01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567\n01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567'`

**Error output**:

```text
INFO     Next up is a big line with a lot of numbers not separated by spaces. Which means they will be truncated by characters and not by word boundaries like this sentence.
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
```

### ✅ Testing log::printFile

❯ `log::printFile file-to-read maxLines=2`

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

❯ `log::printFileString text maxLines=2`

**Error output**:

```text
   1 ░ What is Lorem Ipsum?
   2 ░ 
     ░ (truncated)
```

❯ `log::printFileString text`

**Error output**:

```text
   1 ░ What is Lorem Ipsum?
   2 ░ 
   3 ░   Lorem Ipsum is simply dummy text of the printing and typesetting industry.
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
```

❯ `log::init`

❯ `styles::init`

### ✅ Testing log::printRaw

❯ `log::printRaw _var1`

**Error output**:

```text
hello
```

❯ `log::printRaw _var2`

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

❯ `log::printString \ \ Next\ up\ is\ a\ big\ line\ with\ a\ lot\ of\ numbers\ not\ separated\ by\ spaces.\ Which\ means\ they\ will\ be\ truncated\ by\ characters\ and\ not\ by\ word\ boundaries\ like\ this\ sentence.\ \ `

**Error output**:

```text
                                               Next up is a big line with a lot of numbers
                                             not separated by spaces. Which means they wil
                                             l be truncated by characters and not by word 
                                             boundaries like this sentence.  
```

### ✅ Testing log::info

❯ `log::info $'Next up is a big line with a lot of numbers not separated by spaces. Which means they will be truncated by characters and not by word boundaries like this sentence.\n01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567\n01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567'`

**Error output**:

```text
 1987-05-25T01:00:00+0000 [36m      INFO        Next up is a big line with a lot of numbers 
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

❯ `log::printFile file-to-read maxLines=2`

**Error output**:

```text
                                             [90m   1 ░[39m What is Lorem Ipsum?
                                             [90m   2 ░[39m 
                                             [90m     ░ (truncated)[39m
```

❯ `log::printFile file-to-read`

**Error output**:

```text
                                             [90m   1 ░[39m What is Lorem Ipsum?
                                             [90m   2 ░[39m 
                                             [90m   3 ░[39m Lorem Ipsum is simply dummy text of th
                                                  [90m░[39m e printing and typesetting industry.
                                             [90m   4 ░[39m Lorem Ipsum has been the industry's st
                                                  [90m░[39m andard dummy text ever since the 1500s
                                                  [90m░[39m , when an unknown printer took a galle
                                                  [90m░[39m y of type and scrambled it to make a t
                                                  [90m░[39m ype specimen book.
                                             [90m   5 ░[39m It has survived not only five centurie
                                                  [90m░[39m s, but also the leap into electronic t
                                                  [90m░[39m ypesetting, remaining essentially unch
                                                  [90m░[39m anged.
                                             [90m   6 ░[39m It was popularised in the 1960s with t
                                                  [90m░[39m he release of Letraset sheets containi
                                                  [90m░[39m ng Lorem Ipsum passages, and more rece
                                                  [90m░[39m ntly with desktop publishing software 
                                                  [90m░[39m like Aldus PageMaker including version
                                                  [90m░[39m s of Lorem Ipsum.
                                             [90m   7 ░[39m 
                                             [90m   8 ░[39m 01234567890123456789012345678901234567
                                                  [90m░[39m 89012345678901234567890123456789012345
                                                  [90m░[39m 67890123456789012345678901234567890123
                                                  [90m░[39m 45678901234567890123456789012345678901
                                                  [90m░[39m 23456789012345678901234567890123456789
                                                  [90m░[39m 01234567890123456789012345678901234567
                                                  [90m░[39m 89012345678901234567890123456789012345
                                                  [90m░[39m 67890123456789012345678901234567890123
                                                  [90m░[39m 45678901234567890123456789012345678901
                                                  [90m░[39m 23456789012345678901234567890123456789
                                                  [90m░[39m 01234567890123456789012345678901234567
                                                  [90m░[39m 89012345678901234567890123456789012345
                                                  [90m░[39m 67890123456789012345678901234567890123
                                                  [90m░[39m 456789012345678901234567890123456789
                                             [90m   9 ░[39m 
                                             [90m  10 ░[39m Why do we use it?
                                             [90m  11 ░[39m 
                                             [90m  12 ░[39m It is a long established fact that a r
                                                  [90m░[39m eader will be distracted by the readab
                                                  [90m░[39m le content of a page when looking at i
                                                  [90m░[39m ts layout.
                                             [90m  13 ░[39m The point of using Lorem Ipsum is that
                                                  [90m░[39m it has a more-or-less normal distribut
                                                  [90m░[39m ion of letters, as opposed to using 'C
                                                  [90m░[39m ontent here, content here', making it 
                                                  [90m░[39m look like readable English.
                                             [90m  14 ░[39m Many desktop publishing packages and w
                                                  [90m░[39m eb page editors now use Lorem Ipsum as
                                                  [90m░[39m their default model text, and a search
                                                  [90m░[39m for 'lorem ipsum' will uncover many we
                                                  [90m░[39m b sites still in their infancy.
                                             [90m  15 ░[39m Various versions have evolved over the
                                                  [90m░[39m years, sometimes by accident, sometime
                                                  [90m░[39m s on purpose (injected humour and the 
                                                  [90m░[39m like).
```

### ✅ Testing log::printFileString

❯ `log::printFileString text maxLines=2`

**Error output**:

```text
                                             [90m   1 ░[39m What is Lorem Ipsum?
                                             [90m   2 ░[39m 
                                             [90m     ░ (truncated)[39m
```

❯ `log::printFileString text`

**Error output**:

```text
                                             [90m   1 ░[39m What is Lorem Ipsum?
                                             [90m   2 ░[39m 
                                             [90m   3 ░[39m   Lorem Ipsum is simply dummy text of 
                                                  [90m░[39m the printing and typesetting industry.
                                             [90m   4 ░[39m Lorem Ipsum has been the industry's st
                                                  [90m░[39m andard dummy text ever since the 1500s
                                                  [90m░[39m , when an unknown printer took a galle
                                                  [90m░[39m y of type and scrambled it to make a t
                                                  [90m░[39m ype specimen book.
                                             [90m   5 ░[39m It has survived not only five centurie
                                                  [90m░[39m s, but also the leap into electronic t
                                                  [90m░[39m ypesetting, remaining essentially unch
                                                  [90m░[39m anged.  
                                             [90m   6 ░[39m It was popularised in the 1960s with t
                                                  [90m░[39m he release of Letraset sheets containi
                                                  [90m░[39m ng Lorem Ipsum passages, and more rece
                                                  [90m░[39m ntly with desktop publishing software 
                                                  [90m░[39m like Aldus PageMaker including version
                                                  [90m░[39m s of Lorem Ipsum.
                                             [90m   7 ░[39m 
                                             [90m   8 ░[39m 01234567890123456789012345678901234567
                                                  [90m░[39m 89012345678901234567890123456789012345
                                                  [90m░[39m 67890123456789012345678901234567890123
                                                  [90m░[39m 45678901234567890123456789012345678901
                                                  [90m░[39m 23456789012345678901234567890123456789
                                                  [90m░[39m 01234567890123456789012345678901234567
                                                  [90m░[39m 89012345678901234567890123456789012345
                                                  [90m░[39m 67890123456789012345678901234567890123
                                                  [90m░[39m 45678901234567890123456789012345678901
                                                  [90m░[39m 23456789012345678901234567890123456789
                                                  [90m░[39m 01234567890123456789012345678901234567
                                                  [90m░[39m 89012345678901234567890123456789012345
                                                  [90m░[39m 67890123456789012345678901234567890123
                                                  [90m░[39m 456789012345678901234567890123456789
                                             [90m   9 ░[39m 
                                             [90m  10 ░[39m Why do we use it?
                                             [90m  11 ░[39m 
                                             [90m  12 ░[39m It is a long established fact that a r
                                                  [90m░[39m eader will be distracted by the readab
                                                  [90m░[39m le content of a page when looking at i
                                                  [90m░[39m ts layout.
                                             [90m  13 ░[39m The point of using Lorem Ipsum is that
                                                  [90m░[39m it has a more-or-less normal distribut
                                                  [90m░[39m ion of letters, as opposed to using 'C
                                                  [90m░[39m ontent here, content here', making it 
                                                  [90m░[39m look like readable English.
                                             [90m  14 ░[39m Many desktop publishing packages and w
                                                  [90m░[39m eb page editors now use Lorem Ipsum as
                                                  [90m░[39m their default model text, and a search
                                                  [90m░[39m for 'lorem ipsum' will uncover many we
                                                  [90m░[39m b sites still in their infancy.
                                             [90m  15 ░[39m Various versions have evolved over the
                                                  [90m░[39m years, sometimes by accident, sometime
                                                  [90m░[39m s on purpose (injected humour and the 
                                                  [90m░[39m like).
```

### ✅ Testing log::printCallStack

❯ `log::getCallStack`

Returned variables:

```text
REPLY='├─ in log::printCallStack() at core:10
├─ in log::error() at core:100
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
'
```

❯ `log::getCallStack stackToSkip=1 stackToSkipAtEnd=1 wrapWidth=10`

Returned variables:

```text
REPLY='├─ in log:
│  :printC
│  allStac
│  k() at 
│  core:10
├─ in log:
│  :error(
│  ) at co
│  re:100
╰─ in myCm
   d::subF
   unction
   () at /
   path/to
   /subFun
   ction.s
   h:200
'
```

❯ `log::printCallStack`

**Error output**:

```text
                                             ├─ in myCmd::subFunction() at /path/to/subFun
                                             │  ction.sh:200
                                             ╰─ in myCmd::function() at /path/to/function.
                                                sh:300
```

❯ `log::printCallStack stackToSkip=1 stackToSkipAtEnd=1`

**Error output**:

```text
                                             ├─ in log::error() at core:100
                                             ╰─ in myCmd::subFunction() at /path/to/subFun
                                                ction.sh:200
```

### ✅ Testing log::init

❯ `VALET_CONFIG_LOG_FD=5 log::init`

Exited with code: `1`

**Error output**:

```text
 1987-05-25T01:00:00+0000 [31m      FAIL        The file descriptor for the logs 
                                             VALET_CONFIG_LOG_FD is not valid: ⌜5⌝.
```

❯ `VALET_CONFIG_LOG_FD=/unknown/file/path log::init`

Exited with code: `1`

**Error output**:

```text
 1987-05-25T01:00:00+0000 [31m      FAIL        The file descriptor for the logs 
                                             VALET_CONFIG_LOG_FD is not valid: 
                                             ⌜/unknown/file/path⌝.
```

❯ `log::init`

```text
GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG='local -n levelColor="STYLE_COLOR_${colorName}"
local REPLY REPLY2
local -n messageToPrintInLog=REPLY
string::wrapWords messageToLog width=90 newLinePadString="                                             " firstLineWidth=45
messageToPrintInLog="${messageToPrintInLog//⌜/[95m⌜}"
messageToPrintInLog="${messageToPrintInLog//⌝/⌝[39m}"


local eraseLine; if [[ -v _PROGRESS_BAR_RUNNING ]]; then eraseLine=$'"'"'\e[2K'"'"'; fi
printf "${eraseLine:-}%s%s%(%FT%H:%M:%S%z)T%s%s%s%9s%s%9s%s%s\n" "[90m" " " "${EPOCHSECONDS}" " " "${levelColor:-}" " " "${level:${#level} - 9 > 0 ? ${#level} - 9 : 0}" " " "${icon:-}" " " "${messageToPrintInLog:-}"  1>&11
if [[ -v _PROGRESS_BAR_RUNNING ]]; then progress:redraw; fi
'
GLOBAL_LOG_PRINT_STATEMENT_STANDARD='local eraseLine; if [[ -v _PROGRESS_BAR_RUNNING ]]; then eraseLine=$'"'"'\e[2K'"'"'; fi
printf "${eraseLine:-}%s" "${rawStringToPrintInLog:-}" 1>&11
if [[ -v _PROGRESS_BAR_RUNNING ]]; then progress:redraw; fi
'
GLOBAL_LOG_WRAP_PADDING='                                             '
```

❯ `VALET_CONFIG_LOG_DISABLE_HIGHLIGHT=true VALET_CONFIG_LOG_DISABLE_WRAP=false log::init`

```text
GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG='local -n levelColor="STYLE_COLOR_${colorName}"
local REPLY REPLY2
local -n messageToPrintInLog=REPLY
string::wrapWords messageToLog width=90 newLinePadString="                                             " firstLineWidth=45


local eraseLine; if [[ -v _PROGRESS_BAR_RUNNING ]]; then eraseLine=$'"'"'\e[2K'"'"'; fi
printf "${eraseLine:-}%s%s%(%FT%H:%M:%S%z)T%s%s%s%9s%s%9s%s%s\n" "[90m" " " "${EPOCHSECONDS}" " " "${levelColor:-}" " " "${level:${#level} - 9 > 0 ? ${#level} - 9 : 0}" " " "${icon:-}" " " "${messageToPrintInLog:-}"  1>&11
if [[ -v _PROGRESS_BAR_RUNNING ]]; then progress:redraw; fi
'
GLOBAL_LOG_PRINT_STATEMENT_STANDARD='local eraseLine; if [[ -v _PROGRESS_BAR_RUNNING ]]; then eraseLine=$'"'"'\e[2K'"'"'; fi
printf "${eraseLine:-}%s" "${rawStringToPrintInLog:-}" 1>&11
if [[ -v _PROGRESS_BAR_RUNNING ]]; then progress:redraw; fi
'
GLOBAL_LOG_WRAP_PADDING='                                             '
```

❯ `VALET_CONFIG_LOG_FORMATTED_EXTRA_EVAL=local\ extra=1 log::init`

```text
GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG='local -n levelColor="STYLE_COLOR_${colorName}"
local REPLY REPLY2
local -n messageToPrintInLog=REPLY
string::wrapWords messageToLog width=90 newLinePadString="                                             " firstLineWidth=45
messageToPrintInLog="${messageToPrintInLog//⌜/[95m⌜}"
messageToPrintInLog="${messageToPrintInLog//⌝/⌝[39m}"

local extra=1
local eraseLine; if [[ -v _PROGRESS_BAR_RUNNING ]]; then eraseLine=$'"'"'\e[2K'"'"'; fi
printf "${eraseLine:-}%s%s%(%FT%H:%M:%S%z)T%s%s%s%9s%s%9s%s%s\n" "[90m" " " "${EPOCHSECONDS}" " " "${levelColor:-}" " " "${level:${#level} - 9 > 0 ? ${#level} - 9 : 0}" " " "${icon:-}" " " "${messageToPrintInLog:-}"  1>&11
if [[ -v _PROGRESS_BAR_RUNNING ]]; then progress:redraw; fi
'
GLOBAL_LOG_PRINT_STATEMENT_STANDARD='local eraseLine; if [[ -v _PROGRESS_BAR_RUNNING ]]; then eraseLine=$'"'"'\e[2K'"'"'; fi
printf "${eraseLine:-}%s" "${rawStringToPrintInLog:-}" 1>&11
if [[ -v _PROGRESS_BAR_RUNNING ]]; then progress:redraw; fi
'
GLOBAL_LOG_WRAP_PADDING='                                             '
```

❯ `VALET_CONFIG_LOG_FD=/tmp/valet-temp VALET_CONFIG_LOG_TO_DIRECTORY=tmp log::init`

```text
GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG='local -n levelColor="STYLE_COLOR_${colorName}"
local REPLY REPLY2
local -n messageToPrintInLog=REPLY
string::wrapWords messageToLog width=90 newLinePadString="                                             " firstLineWidth=45
messageToPrintInLog="${messageToPrintInLog//⌜/[95m⌜}"
messageToPrintInLog="${messageToPrintInLog//⌝/⌝[39m}"


printf "%s%s%(%FT%H:%M:%S%z)T%s%s%s%9s%s%9s%s%s\n" "[90m" " " "${EPOCHSECONDS}" " " "${levelColor:-}" " " "${level:${#level} - 9 > 0 ? ${#level} - 9 : 0}" " " "${icon:-}" " " "${messageToPrintInLog:-}"  1>>"/tmp/valet-temp"
printf "%s%s%(%FT%H:%M:%S%z)T%s%s%s%9s%s%9s%s%s\n" "[90m" " " "${EPOCHSECONDS}" " " "${levelColor:-}" " " "${level:${#level} - 9 > 0 ? ${#level} - 9 : 0}" " " "${icon:-}" " " "${messageToPrintInLog:-}"  1>>"tmp/log-1987-05-25T01-00-00+0000--PID_001234.log"'
GLOBAL_LOG_PRINT_STATEMENT_STANDARD='printf "%s" "${rawStringToPrintInLog:-}" 1>>"/tmp/valet-temp"
printf "%s" "${rawStringToPrintInLog:-}" 1>>"tmp/log-1987-05-25T01-00-00+0000--PID_001234.log"'
GLOBAL_LOG_WRAP_PADDING='                                             '
```

❯ `VALET_CONFIG_LOG_FD=/tmp/valet-temp VALET_CONFIG_LOG_TO_DIRECTORY=tmp VALET_CONFIG_LOG_FILENAME_PATTERN=logFile=a log::init`

```text
GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG='local -n levelColor="STYLE_COLOR_${colorName}"
local REPLY REPLY2
local -n messageToPrintInLog=REPLY
string::wrapWords messageToLog width=90 newLinePadString="                                             " firstLineWidth=45
messageToPrintInLog="${messageToPrintInLog//⌜/[95m⌜}"
messageToPrintInLog="${messageToPrintInLog//⌝/⌝[39m}"


printf "%s%s%(%FT%H:%M:%S%z)T%s%s%s%9s%s%9s%s%s\n" "[90m" " " "${EPOCHSECONDS}" " " "${levelColor:-}" " " "${level:${#level} - 9 > 0 ? ${#level} - 9 : 0}" " " "${icon:-}" " " "${messageToPrintInLog:-}"  1>>"/tmp/valet-temp"
printf "%s%s%(%FT%H:%M:%S%z)T%s%s%s%9s%s%9s%s%s\n" "[90m" " " "${EPOCHSECONDS}" " " "${levelColor:-}" " " "${level:${#level} - 9 > 0 ? ${#level} - 9 : 0}" " " "${icon:-}" " " "${messageToPrintInLog:-}"  1>>"tmp/a"'
GLOBAL_LOG_PRINT_STATEMENT_STANDARD='printf "%s" "${rawStringToPrintInLog:-}" 1>>"/tmp/valet-temp"
printf "%s" "${rawStringToPrintInLog:-}" 1>>"tmp/a"'
GLOBAL_LOG_WRAP_PADDING='                                             '
```

❯ `VALET_CONFIG_LOG_FD=/tmp/valet-temp VALET_CONFIG_LOG_TO_DIRECTORY=true VALET_CONFIG_LOG_FILENAME_PATTERN=logFile=a log::init`

```text
GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG='local -n levelColor="STYLE_COLOR_${colorName}"
local REPLY REPLY2
local -n messageToPrintInLog=REPLY
string::wrapWords messageToLog width=90 newLinePadString="                                             " firstLineWidth=45
messageToPrintInLog="${messageToPrintInLog//⌜/[95m⌜}"
messageToPrintInLog="${messageToPrintInLog//⌝/⌝[39m}"


printf "%s%s%(%FT%H:%M:%S%z)T%s%s%s%9s%s%9s%s%s\n" "[90m" " " "${EPOCHSECONDS}" " " "${levelColor:-}" " " "${level:${#level} - 9 > 0 ? ${#level} - 9 : 0}" " " "${icon:-}" " " "${messageToPrintInLog:-}"  1>>"/tmp/valet-temp"
printf "%s%s%(%FT%H:%M:%S%z)T%s%s%s%9s%s%9s%s%s\n" "[90m" " " "${EPOCHSECONDS}" " " "${levelColor:-}" " " "${level:${#level} - 9 > 0 ? ${#level} - 9 : 0}" " " "${icon:-}" " " "${messageToPrintInLog:-}"  1>>"/tmp/valet.valet.d/logs/a"'
GLOBAL_LOG_PRINT_STATEMENT_STANDARD='printf "%s" "${rawStringToPrintInLog:-}" 1>>"/tmp/valet-temp"
printf "%s" "${rawStringToPrintInLog:-}" 1>>"/tmp/valet.valet.d/logs/a"'
GLOBAL_LOG_WRAP_PADDING='                                             '
```

### ✅ Testing log::parseLogPattern

❯ `log::parseLogPattern static\ string`

Returned variables:

```text
REPLY='%s\n'
REPLY2='"static string" '
REPLY3='0'
REPLY4=''
```

❯ `log::parseLogPattern $'static\nstring'`

Returned variables:

```text
REPLY='%s\n'
REPLY2='"static
string" '
REPLY3='0'
REPLY4=''
```

❯ `log::parseLogPattern $'static\n<message>'`

Returned variables:

```text
REPLY='%s%s\n'
REPLY2='"static
" "${messageToPrintInLog:-}" '
REPLY3='0'
REPLY4=''
```

❯ `log::parseLogPattern \<colorFaded\>\<time\>\<colorDefault\>\ \<levelColor\>\<level\>\ \<icon\>\<colorDefault\>\ PID=\<pid\>\ SUBSHELL=\<subshell\>\ \<function\>\{8s\}@\<source\>:\<line\>\ \<message\>`

Returned variables:

```text
REPLY='%s%(%H:%M:%S)T%s%s%s%-8s%s%-4s%s%s%-5d%s%-2d%s%8s%s%-10s%s%-4s%s%s\n'
REPLY2='"[90m" "${EPOCHSECONDS}" "[39m" " " "${levelColor:-}" "${level:0:8}" " " "${icon:-}" "[39m" " PID=" "${BASHPID:0:5}" " SUBSHELL=" "${BASH_SUBSHELL:0:2}" " " "${FUNCNAME[1]:${#FUNCNAME[1]} - 8 > 0 ? ${#FUNCNAME[1]} - 8 : 0}" "@" "${BASH_SOURCE[1]:0:10}" ":" "${BASH_LINENO[1]:0:4}" " " "${messageToPrintInLog:-}" '
REPLY3='68'
REPLY4=''
```

❯ `VALET_CONFIG_ENABLE_NERDFONT_ICONS=true log::parseLogPattern \<icon\>\ \<message\>`

Returned variables:

```text
REPLY='%-4s%s%s\n'
REPLY2='"${icon:-}" " " "${messageToPrintInLog:-}" '
REPLY3='3'
REPLY4=''
```

❯ `VALET_CONFIG_ENABLE_NERDFONT_ICONS=false log::parseLogPattern \<icon\>\ \<message\>`

Returned variables:

```text
REPLY='%s%s\n'
REPLY2='" " "${messageToPrintInLog:-}" '
REPLY3='1'
REPLY4=''
```

❯ `log::parseLogPattern \<colorFaded\>\{9s\}\ \<time\>\{\(%FT%H:%M:%S%z\)T\}\ \<levelColor\>\{9s\}\ \<level\>\{9s\}\ \<icon\>\{9s\}\ \<varCOLOR_DEBUG\>\{9s\}\ \<processName\>\{-5s\}\ \<pid\>\{9s\}\ \<subshell\>\{9s\}\ \<function\>\{9s\}\ \<source\>\{9s\}\ \<line\>\{9s\}`

Returned variables:

```text
REPLY='%s%s%(%FT%H:%M:%S%z)T%s%s%s%9s%s%9s%s%9s%s%-5s%s%9s%s%9s%s%9s%s%9s%s%9s\n'
REPLY2='"[90m" " " "${EPOCHSECONDS}" " " "${levelColor:-}" " " "${level:${#level} - 9 > 0 ? ${#level} - 9 : 0}" " " "${icon:-}" " " "${variableToPrintInLog:${#variableToPrintInLog} - 9 > 0 ? ${#variableToPrintInLog} - 9 : 0}" " " "${processName:0:5}" " " "${BASHPID:${#BASHPID} - 9 > 0 ? ${#BASHPID} - 9 : 0}" " " "${BASH_SUBSHELL:${#BASH_SUBSHELL} - 9 > 0 ? ${#BASH_SUBSHELL} - 9 : 0}" " " "${FUNCNAME[1]:${#FUNCNAME[1]} - 9 > 0 ? ${#FUNCNAME[1]} - 9 : 0}" " " "${BASH_SOURCE[1]:${#BASH_SOURCE[1]} - 9 > 0 ? ${#BASH_SOURCE[1]} - 9 : 0}" " " "${BASH_LINENO[1]:${#BASH_LINENO[1]} - 9 > 0 ? ${#BASH_LINENO[1]} - 9 : 0}" '
REPLY3='0'
REPLY4='
local variableToPrintInLog="${COLOR_DEBUG:-}"
local processName=${GLOBAL_PID_TO_PNAME[${BASHPID}]:-}; if [[ -z ${processName} ]]; then if [[ ${BASHPID} == "1234" ]]; then GLOBAL_PID_TO_PNAME[${BASHPID}]="main"; else string::numberToUniqueId "${BASHPID}"; GLOBAL_PID_TO_PNAME[${BASHPID}]="${REPLY}"; fi; processName=${GLOBAL_PID_TO_PNAME[${BASHPID}]}; fi'
```

❯ `log::parseLogPattern $'<levelColor><level><colorDefault> <message>\n<wrapPadding><colorFaded>[<elapsedTime>] [<elapsedTimeSinceLastLog>] in [<sourceFile>]<colorDefault>'`

Returned variables:

```text
REPLY='%s%-8s%s%s%s%s%s%s%s%-7s%s%-7s%s%-10s%s%s\n'
REPLY2='"${levelColor:-}" "${level:0:8}" "[39m" " " "${messageToPrintInLog:-}" "
" "${GLOBAL_LOG_WRAP_PADDING}" "[90m" "[" "${loggedElapsedTime:0:7}" "] [" "${loggedElapsedTimeSinceLastLog:0:7}" "] in [" "${sourceFile:0:10}" "]" "[39m" '
REPLY3='9'
REPLY4='
local REPLY; time::getProgramElapsedMicroseconds; time::getMicrosecondsToSeconds "${REPLY}" precision=3; local loggedElapsedTime="${REPLY}s"
local REPLY; time::getProgramElapsedMicroseconds; local -i currentTime=${REPLY}; _LOG_ELAPSED_TIME=$(( currentTime - ${_LOG_ELAPSED_TIME:-0} )); time::getMicrosecondsToSeconds "${_LOG_ELAPSED_TIME}" precision=3; local loggedElapsedTimeSinceLastLog="${REPLY}s"; _LOG_ELAPSED_TIME=${currentTime}
local sourceFile="${BASH_SOURCE[1]##*/}"'
```

❯ `log::parseLogPattern "${pat}"`

Returned variables:

```text
REPLY='%s%s%s%s%s%s%s%s%s\n'
REPLY2='"{\"level\": \"" "${level}" "\", \"message\": \"" "${messageToPrintInLog:-}" "\", \"source\": \"" "${BASH_SOURCE[1]}" "\", \"line\": \"" "${BASH_LINENO[1]}" "\"}" '
REPLY3='26'
REPLY4=''
```

❯ `log::parseLogPattern $'<level>{-2s}\n  <varSTUFF>{-5s}\n  <pid>{-04d}\n  <subshell>{-1s}\n  <function>{-5s}\n  <line>{-03d}\n  <source>{-5s}\n  <sourceFile>{-5s}\n  <elapsedTime>{-5s}\n  <elapsedTimeSinceLastLog>{-5s}\n  '`

Returned variables:

```text
REPLY='%-2s%s%-5s%s%-04d%s%-1s%s%-5s%s%-03d%s%-5s%s%-5s%s%-5s%s%-5s%s\n'
REPLY2='"${level:0:2}" "
  " "${variableToPrintInLog:0:5}" "
  " "${BASHPID:0:04}" "
  " "${BASH_SUBSHELL:0:1}" "
  " "${FUNCNAME[1]:0:5}" "
  " "${BASH_LINENO[1]:0:03}" "
  " "${BASH_SOURCE[1]:0:5}" "
  " "${sourceFile:0:5}" "
  " "${loggedElapsedTime:0:5}" "
  " "${loggedElapsedTimeSinceLastLog:0:5}" "
  " '
REPLY3='0'
REPLY4='
local variableToPrintInLog="${STUFF:-}"
local sourceFile="${BASH_SOURCE[1]##*/}"
local REPLY; time::getProgramElapsedMicroseconds; time::getMicrosecondsToSeconds "${REPLY}" precision=3; local loggedElapsedTime="${REPLY}s"
local REPLY; time::getProgramElapsedMicroseconds; local -i currentTime=${REPLY}; _LOG_ELAPSED_TIME=$(( currentTime - ${_LOG_ELAPSED_TIME:-0} )); time::getMicrosecondsToSeconds "${_LOG_ELAPSED_TIME}" precision=3; local loggedElapsedTimeSinceLastLog="${REPLY}s"; _LOG_ELAPSED_TIME=${currentTime}'
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
REPLY='trace'
```

❯ `log::isTraceEnabled`

❯ `log::isDebugEnabled`

❯ `log::error This\ is\ an\ error\ message.`

**Error output**:

```text
ERROR    This is an error message.
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
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
REPLY='debug'
```

❯ `log::isTraceEnabled`

Returned code: `1`

❯ `log::isDebugEnabled`

❯ `log::error This\ is\ an\ error\ message.`

**Error output**:

```text
ERROR    This is an error message.
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
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
REPLY='info'
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
REPLY='success'
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
REPLY='warning'
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
REPLY='error'
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

## Test script 02.log-save

### ✅ Testing log::saveFile

❯ `log::saveFile /tmp/valet.d/f1-2 suffix=important`

**Error output**:

```text
/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--important
```

❯ `fs::cat /tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--important`

**Standard output**:

```text
test

```

❯ `log::saveFile /tmp/valet.d/f1-2 suffix=important silent=true`

Returned variables:

```text
REPLY='/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--important'
```

### ✅ Testing log::saveFileString

❯ `log::saveFileString _myVar suffix=important2`

**Error output**:

```text
/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--important2
```

❯ `fs::cat /tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--important2`

**Standard output**:

```text
test
```

❯ `log::saveFileString _myVar suffix=important silent=true`

Returned variables:

```text
REPLY='/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--important'
```

