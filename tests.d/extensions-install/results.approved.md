# Test suite extensions-install

## Test script 01.extensions-install

### ✅ Testing extensions install command with no options

❯ `extensionsInstall https://git.ok/repo-version-with-setup.git`

**Error output**:

```text
INFO     The extension will be installed under ⌜/tmp/valet.d/d1-2/repo-version-with-setup⌝.
INFO     Cloning the git repository ⌜https://git.ok/repo-version-with-setup.git⌝ in ⌜/tmp/valet.d/d1-2/repo-version-with-setup⌝.
INFO     Checking out the reference ⌜latest⌝.
INFO     The extension ⌜repo-version-with-setup⌝ version ⌜1.0.0⌝ has been downloaded in ⌜/tmp/valet.d/d1-2/repo-version-with-setup⌝.
INFO     Found setup script for the extension repo-version-with-setup: ⌜/tmp/valet.d/d1-2/repo-version-with-setup/extension.setup.sh⌝.
   ╭──────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ The extension ⌜repo-version-with-setup⌝ comes with a setup script usually used to finalize the installation. 115│
   │ Make sure this script is safe to run before confirming this prompt. 115│
   │  115│
   │ Do you trust the setup script for the extension ⌜repo-version-with-setup⌝ and wish to execute it? 115│
   ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭──────╮
9│ Yes. 16├──░
9╰──────╯
INFO     Executing the setup script.
WARNING  This is a setup script!
SUCCESS  The setup script for the extension ⌜repo-version-with-setup⌝ has been executed successfully.
SUCCESS  The extension ⌜repo-version-with-setup⌝ version ⌜1.0.0⌝ has been successfully installed.
INFO     Rebuilding the command cache.
INFO     Called command::reloadCommandsIndex.
INFO     Rebuilding the documentation.
INFO     Called selfDocument.
SUCCESS  The extension ⌜repo-version-with-setup⌝ version ⌜1.0.0⌝ is ready to be used.
```

### ✅ Testing extensions install aborting because existing extension

❯ `extensionsInstall https://git.ok/repo-version-with-setup.git`

**Error output**:

```text
INFO     The extension will be installed under ⌜/tmp/valet.d/d1-2/repo-version-with-setup⌝.
WARNING  The extension ⌜repo-version-with-setup⌝ already exists in ⌜/tmp/valet.d/d1-2/repo-version-with-setup⌝.
   ╭─────────────────────────────────────────────────────────────────────────────────╮
░──┤ You are about to replace the existing extension, it will delete existing files. 86│
   │ Do you want to overwrite the existing ⌜repo-version-with-setup⌝ extension? 86│
   ╰─────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭─────╮
9│ No. 15├──░
9╰─────╯
INFO     The extension ⌜repo-version-with-setup⌝ will not be installed.
```

❯ `extensionsInstall https://git.ok/repo-version-with-setup.git --unattended`

**Error output**:

```text
INFO     The extension will be installed under ⌜/tmp/valet.d/d1-2/repo-version-with-setup⌝.
WARNING  The extension ⌜repo-version-with-setup⌝ already exists in ⌜/tmp/valet.d/d1-2/repo-version-with-setup⌝.
INFO     The extension ⌜repo-version-with-setup⌝ will not be installed.
```

### ✅ Testing extensions install error on clone

❯ `extensionsInstall https://git.ok/repo-error.git --unattended --name xxxx`

Exited with code: `1`

**Error output**:

```text
INFO     The extension will be installed under ⌜/tmp/valet.d/d1-2/xxxx⌝.
INFO     Cloning the git repository ⌜https://git.ok/repo-error.git⌝ in ⌜/tmp/valet.d/d1-2/xxxx⌝.
TRACE    Git had no standard output stream.
TRACE    Git standard error stream:
/tmp/valet.valet.d/saved-files/1987-05-25T01-00-00+0000--PID_001234--git-stderr
   1 ░ mocking git clone --no-checkout https://git.ok/repo-error.git /tmp/valet.d/d1-2/xxxx
   2 ░ targetDirectory: /tmp/valet.d/d1-2/xxxx
   3 ░ Simulating an error in git clone.
FAIL     The command git ended with exit code 1 in 7.000s.
```

