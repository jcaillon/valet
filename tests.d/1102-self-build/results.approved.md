# Test suite 1102-self-build

## Test script 01.self-build

### Testing selfbuild

Exit code: `0`

**Standard** output:

```plaintext
CMD_ALL_COMMANDS=$'self\nhelp\nself add-command\nself add-library\nself build\nself config\nself document\nself export\nself extend\nself mock1\nself mock2\nself mock3\nself mock4\nself release\nself setup\nself test\nself uninstall\nself update'
CMD_ALL_COMMANDS_ARRAY=0 "help" 1 "self add-command" 2 "self add-library" 3 "self build" 4 "self config" 5 "self document" 6 "self export" 7 "self extend" 8 "self mock1" 9 "self mock2" 10 "self mock3" 11 "self mock4" 12 "self release" 13 "self setup" 14 "self test" 15 "self uninstall" 16 "self update"
CMD_ALL_COMMAND_SELECTION_ITEMS_ARRAY=0 "help                Show the help of this program or of a specific command." 1 "self add-command    Add a new command to the current extension." 2 "self add-library    Add a new library to the current extension." 3 "self build          Index all the commands and libraries present in the valet user directory and installation directory." 4 "self config         Open the configuration file of Valet with your default editor." 5 "self document       Generate the documentation and code snippets for all the library functions of Valet." 6 "self extend         Extends Valet by creating or downloading a new extension in the user directory." 7 "self test           Test your valet custom commands." 8 "self update         Update valet and its extensions to the latest releases."
CMD_ALL_FUNCTIONS=$'this\nshowCommandHelp\nselfAddCommand\nselfAddLibrary\nselfBuild\nselfConfig\nselfDocument\nselfExport\nselfExtend\nselfUpdate\nselfMock1\nselfMock2\nselfMock3\nselfMock4\nselfRelease\nselfSetup\nselfTest\nselfUninstall'
CMD_ALL_FUNCTIONS_ARRAY=0 "this" 1 "showCommandHelp" 2 "selfAddCommand" 3 "selfAddLibrary" 4 "selfBuild" 5 "selfConfig" 6 "selfDocument" 7 "selfExport" 8 "selfExtend" 9 "selfUpdate" 10 "selfMock1" 11 "selfMock2" 12 "selfMock3" 13 "selfMock4" 14 "selfRelease" 15 "selfSetup" 16 "selfTest" 17 "selfUninstall"
CMD_ALL_MENU_COMMANDS_ARRAY=0 "self"
CMD_ARGS_LAST_IS_ARRAY_selfAddCommand='false'
CMD_ARGS_LAST_IS_ARRAY_selfAddLibrary='false'
CMD_ARGS_LAST_IS_ARRAY_selfExtend='false'
CMD_ARGS_LAST_IS_ARRAY_selfMock1='false'
CMD_ARGS_LAST_IS_ARRAY_selfMock2='true'
CMD_ARGS_LAST_IS_ARRAY_selfMock4='false'
CMD_ARGS_LAST_IS_ARRAY_showCommandHelp='true'
CMD_ARGS_LAST_IS_ARRAY_this='true'
CMD_ARGS_NAME_selfAddCommand=0 "commandName"
CMD_ARGS_NAME_selfAddLibrary=0 "libraryName"
CMD_ARGS_NAME_selfExtend=0 "extensionUri"
CMD_ARGS_NAME_selfMock1=0 "action"
CMD_ARGS_NAME_selfMock2=0 "firstArg" 1 "more"
CMD_ARGS_NAME_selfMock4=0 "firstArg" 1 "secondArg"
CMD_ARGS_NAME_showCommandHelp=0 "commands"
CMD_ARGS_NAME_this=0 "commands"
CMD_ARGS_NB_OPTIONAL_selfAddCommand='0'
CMD_ARGS_NB_OPTIONAL_selfAddLibrary='0'
CMD_ARGS_NB_OPTIONAL_selfExtend='0'
CMD_ARGS_NB_OPTIONAL_selfMock1='0'
CMD_ARGS_NB_OPTIONAL_selfMock2='0'
CMD_ARGS_NB_OPTIONAL_selfMock4='0'
CMD_ARGS_NB_OPTIONAL_showCommandHelp='1'
CMD_ARGS_NB_OPTIONAL_this='1'
CMD_ARGUMENTS_DESCRIPTION_selfAddCommand=0 "The name of the command to create."
CMD_ARGUMENTS_DESCRIPTION_selfAddLibrary=0 "The name of the library to create."
CMD_ARGUMENTS_DESCRIPTION_selfExtend=0 $'The URI of the extension to install or create.\n\n1. If you want to create a new extension, this argument should be the name of your\n   new extension (e.g. `my-new-extension`).\n2. If you want to setup an existing directory as an extension, this argument should be `.`.\n3. If you want to download an extension, this argument should be the URL of the repository.\n   Usually a GitHub or GitLab repository URL such as `https://github.com/jcaillon/valet-devops-toolbox.git`.\n\n> If the repository is private, you can pass the URL with the username and password like this:\n> `https://username:password@my.gitlab.private/group/project.git`.'
CMD_ARGUMENTS_DESCRIPTION_selfMock1=0 $'The action to perform.\nOne of the following options:\n\n- error\n- fail\n- fail2\n- exit\n- unknown-command\n- create-temp-files\n- logging-level\n- wait-indefinitely\n- show-help\n- print-raw-and-file\n'
CMD_ARGUMENTS_DESCRIPTION_selfMock2=0 "First argument." 1 "Will be an an array of strings."
CMD_ARGUMENTS_DESCRIPTION_selfMock4=0 "First argument." 1 $'Second argument.\n'
CMD_ARGUMENTS_DESCRIPTION_showCommandHelp=0 $'The name of the command to show the help for.\nIf not provided, show the help for the program.'
CMD_ARGUMENTS_DESCRIPTION_this=0 $'The command or sub commands to execute.\nSee the commands section for more information.'
CMD_ARGUMENTS_NAME_selfAddCommand=0 "commandName"
CMD_ARGUMENTS_NAME_selfAddLibrary=0 "libraryName"
CMD_ARGUMENTS_NAME_selfExtend=0 "extensionUri"
CMD_ARGUMENTS_NAME_selfMock1=0 "action"
CMD_ARGUMENTS_NAME_selfMock2=0 "firstArg" 1 "more..."
CMD_ARGUMENTS_NAME_selfMock4=0 "firstArg" 1 "secondArg"
CMD_ARGUMENTS_NAME_showCommandHelp=0 "commands?..."
CMD_ARGUMENTS_NAME_this=0 "commands?..."
CMD_COMMANDS_DESCRIPTION_this=0 "Show the help of this program or of a specific command." 1 "Add a new command to the current extension." 2 "Add a new library to the current extension." 3 "Index all the commands and libraries present in the valet user directory and installation directory." 4 "Open the configuration file of Valet with your default editor." 5 "Generate the documentation and code snippets for all the library functions of Valet." 6 "Returns a string that can be evaluated to have Valet functions in bash." 7 "Extends Valet by creating or downloading a new extension in the user directory." 8 "A command that only for testing valet core functions." 9 "A command that only for testing valet core functions." 10 "A command that only for testing valet core functions." 11 "A command that only for testing valet core functions." 12 "Release a new version of valet." 13 "The command run after the installation of Valet to setup the tool." 14 "Test your valet custom commands." 15 "A command to uninstall Valet." 16 "Update valet and its extensions to the latest releases."
CMD_COMMANDS_NAME_this=0 "help" 1 "self add-command" 2 "self add-library" 3 "self build" 4 "self config" 5 "self document" 6 "self export" 7 "self extend" 8 "self mock1" 9 "self mock2" 10 "self mock3" 11 "self mock4" 12 "self release" 13 "self setup" 14 "self test" 15 "self uninstall" 16 "self update"
CMD_COMMAND_selfAddCommand='self add-command'
CMD_COMMAND_selfAddLibrary='self add-library'
CMD_COMMAND_selfBuild='self build'
CMD_COMMAND_selfConfig='self config'
CMD_COMMAND_selfDocument='self document'
CMD_COMMAND_selfExport='self export'
CMD_COMMAND_selfExtend='self extend'
CMD_COMMAND_selfMock1='self mock1'
CMD_COMMAND_selfMock2='self mock2'
CMD_COMMAND_selfMock3='self mock3'
CMD_COMMAND_selfMock4='self mock4'
CMD_COMMAND_selfRelease='self release'
CMD_COMMAND_selfSetup='self setup'
CMD_COMMAND_selfTest='self test'
CMD_COMMAND_selfUninstall='self uninstall'
CMD_COMMAND_selfUpdate='self update'
CMD_COMMAND_showCommandHelp='help'
CMD_COMMAND_this=''
CMD_DESCRIPTION__menu='Show a menu with sub commands for the current command.'
CMD_DESCRIPTION_selfAddCommand=$'Call this function in an extension directory to add a new command to the extension.\n\nThis will create a file from a command template in the commands.d directory.'
CMD_DESCRIPTION_selfAddLibrary=$'Call this function in an extension directory to add a new library to the extension.\n\nThis will create a file from a library template in the libraries.d directory.'
CMD_DESCRIPTION_selfBuild=$'Index all the command and libraries present in the valet user directory and installation directory.\n\nThis command can be used to re-build the menu / help / options / arguments in case you have modified, added or removed a Valet command definition.\n\nPlease check https://jcaillon.github.io/valet/docs/new-commands/ or check the examples in examples.d directory to learn how to create and modified your commands.\n\nThis scripts:\n\n- Makes a list of all the eligible files in which we could find command definitions.\n- For each file in this list, extract the command definitions.\n- Build your commands file (in your valet user directory) from these definitions.\n- Makes a list of all `libraries.d` directories found in the user directory.\n\nYou can call this script directly in case calling valet self build is broken:\n\n commands.d/self-build.sh'
CMD_DESCRIPTION_selfConfig=$'Open the configuration file of Valet with your default editor.\n\nThis allows you to set advanced options for Valet.'
CMD_DESCRIPTION_selfDocument=$'Generate the documentation and code snippets for all the library functions of Valet.\n\nIt will parse all the library files and generate:\n\n- A markdown file with the documentation.\n- A bash file with the prototype of each function.\n- A vscode snippet file for each function.'
CMD_DESCRIPTION_selfExport=$'If you want to use Valet functions directly in bash, you can use this command like this:\n\n```bash\neval "$(valet self export)"\n```\n\nThis will export all the necessary functions and variables to use the Valet log library by default.\n\nYou can optionally export all the functions if needed.'
CMD_DESCRIPTION_selfExtend=$'Extends Valet by creating or downloading a new extension in the user directory.\nExtensions can add new commands or functions to Valet.\n\nThis command will either:\n\n- Create and setup a new extension directory under the valet user directory,\n- setup an existing directory as a valet extension,\n- or download the given extension (repository) and install it in the Valet user directory.\n\nFor downloaded extensions, all GIT repositories are supported.\nFor the specific cases of GitHub and GitLab repositories, this command will:\n\n1. If git is installed, clone the repository for the given reference (version option).\n2. If git is not installed, download source tarball for the given reference and extract it.\n\nFor downloaded extensions, if a `extension.setup.sh` script is present in the repository root directory,\nit will be executed. This gives the extension the opportunity to setup itself.\n\nOnce an extension is installed, you can use the `valet self update` command to update it.'
CMD_DESCRIPTION_selfMock1='A command that only for testing valet core functions.'
CMD_DESCRIPTION_selfMock2=$'An example of description.\n\nYou can put any text here, it will be wrapped to fit the terminal width.\n\nYou can highlight some text as well.'
CMD_DESCRIPTION_selfMock3=$'Before starting this command, valet will check if sudo is available.\n\nIf so, it will require the user to enter the sudo password and use sudo inside the command\n'
CMD_DESCRIPTION_selfMock4='An example of description.'
CMD_DESCRIPTION_selfRelease=$'Release a new version of valet.\n\nIt will:\n- write the current version in the self-install script,\n- commit the file,\n- update the documentation,\n- commit the changes,\n- creates a git tag and pushes it to the remote repository,\n- bump the version of valet,\n- commit the new version.'
CMD_DESCRIPTION_selfSetup=$'The command run after the installation of Valet to setup the tool.\n\nAdjust the Valet configuration according to the user environment.\nLet the user know what to do next.\n'
CMD_DESCRIPTION_selfTest='Test your valet custom commands using approval tests approach.'
CMD_DESCRIPTION_selfUninstall=$'Generate a bash script that can be used to uninstall Valet.\nWithout any option, this script will print instructions instead.\n\nUsage:\n\n```bash\neval "$(valet self uninstall --script)"\n```'
CMD_DESCRIPTION_selfUpdate=$'Update valet using the latest release on GitHub. Also update all installed extensions.\n\nThis script can also be used as a standalone script to install Valet:\n\nbash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/commands.d/self-install.sh)"\n\nIf you need to pass options (e.g. --single-user-installation) to the script, you can do it like this:\n\nbash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/commands.d/self-install.sh)" -s --single-user-installation\n\nThe default behavior is to install Valet for all users, in /opt/valet, which might require\nyou to type your password on sudo commands (you don\'t have to run this script with sudo, it will\nask for your password when needed).\n\nThis script will:\n\n- 1. Download the given release from GitHub (latest by default).\n\n- 2. Copy it in the Valet home directory, which defaults to:\n  - /opt/valet in case of a multi user installation\n  - ~/.local/valet otherwise\n\n- 3. Make the valet script readable and executable, either by adding a shim\n     in a bin directory already present in your PATH, or by adding the Valet\n     directory to your PATH on shell startup.\n\n- 4. Copy the examples in the valet user directory ~/.valet.d.\n\n- 6. Run self setup command (in case of a new installation) or re-export the config.\n\n- 7. Try to update (fetch merge --ff-only) the git repositories and all\n     installed extensions in your valet user directory.\n'
CMD_DESCRIPTION_showCommandHelp=$'Show the help of this program or of the help of a specific command.\n\nYou can show the help with or without colors and set the maximum columns for the help text.'
CMD_DESCRIPTION_this=$'Valet helps you browse, understand and execute your custom bash commands.\n\nOnline documentation is available at https://jcaillon.github.io/valet/.\n\nYou can call valet without any commands to start an interactive session.\n\nExit codes:\n\n- 0: everything went well\n- 1+: an error occurred\n\nCreate your own commands:\n\nYou can create your own commands and have them available in valet, please check https://jcaillon.github.io/valet/docs/new-commands/ or the examples under examples.d to do so.\nValet looks for commands in the valet user directory, which default to ~/.valet.d and can be overwritten using an environment variable (see below).\nOnce you have created your new command script, run the valet self build command to update the valet menu.\n\nConfiguration through environment variables:\n\nIn addition to the environment variables defined for each options, you can define environment variables to configure valet.\n\nThese variables are contently defined in the valet user config file, located by default at ~/.config/valet/config (the path to this file can be configured using the VALET_CONFIG_FILE environment variable).\n\nYou can run valet self config to open the configuration file with your default editor (the file will get created if it does not yet exist).\n\nDeveloper notes:\n\nYou can enable debug mode with profiling for valet by setting the environment variable VALET_CONFIG_STARTUP_PROFILING to true (it will output to ~/valet-profiler-{PID}.txt).'
CMD_EXAMPLES_DESCRIPTION_selfAddCommand=0 $'Create a new command named my-command in the current extension under the commands.d directory.\n'
CMD_EXAMPLES_DESCRIPTION_selfAddLibrary=0 $'Create a new library named my-library in the current extension under the libraries.d directory.\n'
CMD_EXAMPLES_DESCRIPTION_selfBuild=0 "Build the valet user commands." 1 $'Build the valet user commands from the directory ⌜~/my-valet-directory⌝ and with minimal log output.\n'
CMD_EXAMPLES_DESCRIPTION_selfConfig=0 "Open the configuration file of Valet with your default editor." 1 $'Create (or recreate) the configuration file of Valet reusing the possible current values of the variables.\n'
CMD_EXAMPLES_DESCRIPTION_selfDocument=0 $'Generate the documentation for all the library functions of Valet and output to the default directory.\n'
CMD_EXAMPLES_DESCRIPTION_selfExport=0 $'Export all the functions defined in the Valet libraries.\nThen can then be used directly in your bash scripts or from the bash prompt.\n'
CMD_EXAMPLES_DESCRIPTION_selfExtend=0 "Create a new extension named my-new-extension in the user directory." 1 "Setup the current directory as an extension in the user directory." 2 "Download the latest version of the valet-devops-toolbox application and install it for Valet." 3 $'Download the ⌜extension-1⌝ reference of the valet repository and install it as ⌜extension-1⌝ for Valet.\nSkip the execution of the `extension.setup.sh` script.\n(This is actually a fake extension for testing purposes).\n'
CMD_EXAMPLES_DESCRIPTION_selfMock2=0 $'Call command1 with option1, option2 and some arguments.\n'
CMD_EXAMPLES_DESCRIPTION_selfTest=0 "Run all the tests found in the valet user directory." 1 "Run all the tests found in the valet user directory and automatically approve the results." 2 $'Run only the test suites that match the regex pattern ⌜(my-thing|my-stuff)⌝.\n'
CMD_EXAMPLES_DESCRIPTION_selfUpdate=0 "Update Valet to the latest version." 1 "Install the latest version of Valet, using all the default options." 2 $'Install the latest version of Valet in the user home directory and disable all interaction during the install process.\n'
CMD_EXAMPLES_DESCRIPTION_showCommandHelp=0 "Shows the help for the command cmd" 1 "Shows the help for the sub command ⌜subCmd⌝ of the command ⌜cmd⌝" 2 $'Shows the help for the program without any color and with a maximum of 50 columns\n'
CMD_EXAMPLES_DESCRIPTION_this=0 "Displays this help text." 1 $'Active ⌜verbose⌝ mode and run the command ⌜a-command⌝ with the sub command ⌜and-sub-command⌝.\n'
CMD_EXAMPLES_NAME_selfAddCommand=0 "valet self add-command my-command"
CMD_EXAMPLES_NAME_selfAddLibrary=0 "valet self add-library my-library"
CMD_EXAMPLES_NAME_selfBuild=0 "valet self build" 1 "valet self build -d ~/my-valet-directory --silent"
CMD_EXAMPLES_NAME_selfConfig=0 "valet self config" 1 "valet self config --no-edit --override --export-current-values"
CMD_EXAMPLES_NAME_selfDocument=0 "valet self document"
CMD_EXAMPLES_NAME_selfExport=0 "eval \"\$(valet self export -a)\""
CMD_EXAMPLES_NAME_selfExtend=0 "valet self extend my-new-extension" 1 "valet self extend ." 2 "valet self extend https://github.com/jcaillon/valet-devops-toolbox.git" 3 "valet self extend https://github.com/jcaillon/valet --version extension-1 --name extension-1 --skip-setup"
CMD_EXAMPLES_NAME_selfMock2=0 "valet self mock2 -o -2 value1 arg1 more1 more2"
CMD_EXAMPLES_NAME_selfTest=0 "valet self test" 1 "valet self test -a" 2 "valet self test -i '(my-thing|my-stuff)'"
CMD_EXAMPLES_NAME_selfUpdate=0 "valet self update" 1 "bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/commands.d/self-install.sh)\"" 2 "bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/commands.d/self-install.sh)\" -s --single-user-installation --unattended"
CMD_EXAMPLES_NAME_showCommandHelp=0 "valet help cmd" 1 "valet help cmd subCmd" 2 "valet help --no-colors --columns 50"
CMD_EXAMPLES_NAME_this=0 "valet --help" 1 "valet -v a-command and-sub-command"
CMD_FILETOSOURCE_selfAddCommand='commands.d/self-add-command.sh'
CMD_FILETOSOURCE_selfAddLibrary='commands.d/self-add-library.sh'
CMD_FILETOSOURCE_selfBuild='commands.d/self-build.sh'
CMD_FILETOSOURCE_selfConfig='commands.d/self-config.sh'
CMD_FILETOSOURCE_selfDocument='commands.d/self-document.sh'
CMD_FILETOSOURCE_selfExport='commands.d/self-export.sh'
CMD_FILETOSOURCE_selfExtend='commands.d/self-extend.sh'
CMD_FILETOSOURCE_selfMock1='commands.d/self-mock.sh'
CMD_FILETOSOURCE_selfMock2='commands.d/self-mock.sh'
CMD_FILETOSOURCE_selfMock3='commands.d/self-mock.sh'
CMD_FILETOSOURCE_selfMock4='commands.d/self-mock.sh'
CMD_FILETOSOURCE_selfRelease='commands.d/self-release.sh'
CMD_FILETOSOURCE_selfSetup='commands.d/self-setup.sh'
CMD_FILETOSOURCE_selfTest='commands.d/self-test.sh'
CMD_FILETOSOURCE_selfUninstall='commands.d/self-uninstall.sh'
CMD_FILETOSOURCE_selfUpdate='commands.d/self-install.sh'
CMD_FILETOSOURCE_showCommandHelp='commands.d/help.sh'
CMD_FILETOSOURCE_this='valet'
CMD_FUNCTION_NAME_='this'
CMD_FUNCTION_NAME_help='showCommandHelp'
CMD_FUNCTION_NAME_self='_menu'
CMD_FUNCTION_NAME_self_add_command='selfAddCommand'
CMD_FUNCTION_NAME_self_add_library='selfAddLibrary'
CMD_FUNCTION_NAME_self_build='selfBuild'
CMD_FUNCTION_NAME_self_config='selfConfig'
CMD_FUNCTION_NAME_self_document='selfDocument'
CMD_FUNCTION_NAME_self_export='selfExport'
CMD_FUNCTION_NAME_self_extend='selfExtend'
CMD_FUNCTION_NAME_self_mock1='selfMock1'
CMD_FUNCTION_NAME_self_mock2='selfMock2'
CMD_FUNCTION_NAME_self_mock3='selfMock3'
CMD_FUNCTION_NAME_self_mock4='selfMock4'
CMD_FUNCTION_NAME_self_release='selfRelease'
CMD_FUNCTION_NAME_self_setup='selfSetup'
CMD_FUNCTION_NAME_self_test='selfTest'
CMD_FUNCTION_NAME_self_uninstall='selfUninstall'
CMD_FUNCTION_NAME_self_update='selfUpdate'
CMD_HIDEINMENU_selfExport='true'
CMD_HIDEINMENU_selfMock1='true'
CMD_HIDEINMENU_selfMock2='true'
CMD_HIDEINMENU_selfMock3='true'
CMD_HIDEINMENU_selfMock4='true'
CMD_HIDEINMENU_selfRelease='true'
CMD_HIDEINMENU_selfSetup='true'
CMD_HIDEINMENU_selfUninstall='true'
CMD_MAX_COMMAND_WIDTH='16'
CMD_MAX_SUB_COMMAND_LEVEL='1'
CMD_OPTIONS_DESCRIPTION__menu='Display the help for this command.'
CMD_OPTIONS_DESCRIPTION_selfAddCommand=0 "Display the help for this command."
CMD_OPTIONS_DESCRIPTION_selfAddLibrary=0 "Display the help for this command."
CMD_OPTIONS_DESCRIPTION_selfBuild=0 $'Specify the directory in which to look for your command scripts.\nDefaults to the valet user directory.\nThis option can be set by exporting the variable VALET_USER_DIRECTORY=\'<path>\'.' 1 $'Build only the core commands (under commands.d).\nThis option can be set by exporting the variable VALET_CORE_ONLY=\'true\'.' 2 $'Specify the file path in which to write the command definition variables.\n\nThis defaults to the ⌜commands⌝ file in your Valet user directory.\nThis option can be set by exporting the variable VALET_OUTPUT=\'<path>\'.' 3 $'Do not write the command definition variables to a file.\n\nThis will just create the variables.\nThis option can be set by exporting the variable VALET_NO_OUTPUT=\'true\'.' 4 $'Build silently without any info logs.\nThis option can be set by exporting the variable VALET_SILENT=\'true\'.' 5 "Display the help for this command."
CMD_OPTIONS_DESCRIPTION_selfConfig=0 $'Create the configuration file if it does not exist but do not open it.\nThis option can be set by exporting the variable VALET_NO_EDIT=\'true\'.' 1 $'Override of the configuration file even if it already exists.\nUnless the option --export-current-values is used, the existing values will be reset.\nThis option can be set by exporting the variable VALET_OVERRIDE=\'true\'.' 2 $'When writing the configuration file, export the current values of the variables.\nThis option can be set by exporting the variable VALET_EXPORT_CURRENT_VALUES=\'true\'.' 3 "Display the help for this command."
CMD_OPTIONS_DESCRIPTION_selfDocument=0 $'The directory in which the documentation will be generated.\nDefaults to the valet user directory.\nThis option can be set by exporting the variable VALET_OUTPUT=\'<directory path>\'.' 1 $'Generate the documentation for the core functions only.\nWill not generate for libraries present in the valet user directory.\nThis option can be set by exporting the variable VALET_CORE_ONLY=\'true\'.' 2 "Display the help for this command."
CMD_OPTIONS_DESCRIPTION_selfExport=0 $'Export all the libraries.\nThis option can be set by exporting the variable VALET_EXPORT_ALL=\'true\'.' 1 $'Override the ⌜core::fail⌝ and ⌜core::failWithCode⌝ functions to not exit the script.\nThis option can be set by exporting the variable VALET_NO_EXIT=\'true\'.' 2 "Display the help for this command."
CMD_OPTIONS_DESCRIPTION_selfExtend=0 $'The version of the repository to download.\nUsually a tag or a branch name.\nThis option can be set by exporting the variable VALET_VERSION=\'<version>\'.' 1 $'The name to give to this extension.\nIf a name is not provided, the name of the repository will be used.\nThis option can be set by exporting the variable VALET_NAME=\'<extension-name>\'.' 2 $'Skip the execution of the `extension.setup.sh` script even if it exists.\nThis option can be set by exporting the variable VALET_SKIP_SETUP=\'true\'.' 3 "Display the help for this command."
CMD_OPTIONS_DESCRIPTION_selfMock1=0 "Display the help for this command."
CMD_OPTIONS_DESCRIPTION_selfMock2=0 "First option." 1 $'An option with a value.\nThis option can be set by exporting the variable VALET_THIS_IS_OPTION2=\'<level>\'.' 2 $'Third option.\nThis option can be set by exporting the variable VALET_FLAG3=\'true\'.' 3 $'An option with a default value.\nThis option can be set by exporting the variable VALET_WITH_DEFAULT=\'<val>\'.' 4 "Display the help for this command."
CMD_OPTIONS_DESCRIPTION_selfMock3=0 "Display the help for this command."
CMD_OPTIONS_DESCRIPTION_selfMock4=0 "Display the help for this command."
CMD_OPTIONS_DESCRIPTION_selfRelease=0 $'The token necessary to create the release on GitHub and upload artifacts.\nThis option can be set by exporting the variable VALET_GITHUB_RELEASE_TOKEN=\'<token>\'.' 1 $'The semver level to bump the version.\n\nCan be either: major or minor. Defaults to minor.\nThis option can be set by exporting the variable VALET_BUMP_LEVEL=\'<semver>\'.' 2 $'Do not perform the release, just show what would be done.\n\nThis option can be set by exporting the variable VALET_DRY_RUN=\'true\'.' 3 "Display the help for this command."
CMD_OPTIONS_DESCRIPTION_selfSetup=0 "Display the help for this command."
CMD_OPTIONS_DESCRIPTION_selfTest=0 $'The path to your valet directory.\n\nEach sub directory named .tests.d will be considered as a test directory containing a test.sh file.\nThis option can be set by exporting the variable VALET_USER_DIRECTORY=\'<path>\'.' 1 $'The received test result files will automatically be approved.\nThis option can be set by exporting the variable VALET_AUTO_APPROVE=\'true\'.' 2 $'Also test the valet core functions.\n\nThis is only if you modified valet core functions themselves.\nThis option can be set by exporting the variable VALET_WITH_CORE=\'true\'.' 3 $'Only test the valet core functions. Skips the tests for user commands.\nThis option can be set by exporting the variable VALET_CORE_ONLY=\'true\'.' 4 $'A regex pattern to include only the test suites that match the pattern.\n\nThe name of the test suite is given by the name of the directory containing the .sh test files.\n\nExample: --include \'(1|commands)\'\nThis option can be set by exporting the variable VALET_INCLUDE=\'<pattern>\'.' 5 $'A regex pattern to exclude all the test suites that match the pattern.\n\nThe name of the test suite is given by the name of the directory containing the .sh test files.\n\nExample: --exclude \'(1|commands)\'\nThis option can be set by exporting the variable VALET_EXCLUDE=\'<pattern>\'.' 6 $'Disable the default behavior of running the tests in parallel. Will run the tests sequentially.\nThis option can be set by exporting the variable VALET_NO_PARALLEL_TESTS=\'true\'.' 7 "Display the help for this command."
CMD_OPTIONS_DESCRIPTION_selfUninstall=0 $'Generate a bash script that can be evaluated in bash to uninstall Valet.\n\nThis option can be set by exporting the variable VALET_SCRIPT=\'true\'.' 1 "Display the help for this command."
CMD_OPTIONS_DESCRIPTION_selfUpdate=0 $'Set to true to not enter interactive mode for the setup (useful for automated installation).\nThis option can be set by exporting the variable VALET_UNATTENDED=\'true\'.' 1 $'Set to true to install Valet for the current user only.\n\nNote: for windows, the installation is always for the current user.\nThis option can be set by exporting the variable VALET_SINGLE_USER_INSTALLATION=\'true\'.' 2 $'The version number to install (do not including the starting \'v\').\n\nReleased versions can be found here: https://github.com/jcaillon/valet/releases\n\nThis option can be set by exporting the variable VALET_VERSION=\'<version>\'.' 3 $'The directory where Valet will be installed.\n\nDefaults to /opt/valet for a multi user installation and ~/.local/valet otherwise.\nThis option can be set by exporting the variable VALET_INSTALLATION_DIRECTORY=\'<path>\'.' 4 $'Set to true to not create the shim script in /usr/local/bin.\nThis option can be set by exporting the variable VALET_NO_SHIM=\'true\'.' 5 $'Set to true to not add the Valet directory to the PATH (append to your .bashrc file).\nThis option can be set by exporting the variable VALET_NO_PATH=\'true\'.' 6 $'Set to true to to not copy the examples (showcase) to the valet user directory (~/.valet.d).\n\nIf you do not set this option, newer examples will override the existing ones.\n\nIn case of an update, if the examples.d directory does not exist, the examples will not be copied.\nThis option can be set by exporting the variable VALET_NO_EXAMPLES=\'true\'.' 7 $'Set to true to not attempt to update the installed extensions under the valet user directory (~/.valet.d).\nThis option can be set by exporting the variable VALET_SKIP_EXTENSIONS=\'true\'.' 8 $'Set to true to only update the installed extensions under the valet user directory (~/.valet.d).\nThis option can be set by exporting the variable VALET_ONLY_EXTENSIONS=\'true\'.' 9 $'Set to true to skip the execution of extension setup scripts (if any, when updating extensions).\nThis option can be set by exporting the variable VALET_SKIP_EXTENSIONS_SETUP=\'true\'.' 10 $'Set to true to download Valet from a branch tarball instead of a release.\nIn that case, the version is the branch name.\nOnly works for new installations, not for updates.\nThis option can be set by exporting the variable VALET_USE_BRANCH=\'true\'.' 11 "Display the help for this command."
CMD_OPTIONS_DESCRIPTION_showCommandHelp=0 $'Do not use any colors in the output\nThis option can be set by exporting the variable VALET_NO_COLORS=\'true\'.' 1 $'Set the maximum columns for the help text\nThis option can be set by exporting the variable VALET_COLUMNS=\'<number>\'.' 2 "Display the help for this command."
CMD_OPTIONS_DESCRIPTION_this=0 $'Turn on profiling (with debug mode) before running the required command.\nIt will output to ~/valet-profiler-{PID}-command.txt.\nThis is useful to debug your command and understand what takes a long time to execute.\nThe profiler log will be cleanup to only keep lines relevant for your command script. You can disable this behavior by setting the environment variable VALET_CONFIG_KEEP_ALL_PROFILER_LINES to true.\nThis option can be set by exporting the variable VALET_PROFILING=\'true\'.' 1 $'Set the log level of valet (defaults to info).\nPossible values are: trace, debug, success, info, success, warning, error.\nThis option can be set by exporting the variable VALET_LOG_LEVEL,=\'<level>\'.' 2 $'Output verbose information.\nThis is the equivalent of setting the log level to debug.\nThis option can be set by exporting the variable VALET_VERBOSE=\'true\'.' 3 $'Output very verbose information.\nThis is the equivalent of setting the log level to trace.\nThis option can be set by exporting the variable VALET_VERY_VERBOSE=\'true\'.' 4 $'Disable all progress bars for commands that use them.\nThis option can be set by exporting the variable VALET_DISABLE_PROGRESS_BARS=\'true\'.' 5 $'Enter interactive mode for commands even if arguments are not required or provided.\nThis option can be set by exporting the variable VALET_FORCE_INTERACTIVE_MODE=\'true\'.' 6 "Display the current version of valet." 7 "Display the help for this command."
CMD_OPTIONS_NAME__menu='-h, --help'
CMD_OPTIONS_NAME_selfAddCommand=0 "-h, --help"
CMD_OPTIONS_NAME_selfAddLibrary=0 "-h, --help"
CMD_OPTIONS_NAME_selfBuild=0 "-d, --user-directory <path>" 1 "-C, --core-only" 2 "-o, --output <path>" 3 "-O, --no-output" 4 "-s, --silent" 5 "-h, --help"
CMD_OPTIONS_NAME_selfConfig=0 "--no-edit" 1 "--override" 2 "--export-current-values" 3 "-h, --help"
CMD_OPTIONS_NAME_selfDocument=0 "-o, --output <directory path>" 1 "-C, --core-only" 2 "-h, --help"
CMD_OPTIONS_NAME_selfExport=0 "-a, --export-all" 1 "-E, --no-exit" 2 "-h, --help"
CMD_OPTIONS_NAME_selfExtend=0 "-v, --version <version>" 1 "-n, --name <extension-name>" 2 "--skip-setup" 3 "-h, --help"
CMD_OPTIONS_NAME_selfMock1=0 "-h, --help"
CMD_OPTIONS_NAME_selfMock2=0 "-o, --option1" 1 "-2, --this-is-option2 <level>" 2 "-3, --flag3" 3 "-4, --with-default <val>" 4 "-h, --help"
CMD_OPTIONS_NAME_selfMock3=0 "-h, --help"
CMD_OPTIONS_NAME_selfMock4=0 "-h, --help"
CMD_OPTIONS_NAME_selfRelease=0 "-t, --github-release-token <token>" 1 "-b, --bump-level <semver>" 2 "--dry-run" 3 "-h, --help"
CMD_OPTIONS_NAME_selfSetup=0 "-h, --help"
CMD_OPTIONS_NAME_selfTest=0 "-d, --user-directory <path>" 1 "-a, --auto-approve" 2 "-c, --with-core" 3 "-C, --core-only" 4 "-i, --include <pattern>" 5 "-e, --exclude <pattern>" 6 "-P, --no-parallel-tests" 7 "-h, --help"
CMD_OPTIONS_NAME_selfUninstall=0 "-s, --script" 1 "-h, --help"
CMD_OPTIONS_NAME_selfUpdate=0 "-u, --unattended" 1 "-s, --single-user-installation" 2 "-v, --version <version>" 3 "-d, --installation-directory <path>" 4 "-S, --no-shim" 5 "-P, --no-path" 6 "-E, --no-examples" 7 "-U, --skip-extensions" 8 "-e, --only-extensions" 9 "--skip-extensions-setup" 10 "-b, --use-branch" 11 "-h, --help"
CMD_OPTIONS_NAME_showCommandHelp=0 "-n, --no-colors" 1 "-c, --columns <number>" 2 "-h, --help"
CMD_OPTIONS_NAME_this=0 "-x, --profiling" 1 "-l, --log-level, --log <level>" 2 "-v, --verbose" 3 "-w, --very-verbose" 4 "--disable-progress-bars" 5 "-i, --force-interactive-mode" 6 "--version" 7 "-h, --help"
CMD_OPTS_DEFAULT_selfAddCommand=0 ""
CMD_OPTS_DEFAULT_selfAddLibrary=0 ""
CMD_OPTS_DEFAULT_selfBuild=0 "" 1 "" 2 "" 3 "" 4 "" 5 ""
CMD_OPTS_DEFAULT_selfConfig=0 "" 1 "" 2 "" 3 ""
CMD_OPTS_DEFAULT_selfDocument=0 "" 1 "" 2 ""
CMD_OPTS_DEFAULT_selfExport=0 "" 1 "" 2 ""
CMD_OPTS_DEFAULT_selfExtend=0 "latest" 1 "" 2 "" 3 ""
CMD_OPTS_DEFAULT_selfMock1=0 ""
CMD_OPTS_DEFAULT_selfMock2=0 "" 1 "" 2 "" 3 "cool" 4 ""
CMD_OPTS_DEFAULT_selfMock3=0 ""
CMD_OPTS_DEFAULT_selfMock4=0 ""
CMD_OPTS_DEFAULT_selfRelease=0 "" 1 "" 2 "" 3 ""
CMD_OPTS_DEFAULT_selfSetup=0 ""
CMD_OPTS_DEFAULT_selfTest=0 "" 1 "" 2 "" 3 "" 4 "" 5 "" 6 "" 7 ""
CMD_OPTS_DEFAULT_selfUninstall=0 "" 1 ""
CMD_OPTS_DEFAULT_selfUpdate=0 "false" 1 "false" 2 "latest" 3 "" 4 "false" 5 "false" 6 "false" 7 "false" 8 "false" 9 "false" 10 "false" 11 ""
CMD_OPTS_DEFAULT_showCommandHelp=0 "" 1 "" 2 ""
CMD_OPTS_DEFAULT_this=0 "" 1 "" 2 "" 3 "" 4 "" 5 "" 6 "" 7 ""
CMD_OPTS_HAS_VALUE_selfAddCommand=0 "false"
CMD_OPTS_HAS_VALUE_selfAddLibrary=0 "false"
CMD_OPTS_HAS_VALUE_selfBuild=0 "true" 1 "false" 2 "true" 3 "false" 4 "false" 5 "false"
CMD_OPTS_HAS_VALUE_selfConfig=0 "false" 1 "false" 2 "false" 3 "false"
CMD_OPTS_HAS_VALUE_selfDocument=0 "true" 1 "false" 2 "false"
CMD_OPTS_HAS_VALUE_selfExport=0 "false" 1 "false" 2 "false"
CMD_OPTS_HAS_VALUE_selfExtend=0 "true" 1 "true" 2 "false" 3 "false"
CMD_OPTS_HAS_VALUE_selfMock1=0 "false"
CMD_OPTS_HAS_VALUE_selfMock2=0 "false" 1 "true" 2 "false" 3 "true" 4 "false"
CMD_OPTS_HAS_VALUE_selfMock3=0 "false"
CMD_OPTS_HAS_VALUE_selfMock4=0 "false"
CMD_OPTS_HAS_VALUE_selfRelease=0 "true" 1 "true" 2 "false" 3 "false"
CMD_OPTS_HAS_VALUE_selfSetup=0 "false"
CMD_OPTS_HAS_VALUE_selfTest=0 "true" 1 "false" 2 "false" 3 "false" 4 "true" 5 "true" 6 "false" 7 "false"
CMD_OPTS_HAS_VALUE_selfUninstall=0 "false" 1 "false"
CMD_OPTS_HAS_VALUE_selfUpdate=0 "false" 1 "false" 2 "true" 3 "true" 4 "false" 5 "false" 6 "false" 7 "false" 8 "false" 9 "false" 10 "false" 11 "false"
CMD_OPTS_HAS_VALUE_showCommandHelp=0 "false" 1 "true" 2 "false"
CMD_OPTS_HAS_VALUE_this=0 "false" 1 "true" 2 "false" 3 "false" 4 "false" 5 "false" 6 "false" 7 "false"
CMD_OPTS_NAME_SC_selfAddCommand=0 ""
CMD_OPTS_NAME_SC_selfAddLibrary=0 ""
CMD_OPTS_NAME_SC_selfBuild=0 "VALET_USER_DIRECTORY" 1 "VALET_CORE_ONLY" 2 "VALET_OUTPUT" 3 "VALET_NO_OUTPUT" 4 "VALET_SILENT" 5 ""
CMD_OPTS_NAME_SC_selfConfig=0 "VALET_NO_EDIT" 1 "VALET_OVERRIDE" 2 "VALET_EXPORT_CURRENT_VALUES" 3 ""
CMD_OPTS_NAME_SC_selfDocument=0 "VALET_OUTPUT" 1 "VALET_CORE_ONLY" 2 ""
CMD_OPTS_NAME_SC_selfExport=0 "VALET_EXPORT_ALL" 1 "VALET_NO_EXIT" 2 ""
CMD_OPTS_NAME_SC_selfExtend=0 "VALET_VERSION" 1 "VALET_NAME" 2 "VALET_SKIP_SETUP" 3 ""
CMD_OPTS_NAME_SC_selfMock1=0 ""
CMD_OPTS_NAME_SC_selfMock2=0 "" 1 "VALET_THIS_IS_OPTION2" 2 "VALET_FLAG3" 3 "VALET_WITH_DEFAULT" 4 ""
CMD_OPTS_NAME_SC_selfMock3=0 ""
CMD_OPTS_NAME_SC_selfMock4=0 ""
CMD_OPTS_NAME_SC_selfRelease=0 "VALET_GITHUB_RELEASE_TOKEN" 1 "VALET_BUMP_LEVEL" 2 "VALET_DRY_RUN" 3 ""
CMD_OPTS_NAME_SC_selfSetup=0 ""
CMD_OPTS_NAME_SC_selfTest=0 "VALET_USER_DIRECTORY" 1 "VALET_AUTO_APPROVE" 2 "VALET_WITH_CORE" 3 "VALET_CORE_ONLY" 4 "VALET_INCLUDE" 5 "VALET_EXCLUDE" 6 "VALET_NO_PARALLEL_TESTS" 7 ""
CMD_OPTS_NAME_SC_selfUninstall=0 "VALET_SCRIPT" 1 ""
CMD_OPTS_NAME_SC_selfUpdate=0 "VALET_UNATTENDED" 1 "VALET_SINGLE_USER_INSTALLATION" 2 "VALET_VERSION" 3 "VALET_INSTALLATION_DIRECTORY" 4 "VALET_NO_SHIM" 5 "VALET_NO_PATH" 6 "VALET_NO_EXAMPLES" 7 "VALET_SKIP_EXTENSIONS" 8 "VALET_ONLY_EXTENSIONS" 9 "VALET_SKIP_EXTENSIONS_SETUP" 10 "VALET_USE_BRANCH" 11 ""
CMD_OPTS_NAME_SC_showCommandHelp=0 "VALET_NO_COLORS" 1 "VALET_COLUMNS" 2 ""
CMD_OPTS_NAME_SC_this=0 "VALET_PROFILING" 1 "VALET_LOG_LEVEL" 2 "VALET_VERBOSE" 3 "VALET_VERY_VERBOSE" 4 "VALET_DISABLE_PROGRESS_BARS" 5 "VALET_FORCE_INTERACTIVE_MODE" 6 "" 7 ""
CMD_OPTS_NAME__menu=0 "help"
CMD_OPTS_NAME_selfAddCommand=0 "help"
CMD_OPTS_NAME_selfAddLibrary=0 "help"
CMD_OPTS_NAME_selfBuild=0 "userDirectory" 1 "coreOnly" 2 "output" 3 "noOutput" 4 "silent" 5 "help"
CMD_OPTS_NAME_selfConfig=0 "noEdit" 1 "override" 2 "exportCurrentValues" 3 "help"
CMD_OPTS_NAME_selfDocument=0 "output" 1 "coreOnly" 2 "help"
CMD_OPTS_NAME_selfExport=0 "exportAll" 1 "noExit" 2 "help"
CMD_OPTS_NAME_selfExtend=0 "version" 1 "name" 2 "skipSetup" 3 "help"
CMD_OPTS_NAME_selfMock1=0 "help"
CMD_OPTS_NAME_selfMock2=0 "option1" 1 "thisIsOption2" 2 "flag3" 3 "withDefault" 4 "help"
CMD_OPTS_NAME_selfMock3=0 "help"
CMD_OPTS_NAME_selfMock4=0 "help"
CMD_OPTS_NAME_selfRelease=0 "githubReleaseToken" 1 "bumpLevel" 2 "dryRun" 3 "help"
CMD_OPTS_NAME_selfSetup=0 "help"
CMD_OPTS_NAME_selfTest=0 "userDirectory" 1 "autoApprove" 2 "withCore" 3 "coreOnly" 4 "include" 5 "exclude" 6 "noParallelTests" 7 "help"
CMD_OPTS_NAME_selfUninstall=0 "script" 1 "help"
CMD_OPTS_NAME_selfUpdate=0 "unattended" 1 "singleUserInstallation" 2 "version" 3 "installationDirectory" 4 "noShim" 5 "noPath" 6 "noExamples" 7 "skipExtensions" 8 "onlyExtensions" 9 "skipExtensionsSetup" 10 "useBranch" 11 "help"
CMD_OPTS_NAME_showCommandHelp=0 "noColors" 1 "columns" 2 "help"
CMD_OPTS_NAME_this=0 "profiling" 1 "logLevel" 2 "verbose" 3 "veryVerbose" 4 "disableProgressBars" 5 "forceInteractiveMode" 6 "version" 7 "help"
CMD_OPTS__menu=0 "-h --help"
CMD_OPTS_selfAddCommand=0 "-h --help"
CMD_OPTS_selfAddLibrary=0 "-h --help"
CMD_OPTS_selfBuild=0 "-d --user-directory" 1 "-C --core-only" 2 "-o --output" 3 "-O --no-output" 4 "-s --silent" 5 "-h --help"
CMD_OPTS_selfConfig=0 "--no-edit" 1 "--override" 2 "--export-current-values" 3 "-h --help"
CMD_OPTS_selfDocument=0 "-o --output" 1 "-C --core-only" 2 "-h --help"
CMD_OPTS_selfExport=0 "-a --export-all" 1 "-E --no-exit" 2 "-h --help"
CMD_OPTS_selfExtend=0 "-v --version" 1 "-n --name" 2 "--skip-setup" 3 "-h --help"
CMD_OPTS_selfMock1=0 "-h --help"
CMD_OPTS_selfMock2=0 "-o --option1" 1 "-2 --this-is-option2" 2 "-3 --flag3" 3 "-4 --with-default" 4 "-h --help"
CMD_OPTS_selfMock3=0 "-h --help"
CMD_OPTS_selfMock4=0 "-h --help"
CMD_OPTS_selfRelease=0 "-t --github-release-token" 1 "-b --bump-level" 2 "--dry-run" 3 "-h --help"
CMD_OPTS_selfSetup=0 "-h --help"
CMD_OPTS_selfTest=0 "-d --user-directory" 1 "-a --auto-approve" 2 "-c --with-core" 3 "-C --core-only" 4 "-i --include" 5 "-e --exclude" 6 "-P --no-parallel-tests" 7 "-h --help"
CMD_OPTS_selfUninstall=0 "-s --script" 1 "-h --help"
CMD_OPTS_selfUpdate=0 "-u --unattended" 1 "-s --single-user-installation" 2 "-v --version" 3 "-d --installation-directory" 4 "-S --no-shim" 5 "-P --no-path" 6 "-E --no-examples" 7 "-U --skip-extensions" 8 "-e --only-extensions" 9 "--skip-extensions-setup" 10 "-b --use-branch" 11 "-h --help"
CMD_OPTS_showCommandHelp=0 "-n --no-colors" 1 "-c --columns" 2 "-h --help"
CMD_OPTS_this=0 "-x --profiling" 1 "-l --log-level --log" 2 "-v --verbose" 3 "-w --very-verbose" 4 "--disable-progress-bars" 5 "-i --force-interactive-mode" 6 "--version" 7 "-h --help"
CMD_SHORT_DESCRIPTION_selfAddCommand='Add a new command to the current extension.'
CMD_SHORT_DESCRIPTION_selfAddLibrary='Add a new library to the current extension.'
CMD_SHORT_DESCRIPTION_selfBuild='Index all the commands and libraries present in the valet user directory and installation directory.'
CMD_SHORT_DESCRIPTION_selfConfig='Open the configuration file of Valet with your default editor.'
CMD_SHORT_DESCRIPTION_selfDocument='Generate the documentation and code snippets for all the library functions of Valet.'
CMD_SHORT_DESCRIPTION_selfExport='Returns a string that can be evaluated to have Valet functions in bash.'
CMD_SHORT_DESCRIPTION_selfExtend='Extends Valet by creating or downloading a new extension in the user directory.'
CMD_SHORT_DESCRIPTION_selfMock1='A command that only for testing valet core functions.'
CMD_SHORT_DESCRIPTION_selfMock2='A command that only for testing valet core functions.'
CMD_SHORT_DESCRIPTION_selfMock3='A command that only for testing valet core functions.'
CMD_SHORT_DESCRIPTION_selfMock4='A command that only for testing valet core functions.'
CMD_SHORT_DESCRIPTION_selfRelease='Release a new version of valet.'
CMD_SHORT_DESCRIPTION_selfSetup='The command run after the installation of Valet to setup the tool.'
CMD_SHORT_DESCRIPTION_selfTest='Test your valet custom commands.'
CMD_SHORT_DESCRIPTION_selfUninstall='A command to uninstall Valet.'
CMD_SHORT_DESCRIPTION_selfUpdate='Update valet and its extensions to the latest releases.'
CMD_SHORT_DESCRIPTION_showCommandHelp='Show the help of this program or of a specific command.'
CMD_SHORT_DESCRIPTION_this='Your personal assistant in the terminal!'
CMD_SUDO_selfMock3='true'
```

**Error** output:

```log
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

INFO     The command definition variables have been written to ⌜/tmp/valet.d/f1-1⌝.
SUCCESS  The valet user commands have been successfully built.
```

