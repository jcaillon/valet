# Test suite self-update

## Test script 01.self-update

### ✅ Testing self update command

Already updated

❯ `selfUpdate --unattended`

**Error output**:

```text
🙈 mocked curl::request https://api.github.com/repos/jcaillon/valet/releases/latest --- failOnError=true
INFO     The latest version of Valet found on GitHub is ⌜1.2.3⌝.
INFO     The current local version ⌜2.2.3⌝ is higher or equal to the distant version ⌜1.2.3⌝.
SUCCESS  You already have the latest version.
```

Cancel update

❯ `selfUpdate`

**Error output**:

```text
🙈 mocked curl::request https://api.github.com/repos/jcaillon/valet/releases/latest --- failOnError=true
INFO     The latest version of Valet found on GitHub is ⌜1.2.3⌝.
INFO     The install script will be fetched and executed from the url ⌜https://raw.githubusercontent.com/jcaillon/valet/v1.2.3/install.sh⌝.
   ╭─────────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ A new version of Valet is available. Do you want to update from version ⌜0.2.3⌝ to version ⌜1.2.3⌝? 106│
   ╰─────────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭─────╮
9│ No. 15├──░
9╰─────╯
INFO     Update cancelled by the user.
```

Do update

❯ `selfUpdate`

**Error output**:

```text
🙈 mocked curl::request https://api.github.com/repos/jcaillon/valet/releases/latest --- failOnError=true
INFO     The latest version of Valet found on GitHub is ⌜1.2.3⌝.
INFO     The install script will be fetched and executed from the url ⌜https://raw.githubusercontent.com/jcaillon/valet/v1.2.3/install.sh⌝.
   ╭─────────────────────────────────────────────────────────────────────────────────────────────────────╮
░──┤ A new version of Valet is available. Do you want to update from version ⌜0.2.3⌝ to version ⌜1.2.3⌝? 106│
   ╰─────────────────────────────────────────────────────────────────────────────────────────────────────╯

1    (Y)ES         (N)O   19╭──────╮
9│ Yes. 16├──░
9╰──────╯
🙈 mocked curl::download https://raw.githubusercontent.com/jcaillon/valet/v1.2.3/install.sh --- failOnError=true
INFO     Running the install script...
This is a fake install script for testing purposes.
SUCCESS  Valet has been updated from version ⌜0.2.3⌝ to version ⌜1.2.3⌝.
The changelogs can be found here: https://github.com/jcaillon/valet/releases.
```

Unattended update

❯ `selfUpdate --unattended`

**Error output**:

```text
🙈 mocked curl::request https://api.github.com/repos/jcaillon/valet/releases/latest --- failOnError=true
INFO     The latest version of Valet found on GitHub is ⌜1.2.3⌝.
INFO     The install script will be fetched and executed from the url ⌜https://raw.githubusercontent.com/jcaillon/valet/v1.2.3/install.sh⌝.
🙈 mocked curl::download https://raw.githubusercontent.com/jcaillon/valet/v1.2.3/install.sh --- failOnError=true
INFO     Running the install script...
This is a fake install script for testing purposes.
SUCCESS  Valet has been updated from version ⌜0.2.3⌝ to version ⌜1.2.3⌝.
The changelogs can be found here: https://github.com/jcaillon/valet/releases.
```

Should fail because we are in a git repository

❯ `selfUpdate`

Exited with code: `1`

**Error output**:

```text
🙈 mocked curl::request https://api.github.com/repos/jcaillon/valet/releases/latest --- failOnError=true
INFO     The latest version of Valet found on GitHub is ⌜1.2.3⌝.
FAIL     Valet has been installed using git, so it cannot be updated using this command. Please update it manually by running ⌜git -C $GLOBAL_INSTALLATION_DIRECTORY fetch && git -C $GLOBAL_INSTALLATION_DIRECTORY checkout 1.2.3⌝.
```

