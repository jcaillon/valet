# Valet commands documentation

> Documentation generated for the version 0.30.1409 (2025-08-12).

## ▶️ valet self add-command

Call this function in an extension directory to add a new command to the extension.

This will create a file from a command template in the **commands.d** directory.

### Usage

```bash
valet self add-command [options] [--] <command-name>
```

### Options

- `-h, --help`

  Display the help for this command.

### Arguments

- `command-name`

  The name of the command to create.

### Examples

- `valet self add-command my-command`

  Create a new command named **my-command** in the current extension under the **commands.d** directory.

## ▶️ valet self add-library

Call this function in an extension directory to add a new library to the extension.

This will create a file from a library template in the **libraries.d** directory.

### Usage

```bash
valet self add-library [options] [--] <library-name>
```

### Options

- `-h, --help`

  Display the help for this command.

### Arguments

- `library-name`

  The name of the library to create.

### Examples

- `valet self add-library my-library`

  Create a new library named **my-library** in the current extension under the **libraries.d** directory.

## ▶️ valet self build

Index all the command and libraries present in the valet user directory and installation directory.

This command can be used to re-build the menu / help / options / arguments in case you have modified, added or removed a Valet command definition.

Please check https://jcaillon.github.io/valet/docs/new-commands/ or check the examples in **showcase.d** directory to learn how to create and modified your commands.

This scripts:

- Makes a list of all the eligible files in which we could find command definitions.
- For each file in this list, extract the command definitions.
- Build your commands file (in your valet user directory) from these definitions.
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

- `-C, --core-only`

  Build only the core commands (under commands.d).
  This option can be set by exporting the variable VALET_CORE_ONLY='true'.

- `--include-showcase`

  Build the showcase extension if it exists in the valet installation directory.
  This option can be set by exporting the variable VALET_INCLUDE_SHOWCASE='true'.

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
  Defaults to the valet user directory.
  This option can be set by exporting the variable VALET_OUTPUT='<directory path>'.

- `-C, --core-only`

  Generate the documentation for the core functions only.
  Will not generate for libraries present in the valet user directory.
  This option can be set by exporting the variable VALET_CORE_ONLY='true'.

- `-h, --help`

  Display the help for this command.

### Examples

- `valet self document`

  Generate the documentation for all the library functions of Valet and output to the default directory.

## ▶️ valet self extend

Extends Valet by creating or downloading a new extension in the user directory.
Extensions can add new commands or functions to Valet.

This command will either:

- Create and setup a new extension directory under the valet user directory,
- setup an existing directory as a valet extension,
- or download the given extension (repository) and install it in the Valet user directory.

For downloaded extensions, all GIT repositories are supported.
For the specific cases of GitHub and GitLab repositories, this command will:

1. If git is installed, clone the repository for the given reference (version option).
2. If git is not installed, download source tarball for the given reference and extract it.

For downloaded extensions, if a `extension.setup.sh` script is present in the repository root directory,
it will be executed. This gives the extension the opportunity to setup itself.

Once an extension is installed, you can use the `valet self update` command to update it.

### Usage

```bash
valet self extend [options] [--] <extension-uri>
```

### Options

- `-v, --version <version>`

  The version of the repository to download.
  Usually a tag or a branch name.
  This option can be set by exporting the variable VALET_VERSION='<version>'.

- `-n, --name <extension-name>`

  The name to give to this extension.
  If a name is not provided, the name of the repository will be used.
  This option can be set by exporting the variable VALET_NAME='<extension-name>'.

- `--skip-setup`

  Skip the execution of the `extension.setup.sh` script even if it exists.
  This option can be set by exporting the variable VALET_SKIP_SETUP='true'.

- `-h, --help`

  Display the help for this command.

### Arguments

- `extension-uri`

  The URI of the extension to install or create.
  
  1. If you want to create a new extension, this argument should be the name of your
     new extension (e.g. `my-new-extension`).
  2. If you want to setup an existing directory as an extension, this argument should be `.`.
  3. If you want to download an extension, this argument should be the URL of the repository.
     Usually a GitHub or GitLab repository URL such as `https://github.com/jcaillon/valet-devops-toolbox.git`.
  
  > If the repository is private, you can pass the URL with the username and password like this:
  > `https://username:password@my.gitlab.private/group/project.git`.

### Examples

- `valet self extend my-new-extension`

  Create a new extension named **my-new-extension** in the user directory.

- `valet self extend .`

  Setup the current directory as an extension in the user directory.

