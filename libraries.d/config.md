<!-- markdownlint-disable MD041 -->

Valet is configurable through environment variables.

To configure variables in bash, you should defined them in your `~/.bashrc` file which gets included (source) on each startup.

In Valet, you can also set variables in special bash scripts which are sourced when the program starts.
These scripts are:

- `~/.config/valet/config`: the Valet configuration file (this is the recommended way to configure Valet itself).
- `./.env`: a `.env` in the current directory (the filename can be set with `VALET_CONFIG_DOT_ENV_SCRIPT`).

> **Tip:** Use the `.env` files to configure your project-specific variables.
> Remember that command options are also configurable through environment variables!

## 📄 About the config file

The config file is sourced by Valet on startup which allows you to setup variables to configure Valet.

Use the `valet self config` command to initialize and open the YAML configuration file.

You should not define all the variables, only the ones you want to change.

If you want environment variables exported in the shell to be prioritized over the ones in the config file,
you can define variables with a default value like this:

```bash
VALET_CONFIG_MY_VAR="${VALET_CONFIG_MY_VAR:-"default value if not set"}"
```

Do not add custom code to this script, use the custom startup script instead (see next section).

If you break this file, valet will fail to start!
You can delete it and run the `valet self config` command to recreate it.

## 🚩 Custom startup script

You can define a custom startup script that will be sourced by Valet on startup.

This allows you to define custom functions or variables that will be available in Valet.

For example, the following script is convenient way to translate `CI_*` variables to `VALET_*` variables.
The script should be named `startup` and be in the same directory as the config file.

```bash
# Convert argocd env vars to normal env vars
_TO_EVAL=""
for _MY_VARIABLE_NAME in ${!CI_*}; do
  _TO_EVAL+="declare -g -n ${_MY_VARIABLE_NAME/#CI_/VALET_}=${_MY_VARIABLE_NAME};"$'\n'
done
eval "${_TO_EVAL}"
```

## 🅰️ Configuration variables

All configuration variables in valet start with `VALET_CONFIG_`.

<!-- __________________ CONFIG LOCATION ______________________ -->

### 🗺️ Configuration location

These variables define the location of the configuration files.

They **MUST BE** declared outside the config file (in your `~/.bashrc`)!

#### VALET_CONFIG_DIRECTORY

The path to the configuration directory of Valet.
You can backup this directory to keep your configuration.
Defaults to the `${XDG_CONFIG_HOME}/valet` or the `${HOME}/.config/valet` directory.

#### VALET_CONFIG_FILE

The path to this Valet config file.
Export the variable before calling Valet.
Default to the `config` file in your config directory.

<!-- __________________ GENERAL ______________________ -->

### ⚙️ General configuration

#### VALET_CONFIG_USER_VALET_DIRECTORY

The directory in which to find the user commands.
Defaults to the `${HOME}/.valet.d`.

#### VALET_CONFIG_USER_DATA_DIRECTORY

The path to the directory in which to store the user-specific data files.
Defaults to the `${XDG_DATA_HOME}/valet` or the `${HOME}/.local/share/valet` directory.

#### VALET_CONFIG_USER_CACHE_DIRECTORY

The path to the directory in which to store the user cache data.
Defaults to the `${XDG_CACHE_HOME}/valet` or the `${HOME}/.cache/valet` directory.

#### VALET_CONFIG_USER_STATE_DIRECTORY

The path to the directory in which to store the user state data.
Defaults to the `${XDG_STATE_HOME}/valet` or the `.local/state/valet` directory in the user home directory.

#### VALET_CONFIG_TEMP_DIRECTORY

The directory used in valet to store all temporary files and directories created by the program.
Defaults to the temporary directory `${TMPDIR}` or `/tmp`.

#### VALET_CONFIG_RUNTIME_DIRECTORY

The directory in which to write work files (small files to capture output of programs).
You can set it to a `tmpfs` directory (such as /dev/shm) to speed up the execution of valet.
Defaults to the `${XDG_RUNTIME_DIR}` or the temporary directory.

#### VALET_CONFIG_LOCALE

The value is used to set `LC_ALL` and `LANG` in Valet (see the bash manual for more details on these variables).
Defaults to `C.UTF-8` to ensure that the output is consistent across different systems.

#### VALET_CONFIG_DOT_ENV_SCRIPT

The name of a script which will be sourced by Valet on startup if it is present in
the current directory. This allows you to define custom functions or variables that
will be available in Valet.
Defaults to the `.env` file in the current directory.

<!-- ___________________ FEATURES _____________________ -->

### ✨ Main features configuration

#### VALET_CONFIG_ENABLE_COLORS

If true, will forcibly enable the color output (otherwise we try to detect color support on start).

#### VALET_CONFIG_ENABLE_NERDFONT_ICONS

