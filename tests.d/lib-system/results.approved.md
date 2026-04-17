# Test suite lib-system

## Test script 00.tests

### ✅ Testing system::isDarwin

❯ `OSTYPE=darwin system::isDarwin`

❯ `OSTYPE=darwin-bsd system::isDarwin`

❯ `OSTYPE=msys system::isDarwin`

Returned code: `1`

❯ `OSTYPE=cygwin system::isDarwin`

Returned code: `1`

### ✅ Testing system::isLinux

❯ `OSTYPE=linux system::isLinux`

❯ `OSTYPE=linux-bsd system::isLinux`

❯ `OSTYPE=msys system::isLinux`

Returned code: `1`

❯ `OSTYPE=cygwin system::isLinux`

Returned code: `1`

### ✅ Testing system::isWindows

❯ `OSTYPE=msys system::isWindows`

❯ `OSTYPE=cygwin system::isWindows`

❯ `OSTYPE=windows system::isWindows`

Returned code: `1`

❯ `OSTYPE=linux system::isWindows`

Returned code: `1`

### ✅ Testing system::getArchitecture

❯ `MACHTYPE=x86_64-pc-msys system::getArchitecture`

Returned variables:

```text
REPLY='x86_64'
```

### ✅ Testing system::getOs

❯ `OSTYPE=linux-bsd system::getOs`

Returned variables:

```text
REPLY='linux'
```

❯ `OSTYPE=msys system::getOs`

Returned variables:

```text
REPLY='windows'
```

❯ `OSTYPE=cygwin system::getOs`

Returned variables:

```text
REPLY='windows'
```

❯ `OSTYPE=darwin-stuff system::getOs`

Returned variables:

```text
REPLY='darwin'
```

❯ `OSTYPE=nop system::getOs`

Returned variables:

```text
REPLY='unknown'
```

### ✅ Testing system::getEnvVars

❯ `system::getEnvVars`

Found environment variables in REPLY_ARRAY.

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

### ✅ Testing system::isWindowsWithoutNativeSymlinks

❯ `MSYS= OSTYPE=msys system::isWindowsWithoutNativeSymlinks`

❯ `MSYS= OSTYPE=linux system::isWindowsWithoutNativeSymlinks`

Returned code: `1`

❯ `MSYS=winsymlinks:nativestrict OSTYPE=cygwin system::isWindowsWithoutNativeSymlinks`

Returned code: `1`

❯ `MSYS=winsymlinks:nativestrict OSTYPE=linux system::isWindowsWithoutNativeSymlinks`

Returned code: `1`

### ✅ Testing system::isDirectoryInPath

❯ `system::isDirectoryInPath /usr/local/bin`

❯ `system::isDirectoryInPath /usr/bin`

❯ `system::isDirectoryInPath /bin`

❯ `system::isDirectoryInPath /sbin`

Returned code: `1`

