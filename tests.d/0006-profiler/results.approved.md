# Test suite 0006-profiler

## Test script 00.profiler

The profiler is an excellent tool to debug your command. The following example shows what you would get when you enable it.

Notice that the profiling file has been cleanup after the command execution to maximize readability.

### Testing profiling for command

Exit code: `0`

**Standard** output:

```plaintext
→ valet -x showcase command1 arg1 arg2

→ cat 'profiler.log'
That's it!
(D=function depth, I=level of indirection, S=subshell level, timer=elapsed time in seconds, delta=delta between the last command in seconds, caller source:line=the source file and line number of the caller of the function, function=the name of the function in which the command is executed, command=the executed command)

D  I  S  timer  delta                           source:line function                                 → command
00 00 00 0.0XXX 0.0XXX                     showcase.sh:47   showcaseCommand1()                       → local -a more
00 00 00 0.0XXX 0.0XXX                     showcase.sh:48   showcaseCommand1()                       → parseArguments arg1 arg2
00 00 00 0.0XXX 0.0XXX                     showcase.sh:48   showcaseCommand1()                       → eval 'local parsingErrors option1 thisIsOption2 help firstArg
                                                                                                       local -a more
                                                                                                       thisIsOption2="${VALET_THIS_IS_OPTION2:-}"
                                                                                                       parsingErrors=""
                                                                                                       firstArg="arg1"
                                                                                                       more=(
                                                                                                       "arg2"
                                                                                                       )'
00 00 00 0.0XXX 0.0XXX                     showcase.sh:48   showcaseCommand1()                       → local parsingErrors option1 thisIsOption2 help firstArg
00 00 00 0.0XXX 0.0XXX                     showcase.sh:49   showcaseCommand1()                       → local -a more
00 00 00 0.0XXX 0.0XXX                     showcase.sh:50   showcaseCommand1()                       → thisIsOption2=
00 00 00 0.0XXX 0.0XXX                     showcase.sh:51   showcaseCommand1()                       → parsingErrors=
00 00 00 0.0XXX 0.0XXX                     showcase.sh:52   showcaseCommand1()                       → firstArg=arg1
00 00 00 0.0XXX 0.0XXX                     showcase.sh:55   showcaseCommand1()                       → more=("arg2")
00 00 00 0.0XXX 0.0XXX                     showcase.sh:49   showcaseCommand1()                       → checkParseResults '' ''
00 00 00 0.0XXX 0.0XXX                     showcase.sh:51   showcaseCommand1()                       → inform 'First argument: arg1.'
00 00 00 0.0XXX 0.0XXX                     showcase.sh:52   showcaseCommand1()                       → inform 'Option 1: .'
00 00 00 0.0XXX 0.0XXX                     showcase.sh:53   showcaseCommand1()                       → inform 'Option 2: .'
00 00 00 0.0XXX 0.0XXX                     showcase.sh:54   showcaseCommand1()                       → inform 'More: arg2.'
00 00 00 0.0XXX 0.0XXX                     showcase.sh:56   showcaseCommand1()                       → aSubFunctionInShowcaseCommand1
00 00 00 0.0XXX 0.0XXX                     showcase.sh:63   aSubFunctionInShowcaseCommand1()         → debug 'This is a sub function.'
00 00 00 0.0XXX 0.0XXX                     showcase.sh:58   showcaseCommand1()                       → echo 'That'\''s it!'
```

**Error** output:

```log
INFO     Starting profiler, writing in ⌜/tmp/f101-0⌝. main
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
→ VALET_STARTUP_PROFILING=true valet --log-level error -x self test-core --logging-level
A startup profiling file has been created to log everything happening from the start of Valet to the start of the chosen command.
A command profiling file has been created to log everything happening in the chosen command execution.
```

**Error** output:

```log
INFO     Starting profiler, writing in ⌜/tmp/f102-0⌝. 
```

