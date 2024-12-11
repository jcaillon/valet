---
title: 🔭 Roadmap
cascade:
  type: docs
weight: 800
url: /docs/roadmap
---

This page lists the features that I would like to implement in Valet. They come in addition to new features described in the [issues][valet-issues].

- allow an array for options `--file 1 --file 2` -> `files=(1 2)` `--file <files*>`
- make `source` able to source multiple libraries that are called the same.
- add-test
- Filter build command for `commands.d` ?
- Add HOW TO documentation:
  - how to build and share a CLI application with Valet
  - how to use valet from your bash prompt
  - how to use valet in your existing scripts
- Finish prompt and interactive functions.
- Add full support for interactive mode.
- For dropdown with a set list of options, we can verify that the input value is one of the expected value.
- For argument and option autocompletion, accept any multiline string that will be eval and that should set RETURNED_ARRAY with the list of possible completion.
- Generate an autocompletion script for bash and zsh.
- Add a command `self package` that build the user commands into a single script file. We want to add options to the build command so we can exclude some commands. It will include all source required and try to minify the bash script. In addition, we can rebrand *valet* into another name.
- Betters checks in self build!
- A command can declare dependencies to auto check if some tools are installed before running the command. Add `self download-dependencies` and `self check-dependencies` commands. Dependencies should not be checked/download in each command. Add a hint to play the commands if a tool is missing (exception caught).
- add valet in brew
- add man page for valet
- functions:
  - head / tail from file.
  - test if folder is writeable
  - Implement regex replace in pure bash.
- Add `valet.cmd` to the package, in self setup we can optionally add the valet install dir to the windows PATH.
- Also export user defined functions.

[valet-issues]: https://github.com/jcaillon/valet/issues
