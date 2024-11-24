---
title: 🔭 Roadmap
cascade:
  type: docs
weight: 800
url: /docs/roadmap
---

This page lists the features that I would like to implement in Valet. They come in addition to new features described in the [issues][valet-issues].

- Add a config to remove commands from being built.
- In self setup allow to install additional commands from a git repository.
- Allow repos under .valet user dir:
  - to have `lib.d` folders: on self build we add these path as targets for 'source' in addition to `valet.d/lib-*` and we also add a `valet self generate-snippets` to export the snippets under valet dir which include all functions from said libs.
  - to have a setup.sh that is played on install or update
- Add HOW TO documentation:
  - how to build and share a CLI application with Valet
  - how to use valet from your bash prompt
  - how to use valet in your existing scripts 
- Finish autocompletion and interactive functions.
- Add full support for interactive mode.
- For dropdown with a set list of options, we can verify that the input value is one of the expected value.
- For argument and option autocompletion, accept any multiline string that will be eval and that should set RETURNED_ARRAY with the list of possible completion.
- Self-command to create a new command interactively. It can create a new git repo under the valet directory if git is found.
- Add a command to setup a git repo as a Valet commands dir
- Generate an autocompletion script for bash and zsh.
- Create a valet-community-commands where everyone can contribute to new default commands for Valet.
- Add a command self package that build the user commands into a single script file.
- fix running tests with verbose mode on.
- Betters checks in self build!
- A command can declare dependencies to auto check if some tools are installed before running the command. Add `self download-dependencies` and `self check-dependencies` commands. Dependencies should not be checked/download in each command. Add a hint to play the commands if a tool is missing (exception caught).
- add valet in brew
- add man page for valet
- allow to do that: `eval "$(valet self uninstall)"` to clean everything up
- functions:
  - head / tail from file.
  - test if folder is writeable
  - Implement regex replace in pure bash.

[valet-issues]: https://github.com/jcaillon/valet/issues