### ✅ Testing extensions install error on checkout and unattended

❯ `extensionsInstall https://git.ok/repo-ok.git --unattended --name other --version error`

Exited with code: `1`

**Error output**:

```text
INFO     The extension will be installed under ⌜/tmp/valet.d/d1-2/other⌝.
INFO     Cloning the git repository ⌜https://git.ok/repo-ok.git⌝ in ⌜/tmp/valet.d/d1-2/other⌝.
FAIL     The reference ⌜error⌝ was not found in the repository ⌜https://git.ok/repo-ok.git⌝, please specify an existing reference using the ⌜--version⌝ option.
```

### ✅ Testing extensions install error on checkout and interactive

❯ `extensionsInstall https://git.ok/repo-ok.git --name other2 --version error`

Exited with code: `1`

**Error output**:

```text
INFO     The extension will be installed under ⌜/tmp/valet.d/d1-2/other2⌝.
INFO     Cloning the git repository ⌜https://git.ok/repo-ok.git⌝ in ⌜/tmp/valet.d/d1-2/other2⌝.
   ╭──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ The reference ⌜error⌝ was not found in the repository ⌜https://git.ok/repo-ok.git⌝, do you want to use the default reference ⌜main⌝ instead? 147│
   ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭─────╮
9│ No. 15├──░
9╰─────╯
FAIL     Installation aborted by the user due to missing reference.
```

### ✅ Testing extensions install error on checkout, interactive and then fail setup script

❯ `extensionsInstall https://git.ok/repo-fail-VERSION.git --name other2 --version error`

Exited with code: `1`

**Error output**:

```text
INFO     The extension will be installed under ⌜/tmp/valet.d/d1-2/other2⌝.
INFO     Cloning the git repository ⌜https://git.ok/repo-fail-VERSION.git⌝ in ⌜/tmp/valet.d/d1-2/other2⌝.
   ╭────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ The reference ⌜error⌝ was not found in the repository ⌜https://git.ok/repo-fail-VERSION.git⌝, do you want to use the default reference ⌜main⌝ instead? 157│
   ╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭──────╮
9│ Yes. 16├──░
9╰──────╯
INFO     Checking out the reference ⌜main⌝.
INFO     The extension ⌜other2⌝ version ⌜1.2.3⌝ has been downloaded in ⌜/tmp/valet.d/d1-2/other2⌝.
INFO     Found setup script for the extension other2: ⌜/tmp/valet.d/d1-2/other2/extension.setup.sh⌝.
   ╭─────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ The extension ⌜other2⌝ comes with a setup script usually used to finalize the installation. 98│
   │ Make sure this script is safe to run before confirming this prompt. 98│
   │  98│
   │ Do you trust the setup script for the extension ⌜other2⌝ and wish to execute it? 98│
   ╰─────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭──────╮
9│ Yes. 16├──░
9╰──────╯
INFO     Executing the setup script.
FAIL     Simulating a fail in the setup script.
ERROR    The extension setup script failed.
   ╭─────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ The setup script for the extension ⌜other2⌝ failed (see above), do you want to continue anyway? 102│
   ╰─────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭─────╮
9│ No. 15├──░
9╰─────╯
FAIL     The setup script for the extension ⌜other2⌝ failed, aborting installation.
```

### ✅ Testing extensions install fail setup script then accept

❯ `extensionsInstall https://git.ok/repo-fail.git`

**Error output**:

