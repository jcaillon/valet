# Test suite extensions-init

## Test script 00.extensions-init

### ✅ Testing extensions init without code in PATH, on windows and outside the ext directory

❯ `extensionsInit`

**Error output**:

```text
INFO     Setting up the current directory ⌜my-extension⌝ as an extension.
INFO     Starting a batch of ps1 commands to be executed at the end of the script.
INFO     Extension directories must be created in the user directory ⌜/tmp/valet.d/d1-2⌝ but the current directory is ⌜/tmp/valet.d/d2-2/my-extension⌝.
   ╭──────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ The current directory can be linked inside the valet extensions directory so it can be used as an extension. 115│
   │ Do you want to register the current directory has an extension? 115│
   ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭──────╮
9│ Yes. 16├──░
9╰──────╯
INFO     Creating a symbolic link to register the current directory as an extension.
INFO     Rebuilding the documentation because ⌜/tmp/valet.d/d1-2/lib-valet⌝ is missing.
INFO     Called selfDocument.
INFO     Ending the batch of ps1 commands and executing them.
SUCCESS  The extension my-extension is ready to be used.
```

Listing of `/tmp/valet.d/d2-2/my-extension` (recursively) (including hidden):

```text
F .gitignore
L lib-valet
L lib-valet.md
```

### ✅ Testing extensions init with code in PATH, on linux, outside the ext directory but registered

❯ `extensionsInit`

**Error output**:

```text
INFO     Setting up the current directory ⌜my-extension⌝ as an extension.
INFO     Extension directories must be created in the user directory ⌜/tmp/valet.d/d1-2⌝ but the current directory is ⌜/tmp/valet.d/d2-2/my-extension⌝.
INFO     The current directory is already registered as an extension.
SUCCESS  The extension my-extension is ready to be used.
```

Listing of `/tmp/valet.d/d2-2/my-extension` (recursively) (including hidden):

```text
F .gitignore
D .vscode
F .vscode/extensions.json
F .vscode/settings.json
L .vscode/valet.code-snippets
L lib-valet
L lib-valet.md
```

> cat `/tmp/valet.d/d2-2/my-extension/.gitignore`

```text


### Valet ###
lib-valet
lib-valet.md
.vscode/valet.code-snippets
```

### ✅ Testing extensions init with existing extension and not overwriting

❯ `extensionsInit`

**Error output**:

```text
INFO     Setting up the current directory ⌜my-extension⌝ as an extension.
INFO     Extension directories must be created in the user directory ⌜/tmp/valet.d/d1-2⌝ but the current directory is ⌜/tmp/valet.d/d2-2/my-extension⌝.
   ╭──────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ The current directory can be linked inside the valet extensions directory so it can be used as an extension. 115│
   │ Do you want to register the current directory has an extension? 115│
   ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭──────╮
9│ Yes. 16├──░
9╰──────╯
WARNING  The extension ⌜my-extension⌝ already exists in ⌜/tmp/valet.d/d1-2⌝.
   ╭─────────────────────────────────────────────────────────────────────────────────╮
░──┤ You are about to replace the existing extension, it will delete existing files. 86│
   │ Do you want to overwrite the existing ⌜my-extension⌝ extension? 86│
   ╰─────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭─────╮
9│ No. 15├──░
9╰─────╯
WARNING  The current directory will not be registered as an extension.
If you want to register it later, you can run this command again or link it:
ln -s "/tmp/valet.d/d2-2/my-extension" "/tmp/valet.d/d1-2/my-extension"
INFO     Rebuilding the documentation because ⌜/tmp/valet.d/d1-2/lib-valet⌝ is missing.
INFO     Called selfDocument.
SUCCESS  The extension my-extension is ready to be used.
```

Listing of `/tmp/valet.d/d2-2/my-extension` (recursively) (including hidden):

```text
F .gitignore
L lib-valet
L lib-valet.md
```

### ✅ Testing extensions init with existing extension and overwriting

❯ `extensionsInit`

**Error output**:

```text
INFO     Setting up the current directory ⌜my-extension⌝ as an extension.
INFO     Extension directories must be created in the user directory ⌜/tmp/valet.d/d1-2⌝ but the current directory is ⌜/tmp/valet.d/d2-2/my-extension⌝.
   ╭──────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ The current directory can be linked inside the valet extensions directory so it can be used as an extension. 115│
   │ Do you want to register the current directory has an extension? 115│
   ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭──────╮
9│ Yes. 16├──░
9╰──────╯
WARNING  The extension ⌜my-extension⌝ already exists in ⌜/tmp/valet.d/d1-2⌝.
   ╭─────────────────────────────────────────────────────────────────────────────────╮
░──┤ You are about to replace the existing extension, it will delete existing files. 86│
   │ Do you want to overwrite the existing ⌜my-extension⌝ extension? 86│
   ╰─────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭──────╮
9│ Yes. 16├──░
9╰──────╯
INFO     Creating a symbolic link to register the current directory as an extension.
SUCCESS  The extension my-extension is ready to be used.
```

### ✅ Testing extensions init without registration

❯ `extensionsInit`

**Error output**:

```text
INFO     Setting up the current directory ⌜my-extension⌝ as an extension.
INFO     Extension directories must be created in the user directory ⌜/tmp/valet.d/d1-2⌝ but the current directory is ⌜/tmp/valet.d/d2-2/my-extension⌝.
   ╭──────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ The current directory can be linked inside the valet extensions directory so it can be used as an extension. 115│
   │ Do you want to register the current directory has an extension? 115│
   ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭─────╮
9│ No. 15├──░
9╰─────╯
WARNING  The current directory will not be registered as an extension.
If you want to register it later, you can run this command again or link it:
ln -s "/tmp/valet.d/d2-2/my-extension" "/tmp/valet.d/d1-2/my-extension"
INFO     Rebuilding the documentation because ⌜/tmp/valet.d/d1-2/lib-valet⌝ is missing.
INFO     Called selfDocument.
SUCCESS  The extension my-extension is ready to be used.
```

### ✅ Testing extensions init inside the extensions directory

❯ `extensionsInit`

**Error output**:

```text
INFO     Setting up the current directory ⌜my-extension⌝ as an extension.
INFO     Rebuilding the documentation because ⌜/tmp/valet.d/d1-2/lib-valet⌝ is missing.
INFO     Called selfDocument.
SUCCESS  The extension my-extension is ready to be used.
```

Listing of `/tmp/valet.d/d1-2/my-extension` (recursively) (including hidden):

```text
F .gitignore
L lib-valet
L lib-valet.md
```