- `valet self extend https://github.com/jcaillon/valet-devops-toolbox.git`

  Download the latest version of the valet-devops-toolbox application and install it for Valet.

- `valet self extend https://github.com/jcaillon/valet --version extension-1 --name extension-1 --skip-setup`

  Download the **extension-1** reference of the valet repository and install it as **extension-1** for Valet.
  Skip the execution of the `extension.setup.sh` script.
  (This is actually a fake extension for testing purposes).

## ▶️ valet self release

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

The command run after the installation of Valet to setup the tool.

Adjust the Valet configuration according to the user environment.
Let the user know what to do next.


### Usage

```bash
valet self setup [options]
```

### Options

- `-h, --help`

  Display the help for this command.

## ▶️ valet self source

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

  Override the **core::fail**  function to not exit the script.
  This option can be set by exporting the variable VALET_NO_EXIT='true'.

- `-p, --prompt-mode`

  Source valet functions with modifications to be used in a shell prompt.
  This option can be set by exporting the variable VALET_PROMPT_MODE='true'.

- `-h, --help`

  Display the help for this command.

### Examples

- `eval "$(valet self source)"`

  Source valet functions in your bash script or bash prompt.
  You can then can then use valet function as if you were in a command script.

## ▶️ valet self test

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

- `-c, --with-core`

  Also test the valet core functions.
  
  This is only if you modified valet core functions themselves.
  This option can be set by exporting the variable VALET_WITH_CORE='true'.

- `-C, --core-only`

  Only test the valet core functions. Skips the tests for user commands.
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

  Run all the tests found in the valet user directory.

- `valet self test -a`

  Run all the tests found in the valet user directory and automatically approve the results.

- `valet self test -i '(my-thing|my-stuff)'`

  Run only the test suites that match the regex pattern **(my-thing|my-stuff)**.

## ▶️ valet self uninstall

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

Update valet using the latest release on GitHub. Also update all installed extensions.

This script can also be used as a standalone script to install Valet:

bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/commands.d/self-install.sh)"

If you need to pass options (e.g. --single-user-installation) to the script, you can do it like this:

bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/commands.d/self-install.sh)" -s --single-user-installation

The default behavior is to install Valet for all users, in /opt/valet, which might require
you to type your password on sudo commands (you don't have to run this script with sudo, it will
ask for your password when needed).

This script will:

- 1. Download the given release from GitHub (latest by default).

- 2. Copy it in the Valet home directory, which defaults to:
  - /opt/valet in case of a multi user installation
  - ~/.local/valet otherwise

- 3. Make the valet script readable and executable, either by adding a shim
     in a bin directory already present in your PATH, or by adding the Valet
     directory to your PATH on shell startup.

- 4. Copy the showcase (command examples) in the valet user directory ~/.valet.d.

- 6. Run self setup command (in case of a new installation) or re-export the config.

- 7. Try to update (fetch merge --ff-only) the git repositories and all
     installed extensions in your valet user directory.


### Usage

```bash
valet self update [options]
```

### Options

- `-u, --unattended`

  Set to true to not enter interactive mode for the setup (useful for automated installation).
  This option can be set by exporting the variable VALET_UNATTENDED='true'.

- `-s, --single-user-installation`

  Set to true to install Valet for the current user only.
  
  Note: for windows, the installation is always for the current user.
  This option can be set by exporting the variable VALET_SINGLE_USER_INSTALLATION='true'.

- `-v, --version <version>`

  The version number to install (do not including the starting 'v').
  
  Released versions can be found here: https://github.com/jcaillon/valet/releases
  
  This option can be set by exporting the variable VALET_VERSION='<version>'.

- `-d, --installation-directory <path>`

  The directory where Valet will be installed.
  
  Defaults to /opt/valet for a multi user installation and ~/.local/valet otherwise.
  This option can be set by exporting the variable VALET_INSTALLATION_DIRECTORY='<path>'.

- `-S, --no-shim`

  Set to true to not create the shim script in /usr/local/bin.
  This option can be set by exporting the variable VALET_NO_SHIM='true'.

- `-P, --no-path`

  Set to true to not add the Valet directory to the PATH (append to your .bashrc file).
  This option can be set by exporting the variable VALET_NO_PATH='true'.

- `--no-showcase`

  Set to true to to not copy the showcase (command examples) to the valet user directory (~/.valet.d).
  
  If you do not set this option, newer versions of the showcase will override the existing ones.
  
  In case of an update, if the showcase.d directory does not exist, the showcase will not be copied.
  This option can be set by exporting the variable VALET_NO_SHOWCASE='true'.

