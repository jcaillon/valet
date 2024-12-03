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
INFO     Adding directory ⌜/coucou⌝ to the PATH for ⌜bash⌝ shell.
Appending to ⌜resources/gitignored/.bashrc⌝:
export PATH="/coucou:${PATH}"
INFO     Adding directory ⌜/coucou⌝ to the PATH for ⌜ksh⌝ shell.
Appending to ⌜resources/gitignored/.kshrc⌝:
export PATH="/coucou:${PATH}"
INFO     Adding directory ⌜/coucou⌝ to the PATH for ⌜zsh⌝ shell.
Appending to ⌜resources/gitignored/.zshrc⌝:
export PATH="/coucou:${PATH}"
INFO     Adding directory ⌜/coucou⌝ to the PATH for ⌜tcsh⌝ shell.
Appending to ⌜resources/gitignored/.tcshrc⌝:
set path = ($path '/coucou')
INFO     Adding directory ⌜/coucou⌝ to the PATH for ⌜csh⌝ shell.
Appending to ⌜resources/gitignored/.cshrc⌝:
set path = ($path '/coucou')
INFO     Adding directory ⌜/coucou⌝ to the PATH for ⌜xonsh⌝ shell.
Appending to ⌜resources/gitignored/.xonshrc⌝:
$PATH.append('/coucou')
INFO     Adding directory ⌜/coucou⌝ to the PATH for ⌜fish⌝ shell.
Appending to ⌜resources/gitignored/.config/fish/config.fish⌝:
fish_add_path '/coucou'
INFO     Adding directory ⌜/coucou⌝ to the PATH for ⌜nu⌝ shell.
Appending to ⌜resources/gitignored/.config/nushell/env.nu⌝:
$env.PATH = ($env.PATH | split row (char esep) | append "/coucou")
WARNING  The directory ⌜/coucou⌝ has been added to the PATH for 8 shells.
Please login again to apply the changes on your current shell if you are not using bash.
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
powershell: -NoProfile -NonInteractive -Command $ErrorActionPreference = 'Stop'; $key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Environment', $true); $key.SetValue('VAR', 'VALUE', 'ExpandString');; exit $LASTEXITCODE;

→ system::windowsSetEnvVar VAR ''
powershell: -NoProfile -NonInteractive -Command $ErrorActionPreference = 'Stop'; $key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Environment', $true); $key.DeleteValue('VAR');; exit $LASTEXITCODE;

```

### Testing system::windowsAddToPath

Exit code: `0`

**Standard** output:

```plaintext
→ system::windowsAddToPath /coucou
powershell: -NoProfile -NonInteractive -Command $ErrorActionPreference = 'Stop'; 
  $pathToAdd = '\coucou';
  $key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Environment', $true);
  $oldPath = $key.GetValue('Path', '', 'DoNotExpandEnvironmentNames').TrimEnd([IO.Path]::PathSeparator);
  if ($currentPath -notlike "*$pathToAdd*") {
      $newPath = '{0}{1}{2}' -f $oldPath, [IO.Path]::PathSeparator, $pathToAdd;
      $key.SetValue('Path', $newPath, 'ExpandString');
  };
  $key.Dispose();
  ; exit $LASTEXITCODE;

```

**Error** output:

```log
INFO     The directory ⌜\coucou⌝ has been added to the windows user PATH.
```

