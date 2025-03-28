# Test suite cli-logging

## Test script 01.logging

### ✅ Logging level through an environment variable

❯ `VALET_LOG_LEVEL=success valet self mock1 logging-level`

**Error output**:

```text
TRACE    This is an error trace message which is always displayed.
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.
```

### ✅ Logging level with --log-level option

❯ `valet --log-level warning self mock1 logging-level`

**Error output**:

```text
TRACE    This is an error trace message which is always displayed.
WARNING  This is a warning message.
With a second line.
```

### ✅ Logging level with --verbose option

❯ `valet -v self mock1 logging-level`

**Error output**:

```text
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Loaded file ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/.commands.d/self-mock.sh⌝.
DEBUG    Running the command ⌜self mock1⌝ with the function ⌜selfMock1⌝ and the arguments ⌜logging-level⌝.
DEBUG    Parsed arguments:
local commandArgumentsErrors help action
help=""
commandArgumentsErrors=""
action="logging-level"
TRACE    This is an error trace message which is always displayed.
DEBUG    This is a debug message.
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.
The debug mode is activated!
DEBUG    Exiting with code 0 after 0s.
DEBUG    Deleting temporary files.
```

### ✅ Logging level with --very-verbose option

❯ `valet -w self mock1 logging-level`

**Error output**:

```text
DEBUG    Log level set to trace.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
TRACE    Command found ⌜self mock1⌝.
TRACE    Function name found ⌜selfMock1⌝.
DEBUG    Loaded file ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/.commands.d/self-mock.sh⌝.
DEBUG    Running the command ⌜self mock1⌝ with the function ⌜selfMock1⌝ and the arguments ⌜logging-level⌝.
DEBUG    Parsed arguments:
local commandArgumentsErrors help action
help=""
commandArgumentsErrors=""
action="logging-level"
TRACE    This is an error trace message which is always displayed.
TRACE    This is a trace message.
DEBUG    This is a debug message.
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.
The debug mode is activated!
The trace mode is activated!
DEBUG    Exiting with code 0 after 0s.
DEBUG    Deleting temporary files.
```

### ✅ Logging with -a option

❯ `valet -a self mock1 logging-level`

**Error output**:

```text
| TRACE    This is an error trace message which is always displayed.
| INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
| SUCCESS  This is a success message.
| WARNING  This is a warning message.
With a second line.
```

### ✅ Testing that we can change the log display options

❯ `VALET_CONFIG_LOG_COLUMNS=40 VALET_CONFIG_ENABLE_COLORS=true VALET_CONFIG_ENABLE_NERDFONT_ICONS=true VALET_CONFIG_LOG_DISABLE_WRAP=false VALET_CONFIG_LOG_DISABLE_HIGHLIGHT=false valet self mock1 logging-level`

**Error output**:

```text
TRACE   _This is an error trace message 
         which is always displayed.
INFO    _This is an info message with a 
         super long sentence. The value 
         of life is not in its duration,
         but in its donation. You are 
         not important because of how 
         long you live, you are 
         important because of how 
         effective you live. Give a man 
         a fish and you feed him for a 
         day; teach a man to fish and 
         you feed him for a lifetime. 
         Surround yourself with the best
         people you can find, delegate 
         authority, and don't interfere 
         as long as the policy you've 
         decided upon is being carried 
         out.
SUCCESS _This is a success message.
WARNING _This is a warning message.
         With a second line.
```

### ✅ Testing that we can output the logs to a directory additionally to console

❯ `VALET_CONFIG_LOG_TO_DIRECTORY=/tmp/valet.d/d1-2 valet self mock1 logging-level`

**Error output**:

```text
TRACE    This is an error trace message which is always displayed.
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.
```

❯ `fs::listFiles /tmp/valet.d/d1-2`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='/tmp/valet.d/d1-2/log-2025-02-12T21-57-29+0000.log'
)
```

### ✅ Testing that we can output the logs to a specific file name additionally to console

❯ `VALET_CONFIG_LOG_FILENAME_PATTERN=logFile=test.log VALET_CONFIG_LOG_TO_DIRECTORY=true valet self mock1 logging-level`

**Error output**:

```text
TRACE    This is an error trace message which is always displayed.
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.
```

❯ `fs::cat /tmp/valet.valet.d/logs/test.log`

**Standard output**:

```text
TRACE    This is an error trace message which is always displayed.
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.

```

### ✅ Testing that we can output the logs to a specific file descriptor

❯ `VALET_CONFIG_LOG_FD=/tmp/valet.d/d1-2/test2.log valet self mock1 logging-level`

❯ `fs::cat /tmp/valet.d/d1-2/test2.log`

**Standard output**:

```text
TRACE    This is an error trace message which is always displayed.
INFO     This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out.
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.

```

