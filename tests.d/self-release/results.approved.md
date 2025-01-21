# Test suite self-release

## Test script 01.self-release

### ✅ Testing self release command

Testing selfRelease, dry run major version

❯ `selfRelease -t token -b major --dry-run`

**Error output**:

```text
INFO     Dry run mode is enabled, no changes will be made.
🙈 mocked io::invoke git tag --sort=version:refname --no-color
INFO     The last tag is: v1.2.3.
🙈 mocked curl::toVar true 200 -H Accept: application/vnd.github.v3+json https://api.github.com/repos/jcaillon/valet/releases/latest
INFO     The latest release on GitHub is: v1.2.3.
🙈 mocked io::invoke git rev-parse HEAD
INFO     The current version of valet is: 1.2.3.
🙈 mocked io::invoke git log --pretty=format:%s v1.2.3..HEAD
INFO     The tag message is:
   1 ░ # Release of version 1.2.3
   2 ░ 
   3 ░ Changelog: 
   4 ░ 
   5 ░ - ✨ feature
   6 ░ - 🐞 fix
   7 ░ 
🙈 mocked interactive::promptYesNo Do you want to continue with the release of version 1.2.3? false
INFO     The current version of valet is: 1.2.3.
INFO     The bumped version of valet is: 2.0.0.
SUCCESS  The new version has been released, check: https://github.com/jcaillon/valet/releases/latest.
```

Testing selfRelease, minor version

❯ `selfRelease -t token -b minor`

**Error output**:

