# Test suite self-release

## Test script 01.self-release

### Testing selfRelease, dry run major version



Exit code: `0`

Standard output

```text
→ selfRelease -t token -b major --dry-run
```

Error output

```text
INFO     Dry run mode is enabled, no changes will be made.
▶ called io::invoke git tag --sort=version:refname --no-color
INFO     The last tag is: v1.2.3.
▶ called curl::toVar true 200 -H Accept: application/vnd.github.v3+json https://api.github.com/repos/jcaillon/valet/releases/latest
INFO     The latest release on GitHub is: v1.2.3.
▶ called io::invoke git rev-parse HEAD
INFO     The current version of valet is: 1.2.3.
▶ called io::invoke git log --pretty=format:%s v1.2.3..HEAD
INFO     The tag message is:
   1 ░ # Release of version 1.2.3
   2 ░ 
   3 ░ Changelog: 
   4 ░ 
   5 ░ - ✨ feature
   6 ░ - 🐞 fix
   7 ░ 
INFO     The current version of valet is: 1.2.3.
INFO     The bumped version of valet is: 2.0.0.
SUCCESS  The new version has been released, check: https://github.com/jcaillon/valet/releases/latest.
```

### Testing selfRelease, minor version



Exit code: `0`

Standard output

```text
→ selfRelease -t token -b minor
```

Error output

