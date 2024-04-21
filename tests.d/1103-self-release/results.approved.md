# Test suite 1103-self-release

## Test script 01.self-release

### Testing selfRelease, dry run major version

Exit code: `0`

**Standard** output:

```plaintext
→ selfRelease -t token -b major --dry-run
```

**Error** output:

```log
INFO     Dry run mode is enabled, no changes will be made.
INFO     The current version of valet is: 1.2.3.
▶ called io::invoke git tag --sort=committerdate --no-color
INFO     The last tag is: v1.2.3.
▶ called io::invoke git log --pretty=format:%s v1.2.3..HEAD
INFO     The tag message is:
# Release of version 1.2.3

Changelog: 

- ✨ feature
- 🐞 fix

INFO     The new version of valet is: 2.0.0.
SUCCESS  The new version has been released, check: ⌜https://github.com/jcaillon/valet/releases/latest⌝.
```

### Testing selfRelease, minor version

Exit code: `0`

**Standard** output:

```plaintext
→ selfRelease -t token -b minor
```

**Error** output:

```log
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Parsed arguments:
local parsingErrors githubReleaseToken bumpLevel dryRun uploadArtifactsOnly help
dryRun="${VALET_DRY_RUN:-}"
uploadArtifactsOnly="${VALET_UPLOAD_ARTIFACTS_ONLY:-}"
parsingErrors=""
githubReleaseToken="token"
bumpLevel="minor"

DEBUG    Checking if the workarea is clean
▶ called io::invoke5 false 0   git update-index --really-refresh
▶ called io::invoke5 false 0   git diff-index --quiet HEAD
INFO     The current version of valet is: 1.2.3.
▶ called io::invoke sed -E -i s/VALET_VERSION="[0-9]+\.[^"]+"/VALET_VERSION="aa"/ $GLOBAL_VALET_HOME/valet.d/commands.d/self-install.sh
▶ called io::invoke git add $GLOBAL_VALET_HOME/valet.d/commands.d/self-install.sh
▶ called io::invoke git commit -m :rocket: releasing version 2.0.0
▶ called io::invoke git push origin main
SUCCESS  The new version has been committed.
▶ called io::invoke git tag --sort=committerdate --no-color
INFO     The last tag is: v1.2.3.
▶ called io::invoke git log --pretty=format:%s v1.2.3..HEAD
INFO     The tag message is:
# Release of version 1.2.3

Changelog: 

- ✨ feature
- 🐞 fix

▶ called io::invoke git tag -a v1.2.3 -m Release version 1.2.3
▶ called io::invoke git push origin v1.2.3
SUCCESS  The new version has been tagged and pushed to the remote repository.
INFO     The new version of valet is: 1.3.0.
▶ called io::invoke git add $GLOBAL_VALET_HOME/valet.d/version
▶ called io::invoke git commit -m :bookmark: bump version to 1.3.0
▶ called io::invoke git push origin main
SUCCESS  The new version has been committed.
DEBUG    The release payload is: ⌜{
    "tag_name": "v1.2.3",
    "body": "# Release of version 1.2.3\n\nChangelog: \n\n- ✨ feature\n- 🐞 fix\n",
    "draft": false,
    "prerelease": false
  }⌝
▶ called kurl::toVar true 201,422 -X POST -H Authorization: token token -H Accept: application/vnd.github.v3+json -H Content-type: application/json; charset=utf-8 -d {
    "tag_name": "v1.2.3",
    "body": "# Release of version 1.2.3\n\nChangelog: \n\n- ✨ feature\n- 🐞 fix\n",
    "draft": false,
    "prerelease": false
  } https://api.github.com/repos/jcaillon/valet/releases
SUCCESS  The new version has been released on GitHub.
DEBUG    The upload URL is: https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets
▶ called io::invoke cp -R $GLOBAL_VALET_HOME/examples.d .
▶ called io::invoke cp -R $GLOBAL_VALET_HOME/valet.d .
▶ called io::invoke cp -R $GLOBAL_VALET_HOME/valet .
▶ called io::invoke tar -czvf valet.tar.gz examples.d valet.d valet
DEBUG    The artifact has been created at ⌜valet.tar.gz⌝ with:

INFO     Uploading the artifact ⌜valet.tar.gz⌝ to ⌜https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets⌝.
▶ called kurl::toVar true  -X POST -H Authorization: token token -H Content-Type: application/tar+gzip --data-binary @valet.tar.gz https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets?name=valet.tar.gz
SUCCESS  The new version has been released, check: ⌜https://github.com/jcaillon/valet/releases/latest⌝.
```

