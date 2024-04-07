# Test suite 0003-self-release

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
INFO     Downloading the binaries for the OS: linux.
INFO     Downloading fzf from: https://github.com/junegunn/fzf/releases/download/0.48.1/fzf-0.48.1-linux_amd64.tar.gz.
▶ called kurl::toFile true 200 fzf.tar.gz https://github.com/junegunn/fzf/releases/download/0.48.1/fzf-0.48.1-linux_amd64.tar.gz
▶ called io::invoke tar -xzf fzf.tar.gz
▶ called io::invoke mv -f fzf $VALET_HOME/.tmp/bin/fzf
SUCCESS  The binaries have been downloaded and stored in the bin directory of valet ⌜$VALET_HOME/.tmp/bin⌝.
INFO     Downloading the binaries for the OS: windows.
INFO     Downloading fzf from: https://github.com/junegunn/fzf/releases/download/0.48.1/fzf-0.48.1-windows_amd64.zip.
▶ called kurl::toFile true 200 fzf.zip https://github.com/junegunn/fzf/releases/download/0.48.1/fzf-0.48.1-windows_amd64.zip
▶ called io::invoke unzip fzf.zip
▶ called io::invoke mv -f fzf.exe $VALET_HOME/.tmp/bin/fzf
SUCCESS  The binaries have been downloaded and stored in the bin directory of valet ⌜$VALET_HOME/.tmp/bin⌝.
INFO     Downloading the binaries for the OS: darwin.
INFO     Downloading fzf from: https://github.com/junegunn/fzf/releases/download/0.48.1/fzf-0.48.1-darwin_amd64.zip.
▶ called kurl::toFile true 200 fzf.zip https://github.com/junegunn/fzf/releases/download/0.48.1/fzf-0.48.1-darwin_amd64.zip
▶ called io::invoke unzip fzf.zip
▶ called io::invoke mv -f fzf $VALET_HOME/.tmp/bin/fzf
SUCCESS  The binaries have been downloaded and stored in the bin directory of valet ⌜$VALET_HOME/.tmp/bin⌝.
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
▶ called io::invoke git add $VALET_HOME/valet.d/version
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
DEBUG    Parsed arguments:
local parsingErrors forceOs destination force help
force="${VALET_FORCE:-}"
parsingErrors=""
forceOs="linux"
destination="$VALET_HOME/.tmp/bin"

INFO     Downloading the binaries for the OS: linux.
INFO     Downloading fzf from: https://github.com/junegunn/fzf/releases/download/0.48.1/fzf-0.48.1-linux_amd64.tar.gz.
▶ called kurl::toFile true 200 fzf.tar.gz https://github.com/junegunn/fzf/releases/download/0.48.1/fzf-0.48.1-linux_amd64.tar.gz
▶ called io::invoke tar -xzf fzf.tar.gz
▶ called io::invoke mv -f fzf $VALET_HOME/.tmp/bin/fzf
SUCCESS  The binaries have been downloaded and stored in the bin directory of valet ⌜$VALET_HOME/.tmp/bin⌝.
▶ called io::invoke cp -R $VALET_HOME/examples.d .
▶ called io::invoke cp -R $VALET_HOME/valet.d .
▶ called io::invoke cp -R $VALET_HOME/valet .
▶ called io::invoke tar -czvf valet-linux-amd64.tar.gz examples.d valet.d valet bin
DEBUG    The artifact has been created at ⌜valet-linux-amd64.tar.gz⌝ with:

INFO     Uploading the artifact ⌜valet-linux-amd64.tar.gz⌝ to ⌜https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets⌝.
▶ called kurl::toVar true  -X POST -H Authorization: token token -H Content-Type: application/tar+gzip --data-binary @valet-linux-amd64.tar.gz https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets?name=valet-linux-amd64.tar.gz
DEBUG    Parsed arguments:
local parsingErrors forceOs destination force help
force="${VALET_FORCE:-}"
parsingErrors=""
forceOs="windows"
destination="$VALET_HOME/.tmp/bin"

