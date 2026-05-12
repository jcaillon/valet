# Test suite self-build

## Test script 01.self-build

### ✅ Testing self-build script

❯ `$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-build.sh --extensions-directory $GLOBAL_INSTALLATION_DIRECTORY/no-directory --extra-extension-directories $GLOBAL_INSTALLATION_DIRECTORY/tests.d/.mock-extension --output /tmp/valet.d/d1-2`

**Error output**:

```text
INFO     Looking for commands and libraries in ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/.mock-extension⌝.
INFO     Extracting commands from ⌜valet⌝.
INFO                              ├── ⌜⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/bash-bootstrap.sh⌝.
INFO                              ├── ⌜bash bootstrap⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/bash-links.sh⌝.
INFO                              ├── ⌜bash links⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/extensions-add-command.sh⌝.
INFO                              ├── ⌜extensions add-command⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/extensions-add-library.sh⌝.
INFO                              ├── ⌜extensions add-library⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/extensions-create.sh⌝.
INFO                              ├── ⌜extensions create⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/extensions-init.sh⌝.
INFO                              ├── ⌜extensions init⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/extensions-install.sh⌝.
INFO                              ├── ⌜extensions install⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/extensions-list.sh⌝.
INFO                              ├── ⌜extensions list⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/extensions-update.sh⌝.
INFO                              ├── ⌜extensions update⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/help.sh⌝.
INFO                              ├── ⌜help⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-build.sh⌝.
INFO                              ├── ⌜self build⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-config.sh⌝.
INFO                              ├── ⌜self config⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-document.sh⌝.
INFO                              ├── ⌜self document⌝.
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
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-update.sh⌝.
INFO                              ├── ⌜self update⌝.
INFO     Extracting commands from ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/.mock-extension/commands.d/self-mock.sh⌝.
INFO                              ├── ⌜self mock1⌝.
INFO                              ├── ⌜self mock2⌝.
INFO                              ├── ⌜self mock3⌝.
INFO     == Summary of the commands ==

- Number of variables declared: ⌜382⌝.
- Number of functions: ⌜23⌝.
- Number of commands: ⌜22⌝.
- Number of user library directories found: ⌜0⌝.
- Maximum sub command level: ⌜1⌝.

== List of all the hidden commands ==

bash bootstrap            Returns a string that can be evaluated to bootstrap your bash session.
bash links                Create symbolic links as defined in the links definition directory.
self mock1                A command that only for testing valet core functions.
self mock2                A command that only for testing valet core functions.
self mock3                A command that only for testing valet core functions.
self release              Release a new version of valet.
self setup                The command run after the installation of Valet to setup the tool.
self source               Returns a string that can be evaluated to source Valet functions in bash.
self uninstall            A command to uninstall Valet.

== List of all the commands ==

extensions add-command    Add a new command to the current extension.
extensions add-library    Add a new library to the current extension.
extensions create         Create a new Valet extension.
extensions init           Initialize/setup the current directory as a Valet extension.
extensions install        Download and install an extension in the user extensions directory using GIT.
extensions list           List all Valet extensions.
extensions update         Update Valet extensions.
help                      Show the help of this program or of a specific command.
self build                Index all the commands and libraries present in the valet extensions directory and installation directory.
self config               Open the configuration file of Valet with your default editor.
self document             Generate the documentation and code snippets for all the library functions of Valet.
self test                 Test your valet custom commands.
self update               Update valet to the latest release.

INFO     The command definition variables have been written to ⌜/tmp/valet.d/d1-2/commands⌝.
SUCCESS  The valet user commands have been successfully built.
```

