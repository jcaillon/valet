# Valet commands documentation

> Documentation generated for the version 0.39.12 (2026-05-22).

## ▶️ valet bash bootstrap

### Synopsis

Bootstrap your bash session.

This command is intended to be used in your bash configuration file (e.g. ~/.bashrc) to set up your bash
session with Valet features.
Below is a minimalist example of your ~/.bashrc file:

```bash
#!/usr/bin/env bash
# this is a good place to set VALET_* environment variables to configure valet features.
eval "$(valet bash bootstrap)"
```

By bootstrapping your bash session with Valet, you get access to many features described in the chapters below.

--------------------------

#### 1. PATH management

You can now manage your PATH declaratively.

Valet will use the files under the `~/.config/.paths.d` directory (by default) to compute your PATH variable.

Each file under `~/.config/.paths.d` can contain multiple paths, one per line, and they will be added to your
PATH variable in the same order as they appear in the file.

The following rules are applied when parsing the files:

- A line starting with # is a comment.
- A path may use ~ which will be replaced by the user home directory.
- A path that does not match an existing directory will be skipped.
- A line starting with ^ is a path to add before the original path.
- Any other line is a path to add after the original path.

The files in the ~/.config/.paths.d directory are processed in alphabetical order, allowing you to control the order of the paths in your PATH variable.

The following rules are applied when listing the files to consider in the ~/.config/.paths.d directory:

- If the path file is hidden (starts with a dot), it is skipped.
- If the path file is a markdown file, it is skipped.
- If the path file contains -linux and the current os is not linux, it is skipped.
- If the path file contains -windows and the current os is not windows, it is skipped.
- If the path file contains -darwin and the current os is not macos, it is skipped.

> The original path is stored in ORIGINAL_PATH, allowing you to restore it if needed.

Examples of path definition files are available here:
<https://github.com/jcaillon/valet/tree/dotfiles-example>

--------------------------

#### 2. Bashrc management

You can now split your bash configuration into multiple files under the `~/.config/.bash.d` directory (by default).

This allows you to organize your bash configuration and easily enable/disable parts of it by adding/removing files in this directory.

The files in the `~/.config/.bash.d` directory are sourced in alphabetical order.

The following rules are applied when listing the files to source in the `~/.config/.bash.d` directory:

- If the file is hidden (starts with a dot), it is skipped.
- If the file does not have a .sh or .bash extension, it is skipped.
- If the file contains -linux and the current os is not linux, it is skipped.
- If the file contains -windows and the current os is not windows, it is skipped.
- If the file contains -darwin and the current os is not macos, it is skipped.

> Additionally, a script containing -bash-init in its name will be sourced before the PATH variable is computed,
> allowing you to set environment variables that can be used in the path definition files.

All valet functions can be used in these scripts.

Examples of bash scripts are available here:
<https://github.com/jcaillon/valet/tree/dotfiles-example>

--------------------------

#### 3. Bash hooks for prompt and command execution

You can now define functions to be executed before the prompt is drawn and before a command is executed.

This works exactly like the precmd and preexec hooks in zsh, with the difference that due to bash limitations,
the preexec functions are executed in a subshell and thus cannot modify the environment.

See: <https://zsh.sourceforge.io/Doc/Release/Functions.html#Hook-Functions>.

- `precmd_functions`: array of functions to be executed before the prompt is drawn
  Functions can expect the following variables to be set:
  - GLOBAL_LAST_COMMAND_STATUS: the status of the last command executed
  - GLOBAL_LAST_PIPE_STATUS: the status of the last pipeline executed
  - GLOBAL_LAST_ELAPSED_MICROSECONDS: the elapsed time for the command in microseconds
    (will be 0 if no command was executed since the last prompt)
  - GLOBAL_JOB_COUNT: the number of background jobs
  They can also call the function bashHooks::getCurrentCommand to get the last command executed.
- `preexec_functions`: array of functions to be executed before the command is executed
  Functions are invoked with the command to execute as the first argument $1.
  /!\ they are executed in a subshell, so they cannot modify the environment!
      this can be fixed in bash 5.3 with the ${ exec} variable expansion (see implementation of the hooks).

--------------------------

#### 4. Use Valet functions in your shell

You can now use valet functions directly in your shell, as if you were in a command script.

E.g.: `log::info "Cool logs!"`.

--------------------------

#### 5. Integration with bash tools