INFO     Downloading the binaries for the OS: windows.
INFO     Downloading fzf from: https://github.com/junegunn/fzf/releases/download/0.48.1/fzf-0.48.1-windows_amd64.zip.
▶ called kurl::toFile true 200 fzf.zip https://github.com/junegunn/fzf/releases/download/0.48.1/fzf-0.48.1-windows_amd64.zip
▶ called io::invoke unzip fzf.zip
▶ called io::invoke mv -f fzf.exe $VALET_HOME/.tmp/bin/fzf
SUCCESS  The binaries have been downloaded and stored in the bin directory of valet ⌜$VALET_HOME/.tmp/bin⌝.
▶ called io::invoke cp -R $VALET_HOME/examples.d .
▶ called io::invoke cp -R $VALET_HOME/valet.d .
▶ called io::invoke cp -R $VALET_HOME/valet .
▶ called io::invoke tar -czvf valet-windows-amd64.tar.gz examples.d valet.d valet bin
DEBUG    The artifact has been created at ⌜valet-windows-amd64.tar.gz⌝ with:

INFO     Uploading the artifact ⌜valet-windows-amd64.tar.gz⌝ to ⌜https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets⌝.
▶ called kurl::toVar true  -X POST -H Authorization: token token -H Content-Type: application/tar+gzip --data-binary @valet-windows-amd64.tar.gz https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets?name=valet-windows-amd64.tar.gz
DEBUG    Parsed arguments:
local parsingErrors forceOs destination force help
force="${VALET_FORCE:-}"
parsingErrors=""
forceOs="darwin"
destination="$VALET_HOME/.tmp/bin"

INFO     Downloading the binaries for the OS: darwin.
INFO     Downloading fzf from: https://github.com/junegunn/fzf/releases/download/0.48.1/fzf-0.48.1-darwin_amd64.zip.
▶ called kurl::toFile true 200 fzf.zip https://github.com/junegunn/fzf/releases/download/0.48.1/fzf-0.48.1-darwin_amd64.zip
▶ called io::invoke unzip fzf.zip
▶ called io::invoke mv -f fzf $VALET_HOME/.tmp/bin/fzf
SUCCESS  The binaries have been downloaded and stored in the bin directory of valet ⌜$VALET_HOME/.tmp/bin⌝.
▶ called io::invoke cp -R $VALET_HOME/examples.d .
▶ called io::invoke cp -R $VALET_HOME/valet.d .
▶ called io::invoke cp -R $VALET_HOME/valet .
▶ called io::invoke tar -czvf valet-darwin-amd64.tar.gz examples.d valet.d valet bin
DEBUG    The artifact has been created at ⌜valet-darwin-amd64.tar.gz⌝ with:

INFO     Uploading the artifact ⌜valet-darwin-amd64.tar.gz⌝ to ⌜https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets⌝.
▶ called kurl::toVar true  -X POST -H Authorization: token token -H Content-Type: application/tar+gzip --data-binary @valet-darwin-amd64.tar.gz https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets?name=valet-darwin-amd64.tar.gz
▶ called io::invoke cp -R $VALET_HOME/examples.d .
▶ called io::invoke cp -R $VALET_HOME/valet.d .
▶ called io::invoke cp -R $VALET_HOME/valet .
▶ called io::invoke tar -czvf valet-no-binaries.tar.gz examples.d valet.d valet
DEBUG    The artifact has been created at ⌜valet-no-binaries.tar.gz⌝ with:

INFO     Uploading the artifact ⌜valet-no-binaries.tar.gz⌝ to ⌜https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets⌝.
▶ called kurl::toVar true  -X POST -H Authorization: token token -H Content-Type: application/tar+gzip --data-binary @valet-no-binaries.tar.gz https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets?name=valet-no-binaries.tar.gz
SUCCESS  The new version has been released, check: ⌜https://github.com/jcaillon/valet/releases/latest⌝.
```