If true, will enable the icons (using nerd font).

#### VALET_CONFIG_DISABLE_ESC_CODES

If true, will disable all ANSI escape codes.
This will break Valet usage in the terminal, this option is intended to be used in a CI environment
where you want to disable all colors and escape codes.

#### VALET_CONFIG_DISABLE_TEXT_ATTRIBUTES

If true, will disable all Select Graphic Rendition escape codes that modify the text attributes.
It can be used if your terminal does not support text attributes.

#### VALET_CONFIG_TEST_DIFF_COMMAND

The command (with arguments) that will be used to diff files in the `valet test` command.

The command should have 2 placeholders: `%APPROVED_FILE%` and `%RECEIVED_FILE%`. They
will be replaced by the paths of the approved and received files.
You can change that command to use your favorite diff tool.

This defaults to:

- `delta --paging=never --no-gitconfig --line-numbers --side-by-side %APPROVED_FILE% %RECEIVED_FILE%`
  if delta is available.
- `diff --color -u %APPROVED_FILE% %RECEIVED_FILE%`
  if diff is available.
- `internalCompare %APPROVED_FILE% %RECEIVED_FILE%`
  otherwise (internalCompare is a bash function that compares 2 files).

It is strongly advised to install delta to get the best test outputs: <https://github.com/dandavison/delta>.

#### VALET_CONFIG_STRICT_MATCHING

Set this to `true` to disable fuzzy matching of commands and options.

By default, Valet will try to match the command or option you typed with the closest
command or option available. If you set this to `true`, Valet will only match
commands and options that are exactly the same as what you typed.

This is useful in a CI environment where you want to make sure that the command
you typed is the exact command that will be executed.

#### VALET_CONFIG_STRICT_PURE_BASH

If true, will always use the pure bash implementation, even if we could use an existing binary in the path.

#### VALET_CONFIG_REMEMBER_LAST_CHOICES

Number of last choices to remember when selecting an item from a command menu.
Set to 0 to disable this feature and always display items in the alphabetical order.

<!-- _________________ LOG _______________________ -->

### 🪵 Log configuration

Valet allows you to precisely define the format of the logs by using a pattern and various options.

#### VALET_CONFIG_LOG_PATTERN

The pattern to display a log line.

The default pattern simply display the time, log level (with level icon if `VALET_CONFIG_ENABLE_NERDFONT_ICONS` is true) and message: `<colorFaded><time>{(%H:%M:%S)T}<colorDefault> <levelColor><level> <icon><colorDefault> <message>`

You can use the following placeholders:

- `<colorXXX>`: The value of the color variable `VALET_CONFIG_COLOR_XXX`.
- `<time>`: The current time formatted with the format string.
- `<level>`: The log level.
- `<levelColor>`: The color for the log level.
- `<icon>`: The log level icon.
- `<pid>`: The process ID of the bash instance that logged the message.
- `<subshell>`: The subshell level of the bash instance that logged the message.
- `<function>`: The name of the function that logged the message.
- `<line>`: The line number where the message was logged.
- `<source>`: The source of the function that logged the message.
- `<varXXX>`: The value of an arbitrary variable `XXX`.
- `<message>`: The log message (should be the last placeholder).
- `<sourceFile>`: The file name of the source of the function that logged the message.
- `<wrapPadding>`: The padding (spaces) used for wrapping the log message.
- `<elapsedTime>`: The time elapsed since the start of the script.
- `<elapsedTimeSinceLastLog>`: The time elapsed since the last log.

Each placeholder can be followed by `{...}` to add the format specifier (see printf help).

Examples:

- Java like logs: `"<colorFaded><time>{(%H:%M:%S)T} (+<elapsedTimeSinceLastLog>{7s}) [<pid>{05d}:<subshell>{1s}] <levelColor><level><colorDefault> <colorFaded><sourceFile>{10s}:<line>{-4s}<colorDefault> -- <message>"`
- JSON output: `'{"level": "<level>{s}", "message": "<message>{s}", "source": "<source>{s}", "line": "<line>{s}"}'`
- Boxed messages: `"<colorFaded>╭─<time>{(%H:%M:%S)T}──<levelColor><level>{7s}<colorFaded>────────<sourceFile>{10s}:<line>{-4s}───░<colorDefault>"$'\n'"<colorFaded>│<colorDefault>  <message>"$'\n'"<colorFaded>╰─ +<elapsedTimeSinceLastLog>{7s}──────────────────────────────────░<colorDefault>"$'\n'`
- Subtitles message: `"<levelColor><level><colorDefault> <message>"$'\n'"<colorFaded><elapsedTime>{8s} (+<elapsedTimeSinceLastLog>{7s}) | pid <pid>{5s} | shlvl <subshell>{-1s} | from <sourceFile>{10s}:<line>{-4s}<colorDefault>"`

