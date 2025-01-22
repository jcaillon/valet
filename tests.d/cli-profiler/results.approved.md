# Test suite cli-profiler

## Test script 00.profiler

The profiler is an excellent tool to debug your command. The following example shows what you would get when you enable it.

Notice that the profiling file is cleaned up after the command execution to maximize readability.

**Exported variables:**

```text
VALET_CONFIG_COMMAND_PROFILING_FILE='/tmp/valet.d/f1-2'
VALET_CONFIG_STARTUP_PROFILING_FILE='/tmp/valet.d/f2-2'
```

### ✅ Testing the profiler cli option

❯ `valet -x self mock2 arg1 arg2`

**Standard output**:

```text
That's it!
```

**Error output**:

```text
INFO     Starting profiler, writing in ⌜/tmp/valet.d/f1-2⌝.
INFO     Option 1 (option1): .
INFO     Option 2 (thisIsOption2): .
INFO     Option 3 (flag3): .
INFO     Option 4 (withDefault): cool.
INFO     First argument: arg1.
INFO     More: arg2.
INFO     Disabling profiler.
```

❯ `io::cat /tmp/valet.d/f1-2`

**Standard output**:

```text
(D=function depth, I=level of indirection, S=subshell level, timer=elapsed time in seconds, delta=delta between the last command in seconds, caller source:line=the source file and line number of the caller of the function, function=the name of the function in which the command is executed, command=the executed command)

D  I  S  timer  delta                          source:line function                                 → command
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:164  selfMock2()                              → local -a more
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:165  selfMock2()                              → command::parseArguments arg1 arg2
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:165  selfMock2()                              → eval 'local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
                                                                                                       local -a more
                                                                                                       option1=""
                                                                                                       thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
                                                                                                       flag3="${VALET_FLAG3:-}"
                                                                                                       withDefault="${VALET_WITH_DEFAULT:-"cool"}"
                                                                                                       help=""
                                                                                                       parsingErrors=""
                                                                                                       firstArg="arg1"
                                                                                                       more=(
                                                                                                       "arg2"
                                                                                                       )'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:165  selfMock2()                              → local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:166  selfMock2()                              → local -a more
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:167  selfMock2()                              → option1=
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:168  selfMock2()                              → thisIsOption2=
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:169  selfMock2()                              → flag3=
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:170  selfMock2()                              → withDefault=cool
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:171  selfMock2()                              → help=
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:172  selfMock2()                              → parsingErrors=
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:173  selfMock2()                              → firstArg=arg1
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:176  selfMock2()                              → more=("arg2")
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:166  selfMock2()                              → command::checkParsedResults
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:168  selfMock2()                              → log::info 'Option 1 (option1): .'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:169  selfMock2()                              → log::info 'Option 2 (thisIsOption2): .'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:170  selfMock2()                              → log::info 'Option 3 (flag3): .'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:171  selfMock2()                              → log::info 'Option 4 (withDefault): cool.'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:172  selfMock2()                              → log::info 'First argument: arg1.'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:173  selfMock2()                              → log::info 'More: arg2.'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:175  selfMock2()                              → aSubFunctionInselfMock2
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:182  aSubFunctionInselfMock2()                → log::debug 'This is a sub function.'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:177  selfMock2()                              → printf '%s\n' 'That'\''s it!'

```

### ✅ Testing the profiler with cleanup using bash

❯ `VALET_CONFIG_LOG_CLEANUP_USING_BASH=true valet -x self mock2 arg1 arg2`

**Standard output**:

```text
That's it!
```

**Error output**:

```text
INFO     Starting profiler, writing in ⌜/tmp/valet.d/f1-2⌝.
INFO     Option 1 (option1): .
INFO     Option 2 (thisIsOption2): .
INFO     Option 3 (flag3): .
INFO     Option 4 (withDefault): cool.
INFO     First argument: arg1.
INFO     More: arg2.
INFO     Disabling profiler.
```

❯ `io::cat /tmp/valet.d/f1-2`

**Standard output**:

```text
(D=function depth, I=level of indirection, S=subshell level, timer=elapsed time in seconds, delta=delta between the last command in seconds, caller source:line=the source file and line number of the caller of the function, function=the name of the function in which the command is executed, command=the executed command)

D  I  S  timer  delta                          source:line function                                 → command
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:164  selfMock2()                              → local -a more
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:165  selfMock2()                              → command::parseArguments arg1 arg2
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:165  selfMock2()                              → eval 'local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
                                                                                                           local -a more								
                                                                                                           option1=""								
                                                                                                           thisIsOption2="${VALET_THIS_IS_OPTION2:-}"								
                                                                                                           flag3="${VALET_FLAG3:-}"								
                                                                                                           withDefault="${VALET_WITH_DEFAULT:-"cool"}"								
                                                                                                           help=""								
                                                                                                           parsingErrors=""								
                                                                                                           firstArg="arg1"								
                                                                                                           more=(								
                                                                                                           "arg2"								
                                                                                                           )'								
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:165  selfMock2()                              → local parsingErrors option1 thisIsOption2 flag3 withDefault help firstArg
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:166  selfMock2()                              → local -a more
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:167  selfMock2()                              → option1=
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:168  selfMock2()                              → thisIsOption2=
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:169  selfMock2()                              → flag3=
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:170  selfMock2()                              → withDefault=cool
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:171  selfMock2()                              → help=
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:172  selfMock2()                              → parsingErrors=
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:173  selfMock2()                              → firstArg=arg1
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:176  selfMock2()                              → more=("arg2")
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:166  selfMock2()                              → command::checkParsedResults
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:168  selfMock2()                              → log::info 'Option 1 (option1): .'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:169  selfMock2()                              → log::info 'Option 2 (thisIsOption2): .'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:170  selfMock2()                              → log::info 'Option 3 (flag3): .'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:171  selfMock2()                              → log::info 'Option 4 (withDefault): cool.'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:172  selfMock2()                              → log::info 'First argument: arg1.'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:173  selfMock2()                              → log::info 'More: arg2.'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:175  selfMock2()                              → aSubFunctionInselfMock2
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:182  aSubFunctionInselfMock2()                → log::debug 'This is a sub function.'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:177  selfMock2()                              → printf '%s\n' 'That'\''s it!'

```

### ✅ Testing to enable the profiler on Valet startup

❯ `VALET_CONFIG_STARTUP_PROFILING=true valet --log-level error -x self mock1 logging-level`

**Error output**:

```text
INFO     Starting profiler, writing in ⌜/tmp/valet.d/f2-2⌝.
TRACE    This is an error trace message which is always displayed.
```

❯ `io::head /tmp/valet.d/f2-2 1`

**Standard output**:

```text
(D=function depth, I=level of indirection, S=subshell level, timer=elapsed time in seconds, delta=delta between the last command in seconds, caller source:line=the source file and line number of the caller of the function, function=the name of the function in which the command is executed, command=the executed command)
```

