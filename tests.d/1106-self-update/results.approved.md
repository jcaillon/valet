# Test suite 1106-self-update

## Test script 01.self-update

### Install script usage

Exit code: `0`

**Standard** output:

```plaintext
→ valet self update --help
ABOUT

  Update valet using the latest release on GitHub. Also update all installed extensions.
  
  This script can also be used as a standalone script to install Valet:
  
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/valet.d/commands.d/self-install.sh)"
  
  If you need to pass options (e.g. --single-user-installation) to the script, you can do it like this:
  
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/valet.d/commands.d/self-install.sh)" -s --single-user-installation
  
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
  
  - 4. Copy the examples in the valet user directory ~/.valet.d.
  
  - 6. Run self setup command (in case of a new installation) or re-export the config.
  
  - 7. Try to update (fetch merge --ff-only) the git repositories and all installed extensions in your valet user directory.
  

USAGE

  valet [global options] self update [options]

GLOBAL OPTIONS

  -x, --profiling
      Turn on profiling (with debug mode) before running the required command.
      It will output to ~/valet-profiler-{PID}-command.txt.
      This is useful to debug your command and understand what takes a long time to execute.
      The profiler log will be cleanup to only keep lines relevant for your command script. You can disable this behavior by setting the environment variable VALET_CONFIG_KEEP_ALL_PROFILER_LINES to true.
      This option can be set by exporting the variable VALET_PROFILING='true'.
  -l, --log-level, --log <level>
      Set the log level of valet (defaults to info).
      Possible values are: trace, debug, success, info, success, warning, error.
      This option can be set by exporting the variable VALET_LOG_LEVEL,='<level>'.
  -v, --verbose
      Output verbose information.
      This is the equivalent of setting the log level to debug.
      This option can be set by exporting the variable VALET_VERBOSE='true'.
  -w, --very-verbose
      Output very verbose information.
      This is the equivalent of setting the log level to trace.
      This option can be set by exporting the variable VALET_VERY_VERBOSE='true'.
  --disable-progress-bars
      Disable all progress bars for commands that use them.
      This option can be set by exporting the variable VALET_DISABLE_PROGRESS_BARS='true'.
  -i, --force-interactive-mode
      Enter interactive mode for commands even if arguments are not required or provided.
      This option can be set by exporting the variable VALET_FORCE_INTERACTIVE_MODE='true'.
  --version
      Display the current version of valet.
  -h, --help
      Display the help for this command.

OPTIONS

  -u, --unattended
      Set to true to not enter interactive mode for the setup (useful for automated installation).
      This option can be set by exporting the variable VALET_UNATTENDED='true'.
  -s, --single-user-installation
      Set to true to install Valet for the current user only.
      
      Note: for windows, the installation is always for the current user.
      This option can be set by exporting the variable VALET_SINGLE_USER_INSTALLATION='true'.
  -v, --version <version>
      The version number to install (do not including the starting 'v').
      
      Released versions can be found here: https://github.com/jcaillon/valet/releases
      
      This option can be set by exporting the variable VALET_VERSION='<version>'.
  -d, --installation-directory <path>
      The directory where Valet will be installed.
      
      Defaults to /opt/valet for a multi user installation and ~/.local/valet otherwise.
      This option can be set by exporting the variable VALET_INSTALLATION_DIRECTORY='<path>'.
  -S, --no-shim
      Set to true to not create the shim script in /usr/local/bin.
      This option can be set by exporting the variable VALET_NO_SHIM='true'.
  -P, --no-path
      Set to true to not add the Valet directory to the PATH (append to your .bashrc file).
      This option can be set by exporting the variable VALET_NO_PATH='true'.
  -E, --no-examples
      Set to true to to not copy the examples (showcase) to the valet user directory (~/.valet.d).
      
      If you do not set this option, newer examples will override the existing ones.
      
      In case of an update, if the showcase directory does not exist, the examples will not be copied.
      This option can be set by exporting the variable VALET_NO_EXAMPLES='true'.
  -U, --skip-extensions
      Set to true to not attempt to update the installed extensions under the valet user directory (~/.valet.d).
      This option can be set by exporting the variable VALET_SKIP_EXTENSIONS='true'.
  -e, --only-extensions
      Set to true to only update the installed extensions under the valet user directory (~/.valet.d).
      This option can be set by exporting the variable VALET_ONLY_EXTENSIONS='true'.
  -b, --use-branch
      Set to true to download Valet from a branch tarball instead of a release.
      In that case, the version is the branch name.
      Only works for new installations, not for updates.
      This option can be set by exporting the variable VALET_USE_BRANCH='true'.
  -h, --help
      Display the help for this command.

EXAMPLES

  valet self update
      Update Valet to the latest version.
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/valet.d/commands.d/self-install.sh)"
      Install the latest version of Valet, using all the default options.
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/valet.d/commands.d/self-install.sh)" -s --single-user-installation --unattended
      Install the latest version of Valet in the user home directory and disable all interaction during the install process.
      

```

### Testing selfUpdate, nothing to do (already up to date)

Exit code: `0`

**Standard** output:

```plaintext
→ selfUpdate --skip-extensions
```

**Error** output:

```log
SUCCESS  You already have the latest version.
```

