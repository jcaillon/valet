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
▶ called io::invoke git rev-parse HEAD
INFO     The current version of valet is: 1.2.3.
INFO     Found 96 functions with documentation.
▶ called io::invoke git tag --sort=version:refname --no-color
INFO     The last tag is: v1.2.3.
▶ called io::invoke git log --pretty=format:%s v1.2.3..HEAD
INFO     The tag message is:
   1 ░ # Release of version 1.2.3
   2 ░ 
   3 ░ Changelog: 
   4 ░ 
   5 ░ - ✨ feature
   6 ░ - 🐞 fix
   7 ░ 
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

▶ called io::invoke git rev-parse HEAD
DEBUG    Checking if the workarea is clean
▶ called io::invokef5 false 0   git update-index --really-refresh
▶ called io::invokef5 false 0   git diff-index --quiet HEAD
INFO     The current version of valet is: 1.2.3.
DEBUG    Analyzing the following files:
   1 ░ $GLOBAL_VALET_HOME/valet.d/core
   2 ░ $GLOBAL_VALET_HOME/valet.d/lib-ansi-codes
   3 ░ $GLOBAL_VALET_HOME/valet.d/lib-array
   4 ░ $GLOBAL_VALET_HOME/valet.d/lib-fsfs
   5 ░ $GLOBAL_VALET_HOME/valet.d/lib-interactive
   6 ░ $GLOBAL_VALET_HOME/valet.d/lib-io
   7 ░ $GLOBAL_VALET_HOME/valet.d/lib-kurl
   8 ░ $GLOBAL_VALET_HOME/valet.d/lib-string
   9 ░ $GLOBAL_VALET_HOME/valet.d/lib-system
  10 ░ $GLOBAL_VALET_HOME/valet.d/main
  11 ░ $GLOBAL_VALET_HOME/valet.d/version
  12 ░ $GLOBAL_VALET_HOME/valet.d/commands.d/self-test-utils