```text
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Parsed arguments:
local parsingErrors githubReleaseToken bumpLevel dryRun help
dryRun="${VALET_DRY_RUN:-}"
help=""
parsingErrors=""
githubReleaseToken="token"
bumpLevel="minor"

▶ called io::invoke git tag --sort=version:refname --no-color
INFO     The last tag is: v1.2.3.
▶ called curl::toVar true 200 -H Accept: application/vnd.github.v3+json https://api.github.com/repos/jcaillon/valet/releases/latest
INFO     The latest release on GitHub is: v1.2.3.
DEBUG    The upload URL is: https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets
▶ called io::invoke git rev-parse HEAD
DEBUG    Checking if the workarea is clean
▶ called io::invokef5 false 0   git update-index --really-refresh
▶ called io::invokef5 false 0   git diff-index --quiet HEAD
INFO     The current version of valet is: 1.2.3.
▶ called io::invoke git log --pretty=format:%s v1.2.3..HEAD
INFO     The tag message is:
   1 ░ # Release of version 1.2.3
   2 ░ 
   3 ░ Changelog: 
   4 ░ 
   5 ░ - ✨ feature
   6 ░ - 🐞 fix
   7 ░ 
DEBUG    Parsed arguments:
local parsingErrors output coreOnly help
help=""
parsingErrors=""
coreOnly="true"
output="$GLOBAL_VALET_HOME/extras"

INFO     Generating documentation for the core functions only.
DEBUG    Analyzing the following files:
   1 ░ $GLOBAL_VALET_HOME/libraries.d/core
   2 ░ $GLOBAL_VALET_HOME/libraries.d/lib-ansi-codes
   3 ░ $GLOBAL_VALET_HOME/libraries.d/lib-array
   4 ░ $GLOBAL_VALET_HOME/libraries.d/lib-bash
   5 ░ $GLOBAL_VALET_HOME/libraries.d/lib-benchmark
   6 ░ $GLOBAL_VALET_HOME/libraries.d/lib-curl
   7 ░ $GLOBAL_VALET_HOME/libraries.d/lib-fsfs
   8 ░ $GLOBAL_VALET_HOME/libraries.d/lib-http
   9 ░ $GLOBAL_VALET_HOME/libraries.d/lib-interactive
  10 ░ $GLOBAL_VALET_HOME/libraries.d/lib-io
  11 ░ $GLOBAL_VALET_HOME/libraries.d/lib-profiler
  12 ░ $GLOBAL_VALET_HOME/libraries.d/lib-prompt
  13 ░ $GLOBAL_VALET_HOME/libraries.d/lib-string
  14 ░ $GLOBAL_VALET_HOME/libraries.d/lib-system
  15 ░ $GLOBAL_VALET_HOME/libraries.d/lib-test
  16 ░ $GLOBAL_VALET_HOME/libraries.d/main
DEBUG    Found function: ⌜core::setShellOptions⌝
DEBUG    Found function: ⌜io::createTempFile⌝
DEBUG    Found function: ⌜io::createTempDirectory⌝
DEBUG    Found function: ⌜io::cleanupTempFiles⌝
DEBUG    Found function: ⌜interactive::getTerminalSize⌝
DEBUG    Found function: ⌜log::setLevel⌝
DEBUG    Found function: ⌜log::getLevel⌝
DEBUG    Found function: ⌜log::printFile⌝
DEBUG    Found function: ⌜log::printFileString⌝
DEBUG    Found function: ⌜log::printString⌝
DEBUG    Found function: ⌜log::printRaw⌝
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
DEBUG    Found function: ⌜string::wrapText⌝
DEBUG    Found function: ⌜string::wrapCharacters⌝
DEBUG    Found function: ⌜string::highlight⌝
DEBUG    Found function: ⌜array::fuzzyFilterSort⌝
DEBUG    Found function: ⌜bash::getFunctionDefinitionWithGlobalVars⌝
DEBUG    Found function: ⌜core::fail⌝
DEBUG    Found function: ⌜core::failWithCode⌝
DEBUG    Found function: ⌜source⌝
DEBUG    Found function: ⌜core::resetIncludedFiles⌝
DEBUG    Found function: ⌜core::sourceFunction⌝
DEBUG    Found function: ⌜core::sourceUserCommands⌝
DEBUG    Found function: ⌜core::reloadUserCommands⌝
DEBUG    Found function: ⌜core::deleteUserCommands⌝
DEBUG    Found function: ⌜core::getVersion⌝
DEBUG    Found function: ⌜core::getProgramElapsedMicroseconds⌝
DEBUG    Found function: ⌜core::getConfigurationDirectory⌝
DEBUG    Found function: ⌜core::getLocalStateDirectory⌝
DEBUG    Found function: ⌜core::getUserDirectory⌝
DEBUG    Found function: ⌜core::showHelp⌝
DEBUG    Found function: ⌜core::parseArguments⌝
DEBUG    Found function: ⌜core::checkParseResults⌝
DEBUG    Found function: ⌜ansi-codes::*⌝
DEBUG    Found function: ⌜array::sort⌝
DEBUG    Found function: ⌜array::sortWithCriteria⌝
DEBUG    Found function: ⌜array::appendIfNotPresent⌝
DEBUG    Found function: ⌜array::isInArray⌝
DEBUG    Found function: ⌜array::makeArraysSameSize⌝
DEBUG    Found function: ⌜array::fuzzyFilterSortFileWithGrepAndAwk⌝
DEBUG    Found function: ⌜bash::countJobs⌝
DEBUG    Found function: ⌜bash::runInParallel⌝
DEBUG    Found function: ⌜bash::injectCodeInFunction⌝
DEBUG    Found function: ⌜benchmark::run⌝
DEBUG    Found function: ⌜curl::toFile⌝
DEBUG    Found function: ⌜curl::toVar⌝
DEBUG    Found function: ⌜fsfs::itemSelector⌝
DEBUG    Found function: ⌜interactive::askForConfirmation⌝
DEBUG    Found function: ⌜interactive::askForConfirmationRaw⌝
DEBUG    Found function: ⌜interactive::promptYesNo⌝
DEBUG    Found function: ⌜interactive::promptYesNoRaw⌝
DEBUG    Found function: ⌜interactive::displayQuestion⌝
DEBUG    Found function: ⌜interactive::displayAnswer⌝
DEBUG    Found function: ⌜interactive::displayDialogBox⌝
DEBUG    Found function: ⌜interactive::createSpace⌝
DEBUG    Found function: ⌜interactive::getCursorPosition⌝
DEBUG    Found function: ⌜interactive::switchToFullScreen⌝
DEBUG    Found function: ⌜interactive::switchBackFromFullScreen⌝
DEBUG    Found function: ⌜interactive::sttyInit⌝
DEBUG    Found function: ⌜interactive::sttyRestore⌝
DEBUG    Found function: ⌜interactive::setInterruptTrap⌝
DEBUG    Found function: ⌜interactive::restoreInterruptTrap⌝
DEBUG    Found function: ⌜interactive::clearBox⌝
DEBUG    Found function: ⌜interactive::getBestAutocompleteBox⌝
DEBUG    Found function: ⌜interactive::testWaitForChar⌝
DEBUG    Found function: ⌜interactive::waitForChar⌝
DEBUG    Found function: ⌜interactive::testWaitForKeyPress⌝
DEBUG    Found function: ⌜interactive::waitForKeyPress⌝
DEBUG    Found function: ⌜interactive::rebindKeymap⌝
DEBUG    Found function: ⌜interactive::resetBindings⌝
DEBUG    Found function: ⌜interactive::clearKeyPressed⌝
DEBUG    Found function: ⌜interactive::startProgress⌝
DEBUG    Found function: ⌜interactive::updateProgress⌝
DEBUG    Found function: ⌜interactive::stopProgress⌝
DEBUG    Found function: ⌜io::toAbsolutePath⌝
DEBUG    Found function: ⌜io::invokef5⌝
DEBUG    Found function: ⌜io::invoke5⌝
DEBUG    Found function: ⌜io::invokef2⌝
DEBUG    Found function: ⌜io::invoke2⌝
DEBUG    Found function: ⌜io::invokef2piped⌝
DEBUG    Found function: ⌜io::invoke2piped⌝
DEBUG    Found function: ⌜io::invoke⌝
DEBUG    Found function: ⌜io::readFile⌝
DEBUG    Found function: ⌜io::checkAndFail⌝
DEBUG    Found function: ⌜io::checkAndWarn⌝
DEBUG    Found function: ⌜io::createDirectoryIfNeeded⌝
DEBUG    Found function: ⌜io::createFilePathIfNeeded⌝
DEBUG    Found function: ⌜io::sleep⌝
DEBUG    Found function: ⌜io::cat⌝
DEBUG    Found function: ⌜io::head⌝
DEBUG    Found function: ⌜io::tail⌝
DEBUG    Found function: ⌜io::readStdIn⌝
DEBUG    Found function: ⌜io::countArgs⌝
DEBUG    Found function: ⌜io::listPaths⌝
DEBUG    Found function: ⌜io::listFiles⌝
DEBUG    Found function: ⌜io::listDirectories⌝
DEBUG    Found function: ⌜io::isDirectoryWritable⌝
DEBUG    Found function: ⌜io::windowsRunInPowershell⌝
DEBUG    Found function: ⌜io::windowsPowershellBatchStart⌝
DEBUG    Found function: ⌜io::windowsPowershellBatchEnd⌝
DEBUG    Found function: ⌜io::createLink⌝
DEBUG    Found function: ⌜io::convertToWindowsPath⌝
DEBUG    Found function: ⌜io::convertFromWindowsPath⌝
DEBUG    Found function: ⌜io::windowsCreateTempFile⌝
DEBUG    Found function: ⌜io::windowsCreateTempDirectory⌝
DEBUG    Found function: ⌜io::captureOutput⌝
DEBUG    Found function: ⌜profiler::enable⌝
DEBUG    Found function: ⌜profiler::disable⌝
DEBUG    Found function: ⌜prompt_getDisplayedPromptString⌝
DEBUG    Found function: ⌜string::cutField⌝
DEBUG    Found function: ⌜string::compareSemanticVersion⌝
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
DEBUG    Found function: ⌜string::microsecondsToHuman⌝
DEBUG    Found function: ⌜string::head⌝
DEBUG    Found function: ⌜system::os⌝
DEBUG    Found function: ⌜system::env⌝
DEBUG    Found function: ⌜system::date⌝
DEBUG    Found function: ⌜system::getUndeclaredVariables⌝
DEBUG    Found function: ⌜system::getNotExistingCommands⌝
DEBUG    Found function: ⌜system::commandExists⌝
DEBUG    Found function: ⌜system::isRoot⌝
DEBUG    Found function: ⌜system::addToPath⌝
DEBUG    Found function: ⌜system::windowsSetEnvVar⌝
DEBUG    Found function: ⌜system::windowsGetEnvVar⌝
DEBUG    Found function: ⌜system::windowsAddToPath⌝
DEBUG    Found function: ⌜test::log⌝
DEBUG    Found function: ⌜test::title⌝
DEBUG    Found function: ⌜test::markdown⌝
DEBUG    Found function: ⌜test::prompt⌝
DEBUG    Found function: ⌜test::func⌝
DEBUG    Found function: ⌜test::exec⌝
DEBUG    Found function: ⌜test::exit⌝
DEBUG    Found function: ⌜test::printReturnedVars⌝
DEBUG    Found function: ⌜test::resetReturnedVars⌝
DEBUG    Found function: ⌜test::printVars⌝
DEBUG    Found function: ⌜test::transformTextBeforeFlushing⌝
DEBUG    Found function: ⌜test::flush⌝
DEBUG    Found function: ⌜test::flushStdout⌝
DEBUG    Found function: ⌜test::flushStderr⌝
DEBUG    Found function: ⌜test::fail⌝
INFO     Found 159 functions with documentation.
▶ called io::writeToFile $GLOBAL_VALET_HOME/extras/lib-valet.md
INFO     The documentation has been generated in ⌜$GLOBAL_VALET_HOME/extras/lib-valet.md⌝.
▶ called io::writeToFile $GLOBAL_VALET_HOME/extras/lib-valet
▶ called io::writeToFile $GLOBAL_VALET_HOME/extras/lib-valet
INFO     The prototype script has been generated in ⌜$GLOBAL_VALET_HOME/extras/lib-valet⌝.
▶ called io::writeToFile $GLOBAL_VALET_HOME/extras/valet.code-snippets
INFO     The vscode snippets have been generated in ⌜$GLOBAL_VALET_HOME/extras/valet.code-snippets⌝.
INFO     Writing the 159 functions documentation to the core libraries docs.
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/codes.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/curl.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/fsfs.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/profiler.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::invoke rm -f $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/codes.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/codes.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/bash.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/benchmark.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/benchmark.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/benchmark.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/curl.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/curl.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/curl.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/curl.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/fsfs.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/fsfs.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/profiler.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/profiler.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/profiler.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/profiler.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFileFromRef $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/codes.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/curl.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/fsfs.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/profiler.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::writeToFile $GLOBAL_VALET_HOME/docs/static/config.md
▶ called io::invoke cp $GLOBAL_VALET_HOME/.vscode/extensions.json $GLOBAL_VALET_HOME/extras/extensions.json
▶ called io::invoke git add $GLOBAL_VALET_HOME/docs/static/config.md
▶ called io::invoke git add $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/array.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/codes.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/core.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/curl.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/fsfs.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/interactive.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/io.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/log.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/profiler.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/string.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/system.md $GLOBAL_VALET_HOME/docs/content/docs/300.libraries/test.md
▶ called io::invoke git add $GLOBAL_VALET_HOME/extras/base.code-snippets $GLOBAL_VALET_HOME/extras/extensions.json $GLOBAL_VALET_HOME/extras/lib-valet $GLOBAL_VALET_HOME/extras/lib-valet.md $GLOBAL_VALET_HOME/extras/template-command-default.sh $GLOBAL_VALET_HOME/extras/template-library-default.sh $GLOBAL_VALET_HOME/extras/valet.code-snippets
▶ called io::invoke git commit -m :memo: updating the documentation
SUCCESS  The documentation update has been committed.
▶ called io::invoke sed -E -i s/VALET_RELEASED_VERSION="[0-9]+\.[^"]+"/VALET_RELEASED_VERSION="1.2.3"/ $GLOBAL_VALET_HOME/commands.d/self-install.sh
▶ called io::invoke git add $GLOBAL_VALET_HOME/commands.d/self-install.sh
▶ called io::invoke git commit -m :rocket: releasing version 1.2.3
SUCCESS  The new version has been committed.
▶ called io::invoke git tag -a v1.2.3 -m # Release of version 1.2.3

Changelog: 

- ✨ feature
- 🐞 fix

SUCCESS  The new version has been tagged.
▶ called io::invoke git push origin main
▶ called io::invoke git push origin v1.2.3
SUCCESS  The ⌜main⌝ branch and the new version ⌜v1.2.3⌝ has been pushed.
▶ called io::invoke git push origin -f main:latest
SUCCESS  The ⌜latest⌝ branch has been updated.
DEBUG    The release payload is: ⌜{
    "name": "v1.2.3",
    "tag_name": "v1.2.3",
    "body": "# Release of version 1.2.3\n\nChangelog: \n\n- ✨ feature\n- 🐞 fix\n",
    "draft": false,
    "prerelease": false
  }⌝
▶ called curl::toVar true 201,422 -X POST -H Authorization: token token -H Accept: application/vnd.github.v3+json -H Content-type: application/json; charset=utf-8 -d {
    "name": "v1.2.3",
    "tag_name": "v1.2.3",
    "body": "# Release of version 1.2.3\n\nChangelog: \n\n- ✨ feature\n- 🐞 fix\n",
    "draft": false,
    "prerelease": false
  } https://api.github.com/repos/jcaillon/valet/releases
SUCCESS  The new version has been released on GitHub.
DEBUG    The upload URL is: https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets
▶ called io::invoke cp -R $GLOBAL_VALET_HOME/examples.d .
▶ called io::invoke cp -R $GLOBAL_VALET_HOME/commands.d .
▶ called io::invoke cp -R $GLOBAL_VALET_HOME/libraries.d .
▶ called io::invoke cp -R $GLOBAL_VALET_HOME/extras .
▶ called io::invoke cp -R valet .
▶ called io::invoke cp -R $GLOBAL_VALET_HOME/version .
▶ called io::invoke tar -czvf valet.tar.gz examples.d commands.d libraries.d extras valet version
DEBUG    The artifact has been created at ⌜valet.tar.gz⌝ with:

INFO     Uploading the artifact ⌜valet.tar.gz⌝ to ⌜https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets⌝.
▶ called curl::toVar true  -X POST -H Authorization: token token -H Content-Type: application/tar+gzip --data-binary @valet.tar.gz https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets?name=valet.tar.gz
INFO     The current version of valet is: 1.2.3.
▶ called io::writeToFile $GLOBAL_VALET_HOME/version
INFO     The bumped version of valet is: 1.3.0.
▶ called io::invoke git add $GLOBAL_VALET_HOME/version
▶ called io::invoke git commit -m :bookmark: bump version to 1.3.0
▶ called io::invoke git push origin main
SUCCESS  The bumped version has been committed.
SUCCESS  The new version has been released, check: https://github.com/jcaillon/valet/releases/latest.
```

