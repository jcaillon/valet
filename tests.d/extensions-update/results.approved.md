# Test suite extensions-update

## Test script 00.extensions-update

### ✅ Testing extensions update no extensions

❯ `extensionsUpdate`

**Error output**:

```text
INFO     You do not have any extensions created or installed yet.
```

### ✅ Testing extensions update

❯ `extensionsUpdate`

**Error output**:

```text
INFO     The extension extension-already-up-to-date is already up-to-date.
WARNING  The extension extension-detached-head with repository /tmp/valet.d/d1-2/extension-detached-head has a detached HEAD, could not update it (please check out a branch first).
TRACE    Git had no standard output stream.
TRACE    Git standard error stream:
/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--git-stderr
   1 ░ mocking git -C /tmp/valet.d/d1-2/extension-error-fetch fetch -q
   2 ░ could not fetch!
WARNING  The command git ended with exit code 1 in 1.000s.
Failed to fetch for the repo ⌜/tmp/valet.d/d1-2/extension-error-fetch⌝.
   ╭─────────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ A new version is available for the extension extension-to-update-with-fail-setup: old1234..new1234. 106│
   │ Do you want to update the ⌜extension-to-update-with-fail-setup⌝ extension? 106│
   ╰─────────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭──────╮
9│ Yes. 16├──░
9╰──────╯
SUCCESS  The extension extension-to-update-with-fail-setup has been updated old1234..new1234.
INFO     Found setup script for the extension extension-to-update-with-fail-setup: ⌜/tmp/valet.d/d1-2/extension-to-update-with-fail-setup/extension.setup.sh⌝.
   ╭──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ The extension ⌜extension-to-update-with-fail-setup⌝ comes with a setup script usually used to finalize the installation. 127│
   │ Make sure this script is safe to run before confirming this prompt. 127│
   │  127│
   │ Do you trust the setup script for the extension ⌜extension-to-update-with-fail-setup⌝ and wish to execute it? 127│
   ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭──────╮
9│ Yes. 16├──░
9╰──────╯
INFO     Executing the setup script.
FAIL     Simulating a fail in the setup script.
ERROR    The setup script for the extension ⌜extension-to-update-with-fail-setup⌝ failed.
INFO     You can manually retry the setup by running the script ⌜/tmp/valet.d/d1-2/extension-to-update-with-fail-setup/extension.setup.sh⌝.
   ╭───────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ A new version is available for the extension extension-to-update-with-ok-setup: old1234..new1234. 104│
   │ Do you want to update the ⌜extension-to-update-with-ok-setup⌝ extension? 104│
   ╰───────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭──────╮
9│ Yes. 16├──░
9╰──────╯
SUCCESS  The extension extension-to-update-with-ok-setup has been updated old1234..new1234.
INFO     Found setup script for the extension extension-to-update-with-ok-setup: ⌜/tmp/valet.d/d1-2/extension-to-update-with-ok-setup/extension.setup.sh⌝.
   ╭────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ The extension ⌜extension-to-update-with-ok-setup⌝ comes with a setup script usually used to finalize the installation. 125│
   │ Make sure this script is safe to run before confirming this prompt. 125│
   │  125│
   │ Do you trust the setup script for the extension ⌜extension-to-update-with-ok-setup⌝ and wish to execute it? 125│
   ╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭──────╮
9│ Yes. 16├──░
9╰──────╯
INFO     Executing the setup script.
WARNING  This is a setup script!
SUCCESS  The setup script for the extension ⌜extension-to-update-with-ok-setup⌝ (version 2.1.0) has been executed successfully.
   ╭─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ A new version is available for the extension extension-to-update-with-ok-setup-but-skipped-setup: old1234..new1234. 122│
   │ Do you want to update the ⌜extension-to-update-with-ok-setup-but-skipped-setup⌝ extension? 122│
   ╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭──────╮
9│ Yes. 16├──░
9╰──────╯
SUCCESS  The extension extension-to-update-with-ok-setup-but-skipped-setup has been updated old1234..new1234.
INFO     Found setup script for the extension extension-to-update-with-ok-setup-but-skipped-setup: ⌜/tmp/valet.d/d1-2/extension-to-update-with-ok-setup-but-skipped-setup/extension.setup.sh⌝.
   ╭──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ The extension ⌜extension-to-update-with-ok-setup-but-skipped-setup⌝ comes with a setup script usually used to finalize the installation. 143│
   │ Make sure this script is safe to run before confirming this prompt. 143│
   │  143│
   │ Do you trust the setup script for the extension ⌜extension-to-update-with-ok-setup-but-skipped-setup⌝ and wish to execute it? 143│
   ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭─────╮
9│ No. 15├──░
9╰─────╯
INFO     The setup script for the extension ⌜extension-to-update-with-ok-setup-but-skipped-setup⌝ was not trusted, skipping the setup.
   ╭──────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ A new version is available for the extension extension-to-update-wo-setup: old1234..new1234. 99│
   │ Do you want to update the ⌜extension-to-update-wo-setup⌝ extension? 99│
   ╰──────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭──────╮
9│ Yes. 16├──░
9╰──────╯
SUCCESS  The extension extension-to-update-wo-setup has been updated old1234..new1234.
   ╭──────────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ A new version is available for the extension extension-to-update-wo-setup-skipped: old1234..new1234. 107│
   │ Do you want to update the ⌜extension-to-update-wo-setup-skipped⌝ extension? 107│
   ╰──────────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭─────╮
9│ No. 15├──░
9╰─────╯
INFO     The extension ⌜extension-to-update-wo-setup-skipped⌝ will not be updated.
INFO     Rebuilding the command cache.
INFO     The commands index does not exist ⌜/tmp/valet.valet.d/commands⌝.
Now silently building it using ⌜valet self build⌝ command.
SUCCESS  Updated 4 extensions:

Extension name                                      │ Previous version │ New version │ Setup status                
────────────────────────────────────────────────────┼──────────────────┼─────────────┼─────────────────────────────
extension-already-up-to-date                        │ old1234          │ old1234     │ Already up-to-date
extension-detached-head                             │ old1234          │ -           │ Update errors
extension-error-fetch                               │ old1234          │ -           │ Update errors
extension-not-updatable                             │ -                │ -           │ Can't update, not a git repo
extension-to-update-with-fail-setup                 │ 1.0.0            │ 1.1.0       │ Updated with setup errors
extension-to-update-with-ok-setup                   │ 2.0.0            │ 2.1.0       │ Updated and setup
extension-to-update-with-ok-setup-but-skipped-setup │ old1234          │ 2.1.0       │ Updated but not setup
extension-to-update-wo-setup                        │ old1234          │ old1234     │ Updated
extension-to-update-wo-setup-skipped                │ old1234          │ old1234     │ Update skipped
```

### ✅ Testing extensions unattended update

❯ `extensionsUpdate -n extension-to-update-with-ok-setup --unattended --skip-setup`

**Error output**:

```text
SUCCESS  The extension extension-to-update-with-ok-setup has been updated old1234..new1234.
INFO     Skipping the execution of the ⌜extension.setup.sh⌝ script.
INFO     Rebuilding the command cache.
INFO     The commands index does not exist ⌜/tmp/valet.valet.d/commands⌝.
Now silently building it using ⌜valet self build⌝ command.
SUCCESS  Updated 1 extensions:

Extension name                    │ Previous version │ New version │ Setup status     
──────────────────────────────────┼──────────────────┼─────────────┼──────────────────
extension-to-update-with-ok-setup │ 2.1.0            │ 2.1.0       │ Updated and setup
```

