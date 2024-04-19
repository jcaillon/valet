# Test suite 1102-self-build

## Test script 01.self-build

### Testing selfbuild

Exit code: `0`

**Standard** output:

```plaintext
CMD_ALL_COMMANDS=$'self\nhelp\nself build\nself config\nself download-binaries\nself mock1\nself mock2\nself mock3\nself release\nself setup\nself test\nself update'
CMD_ALL_COMMANDS_ARRAY='help'
CMD_ALL_FUNCTIONS=$'this\nshowCommandHelp\nselfBuild\nselfConfig\nselfDownloadBinaries\nselfUpdate\nselfMock1\nselfMock2\nselfMock3\nselfRelease\nselfSetup\nselfTest'
CMD_ALL_FUNCTIONS_ARRAY='this'
CMD_ALL_MENU_COMMANDS_ARRAY='self'
CMD_ARGS_LAST_IS_ARRAY_selfConfig='false'
CMD_ARGS_LAST_IS_ARRAY_selfMock1='false'
CMD_ARGS_LAST_IS_ARRAY_selfMock2='true'
CMD_ARGS_LAST_IS_ARRAY_showCommandHelp='true'
CMD_ARGS_LAST_IS_ARRAY_this='true'
CMD_ARGS_NAME_selfMock1='action'
CMD_ARGS_NAME_selfMock2='firstArg'
CMD_ARGS_NAME_showCommandHelp='commands'
CMD_ARGS_NAME_this='commands'
CMD_ARGS_NB_OPTIONAL_selfMock1='0'
CMD_ARGS_NB_OPTIONAL_selfMock2='0'
CMD_ARGS_NB_OPTIONAL_showCommandHelp='1'
CMD_ARGS_NB_OPTIONAL_this='1'
CMD_ARGUMENTS_DESCRIPTION_selfMock1=$'The action to perform.\nOne of the following options:\n\n- error\n- fail\n- exit\n- unknown-command\n- create-temp-files\n- logging-level\n- wait-indefinitely\n- show-help\n'
CMD_ARGUMENTS_DESCRIPTION_selfMock2='First argument.'
CMD_ARGUMENTS_DESCRIPTION_showCommandHelp=$'The name of the command to show the help for.\nIf not provided, show the help for the program.'
CMD_ARGUMENTS_DESCRIPTION_this=$'The command or sub commands to execute.\nSee the commands section for more information.'
CMD_ARGUMENTS_NAME_selfMock1='action'
CMD_ARGUMENTS_NAME_selfMock2='firstArg'
CMD_ARGUMENTS_NAME_showCommandHelp='commands?...'
CMD_ARGUMENTS_NAME_this='commands?...'
CMD_COMMANDS_DESCRIPTION_this='Show the help this program or of a specific command.'
CMD_COMMANDS_MENU_BODY=$'help                  \tShow the help this program or of a specific command.\nself build            \tRe-build the menu of valet from your commands.\nself test             \tTest your valet custom commands.\nself update           \tUpdate valet using the latest release on GitHub.'
CMD_COMMANDS_NAME_this='help'
CMD_COMMAND_selfBuild='self build'
CMD_COMMAND_selfConfig='self config'
CMD_COMMAND_selfDownloadBinaries='self download-binaries'
CMD_COMMAND_selfMock1='self mock1'
CMD_COMMAND_selfMock2='self mock2'
CMD_COMMAND_selfMock3='self mock3'
CMD_COMMAND_selfRelease='self release'
CMD_COMMAND_selfSetup='self setup'
CMD_COMMAND_selfTest='self test'
CMD_COMMAND_selfUpdate='self update'
CMD_COMMAND_showCommandHelp='help'
CMD_COMMAND_this=''
CMD_DESCRIPTION__menu='Show a menu with sub commands for the current command.'
CMD_DESCRIPTION_selfBuild=$'This command can be used to re-build the menu / help / options / arguments in case you have modified, added or removed a Valet command definition.\n\nPlease check https://github.com/jcaillon/valet/blob/main/docs/create-new-command.md or check the examples in examples.d directory to learn how to create and modified your commands.\n\nThis scripts:\n  - Makes a list of all the elligible files in which we could find command definitions.\n  - For each file in this list, extract the command definitions.\n  - Build your commands file (in your valet user directory) from these definitions.\n\nYou can call this script directly in case calling valet self build is broken:\n\n ./valet.d/commands.d.sh'
CMD_DESCRIPTION_selfConfig=$'Open the configuration file of Valet with your default editor.\n\nThis allows you to set advanced options for Valet.'
CMD_DESCRIPTION_selfDownloadBinaries=$'Download the required binaries for valet: fzf.\n\nThese binaries will be stored in the bin directory of valet and used in priority over the binaries in your PATH.'
CMD_DESCRIPTION_selfMock1='A command that only for testing valet core functions.'
CMD_DESCRIPTION_selfMock2=$'An example of description.\n\nYou can put any text here, it will be wrapped to fit the terminal width.\n\nYou can highlight some text as well.'
CMD_DESCRIPTION_selfMock3=$'Before starting this command, valet will check if sudo is available.\n\nIf so, it will require the user to enter the sudo password and use sudo inside the command\n'
CMD_DESCRIPTION_selfRelease=$'Release a new version of valet.\n\nIt will:\n- creates a git tag and pushes it to the remote repository,\n- bump the version of valet,\n- commit the new version.'
CMD_DESCRIPTION_selfSetup=$'The command run after the installation of Valet to setup the tool.\n\nAdjust the Valet configuration according to the user environment.\nLet the user know what to do next.\n'
CMD_DESCRIPTION_selfTest='Test your valet custom commands using approval tests approach.'
CMD_DESCRIPTION_selfUpdate=$'Update valet using the latest release on GitHub.\n'
CMD_DESCRIPTION_showCommandHelp=$'Show the help this program or of the help of a specific command.\n\nYou can show the help with or without colors and set the maximum columns for the help text.'
CMD_DESCRIPTION_this=$'Valet helps you browse, understand and execute your custom bash commands.\n\nOnline documentation is available at https://github.com/jcaillon/valet.\n\nYou can call valet without any commands to start an interactive session.\n\nExit codes:\n\n- 0: everything went well\n- 1+: an error occured\n\nCreate your own commands:\n\nYou can create your own commands and have them available in valet, please check https://github.com/jcaillon/valet/blob/main/docs/create-new-command.md or the examples under examples.d to do so.\nValet looks for commands in the valet user directory, which default to ~/.valet.d and can be overwritten using an environment variable (see below).\nOnce you have created your new command script, run the valet self build command to update the valet menu.\n\nConfiguration through environment variables:\n\nIn addition to the environment variables defined for each options, you can define environment variables to configure valet.\n\nThese variables are conviently defined in the valet user config file, located by default at ~/.config/valet/config (the path to this file can be configured using the VALET_CONFIG_FILE environment variable).\n\nYou can run valet self config to open the configuration file with your default editor (the file will get created if it does not yet exist).\n\nDeveloper notes:\n\nYou can enable debug mode with profiling for valet by setting the environment variable VALET_CONFIG_STARTUP_PROFILING to true (it will output to ~/profile_valet.txt).'
CMD_EXAMPLES_DESCRIPTION_selfMock2=$'Call command1 with option1, option2 and some arguments.\n'
CMD_EXAMPLES_DESCRIPTION_showCommandHelp='Shows the help for the command cmd'
CMD_EXAMPLES_DESCRIPTION_this='Displays this help text.'
CMD_EXAMPLES_NAME_selfMock2='self mock2 -o -2 value1 arg1 more1 more2'
CMD_EXAMPLES_NAME_showCommandHelp='help cmd'
CMD_EXAMPLES_NAME_this='--help'
CMD_FILETOSOURCE_selfBuild='valet.d/commands.d/self-build.sh'
CMD_FILETOSOURCE_selfConfig='valet.d/commands.d/self-config.sh'
CMD_FILETOSOURCE_selfDownloadBinaries='valet.d/commands.d/self-download-binaries.sh'
CMD_FILETOSOURCE_selfMock1='valet.d/commands.d/self-mock.sh'
CMD_FILETOSOURCE_selfMock2='valet.d/commands.d/self-mock.sh'
CMD_FILETOSOURCE_selfMock3='valet.d/commands.d/self-mock.sh'
CMD_FILETOSOURCE_selfRelease='valet.d/commands.d/self-release.sh'
CMD_FILETOSOURCE_selfSetup='valet.d/commands.d/self-setup.sh'
CMD_FILETOSOURCE_selfTest='valet.d/commands.d/self-test.sh'
CMD_FILETOSOURCE_selfUpdate='valet.d/commands.d/self-install.sh'
CMD_FILETOSOURCE_showCommandHelp='valet.d/commands.d/help.sh'
CMD_FILETOSOURCE_this='valet'
CMD_FUNCTION_NAME_='this'
CMD_FUNCTION_NAME_help='showCommandHelp'
CMD_FUNCTION_NAME_self='_menu'
CMD_FUNCTION_NAME_self_build='selfBuild'
CMD_FUNCTION_NAME_self_config='selfConfig'
CMD_FUNCTION_NAME_self_download_binaries='selfDownloadBinaries'
CMD_FUNCTION_NAME_self_mock1='selfMock1'
CMD_FUNCTION_NAME_self_mock2='selfMock2'
CMD_FUNCTION_NAME_self_mock3='selfMock3'
CMD_FUNCTION_NAME_self_release='selfRelease'
CMD_FUNCTION_NAME_self_setup='selfSetup'
CMD_FUNCTION_NAME_self_test='selfTest'
CMD_FUNCTION_NAME_self_update='selfUpdate'
CMD_HIDEINMENU_selfConfig='true'
CMD_HIDEINMENU_selfDownloadBinaries='true'
CMD_HIDEINMENU_selfMock1='true'
CMD_HIDEINMENU_selfMock2='true'
CMD_HIDEINMENU_selfMock3='true'
CMD_HIDEINMENU_selfRelease='true'
CMD_HIDEINMENU_selfSetup='true'
CMD_MAX_COMMAND_WIDTH='22'
CMD_MAX_SUB_COMMAND_LEVEL='1'
CMD_OPTIONS_DESCRIPTION__menu='Display the help for this command.'
CMD_OPTIONS_DESCRIPTION_selfBuild=$'Specify the directory in which to look for your command scripts.\n\nThis defaults to the path defined in the environment variable VALET_USER_DIRECTORY=\\my/path\\ or to ~/.valet.d.\n\nCan be empty to only build the core commands.\nThis option can be set by exporting the variable VALET_USER_DIRECTORY=\'<path>\'.'
CMD_OPTIONS_DESCRIPTION_selfConfig=$'Create the configuration file if it does not exist but do not open it.\nThis option can be set by exporting the variable VALET_NO_EDIT=\'true\'.'
CMD_OPTIONS_DESCRIPTION_selfDownloadBinaries=$'By default, this command will download the binaries for your current OS.\n\nYou can force the download for a specific OS by providing the name of the OS.\n\nPossible values are: linux, windows, macos.\nThis option can be set by exporting the variable VALET_FORCE_OS=\'<name>\'.'
CMD_OPTIONS_DESCRIPTION_selfMock1='Display the help for this command.'
CMD_OPTIONS_DESCRIPTION_selfMock2='First option.'
CMD_OPTIONS_DESCRIPTION_selfMock3='Display the help for this command.'
CMD_OPTIONS_DESCRIPTION_selfRelease=$'The token necessary to create the release on GitHub and upload artifacts.\nThis option can be set by exporting the variable VALET_GITHUB_RELEASE_TOKEN=\'<token>\'.'
CMD_OPTIONS_DESCRIPTION_selfSetup='Display the help for this command.'
CMD_OPTIONS_DESCRIPTION_selfTest=$'The path to your valet directory.\n\nEach sub directory named .tests.d will be considered as a test directory containing a test.sh file.\nThis option can be set by exporting the variable VALET_USER_DIRECTORY=\'<path>\'.'
CMD_OPTIONS_DESCRIPTION_selfUpdate='Display the help for this command.'
CMD_OPTIONS_DESCRIPTION_showCommandHelp=$'Do not use any colors in the output\nThis option can be set by exporting the variable VALET_NO_COLORS=\'true\'.'
CMD_OPTIONS_DESCRIPTION_this=$'Turn on profiling (with debug mode) before running the required command.\nIt will output to ~/profile_valet_cmd.txt.\nThis is useful to debug your command and understand what takes a long time to execute.\nThe profiler log will be cleanup to only keep lines relevant for your command script. You can disable this behavior by setting the environment variable VALET_CONFIG_KEEP_ALL_PROFILER_LINES to true.\nThis option can be set by exporting the variable VALET_PROFILING=\'true\'.'
CMD_OPTIONS_NAME__menu='-h, --help'
CMD_OPTIONS_NAME_selfBuild='-d, --user-directory <path>'
CMD_OPTIONS_NAME_selfConfig='--no-edit'
CMD_OPTIONS_NAME_selfDownloadBinaries='-s, --force-os <name>'
CMD_OPTIONS_NAME_selfMock1='-h, --help'
CMD_OPTIONS_NAME_selfMock2='-o, --option1'
CMD_OPTIONS_NAME_selfMock3='-h, --help'
CMD_OPTIONS_NAME_selfRelease='-t, --github-release-token <token>'
CMD_OPTIONS_NAME_selfSetup='-h, --help'
CMD_OPTIONS_NAME_selfTest='-d, --user-directory <path>'
CMD_OPTIONS_NAME_selfUpdate='-h, --help'
CMD_OPTIONS_NAME_showCommandHelp='-n, --no-colors'
CMD_OPTIONS_NAME_this='-x, --profiling'
CMD_OPTS_HAS_VALUE_selfBuild='true'
CMD_OPTS_HAS_VALUE_selfConfig='false'
CMD_OPTS_HAS_VALUE_selfDownloadBinaries='true'
CMD_OPTS_HAS_VALUE_selfMock1='false'
CMD_OPTS_HAS_VALUE_selfMock2='false'
CMD_OPTS_HAS_VALUE_selfMock3='false'
CMD_OPTS_HAS_VALUE_selfRelease='true'
CMD_OPTS_HAS_VALUE_selfSetup='false'
CMD_OPTS_HAS_VALUE_selfTest='true'
CMD_OPTS_HAS_VALUE_selfUpdate='false'
CMD_OPTS_HAS_VALUE_showCommandHelp='false'
CMD_OPTS_HAS_VALUE_this='false'
CMD_OPTS_NAME_SC_selfBuild='VALET_USER_DIRECTORY'
CMD_OPTS_NAME_SC_selfConfig='VALET_NO_EDIT'
CMD_OPTS_NAME_SC_selfDownloadBinaries='VALET_FORCE_OS'
CMD_OPTS_NAME_SC_selfMock1=''
CMD_OPTS_NAME_SC_selfMock2=''
CMD_OPTS_NAME_SC_selfMock3=''
CMD_OPTS_NAME_SC_selfRelease='VALET_GITHUB_RELEASE_TOKEN'
CMD_OPTS_NAME_SC_selfSetup=''
CMD_OPTS_NAME_SC_selfTest='VALET_USER_DIRECTORY'
CMD_OPTS_NAME_SC_selfUpdate=''
CMD_OPTS_NAME_SC_showCommandHelp='VALET_NO_COLORS'
CMD_OPTS_NAME_SC_this='VALET_PROFILING'
CMD_OPTS_NAME__menu='help'
CMD_OPTS_NAME_selfBuild='userDirectory'
CMD_OPTS_NAME_selfConfig='noEdit'
CMD_OPTS_NAME_selfDownloadBinaries='forceOs'
CMD_OPTS_NAME_selfMock1='help'
CMD_OPTS_NAME_selfMock2='option1'
CMD_OPTS_NAME_selfMock3='help'
CMD_OPTS_NAME_selfRelease='githubReleaseToken'
CMD_OPTS_NAME_selfSetup='help'
CMD_OPTS_NAME_selfTest='userDirectory'
CMD_OPTS_NAME_selfUpdate='help'
CMD_OPTS_NAME_showCommandHelp='noColors'
CMD_OPTS_NAME_this='profiling'
CMD_OPTS__menu='-h --help'
CMD_OPTS_selfBuild='-d --user-directory'
CMD_OPTS_selfConfig='--no-edit'
CMD_OPTS_selfDownloadBinaries='-s --force-os'
CMD_OPTS_selfMock1='-h --help'
CMD_OPTS_selfMock2='-o --option1'
CMD_OPTS_selfMock3='-h --help'
CMD_OPTS_selfRelease='-t --github-release-token'
CMD_OPTS_selfSetup='-h --help'
CMD_OPTS_selfTest='-d --user-directory'
CMD_OPTS_selfUpdate='-h --help'
CMD_OPTS_showCommandHelp='-n --no-colors'
CMD_OPTS_this='-x --profiling'
CMD_SHORT_DESCRIPTION_selfBuild='Re-build the menu of valet from your commands.'
CMD_SHORT_DESCRIPTION_selfConfig='Open the configuration file of Valet with your default editor.'
CMD_SHORT_DESCRIPTION_selfDownloadBinaries='Download the required binaries for valet.'
CMD_SHORT_DESCRIPTION_selfMock1='A command that only for testing valet core functions.'
CMD_SHORT_DESCRIPTION_selfMock2='A command that only for testing valet core functions.'
CMD_SHORT_DESCRIPTION_selfMock3='A command that only for testing valet core functions.'
CMD_SHORT_DESCRIPTION_selfRelease='Release a new version of valet.'
CMD_SHORT_DESCRIPTION_selfSetup='The command run after the installation of Valet to setup the tool.'
CMD_SHORT_DESCRIPTION_selfTest='Test your valet custom commands.'
CMD_SHORT_DESCRIPTION_selfUpdate='Update valet using the latest release on GitHub.'
CMD_SHORT_DESCRIPTION_showCommandHelp='Show the help this program or of a specific command.'
CMD_SHORT_DESCRIPTION_this='Your personal assistant in the terminal!'
CMD_SUDO_selfMock3='true'
```

