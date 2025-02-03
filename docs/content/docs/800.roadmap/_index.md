---
title: 🔭 Roadmap
cascade:
  type: docs
weight: 800
url: /docs/roadmap
---

This page lists the features that I would like to implement in Valet. They come in addition to new features described in the [issues][valet-issues].

- prompt:
  - Finish prompt and interactive functions: prompt user for multiline text (doable with by just implementing a good _PROMPT_CALLBACK_FUNCTION_ON_ITEM_DISPLAY)
  - Prompt user for multi select.
  - prompt: add the possibility to position the autocompletion box (top/left/width/height)
  - Add a full screen view with the keyboard shortcuts in edit mode (new interactive::showFullScreenHelp ?).
- fzf: 
  - draw in a given rectangle, we handle full screen or not before calling sfzf
- log:
  - for the log functions, we can optionally display the function name and the line number of the caller + pid + shlvl. +ISO8601 time `printf "%(%FT%H:%M:%S%z)T" "${EPOCHSECONDS}"`. Let user customize the log format with a var? `[%t] %-5level %36logger %msg`. Show them how to output as json!
  - Refactor the logging functions to be more readable, see if we really need to precalculate them or if we can just compute on the fly. Remove createPrintFunction on SIGWINCH.
- progress:
  - refacto progress bar; use signal to tell the bg job to redraw the progress bar after displaying a log. +handle the terminal size to display the progress bar!
  - after logging, if progress bar is in progress, we need to redraw it immediately.
- all interactive functions must write to stderr not stdout!
- we split the commands file into several one, per extension, so we don't have to load everything immediately
- the config file should define everything, leave all def commented. When we self config we define only those already defined. We have an associative array of each var and description to handle this
- add info of the extension from which a command comes from
- in the menu we can filter by extension (and we see the extension of a command)
- propagate the set -x in self test subshells to have profiling enabled. We can create a new method in lib-profiler to profiler::reapply.
- test the "sudo" feature: it runs the command by forking. We could add an option to instead rerun valet with sudo.
- document the test; use the lib-test test as an example, and also link to the test:: lib.
- for interactive mode, a first iteration is to prompt the user in the scrolling terminal. Then we add an option to instead open a full screen editor.
- might be able to improve the quicksort if we use direct statements instead of functions.
- In benchmark, with debug mode on, we can compute the time spent on each line of a function (+ try to improve the fuzzy filter sort). See extdebug shopt.
- add snippets for the Ansi codes. Add snippets on the global variables.
- Demo with ascii cinema: https://asciinema.org. Put the showcase in the index page instead.
- For all the optional arguments of exported functions, allow to set them using a global variable `_OPTION_*` in addition to the positional argument. Add this in the documentation about functions.
- allow an array for options `--file 1 --file 2` -> `files=(1 2)` `--file <files*>`
- self-add-test
- for major version and breaking changes, we can add a lib `compat-x.x` which can be sourced by functions and declares functions as in version x.x.
- Filter build command for `commands.d` ?
- Add HOW TO documentation:
  - how to build and share a CLI application with Valet
  - how to use valet from your bash prompt
  - how to use valet in your existing scripts
- Add full support for interactive mode.
- For dropdown with a set list of options, we can verify that the input value is one of the expected value.
- For argument and option autocompletion, accept any multiline string that will be eval and that should set RETURNED_ARRAY with the list of possible completion.
- Generate an autocompletion script for bash and zsh.
- Add a command `self package` that build the user commands into a single script file. We want to add options to the build command so we can exclude some commands. It will include all source required and try to minify the bash script. In addition, we can rebrand *valet* into another name.
- Betters checks in self build!
- A command can declare dependencies to auto check if some tools are installed before running the command. Add `self download-dependencies` and `self check-dependencies` commands. Dependencies should not be checked/download in each command. Add a hint to play the commands if a tool is missing (exception caught).
- add valet in brew
- add man page for valet
- Add `valet.cmd` to the package, in self setup we can optionally add the valet install dir to the windows PATH.
- Allow self release to release extensions.
- Prompt improvements:
  - handle shift + arrows to highlight text
  - add a stack for kill/yank
  - add a stack for undo/redo
- add a new command self diagnostic that will run a series of tests to check the environment and help figure out what's wrong.
- option --install-dir (or cmd) to be able to eval "$(valet --install-dir)"

[valet-issues]: https://github.com/jcaillon/valet/issues
