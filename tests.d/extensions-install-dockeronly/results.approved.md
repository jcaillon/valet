# Test suite extensions-install-dockeronly

## Test script 00.extensions-install

### ✅ Testing extensions installation

**Standard output**:

```text
================================================
Install extension: extension-1 using git.
================================================
INFO     The commands index does not exist ⌜/home/me/.local/share/valet/commands⌝.
Now silently building it using ⌜valet self build⌝ command.
INFO     The extension will be installed under ⌜/home/me/.valet.d/extension-1⌝.
INFO     Cloning the git repository ⌜https://github.com/jcaillon/valet.git⌝ in ⌜/home/me/.valet.d/extension-1⌝.
INFO     Checking out the reference ⌜extension-1⌝.
INFO     The extension ⌜extension-1⌝ version ⌜46dcbbf⌝ has been downloaded in ⌜/home/me/.valet.d/extension-1⌝.
INFO     No ⌜extension.setup.sh⌝ script found in the extension directory ⌜/home/me/.valet.d/extension-1⌝.
SUCCESS  The extension ⌜extension-1⌝ version ⌜46dcbbf⌝ has been successfully installed.
INFO     Rebuilding the command cache.
INFO     The commands index does not exist ⌜/home/me/.local/share/valet/commands⌝.
Now silently building it using ⌜valet self build⌝ command.
INFO     Rebuilding the documentation.
INFO     Generating documentation for all the functions.
INFO     Found XXX functions with documentation.
INFO     The documentation has been generated in ⌜/home/me/.valet.d/lib-valet.md⌝.
INFO     The prototype script has been generated in ⌜/home/me/.valet.d/lib-valet⌝.
INFO     The vscode snippets have been generated in ⌜/home/me/.valet.d/valet.code-snippets⌝.
INFO     Found XX commands with documentation.
INFO     The commands documentation has been generated in ⌜/home/me/.valet.d/valet-commands.md⌝.
SUCCESS  The extension ⌜extension-1⌝ version ⌜46dcbbf⌝ is ready to be used.

================================================
> ls /home/me/.valet.d
extension-1
lib-valet
lib-valet.md
valet.code-snippets
valet-commands.md
46dcbbf :sparkles: update valet 0.33

================================================
Update extension: extension-1 using git (already updated).
================================================
INFO     The extension extension-1 is already up-to-date.
SUCCESS  Updated 0 extensions:

Extension name[0m │ Previous version[0m │ New version[0m │ Setup status          [0m
───────────────┼──────────────────┼─────────────┼───────────────────────
extension-1    │ 46dcbbf         [0m │ 46dcbbf     │ Already up-to-date[0m
HEAD is now at 07cda5f :sparkles: updated for valet 0.30

================================================
Update extension: extension-1 using git.
================================================
   ╭─────────────────────────────────────────────────────────────────────────────╮[0m
░──┤[0m A new version is available for the extension extension-1: 07cda5f..46dcbbf. [82G│[0m
   │[0m Do you want to update the ⌜extension-1⌝ extension? [82G│[0m
   ╰─────────────────────────────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l [7m   (Y)ES   [0m      (N)O   [0m[1G[0K[9G╭──────╮[0m
[9G│[0m Yes. [16G├──░[0m
[9G╰──────╯[0m
SUCCESS  The extension extension-1 has been updated 07cda5f..46dcbbf.
SUCCESS  Updated 1 extensions:

Extension name[0m │ Previous version[0m │ New version[0m │ Setup status[0m
───────────────┼──────────────────┼─────────────┼─────────────
extension-1    │ 07cda5f         [0m │ 46dcbbf     │ Updated[0m
```

