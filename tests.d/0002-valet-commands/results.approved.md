# Test: 0002-valet-commands

## Testing help for the showcase hello-world command

Exit code: 0

**Standard** output:

```plaintext
ABOUT

  An hello world command.

USAGE

  valet showcase hello-world [options]

OPTIONS

  -h, --help
      Display the help for this command


```

## Testing to fuzzy find command

Exit code: 0

**Standard** output:

```plaintext
ABOUT

  An hello world command.

USAGE

  valet showcase hello-world [options]

OPTIONS

  -h, --help
      Display the help for this command


```

**Error** output:

```log
INFO     Fuzzy matching the command ⌜h s⌝ to ⌜help⌝.
INFO     Fuzzy matching the command ⌜s h⌝ to ⌜showcase hello-world⌝.
```

## Testing help with columns 60

Exit code: 0

**Standard** output:

```plaintext
------------------------------------------------------------
ABOUT

  Show the help this program or of the help of a specific 
  command.
  
  You can show the help with or without colors and set the 
  maximum columns for the help text.

USAGE

  valet help [options] <commands...>

OPTIONS

  -nc, --no-colors
      Do not use any colors in the output
      This option can be set by exporting the variable 
      VALET_NO_COLORS="true".
  -c, --columns <number>
      Set the maximum columns for the help text
      This option can be set by exporting the variable 
      VALET_COLUMNS="<number>".
  -h, --help
      Display the help for this command

ARGUMENTS

  commands...
      The name of the command to show the help for.
      If not provided, show the help for the program.

EXAMPLES

  help ⌟cmd⌞
      Shows the help for the command ⌜cmd⌝
  help ⌟cmd⌞ ⌟subCmd⌞
      Shows the help for the sub command ⌜subCmd⌝ of the 
      command ⌜cmd⌝
  help --no-colors --columns 50
      Shows the help for the program without any color and 
      with a maximum of 50 columns


```