- `-U, --skip-extensions`

  Set to true to not attempt to update the installed extensions under the valet user directory (~/.valet.d).
  This option can be set by exporting the variable VALET_SKIP_EXTENSIONS='true'.

- `-e, --only-extensions`

  Set to true to only update the installed extensions under the valet user directory (~/.valet.d).
  This option can be set by exporting the variable VALET_ONLY_EXTENSIONS='true'.

- `--skip-extensions-setup`

  Set to true to skip the execution of extension setup scripts (if any, when updating extensions).
  This option can be set by exporting the variable VALET_SKIP_EXTENSIONS_SETUP='true'.

- `-b, --use-branch`

  Set to true to download Valet from a branch tarball instead of a release.
  In that case, the version is the branch name.
  Only works for new installations, not for updates.
  This option can be set by exporting the variable VALET_USE_BRANCH='true'.

- `-h, --help`

  Display the help for this command.

### Examples

- `valet self update`

  Update Valet to the latest version.

- `bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/commands.d/self-install.sh)"`

  Install the latest version of Valet, using all the default options.

- `bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/commands.d/self-install.sh)" -s --single-user-installation --unattended`

  Install the latest version of Valet in the user home directory and disable all interaction during the install process.

## ▶️ valet help

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

Valet helps you browse, understand and execute your custom bash commands.

Online documentation is available at https://jcaillon.github.io/valet/.

You can call valet without any commands to start an interactive session.

**Configuration through environment variables:**

Core features variables can be defined in the valet user config file. Run **valet self config** to open the configuration file with your default editor (the file will get created if it does not yet exist).

Command options can also be set through environment variables. Check the command help for more information.

**Create your own commands:**

You can create your own commands and have them available in valet.
A command is part of an extension, which is a collection of commands.

To get started, run the command **valet self create-extension**.

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

  Set the log level of valet (defaults to info).
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

  Returns in the path to the valet file to source in order to use valet in your scripts.
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

- `bootstrap`

  Bootstrap a k8s cluster by applying Kustomize configuration step by step.

- `chart-inflator`

  (Kustomize plugin) Inflates helm chart(s) from the given Kustomize generator specifications.

- `delete-resources`

  Delete k8s resources.

- `extension1`

  Do nothing.

- `extension2`

  Do nothing.

- `extension3`

  Do nothing.

- `fix-videos-name`

  Rename videos files in a directory.

- `generate`

  Generate the yaml from the given kustomize directory.

- `generate-manifests`

  Generate the k8s manifests as seen by ArgoCD for a GitOps repository.

- `help`

  Show the help of this program or of a specific command.

- `mustache-generator`

  (Kustomize plugin) Generate k8s resource list from a combination of mustaches templates and scopes.

- `mustache-replace-for-iac`

  Run mustache on a given file or string with the specifications from a platform or an operation-zone.

- `reset-argo-cd`

  Deletes all the ArgoCD resources from a cluster.

- `reset-cluster`

  Reset the k8s cluster by removing all objects deploying in the common-plane, tenants and operation zone.

- `self add-command`

  Add a new command to the current extension.

- `self add-library`

  Add a new library to the current extension.

- `self build`

  Index all the commands and libraries present in the valet user directory and installation directory.

- `self config`

  Open the configuration file of Valet with your default editor.

- `self document`

  Generate the documentation and code snippets for all the library functions of Valet.

- `self extend`

  Extends Valet by creating or downloading a new extension in the user directory.

- `self mock1`

  A command that only for testing valet core functions.

- `self mock2`

  A command that only for testing valet core functions.

- `self mock3`

  A command that only for testing valet core functions.

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

  Update valet and its extensions to the latest releases.

- `showcase command1`

  A showcase command that uses arguments and options.

- `showcase interactive`

  A showcase command that demonstrates how to interact with the user.

- `showcase sudo-command`

  A command that requires sudo.

- `terraform`

  Validate, plan or apply terraform files for a platform or an operation-zone.

- `test-repository`

  Test the validity of the gitops repository.

- `wait-pods`

  Wait for the k8s pods to be ready.

- `wait-resources`

  Wait for the k8s resources to be created.

### Examples

- `valet --help`

  Displays this help text.

- `valet -v a-command and-sub-command`

  Active **verbose** mode and run the command **a-command** with the sub command **and-sub-command**.

> Documentation generated for the version 0.30.1409 (2025-08-12).