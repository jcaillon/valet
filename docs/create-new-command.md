# How to add your own command

## 0. Prerequisite

> [!IMPORTANT]
> In order to add a new command, you will need to "rebuild" Valet, which requires [yq](https://github.com/mikefarah/yq) to be present in your `PATH`.

## 1. Add a new command file

Copy the template command `showcase.sh` to a new file and rename it as you wish.

Files starting with a `.` are ignored, so the commands defined inside them are never shown in the valet menu.

## 2. Define your new command

Follow the example of the template to create a new `about_xxx` function that returns a YAML file describing your command. `xxx` is the function name of your command (see next chapter).

The available properties are:

- **command**: the name with which your command can be called by the user. E.g. `mycmd` will be accessible with `valet mycmd`.
- **fileToSource**: should always be equals to `${BASH_SOURCE[0]}`. It is the file that will be sourced to execute the function of your command.
- **sudo**: `true` if your command uses `sudo`; in which case we will prompt the user for sudo password before executing the command. `false` otherwise.  
- **shortDescription**: shortly describe your command; this will appear next to your command name in the valet menu.
- **description**: long description of your command and its purpose.
- **options**: a list of options for your command. Don't forget that, by definition, an option is optional (i.e. it is not mandatory like an argument). If you expect an option to be defined, then it is an argument.
- **arguments**: a list of mandatory arguments for your command. If the user does not provide an argument, your command should fail. Otherwise, that means it is an option, not an argument.
- **examples**: a list of examples for your command.

All commands will have, by default, an `-h, --help` option to display the help of this command.

## 3. Implement your command

The `xxx` (in your `about_xxx` function) must be the name of the function that implements your command.

Implement your command in new function named `xxx` placed in the same file as the `about_xxx` function.

Valet has a function to parse the expected options and arguments directly into variables. See the example file `showcase.sh`. Here is a standard usage of the parser:

```bash
local myOption myArgument
# parse the arguments of the command
parseArguments "$@" && eval "${LAST_RETURNED_VALUE}"
# check if we need to fail because there was some inputs errors or if we need to just display the help
checkParseResults "${help:-}" "${parsingErrors:-}"

# check if the user asked to just display the help of this command
if [ -n "${help:-}" ]; then showHelp; return 0; fi

# check if the parser caught some errors and fail if so
if [ -n "${parsingErrors:-}" ]; then fail "${parsingErrors}"; fi

# use options and arguments
echo "${myOption} > ${myArgument}"
# e.g. if the user called
# valet mycmd --my-option opt1 arg1
# the line above would display
# opt1 > arg1
```

- An option named `-o, --my-option` will translate to a local variable `myOption` (takes the first long name found and convert it to camel case).
- An argument named `my-argument` will translate to a local variable `myArgument` (camel case).
- An argument named `my-other-args...` will translate to a local bash array `myOtherArgs` (camel case). Note that only the last argument can end with `...` to indicate an array of arguments.
- `parsingErrors` will contain the parsing error messages (one per line).

The function `parseFunctionArgumentsOrGoInteractive` will return a string that can be evaluated to define the parsed variables. E.g. it can look like that:

```bash
local parsingErrors myOption myArgument
myoptions="opt1"
myArgument="arg1"
parsingErrors="Unknown option '--truc'"
```

In the function of a command, you have access to all functions defined in `valet.d/core`.

In case of error, your function should call the `fail` directly which will exit the program while displaying a meaningful message to the user.

> [!TIP]
> Please check [docs/working-on-bash-scripts.md](docs/working-on-bash-scripts.md) to learn more about working on bash scripts and create performant scripts.

## 4. Rebuild valet menu

In order to find your new command in the valet menu; you need to call the `self build` command. Either from the valet menu or by executing directly `./valet.d/self-build`. The later option is mandatory if you have an issue with the `valet.d/cmd` file itself.

The build process consists of recreating the `valet.d/cmd` program by reading all the `about_xxx` functions and extracting info from the YAML definition. It also appends all the functions defined in `cmd-extra`.

## Extra: defining sub commands

If your new command name contains one or more spaces, you are defining a sub command. E.g. `sub cmd` defines a command `cmd` which is a sub command of the `sub` command. It can be useful to regroup commands under a theme. You can have a sub valet menu for the sub command `sub` which displays only the commands under this command.

The body of the function for the `sub` command should be:

```bash
showSubMenu "$@"
```

An example is available under `valet.d/cmdd/self.sh`.
