---
title: 🔭 Roadmap
cascade:
  type: docs
weight: 800
url: /docs/roadmap
---

This page lists the features that I would like to implement in Valet. They come in addition to new features described in the [issues][valet-issues].

- rename CMD_ variables.
- Document everything. Document test.
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
- Replace awk with bash.
- Provide an alternative bash function if diff is not found.
- Allow to separate commands from options/arguments with `--`.
- Have a consistent look and feel for interactive functions.
- Reimplement usage of main::sortCommands / main::addLastChoice.
- Add a default value for options.
- Implement regex replace in pure bash.
- Show the arguments required when a command parsing fails.
- Betters checks in self build!
- Support alternative single comments `# ## VALET COMMAND` instead of multiline comments for command declaration (see we can have help in autocompletion).
- A command can declare dependencies to auto check if some tools are installed before running the command.
- Try to add a variable that allows to output the logs to a given file in addition to &2 and we generate a unique file for each time valet is run.
- On release:
  - Update `docs/static/config.md`
  - Add the built-in commands help in the docs.
- Add test:: and also add a snippet to create a new function.
- Generate vscode snippets from each function in core and lib-* to provide autocompletion for users.
  Alternatively, generate a single sh containing all the function definitions with comments...

[valet-issues]: https://github.com/jcaillon/valet/issues
