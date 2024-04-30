# Test suite 1301-profiler

## Test script 00.profiler

The profiler is an excellent tool to debug your command. The following example shows what you would get when you enable it.

Notice that the profiling file has been cleanup after the command execution to maximize readability.

### Testing profiling for command

Exit code: `0`

**Standard** output:

```plaintext
→ valet -x self mock2 arg1 arg2

→ cat 'profiler.log'
That's it!
(D=function depth, I=level of indirection, S=subshell level, timer=elapsed time in seconds, delta=delta between the last command in seconds, caller source:line=the source file and line number of the caller of the function, function=the name of the function in which the command is executed, command=the executed command)

D  I  S  timer  delta                           source:line function                                 → command
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:162  selfMock2()                              → local -a more
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:163  selfMock2()                              → core::parseArguments arg1 arg2
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:163  selfMock2()                              → eval 'local parsingErrors option1 thisIsOption2 help firstArg
                                                                                                       local -a more
                                                                                                       thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
                                                                                                       parsingErrors=""
                                                                                                       firstArg="arg1"
                                                                                                       more=(
                                                                                                       "arg2"
                                                                                                       )'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:163  selfMock2()                              → local parsingErrors option1 thisIsOption2 help firstArg
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:164  selfMock2()                              → local -a more
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:165  selfMock2()                              → thisIsOption2=
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:166  selfMock2()                              → parsingErrors=
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:167  selfMock2()                              → firstArg=arg1
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:170  selfMock2()                              → more=("arg2")
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:164  selfMock2()                              → core::checkParseResults '' ''
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:166  selfMock2()                              → log::info 'First argument: arg1.'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:167  selfMock2()                              → log::info 'Option 1: .'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:168  selfMock2()                              → log::info 'Option 2: .'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:169  selfMock2()                              → log::info 'More: arg2.'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:171  selfMock2()                              → aSubFunctionInselfMock2
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:178  aSubFunctionInselfMock2()                → log::debug 'This is a sub function.'
00 00 00 0.0XXX 0.0XXX                    self-mock.sh:173  selfMock2()                              → printf '%s\n' 'That'\''s it!'
```

**Error** output:

```log
INFO     Starting profiler, writing in ⌜/tmp/valet.d/f201-0⌝. main
INFO     First argument: arg1.
INFO     Option 1: .
INFO     Option 2: .
INFO     More: arg2.
INFO     Disabling profiler.
```

### Testing profiling for command and startup

Exit code: `0`

**Standard** output:

```plaintext
→ VALET_CONFIG_STARTUP_PROFILING=true valet --log-level error -x self mock1 logging-level
A startup profiling file has been created to log everything happening from the start of Valet to the start of the chosen command.
A command profiling file has been created to log everything happening in the chosen command execution.
```

**Error** output:

```log
INFO     Starting profiler, writing in ⌜/tmp/valet.d/f202-0⌝. 
```

