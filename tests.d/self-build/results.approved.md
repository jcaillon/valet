# Test suite self-build

## Test script 01.self-build

### Testing self build

Exit code: `0`

**Error output**:

```text
INFO     Skipping the build of scripts in user directory (building core commands only).
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/valet⌝.
INFO                              ├── ⌜⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/commands.d/help.sh⌝.
INFO                              ├── ⌜help⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/commands.d/self-add-command.sh⌝.
INFO                              ├── ⌜self add-command⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/commands.d/self-add-library.sh⌝.
INFO                              ├── ⌜self add-library⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/commands.d/self-build.sh⌝.
INFO                              ├── ⌜self build⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/commands.d/self-config.sh⌝.
INFO                              ├── ⌜self config⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/commands.d/self-document.sh⌝.
INFO                              ├── ⌜self document⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/commands.d/self-export.sh⌝.
INFO                              ├── ⌜self export⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/commands.d/self-extend.sh⌝.
INFO                              ├── ⌜self extend⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/commands.d/self-install.sh⌝.
INFO                              ├── ⌜self update⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/commands.d/self-mock.sh⌝.
INFO                              ├── ⌜self mock1⌝.
INFO                              ├── ⌜self mock2⌝.
INFO                              ├── ⌜self mock3⌝.
INFO                              ├── ⌜self mock4⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/commands.d/self-release.sh⌝.
INFO                              ├── ⌜self release⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/commands.d/self-setup.sh⌝.
INFO                              ├── ⌜self setup⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/commands.d/self-test.sh⌝.
INFO                              ├── ⌜self test⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/commands.d/self-uninstall.sh⌝.
INFO                              ├── ⌜self uninstall⌝.
INFO     == Summary of the commands ==

- Number of variables declared: ⌜307⌝.
- Number of functions: ⌜18⌝.
- Number of commands: ⌜17⌝.
- Number of user library directories found: ⌜0⌝.
- Maximum sub command level: ⌜1⌝.

== List of all the hidden commands ==

self export         Returns a string that can be evaluated to have Valet functions in bash.
self mock1          A command that only for testing valet core functions.
self mock2          A command that only for testing valet core functions.
self mock3          A command that only for testing valet core functions.
self mock4          A command that only for testing valet core functions.
self release        Release a new version of valet.
self setup          The command run after the installation of Valet to setup the tool.
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

INFO     The command definition variables have been written to ⌜/tmp/valet.d/f1-2⌝.
SUCCESS  The valet user commands have been successfully built.
```

