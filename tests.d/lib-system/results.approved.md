# Test suite lib-system

## Test script 00.tests

### ✅ Testing system::os

❯ `OSTYPE=linux-bsd system::os`

Returned variables:

```text
RETURNED_VALUE='linux'
```

❯ `OSTYPE=msys system::os`

Returned variables:

```text
RETURNED_VALUE='windows'
```

❯ `OSTYPE=darwin-stuff system::os`

Returned variables:

```text
RETURNED_VALUE='darwin'
```

❯ `OSTYPE=nop system::os`

Returned variables:

```text
RETURNED_VALUE='unknown'
```

### ✅ Testing system::env

❯ `system::env`

Found environment variables in RETURNED_ARRAY.

### ✅ Testing system::date

❯ `system::date`

Returned variables:

```text
RETURNED_VALUE='1987-05-25_01h00m00s'
```

❯ `system::date '%(%H:%M:%S)T'`

Returned variables:

```text
RETURNED_VALUE='01:00:00'
```

### ✅ Testing system::getUndeclaredVariables

❯ `system::getUndeclaredVariables`

Returned code: `1`

❯ `ABC=ok`

❯ `system::getUndeclaredVariables GLOBAL_TEST_TEMP_FILE dfg ABC NOP`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='dfg'
[1]='NOP'
)
```

### ✅ Testing system::getNotExistingCommands

❯ `system::getNotExistingCommands`

Returned code: `1`

❯ `system::getNotExistingCommands NONEXISTINGSTUFF system::getNotExistingCommands rm YETANOTHERONEMISSING`

Returned variables:

```text
RETURNED_ARRAY=(
[0]='NONEXISTINGSTUFF'
[1]='YETANOTHERONEMISSING'
)
```

### ✅ Testing system::commandExists

❯ `system::commandExists`

Returned code: `1`

❯ `system::commandExists NONEXISTINGSTUFF`

Returned code: `1`

❯ `system::commandExists rm`

### ✅ Testing system::addToPath

❯ `system::addToPath /coucou`

**Error output**:

```text
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
```

❯ `fs::cat resources/gitignored/.zshrc`

**Standard output**:

```text


export PATH="/coucou:${PATH}"

```

❯ `fs::cat resources/gitignored/.tcshrc`

**Standard output**:

```text


set path = ($path '/coucou')

```

❯ `fs::cat resources/gitignored/.cshrc`

**Standard output**:

```text


set path = ($path '/coucou')

```

❯ `fs::cat resources/gitignored/.xonshrc`

**Standard output**:

```text


$PATH.append('/coucou')

```

❯ `fs::cat resources/gitignored/.config/fish/config.fish`

**Standard output**:

```text


fish_add_path '/coucou'

```

❯ `fs::cat resources/gitignored/.kshrc`

**Standard output**:

```text


export PATH="/coucou:${PATH}"

```

❯ `fs::cat resources/gitignored/.config/nushell/env.nu`

**Standard output**:

```text


$env.PATH = ($env.PATH | split row (char esep) | append "/coucou")

```

❯ `system::addToPath /coucou`

**Error output**:

```text
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜bash⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜ksh⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜zsh⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜tcsh⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜csh⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜xonsh⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜fish⌝ shell.
INFO     The directory ⌜/coucou⌝ is already in the PATH for ⌜nu⌝ shell.
```

### ✅ Testing windows::setEnvVar

❯ `OSTYPE=msys windows::setEnvVar VAR VALUE`

**Standard output**:

```text
🙈 mocking windows::runPs1: $key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Environment', $true); $key.SetValue('VAR', 'VALUE', 'ExpandString');
```

❯ `OSTYPE=msys windows::setEnvVar VAR ''`

**Standard output**:

```text
🙈 mocking windows::runPs1: $key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Environment', $true); $key.DeleteValue('VAR');
```

### ✅ Testing windows::getEnvVar

❯ `OSTYPE=msys windows::getEnvVar VAR`

**Standard output**:

```text
🙈 mocking windows::runPs1: 
  $key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Environment', $true);
  $value = $key.GetValue('VAR', '', 'DoNotExpandEnvironmentNames');
  $key.Dispose();
  Write-Output $value;
  
```

### ✅ Testing windows::addToPath

❯ `OSTYPE=msys windows::addToPath /coucou`

**Standard output**:

```text
🙈 mocking windows::runPs1: 
  $pathToAdd = '\coucou';
  $key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Environment', $true);
  $oldPath = $key.GetValue('Path', '', 'DoNotExpandEnvironmentNames').TrimEnd([IO.Path]::PathSeparator);
  if ($currentPath -notlike "*$pathToAdd*") {
      $newPath = '{0}{1}{2}' -f $oldPath, [IO.Path]::PathSeparator, $pathToAdd;
      $key.SetValue('Path', $newPath, 'ExpandString');
  };
  $key.Dispose();
  
```

