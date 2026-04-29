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
🙈 mocked curl::request https://api.github.com/repos/jcaillon/valet/releases/latest -H Accept: application/vnd.github.v3+json --- acceptableCodes=200
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
🙈 mocked interactive::confirm Do you want to continue with the release of version 1.2.3? default=false
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
🙈 mocked curl::request https://api.github.com/repos/jcaillon/valet/releases/latest -H Accept: application/vnd.github.v3+json --- acceptableCodes=200
INFO     The latest release on GitHub is: v1.2.3.
🙈 mocked exe::invoke git rev-parse HEAD
🙈 mocked exe::invoke git update-index --really-refresh --- noFail=true
🙈 mocked exe::invoke git diff-index --quiet HEAD --- noFail=true
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
INFO     Found xxx functions with documentation.
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/extras/lib-valet.md
content
INFO     The documentation has been generated in ⌜$GLOBAL_INSTALLATION_DIRECTORY/extras/lib-valet.md⌝.
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/extras/lib-valet _title
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/extras/lib-valet content
INFO     The prototype script has been generated in ⌜$GLOBAL_INSTALLATION_DIRECTORY/extras/lib-valet⌝.
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/extras/valet.code-snippets content
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/extras/valet.code-snippets originalContent append=true
INFO     The vscode snippets have been generated in ⌜$GLOBAL_INSTALLATION_DIRECTORY/extras/valet.code-snippets⌝.
INFO     Found 16 commands with documentation.
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/extras/valet-commands.md content
INFO     The commands documentation has been generated in ⌜$GLOBAL_INSTALLATION_DIRECTORY/extras/valet-commands.md⌝.
INFO     Writing the xxx functions documentation to the core libraries docs.
🙈 mocked exe::invoke rm -f ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked fs::writeToFile ...
🙈 mocked exe::invoke cp -f $GLOBAL_INSTALLATION_DIRECTORY/libraries.d/config.md $GLOBAL_INSTALLATION_DIRECTORY/docs/static/config.md
🙈 mocked exe::invoke cp -f $GLOBAL_INSTALLATION_DIRECTORY/extras/lib-valet.md $GLOBAL_INSTALLATION_DIRECTORY/docs/static/lib-valet.md
🙈 mocked exe::invoke cp -f $GLOBAL_INSTALLATION_DIRECTORY/extras/valet-commands.md $GLOBAL_INSTALLATION_DIRECTORY/docs/static/valet-commands.md
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/docs/static/stats.yaml statsContent
🙈 mocked exe::invoke git add $GLOBAL_INSTALLATION_DIRECTORY/docs/static/config.md $GLOBAL_INSTALLATION_DIRECTORY/docs/static/lib-valet.md $GLOBAL_INSTALLATION_DIRECTORY/docs/static/valet-commands.md $GLOBAL_INSTALLATION_DIRECTORY/docs/static/stats.yaml
🙈 mocked exe::invoke git add ...
🙈 mocked exe::invoke git add $GLOBAL_INSTALLATION_DIRECTORY/extras/base.code-snippets $GLOBAL_INSTALLATION_DIRECTORY/extras/lib-valet $GLOBAL_INSTALLATION_DIRECTORY/extras/lib-valet.md $GLOBAL_INSTALLATION_DIRECTORY/extras/template-command-default.sh $GLOBAL_INSTALLATION_DIRECTORY/extras/template-library-default.sh $GLOBAL_INSTALLATION_DIRECTORY/extras/valet-commands.md $GLOBAL_INSTALLATION_DIRECTORY/extras/valet.code-snippets
🙈 mocked exe::invoke git commit -m :memo: updating the documentation
SUCCESS  The documentation update has been committed.
🙈 mocked exe::invoke sed -E -i s/VALET_RELEASED_VERSION="[0-9]+\.[^"]+"/VALET_RELEASED_VERSION="1.2.3"/ $GLOBAL_INSTALLATION_DIRECTORY/install.sh
🙈 mocked exe::invoke git add $GLOBAL_INSTALLATION_DIRECTORY/install.sh
🙈 mocked exe::invoke git commit -m :rocket: releasing version 1.2.3
SUCCESS  The new version has been committed.
🙈 mocked interactive::confirm Do you want to continue with the release of version 1.2.3? default=false
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
🙈 mocked curl::request https://api.github.com/repos/jcaillon/valet/releases -X POST -H Authorization: token token -H Accept: application/vnd.github.v3+json -H Content-type: application/json; charset=utf-8 -d {
    "name": "v1.2.3",
    "tag_name": "v1.2.3",
    "body": "# Release of version 1.2.3\n\nChangelog: \n\n- ✨ feature\n- 🐞 fix\n",
    "draft": false,
    "prerelease": false
  } --- failOnError=true acceptableCodes=201,422
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
🙈 mocked curl::request https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets?name=valet.tar.gz -X POST -H Authorization: token token -H Content-Type: application/tar+gzip --data-binary @valet.tar.gz --- failOnError=true
INFO     The current version of valet is: 1.2.3.
🙈 mocked fs::writeToFile $GLOBAL_INSTALLATION_DIRECTORY/version newVersion
INFO     The bumped version of valet is: 1.3.0.
🙈 mocked exe::invoke git add $GLOBAL_INSTALLATION_DIRECTORY/version
🙈 mocked exe::invoke git commit -m :bookmark: bump version to 1.3.0
🙈 mocked exe::invoke git push origin main
SUCCESS  The bumped version has been committed.
SUCCESS  The new version has been released, check: https://github.com/jcaillon/valet/releases/latest.
```