Valet also sets up integration with some popular bash tools:

- Starship: a better, fully featured prompt <https://starship.rs/>.
- Atuin: a better shell history manager <https://atuin.sh/>.

--------------------------

#### 6. Incoming features

TODO: FEATURES TO IMPLEMENT:

- add builtin "z" to jump to frequently used directories
- auto source .env and .envrc files in the current directory
- Provide a good and fast default prompt if atuin is not installed


### Usage

```bash
valet bash bootstrap [options]
```

### Options

- `--bash-scripts-directory <directory>`

  Path to the directory containing bash scripts to source during bootstrap.
  This option can be set by exporting the variable VALET_BASH_SCRIPTS_DIRECTORY='<directory>'.

- `--path-definition-directory <directory>`

  Path to the directory containing path definition files to compute the PATH variable.
  
  This option can be set by exporting the variable VALET_PATH_DEFINITION_DIRECTORY='<directory>'.

- `-h, --help`

  Display the help for this command.

### Examples

- `eval "$(valet bash bootstrap)"`

  Source valet functions in your bash script or bash prompt.
  You can then can then use valet function as if you were in a command script.

## ▶️ valet bash links

### Synopsis

This command allows you to create symbolic links declaratively, based on simple definitions written in text files.

By default, it will look for link definition files in the directory `~/.config/.links.d`.

Each file under `~/.config/.links.d` can contain multiple link definitions, one per line.

A valid line should have one of the following formats:

```
<soft_link_path> :-> <source_path>
```

Or to create a hard link:

```
<hard_link_path> :h-> <source_path>
```

The following rules are applied when parsing the files:

- A line starting with # is a comment.
- A path may use ~ which will be replaced by the user home directory.
- A path may contain variables in bash format `${VAR}` or `${VAR:-default}`, which will be replaced by their value.

The following rules are applied when listing the files to consider in the ~/.config/.links.d directory:

- If the path file is hidden (starts with a dot), it is skipped.
- If the path file contains -linux and the current os is not linux, it is skipped.
- If the path file contains -windows and the current os is not windows, it is skipped.
- If the path file contains -darwin and the current os is not macos, it is skipped.

Examples of link definition files are available here:
<https://github.com/jcaillon/valet/tree/dotfiles-example>


### Usage

```bash
valet bash links [options]
```

### Options

- `--force`

  Replace existing targets without confirmation when creating the links (dangerous).
  This option can be set by exporting the variable VALET_FORCE='true'.

- `--links-definition-directory <directory>`

  Path to the directory containing link definition files to create symbolic links.
  This option can be set by exporting the variable VALET_LINKS_DEFINITION_DIRECTORY='<directory>'.

- `--dotfiles <directory>`

  Path to the your dotfiles directory. All links referring to the "./" directory will be
  resolved relative to this directory.
  Will default to the current working directory.
  
  This option can be set by exporting the variable VALET_DOTFILES='<directory>'.

- `-h, --help`

  Display the help for this command.

### Examples

- `valet bash links`

  Create symbolic links as defined in the links definition directory.

## ▶️ valet extensions add-command

### Synopsis

Call this function in an extension directory to add a new command to the extension.

This will create a file from a command template in the **commands.d** directory.


### Usage

```bash
valet extensions add-command [options] [--] <command-name>
```

### Options

- `-h, --help`

  Display the help for this command.

### Arguments

- `command-name`

  The name of the command to create.

### Examples

- `valet extensions add-command my-command`

  Create a new command named **my-command** in the current extension under the **commands.d** directory.

## ▶️ valet extensions add-library

### Synopsis

Call this function in an extension directory to add a new library to the extension.

This will create a file from a library template in the **libraries.d** directory.

### Usage

```bash
valet extensions add-library [options] [--] <library-name>
```

### Options

- `-h, --help`

  Display the help for this command.

### Arguments

- `library-name`

  The name of the library to create.

### Examples

- `valet extensions add-library my-library`

  Create a new library named **my-library** in the current extension under the **libraries.d** directory.

## ▶️ valet extensions create

### Synopsis

Create a new Valet extension.


### Usage

```bash
valet extensions create [options] [--] <name>
```

### Options

- `-h, --help`

  Display the help for this command.

### Arguments

- `name`

  The name of the extension to create.

### Examples

- `valet extensions create`

  Create a new Valet extension.

## ▶️ valet extensions init