**Error** output:

```log
INFO     Skipping user directory because it was empty.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/valet⌝.
INFO                              ├── ⌜⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/valet.d/commands.d/help.sh⌝.
INFO                              ├── ⌜help⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/valet.d/commands.d/self-build.sh⌝.
INFO                              ├── ⌜self build⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/valet.d/commands.d/self-config.sh⌝.
INFO                              ├── ⌜self config⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/valet.d/commands.d/self-download-binaries.sh⌝.
INFO                              ├── ⌜self download-binaries⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/valet.d/commands.d/self-install.sh⌝.
INFO                              ├── ⌜self update⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/valet.d/commands.d/self-mock.sh⌝.
INFO                              ├── ⌜self mock1⌝.
INFO                              ├── ⌜self mock2⌝.
INFO                              ├── ⌜self mock3⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/valet.d/commands.d/self-release.sh⌝.
INFO                              ├── ⌜self release⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/valet.d/commands.d/self-setup.sh⌝.
INFO                              ├── ⌜self setup⌝.
INFO     Extracting commands from ⌜$GLOBAL_VALET_HOME/valet.d/commands.d/self-test.sh⌝.
INFO                              ├── ⌜self test⌝.
INFO     == Summary of the commands ==

- Number of variables declared: ⌜183⌝.
- Number of functions: ⌜12⌝.
- Number of commands: ⌜11⌝.
- Maximum sub command level: ⌜1⌝.

== List of all the commands ==

help                  	Show the help this program or of a specific command.
self build            	Re-build the menu of valet from your commands.
self test             	Test your valet custom commands.
self update           	Update valet using the latest release on GitHub.

== List of all the hidden commands ==

self config           	Open the configuration file of Valet with your default editor.
self download-binaries	Download the required binaries for valet.
self mock1            	A command that only for testing valet core functions.
self mock2            	A command that only for testing valet core functions.
self mock3            	A command that only for testing valet core functions.
self release          	Release a new version of valet.
self setup            	The command run after the installation of Valet to setup the tool.

INFO     The command definition variables have been written to ⌜/tmp/valet.d/f501-0⌝.
SUCCESS  The valet user commands have been successfully built
```