DEBUG    Found function: ⌜io::createTempFile⌝
DEBUG    Found function: ⌜io::createTempDirectory⌝
DEBUG    Found function: ⌜io::cleanupTempFiles⌝
DEBUG    Found function: ⌜system::exportTerminalSize⌝
DEBUG    Found function: ⌜log::setLevel⌝
DEBUG    Found function: ⌜log::getLevel⌝
DEBUG    Found function: ⌜log::printFile⌝
DEBUG    Found function: ⌜log::printFileString⌝
DEBUG    Found function: ⌜log::printString⌝
DEBUG    Found function: ⌜log::printRaw⌝
DEBUG    Found function: ⌜core::fail⌝
DEBUG    Found function: ⌜core::failWithCode⌝
DEBUG    Found function: ⌜log::error⌝
DEBUG    Found function: ⌜log::warning⌝
DEBUG    Found function: ⌜log::success⌝
DEBUG    Found function: ⌜log::info⌝
DEBUG    Found function: ⌜log::debug⌝
DEBUG    Found function: ⌜log::trace⌝
DEBUG    Found function: ⌜log::errorTrace⌝
DEBUG    Found function: ⌜log::isDebugEnabled⌝
DEBUG    Found function: ⌜log::isTraceEnabled⌝
DEBUG    Found function: ⌜log::printCallStack⌝
DEBUG    Found function: ⌜source⌝
DEBUG    Found function: ⌜core::resetIncludedFiles⌝
DEBUG    Found function: ⌜core::sourceFunction⌝
DEBUG    Found function: ⌜core::sourceUserCommands⌝
DEBUG    Found function: ⌜core::reloadUserCommands⌝
DEBUG    Found function: ⌜string::wrapCharacters⌝
DEBUG    Found function: ⌜string::wrapSentence⌝
DEBUG    Found function: ⌜string::wrapCharacters⌝
DEBUG    Found function: ⌜array::fuzzyFilter⌝
DEBUG    Found function: ⌜core::getConfigurationDirectory⌝
DEBUG    Found function: ⌜core::getLocalStateDirectory⌝
DEBUG    Found function: ⌜core::getUserDirectory⌝
DEBUG    Found function: ⌜core::showHelp⌝
DEBUG    Found function: ⌜core::parseArguments⌝
DEBUG    Found function: ⌜core::checkParseResults⌝
DEBUG    Found function: ⌜ansi-codes::*⌝
DEBUG    Found function: ⌜array::sort⌝
DEBUG    Found function: ⌜array::appendIfNotPresent⌝
DEBUG    Found function: ⌜array::isInArray⌝
DEBUG    Found function: ⌜array::makeArraysSameSize⌝
DEBUG    Found function: ⌜array::sortWithCriteria⌝
DEBUG    Found function: ⌜array::fuzzyFilterSort⌝
DEBUG    Found function: ⌜fsfs::itemSelector⌝
DEBUG    Found function: ⌜interactive::askForConfirmation⌝
DEBUG    Found function: ⌜interactive::askForConfirmationRaw⌝
DEBUG    Found function: ⌜interactive::promptYesNo⌝
DEBUG    Found function: ⌜interactive::promptYesNoRaw⌝
DEBUG    Found function: ⌜interactive::displayQuestion⌝
DEBUG    Found function: ⌜interactive::displayAnswer⌝
DEBUG    Found function: ⌜interactive::displayDialogBox⌝
DEBUG    Found function: ⌜interactive::testKeys⌝
DEBUG    Found function: ⌜interactive::waitForKey⌝
DEBUG    Found function: ⌜interactive::clearKeyPressed⌝
DEBUG    Found function: ⌜interactive::createSpace⌝
DEBUG    Found function: ⌜interactive::getCursorPosition⌝
DEBUG    Found function: ⌜interactive::switchToFullScreen⌝
DEBUG    Found function: ⌜interactive::switchBackFromFullScreen⌝
DEBUG    Found function: ⌜io::toAbsolutePath⌝
DEBUG    Found function: ⌜io::invokef5⌝
DEBUG    Found function: ⌜io::invokef2⌝
DEBUG    Found function: ⌜io::invoke2⌝
DEBUG    Found function: ⌜io::invokef2piped⌝
DEBUG    Found function: ⌜io::invoke2piped⌝
DEBUG    Found function: ⌜io::invoke⌝
DEBUG    Found function: ⌜io::readFile⌝
DEBUG    Found function: ⌜io::checkAndFail⌝
DEBUG    Found function: ⌜io::checkAndWarn⌝
DEBUG    Found function: ⌜io::createFilePathIfNeeded⌝
DEBUG    Found function: ⌜io::sleep⌝
DEBUG    Found function: ⌜io::cat⌝
DEBUG    Found function: ⌜io::readStdIn⌝
DEBUG    Found function: ⌜io::countArgs⌝
DEBUG    Found function: ⌜io::listPaths⌝
DEBUG    Found function: ⌜io::listFiles⌝
DEBUG    Found function: ⌜io::listDirectories⌝
DEBUG    Found function: ⌜kurl::toFile⌝
DEBUG    Found function: ⌜kurl::toVar⌝
DEBUG    Found function: ⌜string::cutField⌝
DEBUG    Found function: ⌜string::bumpSemanticVersion⌝
DEBUG    Found function: ⌜string::camelCaseToSnakeCase⌝
DEBUG    Found function: ⌜string::kebabCaseToSnakeCase⌝
DEBUG    Found function: ⌜string::kebabCaseToCamelCase⌝
DEBUG    Found function: ⌜string::trimAll⌝
DEBUG    Found function: ⌜string::trim⌝
DEBUG    Found function: ⌜string::indexOf⌝
DEBUG    Found function: ⌜string::extractBetween⌝
DEBUG    Found function: ⌜string::count⌝
DEBUG    Found function: ⌜string::split⌝
DEBUG    Found function: ⌜string::regexGetFirst⌝
DEBUG    Found function: ⌜system::os⌝
DEBUG    Found function: ⌜system::env⌝
DEBUG    Found function: ⌜system::date⌝
DEBUG    Found function: ⌜system::getUndeclaredVariables⌝
DEBUG    Found function: ⌜test::commentTest⌝
DEBUG    Found function: ⌜test::endTest⌝
INFO     Found 96 functions with documentation.
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/codes.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/fsfs.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/kurl.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/codes.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/codes.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/fsfs.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/fsfs.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/kurl.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/kurl.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/kurl.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/kurl.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/codes.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/fsfs.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/kurl.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/extras/all-valet-functions.sh
▶ called io::writeToFile $GLOBAL_VALET_HOME/extras/valet.code-snippets
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/static/config.md
▶ called io::invoke git add $GLOBAL_VALET_HOME/docs/static/config.md
▶ called io::invoke git add $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/codes.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/fsfs.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/kurl.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::invoke git add $GLOBAL_VALET_HOME/extras/all-valet-functions.sh $GLOBAL_VALET_HOME/extras/valet.code-snippets
▶ called io::invoke git commit -m :memo: updating the documentation
SUCCESS  The documentation update has been committed.
▶ called io::invoke sed -E -i s/VALET_VERSION="[0-9]+\.[^"]+"/VALET_VERSION="1.2.3"/ $GLOBAL_VALET_HOME/valet.d/commands.d/self-install.sh
▶ called io::invoke git add $GLOBAL_VALET_HOME/valet.d/commands.d/self-install.sh
▶ called io::invoke git commit -m :rocket: releasing version 1.2.3
SUCCESS  The new version has been committed.
▶ called io::invoke git tag --sort=version:refname --no-color
INFO     The last tag is: v1.2.3.
▶ called io::invoke git log --pretty=format:%s v1.2.3..HEAD
INFO     The tag message is:
   1 ░ # Release of version 1.2.3
   2 ░ 
   3 ░ Changelog: 
   4 ░ 
   5 ░ - ✨ feature
   6 ░ - 🐞 fix
   7 ░ 
▶ called io::invoke git push origin main
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
▶ called io::invoke cp -R $GLOBAL_VALET_HOME/extras .
▶ called io::invoke cp -R $GLOBAL_VALET_HOME/valet .
▶ called io::invoke tar -czvf valet.tar.gz examples.d valet.d extras valet
DEBUG    The artifact has been created at ⌜valet.tar.gz⌝ with:

INFO     Uploading the artifact ⌜valet.tar.gz⌝ to ⌜https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets⌝.
▶ called kurl::toVar true  -X POST -H Authorization: token token -H Content-Type: application/tar+gzip --data-binary @valet.tar.gz https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets?name=valet.tar.gz
SUCCESS  The new version has been released, check: ⌜https://github.com/jcaillon/valet/releases/latest⌝.
```

