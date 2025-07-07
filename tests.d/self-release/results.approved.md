# Test suite self-release

## Test script 01.self-release

### ✅ Testing self release command

Testing selfRelease, dry run major version

❯ `selfRelease -t token -b major --dry-run`

**Error output**:

```text
INFO     Dry run mode is enabled, no changes will be made.
🙈 mocked exe::invoke git tag --sort=version:refname --no-color
INFO     The last tag is: v1.2.3.
🙈 mocked curl::request true 200 -H Accept: application/vnd.github.v3+json https://api.github.com/repos/jcaillon/valet/releases/latest
INFO     The latest release on GitHub is: v1.2.3.
🙈 mocked exe::invoke git rev-parse HEAD
INFO     The current version of valet is: 1.2.3.
🙈 mocked exe::invoke git log --pretty=format:%s v1.2.3..HEAD
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
🙈 mocked exe::invoke git tag --sort=version:refname --no-color
INFO     The last tag is: v1.2.3.
🙈 mocked curl::request true 200 -H Accept: application/vnd.github.v3+json https://api.github.com/repos/jcaillon/valet/releases/latest
INFO     The latest release on GitHub is: v1.2.3.
🙈 mocked exe::invoke git rev-parse HEAD
🙈 mocked exe::invokef5 false 0   git update-index --really-refresh
🙈 mocked exe::invokef5 false 0   git diff-index --quiet HEAD
INFO     The current version of valet is: 1.2.3.
🙈 mocked exe::invoke git log --pretty=format:%s v1.2.3..HEAD
INFO     The tag message is:
   1 ░ # Release of version 1.2.3
   2 ░ 
   3 ░ Changelog: 
   4 ░ 
   5 ░ - ✨ feature
   6 ░ - 🐞 fix
   7 ░ 
INFO     Generating documentation for the core functions only.
INFO     Found 190 functions with documentation.
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/extras/lib-valet.md
INFO     The documentation has been generated in ⌜$GLOBAL_INSTALLATION_DIRECTORY/extras/lib-valet.md⌝.
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/extras/lib-valet
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/extras/lib-valet
INFO     The prototype script has been generated in ⌜$GLOBAL_INSTALLATION_DIRECTORY/extras/lib-valet⌝.
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/extras/valet.code-snippets
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/extras/valet.code-snippets
INFO     The vscode snippets have been generated in ⌜$GLOBAL_INSTALLATION_DIRECTORY/extras/valet.code-snippets⌝.
INFO     Writing the 190 functions documentation to the core libraries docs.
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/array.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/bash.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/benchmark.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/command.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/core.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/curl.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/esc-codes.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/exe.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/fs.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/interactive.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/log.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/profiler.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/progress.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/regex.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/sfzf.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/string.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/system.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/test.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/time.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/tui.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/version.md
🙈 mocked exe::invoke rm -f $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/windows.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/array.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/bash.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/benchmark.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/command.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/core.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/curl.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/esc-codes.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/exe.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/fs.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/interactive.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/list.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/log.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/profiler.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/progress.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/regex.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/sfzf.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/string.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/system.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/test.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/time.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/tui.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/version.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/windows.md
🙈 mocked exe::invoke cp -f $GLOBAL_INSTALLATION_DIRECTORY/libraries.d/config.md $GLOBAL_INSTALLATION_DIRECTORY/docs/static/config.md
🙈 mocked exe::invoke cp $GLOBAL_INSTALLATION_DIRECTORY/.vscode/extensions.json $GLOBAL_INSTALLATION_DIRECTORY/extras/extensions.json
🙈 mocked exe::invoke git add $GLOBAL_INSTALLATION_DIRECTORY/docs/static/config.md
🙈 mocked exe::invoke git add $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/array.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/bash.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/benchmark.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/command.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/core.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/curl.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/esc-codes.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/exe.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/fs.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/interactive.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/log.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/profiler.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/progress.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/regex.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/sfzf.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/string.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/system.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/test.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/time.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/tui.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/version.md $GLOBAL_INSTALLATION_DIRECTORY/docs/content/docs/300.libraries/windows.md
🙈 mocked exe::invoke git add $GLOBAL_INSTALLATION_DIRECTORY/extras/base.code-snippets $GLOBAL_INSTALLATION_DIRECTORY/extras/extensions.json $GLOBAL_INSTALLATION_DIRECTORY/extras/lib-valet $GLOBAL_INSTALLATION_DIRECTORY/extras/lib-valet.md $GLOBAL_INSTALLATION_DIRECTORY/extras/template-command-default.sh $GLOBAL_INSTALLATION_DIRECTORY/extras/template-library-default.sh $GLOBAL_INSTALLATION_DIRECTORY/extras/valet.code-snippets
🙈 mocked exe::invoke git commit -m :memo: updating the documentation
SUCCESS  The documentation update has been committed.
🙈 mocked exe::invoke sed -E -i s/VALET_RELEASED_VERSION="[0-9]+\.[^"]+"/VALET_RELEASED_VERSION="1.2.3"/ $GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-install.sh
🙈 mocked exe::invoke git add $GLOBAL_INSTALLATION_DIRECTORY/commands.d/self-install.sh
🙈 mocked exe::invoke git commit -m :rocket: releasing version 1.2.3
SUCCESS  The new version has been committed.
🙈 mocked interactive::promptYesNo Do you want to continue with the release of version 1.2.3? false
🙈 mocked exe::invoke git tag -a v1.2.3 -m # Release of version 1.2.3

Changelog: 

- ✨ feature
- 🐞 fix

SUCCESS  The new version has been tagged.
🙈 mocked exe::invoke git push origin main
🙈 mocked exe::invoke git push origin v1.2.3
SUCCESS  The ⌜main⌝ branch and the new version ⌜v1.2.3⌝ has been pushed.
🙈 mocked exe::invoke git push origin -f main:latest
SUCCESS  The ⌜latest⌝ branch has been updated.
🙈 mocked curl::request true 201,422 -X POST -H Authorization: token token -H Accept: application/vnd.github.v3+json -H Content-type: application/json; charset=utf-8 -d {
    "name": "v1.2.3",
    "tag_name": "v1.2.3",
    "body": "# Release of version 1.2.3\n\nChangelog: \n\n- ✨ feature\n- 🐞 fix\n",
    "draft": false,
    "prerelease": false
  } https://api.github.com/repos/jcaillon/valet/releases
SUCCESS  The new version has been released on GitHub.
🙈 mocked exe::invoke cp -R $GLOBAL_INSTALLATION_DIRECTORY/showcase.d .
🙈 mocked exe::invoke cp -R $GLOBAL_INSTALLATION_DIRECTORY/commands.d .
🙈 mocked exe::invoke cp -R $GLOBAL_INSTALLATION_DIRECTORY/libraries.d .
🙈 mocked exe::invoke cp -R $GLOBAL_INSTALLATION_DIRECTORY/extras .
🙈 mocked exe::invoke cp -R valet .
🙈 mocked exe::invoke cp -R valet.cmd .
🙈 mocked exe::invoke cp -R valet.ps1 .
🙈 mocked exe::invoke cp -R $GLOBAL_INSTALLATION_DIRECTORY/version .
🙈 mocked exe::invoke tar -czvf valet.tar.gz showcase.d commands.d libraries.d extras valet valet.cmd valet.ps1 version
INFO     Uploading the artifact ⌜valet.tar.gz⌝ to ⌜https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets⌝.
🙈 mocked curl::request true  -X POST -H Authorization: token token -H Content-Type: application/tar+gzip --data-binary @valet.tar.gz https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets?name=valet.tar.gz
INFO     The current version of valet is: 1.2.3.
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/version
INFO     The bumped version of valet is: 1.3.0.
🙈 mocked exe::invoke git add $GLOBAL_INSTALLATION_DIRECTORY/version
🙈 mocked exe::invoke git commit -m :bookmark: bump version to 1.3.0
🙈 mocked exe::invoke git push origin main
SUCCESS  The bumped version has been committed.
SUCCESS  The new version has been released, check: https://github.com/jcaillon/valet/releases/latest.
```