### Synopsis

Initialize/setup the current directory as a Valet extension.

This command will:

- Ask the user if they want to register the current directory as an extension by linking it in the valet extensions directory (if it's not already the case).
- Link lib-valet and lib-valet.md in the current directory.
- If vscode is installed, copy the recommended settings and extensions for valet development in a .vscode directory in the current directory.


### Usage

```bash
valet extensions init [options]
```

### Options

- `-h, --help`

  Display the help for this command.

### Examples

- `valet extensions init`

  Initialize the current directory as a Valet extension.

## ▶️ valet extensions install

### Synopsis

Download and install an extension in the user extensions directory using GIT.

This command will download the given extension (GIT repository) and install it in the valet extensions directory.

For downloaded extensions, if a `extension.setup.sh` script is present in the repository root directory,
it will be executed. This gives the extension the opportunity to setup itself.

Once an extension is installed, you can use the `valet extensions update` command to update it.


### Usage

```bash
valet extensions install [options] [--] <git-repo>
```

### Options

- `-n, --name <extension-name>`

  The name to give to this extension.
  If a name is not provided, the name of the repository will be used.
  This option can be set by exporting the variable VALET_NAME='<extension-name>'.

- `-v, --version <version>`

  The version (git reference) to checkout for the repository to download.
  Usually a tag or a branch name.
  This option can be set by exporting the variable VALET_VERSION='<version>'.

- `--skip-setup`

  Skip the execution of the `extension.setup.sh` script even if it exists.
  This option can be set by exporting the variable VALET_SKIP_SETUP='true'.

- `--unattended`

  Set to true to install without interactive confirmation.
  This option can be set by exporting the variable VALET_UNATTENDED='true'.

- `-h, --help`

  Display the help for this command.

### Arguments

- `git-repo`

  The GIT repository of the extension to install.
  
  For example `https://github.com/jcaillon/valet-devops-toolbox.git`.
  
  > If the repository is private, you can pass the URL with the username and password like this:
  > `https://username:password@my.gitlab.private/group/project.git`.

### Examples

- `valet extensions install https://github.com/jcaillon/valet-devops-toolbox.git`

  Download the latest version of the valet-devops-toolbox application and install it for Valet.

- `valet extensions install https://github.com/jcaillon/valet-devops-toolbox.git --name extension-1 --version main --skip-setup`

  Download the **main** reference of the jcaillon/valet-devops-toolbox repository and install it as **extension-1** for Valet.
  Skip the execution of the `extension.setup.sh` script.

## ▶️ valet extensions list

### Synopsis

List all Valet extensions, their versions and if the setup script has been executed.


### Usage

```bash
valet extensions list [options]
```

### Options

- `-h, --help`

  Display the help for this command.

### Examples

- `valet extensions list`

  List all Valet extensions.

## ▶️ valet extensions update

### Synopsis

Update Valet extensions.


### Usage

```bash
valet extensions update [options]
```

### Options

- `-n, --name <extension-name>`

  The name of the extension to update.
  If not provided, defaults to updating all extensions.
  This option can be set by exporting the variable VALET_NAME='<extension-name>'.

- `--skip-setup`

  Skip the execution of the `extension.setup.sh` scripts even when they exist.
  This option can be set by exporting the variable VALET_SKIP_SETUP='true'.

- `--unattended`

  Set to true to install without interactive confirmation.
  This option can be set by exporting the variable VALET_UNATTENDED='true'.

- `-h, --help`

  Display the help for this command.

### Examples

- `valet extensions update`

  Update all Valet extensions.

## ▶️ valet self build

### Synopsis

Index all the command and libraries present in the valet extensions directory and installation directory.

This command can be used to re-build the menu / help / options / arguments in case you have modified, added or removed a Valet command definition.

Please check https://jcaillon.github.io/valet/docs/new-commands/ or check the examples in **showcase.d** directory to learn how to create and modified your commands.

This scripts:

- Makes a list of all the eligible files in which we could find command definitions.
- For each file in this list, extract the command definitions.
- Build your commands file (in your valet extensions directory) from these definitions.
- Makes a list of all `libraries.d` directories found in the user directory.

You can call this script directly in case calling **valet self build** is broken:

→ commands.d/self-build.sh

### Usage

```bash
valet self build [options]
```

### Options

- `-d, --extensions-directory <path>`

  Specify your valet extensions directory, in which to look for your extension commands.
  Defaults to the valet extensions directory.
  This option can be set by exporting the variable VALET_EXTENSIONS_DIRECTORY='<path>'.

- `--extra-extension-directories <path>`

  Comma separated list of additional valet extension directories, in which to look for commands and libraries.
  This option can be set by exporting the variable VALET_EXTRA_EXTENSION_DIRECTORIES='<path>'.

- `-o, --output <path>`

  Specify the directory path in which to write the command definition variable files.
  
  This defaults to your user data folder `~/.local/share/valet`.
  This option can be set by exporting the variable VALET_OUTPUT='<path>'.

- `-O, --no-output`

  Do not write the command definition variables to a file.
  
  This will just create the variables.
  This option can be set by exporting the variable VALET_NO_OUTPUT='true'.

- `-s, --silent`

  Build silently without any info logs.
  This option can be set by exporting the variable VALET_SILENT='true'.

- `-h, --help`

  Display the help for this command.

### Examples

- `valet self build`

  Build the valet user commands.

- `valet self build -d ~/my-valet-directory --silent`

  Build the valet user commands from the directory **~/my-valet-directory** and with minimal log output.

## ▶️ valet self config

### Synopsis

Open the configuration file of Valet with your default editor.

This allows you to set advanced options for Valet.

If the configuration file does not exist, it will be created.
Each configuration variable will be commented out with a description of its purpose.

### Usage

```bash
valet self config [options]
```

### Options

- `--no-edit`

  Create the configuration file if it does not exist but do not open it.
  This option can be set by exporting the variable VALET_NO_EDIT='true'.

- `--override`

  Override of the configuration file even if it already exists.
  Unless the option --export-current-values is used, the existing values will be reset.
  This option can be set by exporting the variable VALET_OVERRIDE='true'.

- `--export-current-values`

  When writing the configuration file, export the current values of the variables.
  This option can be set by exporting the variable VALET_EXPORT_CURRENT_VALUES='true'.

- `-h, --help`

  Display the help for this command.

### Examples

- `valet self config`

  Open the configuration file of Valet with your default editor.

- `valet self config --no-edit --override --export-current-values`

  Create (or recreate) the configuration file of Valet reusing the possible current values of the variables.

## ▶️ valet self document

### Synopsis

Generate the documentation and code snippets for all the library functions of Valet.

It will parse all the library files and generate:

- A markdown file with the documentation.
- A bash file with the prototype of each function.
- A vscode snippet file for each function.

### Usage

```bash
valet self document [options]
```

### Options

- `-o, --output <directory path>`

  The directory in which the documentation will be generated.
  Defaults to the valet extensions directory.
  This option can be set by exporting the variable VALET_OUTPUT='<directory path>'.

- `-C, --core-only`

  Generate the documentation for the core functions only.
  Will not generate for libraries present in the valet extensions directory.
  This option can be set by exporting the variable VALET_CORE_ONLY='true'.

- `-h, --help`

  Display the help for this command.

### Examples

- `valet self document`

  Generate the documentation for all the library functions of Valet and output to the default directory.

## ▶️ valet self release

### Synopsis

Release a new version of valet.

It will:
- write the current version in the self-install script,
- commit the file,
- update the documentation,
- commit the changes,
- creates a git tag and pushes it to the remote repository,
- bump the version of valet,
- commit the new version.

### Usage

```bash
valet self release [options]
```

### Options

- `-t, --github-release-token <token>`

  The token necessary to create the release on GitHub and upload artifacts.
  This option can be set by exporting the variable VALET_GITHUB_RELEASE_TOKEN='<token>'.

- `-b, --bump-level <semver>`

  The semver level to bump the version.
  
  Can be either: major or minor. Defaults to minor.
  This option can be set by exporting the variable VALET_BUMP_LEVEL='<semver>'.

- `--dry-run`

  Do not perform the release, just show what would be done.
  
  This option can be set by exporting the variable VALET_DRY_RUN='true'.

- `-h, --help`

  Display the help for this command.

## ▶️ valet self setup

### Synopsis

The command run after the installation of Valet to setup the tool.

This command will do the following (with user approval for each step):

- Copy the showcase to the user extensions directory.
- Create a shim/proxy script in `~/.local/bin` or `~/bin` that points to the valet script.
- Add the Valet directory to the user PATH by editing the shell startup files.
- Add the Valet directory to the windows PATH if on windows.
- Adjust the Valet configuration according to the user environment.
- If the current user is root and the option is given, make Valet available for all users.
  (set read permissions for all users on Valet files and directories and create a shim in /usr/local/bin).
- Let the user know what to do next.


### Usage

```bash
valet self setup [options]
```

### Options

- `--unattended`

  Do not enter interactive mode for the setup (skip all actions except those explicitly specified).
  This option can be set by exporting the variable VALET_UNATTENDED='true'.

- `--copy-showcase`

  Copy the showcase to the user extensions directory.
  This option can be set by exporting the variable VALET_COPY_SHOWCASE='true'.

- `--create-shim`

  Create a shim/proxy script in `~/.local/bin` or `~/bin` (if one of them is in your PATH) that points to the valet script.
  This option can be set by exporting the variable VALET_CREATE_SHIM='true'.

- `--add-to-path`

  Add the Valet directory to the user PATH by editing the shell startup files.
  This option can be set by exporting the variable VALET_ADD_TO_PATH='true'.

- `--setup-for-windows`

  Add the Valet directory to the windows PATH if on windows and set the VALET_WIN_BASH and VALET_WIN_INSTALLATION_DIRECTORY windows environment variables.
  This option can be set by exporting the variable VALET_SETUP_FOR_WINDOWS='true'.

- `--global-installation`

  If the current user is root and the option is given, make Valet available for all users (set read permissions for all users on Valet files and directories and create a shim in /usr/local/bin).
  
  This option can be set by exporting the variable VALET_GLOBAL_INSTALLATION='true'.

- `-h, --help`

  Display the help for this command.

## ▶️ valet self source

### Synopsis

If you want to use Valet functions directly in bash, you can use this command like this:

```bash
eval "$(valet self source)"
```

This will source valet to be able to use its functions as if you were in a command script.

You can optionally export all the functions if needed.

### Usage

```bash
valet self source [options]
```

### Options

- `-a, --source-all-functions`

  Will immediately source all the libraries functions.
  This option can be set by exporting the variable VALET_SOURCE_ALL_FUNCTIONS='true'.

- `-E, --no-exit`

  Override the **core::fail** and **core::exit** functions to not exit the script.
  This option can be set by exporting the variable VALET_NO_EXIT='true'.

- `-p, --prompt-mode`

  Source valet functions with modifications to be used in a shell prompt.
  This will disable all traps and override the **core::fail** and **core::exit** functions to not exit the shell.
  This option can be set by exporting the variable VALET_PROMPT_MODE='true'.

- `-h, --help`

  Display the help for this command.

### Examples

- `eval "$(valet self source)"`

  Source valet functions in your bash session.
  You can then can then use valet function as if you were in a command script.
  Perfect for CI/CD pipelines.

- `eval "$(valet self source --prompt-mode)"`

  The preferred mode to source valet functions in your shell prompt.

## ▶️ valet self test

### Synopsis

Test your valet custom commands using approval tests approach.

### Usage

```bash
valet self test [options]
```

### Options

- `-d, --extensions-directory <path>`

  The path to your valet extensions directory.
  
  Each sub directory named **.tests.d** in an extension will be considered as a test directory containing a test.sh file.
  This option can be set by exporting the variable VALET_EXTENSIONS_DIRECTORY='<path>'.

- `-a, --auto-approve`

  The received test result files will automatically be approved.
  This option can be set by exporting the variable VALET_AUTO_APPROVE='true'.

- `-r, --replay-failed-tests`

  Replay the failed tests from the previous run (or run all tests if none failed).
  This option can be set by exporting the variable VALET_REPLAY_FAILED_TESTS='true'.

- `-c, --core-only`

  Only test the valet core functions. Skips the tests for user commands.
  
  This option is intended to be used by people modifying valet itself.
  This option can be set by exporting the variable VALET_CORE_ONLY='true'.

- `-i, --include <pattern>`

  A regex pattern to include only the test suites (path) that match the pattern.
  
  The name of the test suite is given by the name of the directory containing the .sh test files.
  
  Example: --include '(1|commands)'
  This option can be set by exporting the variable VALET_INCLUDE='<pattern>'.

- `-e, --exclude <pattern>`

  A regex pattern to exclude all the test suites (path) that match the pattern.
  
  The name of the test suite is given by the name of the directory containing the .sh test files.
  
  Example: --exclude '(1|commands)'
  This option can be set by exporting the variable VALET_EXCLUDE='<pattern>'.

- `-p, --parallel-test-suites <number>`

  The number of test suites to run in parallel.
  This option can be set by exporting the variable VALET_PARALLEL_TEST_SUITES='<number>'.

- `-h, --help`

  Display the help for this command.

### Examples

- `valet self test`

  Run all the tests found in the valet extensions directory.

- `valet self test -a`

  Run all the tests found in the valet extensions directory and automatically approve the results.

- `valet self test -i '(my-thing|my-stuff)'`

  Run only the test suites that match the regex pattern **(my-thing|my-stuff)**.

## ▶️ valet self uninstall

### Synopsis

Generate a bash script that can be used to uninstall Valet.
Without any option, this script will print instructions instead.

Usage:

```bash
eval "$(valet self uninstall --script)"
```

### Usage

```bash
valet self uninstall [options]
```

### Options

- `-s, --script`

  Generate a bash script that can be evaluated in bash to uninstall Valet.
  
  This option can be set by exporting the variable VALET_SCRIPT='true'.

- `-h, --help`

  Display the help for this command.

## ▶️ valet self update

### Synopsis

Update valet using the latest release on GitHub.


### Usage

```bash
valet self update [options]
```

### Options

- `--unattended`

  Set to true to update without interactive confirmation.
  This option can be set by exporting the variable VALET_UNATTENDED='true'.

- `-h, --help`

  Display the help for this command.

### Examples

- `valet self update`

  Update Valet to the latest version.

- `valet self update --unattended`

  Update Valet to the latest version without interactive confirmation.

## ▶️ valet help

### Synopsis

Show the help of this program or of the help of a specific command.

You can show the help with or without colors and set the maximum columns for the help text.

### Usage

```bash
valet help [options] [--] [commands...]
```

### Options

- `-c, --columns <number>`

  Set the maximum columns for the help text
  This option can be set by exporting the variable VALET_COLUMNS='<number>'.

- `-h, --help`

  Display the help for this command.

### Arguments

- `commands?...`

  The name of the command to show the help for.
  If not provided, show the help for the program.

### Examples

- `valet help cmd`

  Shows the help for the command **cmd**

- `valet help cmd subCmd`

  Shows the help for the sub command **subCmd** of the command **cmd**

- `valet help --no-colors --columns 50`

  Shows the help for the program without any color and with a maximum of 50 columns

## ▶️ valet

### Synopsis

Valet helps you browse, understand and execute your custom bash commands.

Online documentation is available at <https://jcaillon.github.io/valet/>.

You can call valet without any commands to start an interactive session.

#### Configuration through environment variables

Core features variables can be defined in the valet user config file. Run **valet self config** to open the configuration file with your default editor (the file will get created if it does not yet exist).

Command options can also be set through environment variables. Check the command help for more information.

#### Create your own commands

You can create your own commands and have them available in valet.

A command is part of an extension, which is a collection of commands.

To get started, run the command **valet extensions create**.

### Usage

```bash
valet [options] [--] [commands...]
```

### Options

- `--profiler`

  Turn on profiling (with debug mode) before running the required command.
  It will output to `~/.local/state/valet/logs` by default.
  This is useful to debug your command and understand what takes a long time to execute.
  The profiler log will be cleanup to only keep lines relevant for your command script. You can disable this behavior by setting the environment variable VALET_CONFIG_KEEP_ALL_PROFILER_LINES to true.
  This option can be set by exporting the variable VALET_PROFILER='true'.

- `--log-level, --log <level>`

  Set the log level (defaults to info).
  Possible values are: trace, debug, success, info, success, warning, error.
  This option can be set by exporting the variable VALET_LOG_LEVEL='<level>'.

- `-v, --verbose`

  Output verbose information.
  This is the equivalent of setting the log level to debug.
  This option can be set by exporting the variable VALET_VERBOSE='true'.

- `--disable-progress-bars`

  Disable all progress bars for commands that use them.
  This option can be set by exporting the variable VALET_DISABLE_PROGRESS_BARS='true'.

- `--interactive`

  Enter interactive mode for commands even if arguments are not required or provided.
  This option can be set by exporting the variable VALET_INTERACTIVE='true'.

- `--source`

  Returns in the path of a script file to source in order to use valet library functions in your scripts.
  Usage: `source "$(valet --source)"`.

- `--version`

  Display the current version of valet.

- `-h, --help`

  Display the help for this command.

### Arguments

- `commands?...`

  The command or sub commands to execute.
  See the commands section for more information.

### Commands

- `append-checksum-transformer`

  (Kustomize plugin) A Kustomize transformer that appends a manifest checksum to the name of a resource.

- `argocd-plugin`

  Generate the yaml from the given kustomize directory.

- `auto-merge`

  Automatically merge given branches to target branches.

- `aws-cleanup-resources`

  Cleanup AWS resources.

- `aws-find-secret`

  Find a secret from AWS Secrets Manager.

- `aws-login`

  Log in to AWS and EKS for the specified profile.

- `aws-logout`

  Log out of AWS.

- `aws-switch`

  Allows to switch on/off aws resources.

- `bash bootstrap`

  Returns a string that can be evaluated to bootstrap your bash session.

- `bash links`

  Create symbolic links as defined in the links definition directory.

- `chart-inflator`

  (Kustomize plugin) Inflates helm chart(s) from the given Kustomize generator specifications.

- `clean-up`

  Clean up the system.

- `extension2`

  Do nothing.

- `extension3`

  Do nothing.

- `extensions add-command`

  Add a new command to the current extension.

- `extensions add-library`

  Add a new library to the current extension.

- `extensions create`

  Create a new Valet extension.

- `extensions init`

  Initialize/setup the current directory as a Valet extension.

- `extensions install`

  Download and install an extension in the user extensions directory using GIT.

- `extensions list`

  List all Valet extensions.

- `extensions update`

  Update Valet extensions.

- `fix-videos-name`

  Rename videos files in a directory.

- `generate`

  Generate the yaml from the given kustomize directory.

- `gitops-generate-manifests`

  Generate the k8s manifests as seen by ArgoCD for a GitOps repository.

- `gitops-test-repository`

  Test the validity of the gitops repository.

- `help`

  Show the help of this program or of a specific command.

- `hibernator`

  Allows to either hibernate or awake a given tenant.

- `k8s-argocd`

  Interact with ArgoCD.

- `k8s-bootstrap`

  Bootstrap a k8s cluster by applying Kustomize configuration step by step.

- `k8s-delete-bad-pdbs`

  Remove problematic PodDisruptionBudgets that would prevent nodes from being drained.

- `k8s-delete-resources`

  Delete k8s resources.

- `k8s-find-issues`

  Find issues in the k8s cluster and report them.

- `k8s-switch`

  Allows to switch on/off k8s resources.

- `k8s-uninstall-deployment-charts`

  Uninstall helm charts for the given deployments.

- `k8s-wait-for-pods`

  Wait for the k8s pods/jobs to be ready/complete.

- `k8s-wait-for-resources`

  Wait for k8s resources to be created.

- `mustache-generator`

  (Kustomize plugin) Generate k8s resource list from a combination of mustaches templates and scopes.

- `notify-team`

  Sends a notification to the team.

- `self build`

  Index all the commands and libraries present in the valet extensions directory and installation directory.

- `self config`

  Open the configuration file of Valet with your default editor.

- `self document`

  Generate the documentation and code snippets for all the library functions of Valet.

- `self release`

  Release a new version of valet.

- `self setup`

  The command run after the installation of Valet to setup the tool.

- `self source`

  Returns a string that can be evaluated to source Valet functions in bash.

- `self test`

  Test your valet custom commands.

- `self uninstall`

  A command to uninstall Valet.

- `self update`

  Update valet to the latest release.

- `send-repo-status`

  Send a report of the current repository status.

- `showcase command1`

  A showcase command that uses arguments and options.

- `showcase interactive`

  A showcase command that demonstrates how to interact with the user.

- `terraform`

  Init, validate, destroy, plan or apply a terraform configuration.

- `wait-pods`

  DEPRECATED! Wait for the k8s pods to be ready.

- `wait-resources`

  DEPRECATED! Wait for the k8s resources to be created.

- `yaml-query-transformer`

  (Kustomize plugin) A Kustomize transformer that runs the resources list through a yq query.

### Examples

- `valet --help`

  Displays this help text.

- `valet -v a-command and-sub-command`

  Active **verbose** mode and run the command **a-command** with the sub command **and-sub-command**.

> Documentation generated for the version 0.39.12 (2026-05-22).