#### VALET_CONFIG_LOG_PATTERN_ALTERNATIVE

The pattern to display a log line when the alternative log mode is used (global option `-a`).

Defaults to: `"<colorFaded><elapsedTime>{8s} (+<elapsedTimeSinceLastLog>{7s}) [<pid>{05d}:<subshell>{1s}] <levelColor><level>{7s}<colorDefault> <colorFaded><sourceFile>{15s}:<line>{-4s}<colorDefault> <message>"`

#### VALET_CONFIG_LOG_FORMATTED_EXTRA_EVAL

Contains a bash code executed before the print statement, to further process the variable `messageToPrint`
(containing the log message) or define new variables to use in the log pattern
with `<varXXX>` placeholders.

#### VALET_CONFIG_LOG_COLUMNS

Sets the maximum width for the log output (used only when log wrapping is enabled). This default to your terminal width, but it can be convenient to define it in a CI/headless environment.

#### VALET_CONFIG_LOG_DISABLE_WRAP

If true, will disable the text wrapping for logs.

#### VALET_CONFIG_LOG_DISABLE_HIGHLIGHT

If true, will disable the highlight for ⌜quoted⌝ text in logs.

#### VALET_CONFIG_LOG_FD

The file descriptor in which to print the logs (defaults to `2` to output to stderr). Can also be set to a file path e.g. `/my/log`.

#### VALET_CONFIG_LOG_TO_DIRECTORY

A path to directory in which we will create one log file per valet execution, which
will contain the valet logs.

#### VALET_CONFIG_LOG_FILENAME_PATTERN

A string that will be evaluated to set a variable `logFile` which represents
the name of the file in which to write the logs.

Only used if VALET_CONFIG_LOG_TO_DIRECTORY is set.

The default is equivalent to setting this string to: `printf -v logFile '%s%(%FT%H-%M-%S%z)T%s' 'valet-' \${EPOCHSECONDS} '.log'`.

<!-- _________________ PROFILER _______________________ -->

### 🕵️ Profiler configuration

#### VALET_CONFIG_COMMAND_PROFILING_FILE

The path to the file in which to write the profiling information for the command.
Defaults to a new file under ~/.local/state/valet/logs.

#### VALET_CONFIG_KEEP_ALL_PROFILER_LINES

The profiler log will be cleanup to only keep lines relevant for your command script
If true, it disables this behavior and you can see all the profiler lines.

<!-- _________________ LIBRARIES _______________________ -->

### 🖱️ Interactive mode configuration

#### VALET_CONFIG_PROGRESS_DEFAULT_TEMPLATE

Change the default progress template.
See progress::start.

#### VALET_CONFIG_PROGRESS_BAR_DEFAULT_SIZE

Change the default progress bar size.

#### VALET_CONFIG_PROGRESS_DEFAULT_ANIMATION_DELAY

Change the default time between two frames for the animation of the spinner in the progress (in milliseconds).
See progress::start.

#### VALET_CONFIG_PROGRESS_DEFAULT_UPDATE_INTERVAL

The default number of animation frames to wait between two updates of the progress bar.

#### VALET_CONFIG_PROMPT_KEY_MAPPING

The key mapping for the prompts. This variable must be a valid bash associative array.
Each key is a key code and the value is the action to perform.

You don't have to define all the keys, only the ones you want to change.

E.g.

```bash
VALET_CONFIG_PROMPT_KEY_MAPPING=(
  ["CTRL+Y"]="yank"
  ["DEL"]="delete-char"
  ["UP"]="move-up"
  ["DOWN"]="move-down"
)
```

<!-- _________________ THEME _______________________ -->

### 🎨 Theme configuration

TODO: To be done.

<!-- _________________ Developer _______________________ -->

### 🧑‍💻 Developer configuration

#### VALET_CONFIG_BUMP_VERSION_ON_BUILD

If true, will enable the automatic bump of the version of Valet on build.
Intended for Valet developers only.

#### VALET_CONFIG_STARTUP_PROFILING

If true, will enable debug mode with profiling for valet ON STARTUP.
It must defined outside the config file (in your `~/.bashrc` or exporting before running valet).
This is intended for Valet developers to debug the startup of Valet.
To debug your commands, use the -x option.

#### VALET_CONFIG_STARTUP_PROFILING_FILE

The path to the file in which to write the profiling information for the startup of Valet.
It must defined outside the config file (in your `~/.bashrc` or exporting before running valet).
Defaults to a new file in your user state directory `~/.local/state/valet/logs`.

#### VALET_CONFIG_CORE_DUMP_ON_EXIT

Force the creation of a core dump file when valet exits.
Dump files are created in the user state directory in `~/.local/state/valet/core-dumps` by default.

<!-- END -->