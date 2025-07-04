# Test suite self-build

## Test script 01.self-build

### ✅ Testing self-build script

❯ `$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-build.sh --output /tmp/valet.d/d1-2 --core-only`

**Error output**:

```text
INFO     Added the test commands to the build.
INFO     Skipping the build of scripts in user directory (building core commands only).
INFO     Extracting commands from ⌜valet⌝.
INFO                              ├── ⌜⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/help.sh⌝.
INFO                              ├── ⌜help⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-add-command.sh⌝.
INFO                              ├── ⌜self add-command⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-add-library.sh⌝.
INFO                              ├── ⌜self add-library⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-build.sh⌝.
INFO                              ├── ⌜self build⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-config.sh⌝.
INFO                              ├── ⌜self config⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-document.sh⌝.
INFO                              ├── ⌜self document⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-extend.sh⌝.
INFO                              ├── ⌜self extend⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-install.sh⌝.
INFO                              ├── ⌜self update⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-release.sh⌝.
INFO                              ├── ⌜self release⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-setup.sh⌝.
INFO                              ├── ⌜self setup⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-source.sh⌝.
INFO                              ├── ⌜self source⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-test.sh⌝.
INFO                              ├── ⌜self test⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-uninstall.sh⌝.
INFO                              ├── ⌜self uninstall⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/.commands.d/self-mock.sh⌝.
INFO                              ├── ⌜self mock1⌝.
INFO                              ├── ⌜self mock2⌝.
INFO                              ├── ⌜self mock3⌝.
INFO     == Summary of the commands ==

- Number of variables declared: ⌜289⌝.
- Number of functions: ⌜17⌝.
- Number of commands: ⌜16⌝.
- Number of user library directories found: ⌜0⌝.
- Maximum sub command level: ⌜1⌝.

== List of all the hidden commands ==

self mock1          A command that only for testing valet core functions.
self mock2          A command that only for testing valet core functions.
self mock3          A command that only for testing valet core functions.
self release        Release a new version of valet.
self setup          The command run after the installation of Valet to setup the tool.
self source         Returns a string that can be evaluated to source Valet functions in bash.
self uninstall      A command to uninstall Valet.

== List of all the commands ==

help                Show the help of this program or of a specific command.
self add-command    Add a new command to the current extension.
self add-library    Add a new library to the current extension.
self build          Index all the commands and libraries present in the valet user directory and installation directory.
self config         Open the configuration file of Valet with your default editor.
self document       Generate the documentation and code snippets for all the library functions of Valet.
self extend         Extends Valet by creating or downloading a new extension in the user directory.
self test           Test your valet custom commands.
self update         Update valet and its extensions to the latest releases.

INFO     The command definition variables have been written to ⌜/tmp/valet.d/d1-2/commands⌝.
SUCCESS  The valet user commands have been successfully built.
```

