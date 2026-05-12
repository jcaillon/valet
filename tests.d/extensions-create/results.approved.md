# Test suite extensions-create

## Test script 00.extensions-create

### ✅ Testing extensions create

❯ `extensionsCreate test1`

**Error output**:

```text
INFO     Creating the extension test1 at ⌜/tmp/valet.d/d1-2/test1⌝.
INFO     Setting up the current directory ⌜test1⌝ as an extension.
INFO     Rebuilding the documentation because ⌜/tmp/valet.d/d1-2/lib-valet⌝ is missing.
INFO     Called selfDocument.
SUCCESS  The extension test1 is ready to be used.
INFO     You new extension test1 has been created.
Learn more about extensions and command here: <https://jcaillon.github.io/valet/docs/>.
You can now create a new commands or libraries for this extension:

cd '/tmp/valet.d/d1-2/test1'
valet extensions add-command
valet extensions add-library
```

Listing of `/tmp/valet.d/d1-2/test1` (recursively) (including hidden):

```text
F .gitignore
D .vscode
F .vscode/extensions.json
F .vscode/settings.json
L .vscode/valet.code-snippets
D commands.d
? commands.d/*
L lib-valet
L lib-valet.md
```

### ✅ Testing extensions create with existing extension

❯ `extensionsCreate test1`

Exited with code: `1`

**Error output**:

```text
FAIL     An extension named test1 already exists at ⌜/tmp/valet.d/d1-2/test1⌝, please choose another name.
```

