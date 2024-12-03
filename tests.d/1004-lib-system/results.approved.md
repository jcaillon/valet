# Test suite 1004-lib-system

## Test script 00.tests

### Testing system::os

Exit code: `0`

**Standard** output:

```plaintext
→ OSTYPE=linux-bsd system::os
linux

→ OSTYPE=msys system::os
windows

→ OSTYPE=darwin-stuff system::os
darwin

→ OSTYPE=nop system::os
unknown

```

### Testing system::env

Exit code: `0`

**Standard** output:

```plaintext
→ system::env
Found environment variables.
```

### Testing system::date

Exit code: `0`

**Standard** output:

```plaintext
→ system::date
Returned date with length 22.

→ system::date %(%H:%M:%S)T
Returned date with length 8.
```

### Testing system::date

Exit code: `0`

**Standard** output:

```plaintext
→ system::getUndeclaredVariables
No undeclared variables found.

→ system::getUndeclaredVariables GLOBAL_TEST_TEMP_FILE
Found undeclared variables: ⌜dfg NOP⌝.
```

### Testing system::getNotExistingCommands

Exit code: `0`

**Standard** output:

```plaintext
→ system::getNotExistingCommands
No not existing commands found.

→ system::getNotExistingCommands NONEXISTINGSTUFF system::getNotExistingCommands rm YETANOTHERONEMISSING
Found not existing commands: ⌜NONEXISTINGSTUFF YETANOTHERONEMISSING⌝.
```

### Testing system::commandExists

Exit code: `0`

**Standard** output:

```plaintext
→ system::commandExists
Command not found.

→ system::commandExists NONEXISTINGSTUFF
Command not found.

→ system::commandExists rm ls
Found command.
```

### Testing system::addToPath

Exit code: `0`

**Standard** output:

```plaintext
→ system::addToPath

content of files:


export PATH="/coucou:${PATH}"


set path = ($path '/coucou')


set path = ($path '/coucou')


$PATH.append('/coucou')


fish_add_path '/coucou'


export PATH="/coucou:${PATH}"


$env.PATH = ($env.PATH | split row (char esep) | append "/coucou")
```

**Error** output:

```log
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜bash⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜ksh⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜zsh⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜tcsh⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜csh⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜xonsh⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜fish⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜nu⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜bash⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜ksh⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜zsh⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜tcsh⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜csh⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜xonsh⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜fish⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜nu⌝ shell.
```

### Testing system::windowsSetEnvVar

Exit code: `0`

**Standard** output:

```plaintext
→ system::windowsSetEnvVar VAR VALUE
powershell: -NoProfile -NonInteractive -Command $ErrorActionPreference = 'Stop'; [Environment]::SetEnvironmentVariable('VAR', 'VALUE', [System.EnvironmentVariableTarget]::User); exit $LASTEXITCODE;

→ system::windowsSetEnvVar VAR ''
powershell: -NoProfile -NonInteractive -Command $ErrorActionPreference = 'Stop'; [Environment]::SetEnvironmentVariable('VAR', '', [System.EnvironmentVariableTarget]::User); exit $LASTEXITCODE;
powershell: -NoProfile -NonInteractive -Command $ErrorActionPreference = 'Stop'; [Environment]::SetEnvironmentVariable('VAR', [NullString]::Value, [System.EnvironmentVariableTarget]::User); exit $LASTEXITCODE;

```

