---
title: 🔭 Roadmap
cascade:
  type: docs
weight: 800
url: /docs/roadmap
---

This page lists the features that I would like to implement in Valet. They come in addition to new features described in the [issues][valet-issues].

- rename CMD_ variables.
- Add full support for interactive mode.
- For dropdown with a set list of options, we can verify that the input value is one of the expected value.
- Generate an autocompletion script for bash and zsh.
- Self-command to create a new command interactively.
- We can have fuzzy matching on options too; just make sure it is not ambiguous.
- Create a valet-community-commands where everyone can contribute to new default commands for Valet.
- Optional strict mode (env var) to disable fuzzy matching (to not mistakenly execute a command on ci for instance).
- head / tail from file.
- Allow to regroup single letter options (e.g. -fsSL).
- Add a command self package that build the user commands into a single script file.
- fix running tests with verbose mode on.
- Allow to separate commands from options/arguments with `--`.
- Have a consistent look and feel for interactive functions.
- Reimplement usage of main::sortCommands / main::addLastChoice.
- Add a default value for options.
- Implement regex replace in pure bash.
- Show the arguments required when a command parsing fails.
- Betters checks in self build!
- Support alternative single comments `# ## VALET COMMAND` instead of multiline comments for command declaration (see we can have help in autocompletion).
- A command can declare dependencies to auto check if some tools are installed before running the command.
- Add test:: and also add a snippet to create a new function.
- add valet in brew
- Improve the self install script / check for updates by comparing the version number / suggest the user to git pull the repositories existing under .valet.d
- For argument and option autocompletion, accept any multiline string that will be eval and that should set RETURNED_ARRAY with the list of possible completion.


[valet-issues]: https://github.com/jcaillon/valet/issues