```text
🙈 mocked io::invoke git tag --sort=version:refname --no-color
INFO     The last tag is: v1.2.3.
🙈 mocked curl::toVar true 200 -H Accept: application/vnd.github.v3+json https://api.github.com/repos/jcaillon/valet/releases/latest
INFO     The latest release on GitHub is: v1.2.3.
🙈 mocked io::invoke git rev-parse HEAD
🙈 mocked io::invokef5 false 0   git update-index --really-refresh
🙈 mocked io::invokef5 false 0   git diff-index --quiet HEAD
INFO     The current version of valet is: 1.2.3.
🙈 mocked io::invoke git log --pretty=format:%s v1.2.3..HEAD
INFO     The tag message is:
   1 ░ # Release of version 1.2.3
   2 ░ 
   3 ░ Changelog: 
   4 ░ 
   5 ░ - ✨ feature
   6 ░ - 🐞 fix
   7 ░ 
INFO     Generating documentation for the core functions only.
INFO     Found 159 functions with documentation.
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/extras/lib-valet.md
INFO     The documentation has been generated in ⌜$GLOBAL_VALET_HOME/extras/lib-valet.md⌝.
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/extras/lib-valet
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/extras/lib-valet
INFO     The prototype script has been generated in ⌜$GLOBAL_VALET_HOME/extras/lib-valet⌝.
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/extras/valet.code-snippets
INFO     The vscode snippets have been generated in ⌜$GLOBAL_VALET_HOME/extras/valet.code-snippets⌝.
INFO     Writing the 159 functions documentation to the core libraries docs.
🙈 mocked io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
🙈 mocked io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/codes.md
🙈 mocked io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/curl.md
🙈 mocked io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/fsfs.md
🙈 mocked io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
🙈 mocked io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/profiler.md
🙈 mocked io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/codes.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/codes.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/benchmark.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/benchmark.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/benchmark.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/curl.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/curl.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/curl.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/curl.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/fsfs.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/fsfs.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/profiler.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/profiler.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/profiler.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/profiler.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/progress.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/progress.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/progress.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/progress.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/progress.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/progress.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/progress.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/progress.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/progress.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/tui.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/version.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/version.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/version.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/version.md
🙈 mocked io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/version.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/version.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/codes.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/curl.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/fsfs.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/profiler.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/docs/static/config.md
🙈 mocked io::invoke cp $GLOBAL_VALET_HOME/.vscode/extensions.json $GLOBAL_VALET_HOME/extras/extensions.json
🙈 mocked io::invoke git add $GLOBAL_VALET_HOME/docs/static/config.md
🙈 mocked io::invoke git add $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/codes.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/curl.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/fsfs.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/profiler.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
🙈 mocked io::invoke git add $GLOBAL_VALET_HOME/extras/base.code-snippets $GLOBAL_VALET_HOME/extras/extensions.json $GLOBAL_VALET_HOME/extras/lib-valet $GLOBAL_VALET_HOME/extras/lib-valet.md $GLOBAL_VALET_HOME/extras/template-command-default.sh $GLOBAL_VALET_HOME/extras/template-library-default.sh $GLOBAL_VALET_HOME/extras/valet.code-snippets
🙈 mocked io::invoke git commit -m :memo: updating the documentation
SUCCESS  The documentation update has been committed.
🙈 mocked io::invoke sed -E -i s/VALET_RELEASED_VERSION="[0-9]+\.[^"]+"/VALET_RELEASED_VERSION="1.2.3"/ $GLOBAL_VALET_HOME/commands.d/self-install.sh
🙈 mocked io::invoke git add $GLOBAL_VALET_HOME/commands.d/self-install.sh
🙈 mocked io::invoke git commit -m :rocket: releasing version 1.2.3
SUCCESS  The new version has been committed.
🙈 mocked interactive::promptYesNo Do you want to continue with the release of version 1.2.3? false
🙈 mocked io::invoke git tag -a v1.2.3 -m # Release of version 1.2.3

Changelog: 

- ✨ feature
- 🐞 fix

SUCCESS  The new version has been tagged.
🙈 mocked io::invoke git push origin main
🙈 mocked io::invoke git push origin v1.2.3
SUCCESS  The ⌜main⌝ branch and the new version ⌜v1.2.3⌝ has been pushed.
🙈 mocked io::invoke git push origin -f main:latest
SUCCESS  The ⌜latest⌝ branch has been updated.
🙈 mocked curl::toVar true 201,422 -X POST -H Authorization: token token -H Accept: application/vnd.github.v3+json -H Content-type: application/json; charset=utf-8 -d {
    "name": "v1.2.3",
    "tag_name": "v1.2.3",
    "body": "# Release of version 1.2.3\n\nChangelog: \n\n- ✨ feature\n- 🐞 fix\n",
    "draft": false,
    "prerelease": false
  } https://api.github.com/repos/jcaillon/valet/releases
SUCCESS  The new version has been released on GitHub.
🙈 mocked io::invoke cp -R $GLOBAL_VALET_HOME/examples.d .
🙈 mocked io::invoke cp -R $GLOBAL_VALET_HOME/commands.d .
🙈 mocked io::invoke cp -R $GLOBAL_VALET_HOME/libraries.d .
🙈 mocked io::invoke cp -R $GLOBAL_VALET_HOME/extras .
🙈 mocked io::invoke cp -R valet .
🙈 mocked io::invoke cp -R $GLOBAL_VALET_HOME/version .
🙈 mocked io::invoke tar -czvf valet.tar.gz examples.d commands.d libraries.d extras valet version
INFO     Uploading the artifact ⌜valet.tar.gz⌝ to ⌜https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets⌝.
🙈 mocked curl::toVar true  -X POST -H Authorization: token token -H Content-Type: application/tar+gzip --data-binary @valet.tar.gz https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets?name=valet.tar.gz
INFO     The current version of valet is: 1.2.3.
🙈 mocked io::writeToFile $GLOBAL_VALET_HOME/version
INFO     The bumped version of valet is: 1.3.0.
🙈 mocked io::invoke git add $GLOBAL_VALET_HOME/version
🙈 mocked io::invoke git commit -m :bookmark: bump version to 1.3.0
🙈 mocked io::invoke git push origin main
SUCCESS  The bumped version has been committed.
SUCCESS  The new version has been released, check: https://github.com/jcaillon/valet/releases/latest.
```

