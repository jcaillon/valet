# Test suite self-config

## Test script 01.self-config

### ✅ Testing selfConfig::getFileContent

❯ `selfConfig::getFileContent false`

❯ `string::head configContent 80`

Returned variables:

```text
REPLY='#!/usr/bin/env bash
# The config script for Valet.
# shellcheck disable=SC2034
# 
# Valet is configurable through environment variables.
# 
# To configure variables in bash, you should export them in your `~/.bashrc` file which gets included (source) on each startup.
# 
# In Valet, you can also set variables in special bash scripts which are sourced when the program starts.
# These scripts are:
# 
# - `~/.config/valet/config`: the Valet configuration file (this is the recommended way to configure Valet itself).
# - `./.env`: a `.env` in the current directory (the filename can be set with `VALET_CONFIG_DOT_ENV_SCRIPT`).
# 
# > **Tip:** Use the `.env` files to configure your project-specific variables.
# > Remember that command options are also configurable through environment variables!
# 
##############################
# 📄 About the config file
##############################
# 
# The config file is sourced by Valet on startup which allows you to setup variables to configure Valet.
# 
# Use the `valet self config` command to initialize and open the YAML configuration file.
# 
# You should not define all the variables, only the ones you want to change.
# 
# If you want environment variables exported in the shell to be prioritized over the ones in the config file,
# you can define variables with a default value like this:
# 
# ```bash
# VALET_CONFIG_MY_VAR="${VALET_CONFIG_MY_VAR:-"default value if not set"}"
# ```
# 
# Do not add custom code to this script, use the custom startup script instead (see next section).
# 
# If you break this file, valet will fail to start!
# You can delete it and run the `valet self config` command to recreate it.
# 
##############################
# 🚩 Custom startup script
##############################
# 
# You can define a custom startup script that will be sourced by Valet on startup.
# 
# This allows you to define custom functions or variables that will be available in Valet.
# 
# For example, the following script is convenient way to translate `CI_*` variables to `VALET_*` variables.
# The script should be named `startup` and be in the same directory as the config file.
# 
# ```bash
# # Convert argocd env vars to normal env vars
# _TO_EVAL=""
# for _MY_VARIABLE_NAME in ${!CI_*}; do
#   _TO_EVAL+="declare -g -n ${_MY_VARIABLE_NAME/#CI_/VALET_}=${_MY_VARIABLE_NAME};"$'"'"'\n'"'"'
# done
# eval "${_TO_EVAL}"
# ```
# 
##############################
# 🅰️ Configuration variables
##############################
# 
# All configuration variables in valet start with `VALET_CONFIG_`.
# 
# 
####################
# 🗺️ Configuration location
####################
# 
# These variables define the location of the configuration files.
# 
# They **MUST BE** declared outside the config file (in your `~/.bashrc`)!
# 
# VALET_CONFIG_DIRECTORY=""
# The path to the configuration directory of Valet.
# You can backup this directory to keep your configuration.
# Defaults to the `${XDG_CONFIG_HOME}/valet` or the `${HOME}/.config/valet` directory.
# 
# VALET_CONFIG_FILE=""
'
```

Testing selfConfig::getFileContent with exportCurrentValues:

❯ `selfConfig::getFileContent true`

❯ `string::head configContent 80`

Returned variables:

```text
REPLY='#!/usr/bin/env bash
# The config script for Valet.
# shellcheck disable=SC2034
# 
# Valet is configurable through environment variables.
# 
# To configure variables in bash, you should export them in your `~/.bashrc` file which gets included (source) on each startup.
# 
# In Valet, you can also set variables in special bash scripts which are sourced when the program starts.
# These scripts are:
# 
# - `~/.config/valet/config`: the Valet configuration file (this is the recommended way to configure Valet itself).
# - `./.env`: a `.env` in the current directory (the filename can be set with `VALET_CONFIG_DOT_ENV_SCRIPT`).
# 
# > **Tip:** Use the `.env` files to configure your project-specific variables.
# > Remember that command options are also configurable through environment variables!
# 
##############################
# 📄 About the config file
##############################
# 
# The config file is sourced by Valet on startup which allows you to setup variables to configure Valet.
# 
# Use the `valet self config` command to initialize and open the YAML configuration file.
# 
# You should not define all the variables, only the ones you want to change.
# 
# If you want environment variables exported in the shell to be prioritized over the ones in the config file,
# you can define variables with a default value like this:
# 
# ```bash
# VALET_CONFIG_MY_VAR="${VALET_CONFIG_MY_VAR:-"default value if not set"}"
# ```
# 
# Do not add custom code to this script, use the custom startup script instead (see next section).
# 
# If you break this file, valet will fail to start!
# You can delete it and run the `valet self config` command to recreate it.
# 
##############################
# 🚩 Custom startup script
##############################
# 
# You can define a custom startup script that will be sourced by Valet on startup.
# 
# This allows you to define custom functions or variables that will be available in Valet.
# 
# For example, the following script is convenient way to translate `CI_*` variables to `VALET_*` variables.
# The script should be named `startup` and be in the same directory as the config file.
# 
# ```bash
# # Convert argocd env vars to normal env vars
# _TO_EVAL=""
# for _MY_VARIABLE_NAME in ${!CI_*}; do
#   _TO_EVAL+="declare -g -n ${_MY_VARIABLE_NAME/#CI_/VALET_}=${_MY_VARIABLE_NAME};"$'"'"'\n'"'"'
# done
# eval "${_TO_EVAL}"
# ```
# 
##############################
# 🅰️ Configuration variables
##############################
# 
# All configuration variables in valet start with `VALET_CONFIG_`.
# 
# 
####################
# 🗺️ Configuration location
####################
# 
# These variables define the location of the configuration files.
# 
# They **MUST BE** declared outside the config file (in your `~/.bashrc`)!
# 
VALET_CONFIG_DIRECTORY=A\ value
# The path to the configuration directory of Valet.
# You can backup this directory to keep your configuration.
# Defaults to the `${XDG_CONFIG_HOME}/valet` or the `${HOME}/.config/valet` directory.
# 
# VALET_CONFIG_FILE=""
'
```

### ✅ Testing self config command

❯ `selfConfig`

**Standard output**:

```text
🙈 mocking myEditor: /tmp/valet-temp
```

**Error output**:

```text
INFO     Writing the valet config file ⌜/tmp/valet-temp⌝.
INFO     Opening the valet config file ⌜/tmp/valet-temp⌝.
```

❯ `fs::head /tmp/valet-temp 3`

**Standard output**:

```text
#!/usr/bin/env bash
# The config script for Valet.
# shellcheck disable=SC2034
```

Testing selfConfig (should only open, file does not exist)

❯ `selfConfig`

**Standard output**:

```text
🙈 mocking myEditor: /tmp/valet-temp
```

**Error output**:

```text
INFO     Opening the valet config file ⌜/tmp/valet-temp⌝.
```

Testing selfConfig override no edit

❯ `selfConfig --override --no-edit`

**Error output**:

```text
INFO     Writing the valet config file ⌜/tmp/valet-temp⌝.
```

Testing to export the current values

```text
VALET_CONFIG_LOCALE='/tmp/valet-temp'
```

❯ `selfConfig --override --export-current-values`

**Standard output**:

```text
🙈 mocking myEditor: /tmp/valet-temp
```

**Error output**:

```text
INFO     Writing the valet config file ⌜/tmp/valet-temp⌝.
INFO     Opening the valet config file ⌜/tmp/valet-temp⌝.
```

The path /tmp/valet-temp is in the config file as expected.

