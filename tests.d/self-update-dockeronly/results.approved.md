# Test suite self-update-dockeronly

## Test script 01.self-update

### ✅ Testing valet update

**Standard output**:

```text
================================================
valet install
================================================

  Valet installation recap:

  - Version to install:           branch main
  - Download URL:                 https://github.com/jcaillon/valet/archive/main.tar.gz
  - Installation dir:             /home/me/.local/lib/valet

01:00:00 SUCCESS  Valet has been downloaded in ⌜/home/me/.local/lib/valet⌝.
01:00:00 SUCCESS  Valet version ⌜branch main⌝ has been installed in ⌜/home/me/.local/lib/valet⌝.
01:00:00 INFO     Running the self setup command.
INFO     The commands index does not exist ⌜/home/me/.local/share/valet/commands⌝.
Now silently building it using ⌜valet self build⌝ command.
INFO     Now setting up Valet.
INFO     Writing the valet config file ⌜/home/me/.config/valet/config⌝.
WARNING  Valet is not in your PATH yet. You need to add ⌜/home/me/.local/lib/valet⌝ to your PATH or call valet directly with ⌜/home/me/.local/lib/valet/valet⌝.

================================================

================================================
valet self update --unattended
================================================
INFO     The latest version of Valet found on GitHub is ⌜X.Y.Z⌝.
INFO     The install script will be fetched and executed from the url ⌜https://raw.githubusercontent.com/jcaillon/valet/main/install.sh⌝.
INFO     Running the install script...

  Valet installation recap:

  - Version to install:           branch main
  - Download URL:                 https://github.com/jcaillon/valet/archive/main.tar.gz
  - Installation dir:             /home/me/.local/lib/valet

01:00:00 SUCCESS  Valet has been downloaded in ⌜/home/me/.local/lib/valet⌝.
01:00:00 SUCCESS  Valet version ⌜branch main⌝ has been installed in ⌜/home/me/.local/lib/valet⌝.
01:00:00 WARNING  Skipping the valet self setup command as --skip-setup has been passed.
You can now run ⌜valet self setup⌝ manually to finish setting up valet.
Or add /home/me/.local/lib/valet to your PATH.
SUCCESS  Valet has been updated from version ⌜0.1.0⌝ to version ⌜X.Y.Z⌝.
The changelogs can be found here: https://github.com/jcaillon/valet/releases.
Self setup tests passed.
```