```text
INFO     The extension will be installed under ⌜/tmp/valet.d/d1-2/repo-fail⌝.
INFO     Cloning the git repository ⌜https://git.ok/repo-fail.git⌝ in ⌜/tmp/valet.d/d1-2/repo-fail⌝.
INFO     Checking out the reference ⌜latest⌝.
INFO     The extension ⌜repo-fail⌝ has been downloaded in ⌜/tmp/valet.d/d1-2/repo-fail⌝.
INFO     Found setup script for the extension repo-fail: ⌜/tmp/valet.d/d1-2/repo-fail/extension.setup.sh⌝.
   ╭────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ The extension ⌜repo-fail⌝ comes with a setup script usually used to finalize the installation. 101│
   │ Make sure this script is safe to run before confirming this prompt. 101│
   │  101│
   │ Do you trust the setup script for the extension ⌜repo-fail⌝ and wish to execute it? 101│
   ╰────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭──────╮
9│ Yes. 16├──░
9╰──────╯
INFO     Executing the setup script.
FAIL     Simulating a fail in the setup script.
ERROR    The extension setup script failed.
   ╭────────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ The setup script for the extension ⌜repo-fail⌝ failed (see above), do you want to continue anyway? 105│
   ╰────────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭──────╮
9│ Yes. 16├──░
9╰──────╯
INFO     You can manually retry the setup by running the script ⌜/tmp/valet.d/d1-2/repo-fail/extension.setup.sh⌝.
SUCCESS  The extension ⌜repo-fail⌝ has been successfully installed.
INFO     Rebuilding the command cache.
INFO     Called command::reloadCommandsIndex.
INFO     Rebuilding the documentation.
INFO     Called selfDocument.
SUCCESS  The extension ⌜repo-fail⌝ is ready to be used.
```

### ✅ Testing extensions install skipping setup

❯ `extensionsInstall https://git.ok/repo-setup-ok.git --skip-setup`

**Error output**:

```text
INFO     The extension will be installed under ⌜/tmp/valet.d/d1-2/repo-setup-ok⌝.
INFO     Cloning the git repository ⌜https://git.ok/repo-setup-ok.git⌝ in ⌜/tmp/valet.d/d1-2/repo-setup-ok⌝.
INFO     Checking out the reference ⌜latest⌝.
INFO     The extension ⌜repo-setup-ok⌝ has been downloaded in ⌜/tmp/valet.d/d1-2/repo-setup-ok⌝.
INFO     Skipping the execution of the ⌜extension.setup.sh⌝ script.
SUCCESS  The extension ⌜repo-setup-ok⌝ has been successfully installed.
INFO     Rebuilding the command cache.
INFO     Called command::reloadCommandsIndex.
INFO     Rebuilding the documentation.
INFO     Called selfDocument.
SUCCESS  The extension ⌜repo-setup-ok⌝ is ready to be used.
```

### ✅ Testing extensions install setup unattended

❯ `extensionsInstall https://git.ok/repo-setup-ok-unattended.git --unattended`

**Error output**:

```text
INFO     The extension will be installed under ⌜/tmp/valet.d/d1-2/repo-setup-ok-unattended⌝.
INFO     Cloning the git repository ⌜https://git.ok/repo-setup-ok-unattended.git⌝ in ⌜/tmp/valet.d/d1-2/repo-setup-ok-unattended⌝.
INFO     Checking out the reference ⌜latest⌝.
INFO     The extension ⌜repo-setup-ok-unattended⌝ has been downloaded in ⌜/tmp/valet.d/d1-2/repo-setup-ok-unattended⌝.
INFO     Found setup script for the extension repo-setup-ok-unattended: ⌜/tmp/valet.d/d1-2/repo-setup-ok-unattended/extension.setup.sh⌝.
INFO     Executing the setup script.
WARNING  This is a setup script!
SUCCESS  The setup script for the extension ⌜repo-setup-ok-unattended⌝ has been executed successfully.
SUCCESS  The extension ⌜repo-setup-ok-unattended⌝ has been successfully installed.
INFO     Rebuilding the command cache.
INFO     Called command::reloadCommandsIndex.
INFO     Rebuilding the documentation.
INFO     Called selfDocument.
SUCCESS  The extension ⌜repo-setup-ok-unattended⌝ is ready to be used.
```

