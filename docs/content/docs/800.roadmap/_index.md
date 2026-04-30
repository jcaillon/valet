---
title: 🔭 Roadmap
cascade:
  type: docs
weight: 800
url: /docs/roadmap
---

This page lists the features that I would like to implement in Valet. They come in addition to new features described in the [issues][valet-issues].

- bug on self test when resizing the terminal mid test!!!
- time better function time function to be able to use them opstools and compute timers and timeout !
- make version a command instead of an option, and add a `valet version` command that shows the current version and the latest release. Also show the extension versions ?
- implement fs::normalizePath
- Modify self install: at the moment we count on the fact that some functions will still exist in valet after an update. The simplest is to redownload the self install script and run it again.
- Implement tests that are only run with -e flag and where we test system specific stuff, like the windows library and fs::createLink, absolute path with real path etc...
- validate execution of .env or .envrc
- Arguments parser:
  - Make the program parser catch all global options and verify in the build command that we do not reuse the same global option in different commands.
  - Allow options to be inherited from parent commands. We can check the existence of the base options in the command::parse function (for verbose, log level, progress bars). For source and version, mark them as `inherited: false` as we only want to handle them in the main parsing loop, at valet level.
  - allow an array for options `--file 1 --file 2` -> `files=(1 2)` `--file <files*>`
- test the "sudo" feature: it runs the command by forking. We could add an option to instead rerun valet with sudo.
- make a real test for the self install / extend commands.
- add a yaml library for basic parsing. Same for json. The parse method can optionally output .keys and .length variable allowing to easily loop over keys or arrays (e.g. REPLY_ASSOCIATIVE_ARRAY["thing.stuff.length"])
- Check the bash-links command, error when creating a link if the destination path already exists as a folder.
- Add tooltip in interactive functions (Enter shows help, Tab autocompletes, etc...)
- document debugging with strace
- Check error handling inside ifs and evals.
- Check how we can make the list component work in the main screen while user is scrolling. Seems like gum is doing it by positioning the cursor at the end of the screen always, and then using move cursor left to trigger an automatic scroll that takes the user back at the right spot.
- test with bash 5.1, 5.2 and 5.3 in the pipeline (with different distros each time).
- handle the drawing of TUI panels in a coproc so each has its own set of variables for its state.
- add a global --edit option to edit the command function file
- for the showcase, actually build a small app like a git conventional commit tool.
- prompt:
  - Finish prompt and interactive functions: prompt user for multiline text (doable with by just implementing a good _PROMPT_CALLBACK_FUNCTION_ON_ITEM_DISPLAY)
  - Prompt user for multi select.
  - Add a full screen view with the keyboard shortcuts in edit mode (new interactive::showFullScreenHelp ?).
- fzf:
  - draw in a given rectangle, we handle full screen or not before calling sfzf
- main menu:
  - add info of the extension from which a command comes from
  - in the menu we can filter by extension (and we see the extension of a command)
- When calling `valet extension-name`, it should show the commands of the extension.
- Add full support for interactive mode:
  - prompt the user in the scrolling terminal. Then we add an option to instead open a full screen editor.
- In benchmark, with debug mode on, we can compute the time spent on each line of a function. See extdebug shopt.
- add snippets for the esc codes. Add snippets on the global variables.
- Revamp self build:
  - an error in the user extensions should not prevent from building valet core commands so we don't fail an install
  - add more checks on command definition
  - Filter build command for `commands.d` directory
  - we split the commands file into several one, per extension, so we don't have to load everything immediately
  - self build has 2 modes: either build each command with the extension preprend (yg generate, showcase interactive); this is the default. Or also give the option to build the commands without the extension prefix.
- Tests:
  - add an option to display the received outputs markdown instead of comparing (or in addition to comparing). We can add our own function to display a markdown file.
  - self-add-test
  - propagate the set -x in self test subshells to have profiling enabled. We can create a new method in lib-profiler to profiler::reapply.
  - document the test; use the lib-test test as an example, and also link to the test:: lib.
- for major version and breaking changes, we can add a lib `compat-x.x` which can be sourced by functions and declares functions as in version x.x.
- Add HOW TO documentation:
  - how to build and share a CLI application with Valet
  - how to use valet from your bash prompt
  - how to use valet in your existing scripts
- For dropdown with a set list of options, we can verify that the input value is one of the expected value.
- For argument and option autocompletion, accept any multiline string that will be eval and that should set REPLY_ARRAY with the list of possible completion.
- Generate an autocompletion script for bash and zsh.
- Add a command `self package` that build the user commands into a single script file. We want to add options to the build command so we can exclude some commands. It will include all source required and try to minify the bash script.
- Allow an extension maintainer to create a tool where valet is not mentioned. Idea: a simple shim that allows to override the valet COMMAND_YAML + translates XXX_ variables into VALET_variables + in the help, hint to use XXX_ vars instead of VALET_ vars.
- add valet in brew
- add man page for valet
- Allow self release to release extensions.
- Prompt improvements:
  - handle shift + arrows to highlight text
  - add a stack for kill/yank
  - add a stack for undo/redo
- add a new command self diagnostic that will run a series of tests to check the environment and help figure out what's wrong.
- Add an option to enter interactive debug mode when an error occurs and on each log::print call.
- Add a function to display a table, use it for benchmark.
- Add a function to display a text using figlet fonts.
- Links to file and line number of each function implementation.
- implement a simple http server with accept

[valet-issues]: https://github.com/jcaillon/valet/issues

{{< main-section-end >}}
