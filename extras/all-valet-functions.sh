#!/usr/bin/env bash
# This script contains the documentation of all the valet library functions.
# It can be used in your editor to provide auto-completion and documentation.
#
# Documentation generated for the version 0.24.6 (2024-11-24).

# ## ansi-codes::*
# 
# ANSI codes for text attributes, colors, cursor control, and other common escape sequences.
# These codes can be used to format text in the terminal.
# 
# They are defined as variables and not as functions. Please check the content of the lib-ansi-codes to learn more:
# <https://github.com/jcaillon/valet/blob/latest/valet.d/lib-ansi-codes>
# 
# References:
# 
# - https://en.wikipedia.org/wiki/ANSI_escape_code
# - https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
# - https://paulbourke.net/dataformats/ascii/
# - https://www.aivosto.com/articles/control-characters.html
# - https://github.com/tmux/tmux/blob/master/tools/ansicode.txt
# - https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h2-Functions-using-CSI-_-ordered-by-the-final-character_s_
# - https://vt100.net/docs/vt102-ug/chapter5.html
# - https://vt100.net/docs/vt100-ug/chapter3.html#S3.3.1
# 
# Ascii graphics:
# 
# - https://gist.github.com/dsample/79a97f38bf956f37a0f99ace9df367b9
# 
# > While it could be very handy to define a function for each of these instructions,
# > it would also be slower to execute (function overhead + multiple printf calls).
# 
function ansi-codes::*() { return 0; }

# ## array::appendIfNotPresent
# 
# Add a value to an array if it is not already present.
# 
# - $1: **array name** _as string_:
#       The global variable name of the array.
# - $2: **value** _as any:
#       The value to add.
# 
# Returns:
# 
# - $?:
#   - 0 if the value was added
#   - 1 if it was already present
# 
# ```bash
# declare -g myArray=( "a" "b" )
# array::appendIfNotPresent myArray "c"
# printf '%s\n' "${myArray[@]}"
# ```
# 
function array::appendIfNotPresent() { return 0; }

# ## array::fuzzyFilter
# 
# Allows to fuzzy match an array against a given pattern.
# Returns an array containing only the lines matching the pattern.
# 
# - $1: **pattern** _as string_:
#       the pattern to match
# - $2: **array name** _as string_:
#       the initial array name
# 
# Returns:
# 
# - `RETURNED_ARRAY`: an array containing only the lines matching the pattern
# - `RETURNED_ARRAY2`: an array of the same size that contains the start index of the match
# - `RETURNED_ARRAY3`: an array of the same size that contains the distance of the match
# 
# ```bash
# array::fuzzyFilter "pattern" "myarray"
# if (( ${#RETURNED_ARRAY[@]} == 1 )); then
#   singleMatch="${RETURNED_ARRAY[0]}"
# fi
# ```
# 
# > - All characters in the pattern must be found in the same order in the matched line.
# > - The function is case insensitive.
# > - This function does not sort the results, it only filters them.
# 
function array::fuzzyFilter() { return 0; }

# ## array::fuzzyFilterSort
# 
# Allows to fuzzy sort an array against a given pattern.
# Returns an array containing only the lines matching the pattern.
# The array is sorted by (in order):
# 
# - the index of the first matched character in the line
# - the distance between the characters in the line
# 
# - $1: **pattern** _as string_:
#       the pattern to match
# - $2: **array name** _as string_:
#       the initial array name
# - $3: prefix matched char _as string_:
#       (optional) string to add before each matched char
#       (defaults to empty string)
# - $4: suffix matched char _as string_:
#       (optional) string to add after each matched char
#       (defaults to empty string)
# - $5: max line length _as int_:
#       (optional) The maximum length to keep for the matched lines,
#       does not count the strings added/before after each matched char
#       (defaults to 9999999)
# 
# Returns:
# 
# - `RETURNED_ARRAY`: An array containing the items sorted and filtered
# - `RETURNED_ARRAY2`: An array containing the indexes of the matched items in the original array
# 
# ```bash
# array::fuzzyFilterSort "pattern" "myarray" && local filteredArray="${RETURNED_ARRAY}"
# array::fuzzyFilterSort "pattern" "myarray" ⌜ ⌝ && local filteredArray="${RETURNED_ARRAY}"
# array::fuzzyFilterSort "pattern" "myarray" ⌜ ⌝ 10 && local filteredArray="${RETURNED_ARRAY}"
# ```
# 
# > - All characters in the pattern must be found in the same order in the matched line.
# > - The function is case insensitive.
# > - This function does not sort the results, it only filters them.
# 
function array::fuzzyFilterSort() { return 0; }

# ## array::isInArray
# 
# Check if a value is in an array.
# It uses pure bash.
# 
# - $1: **array name** _as string_:
#       The global variable name of the array.
# - $2: **value** _as any:
#       The value to check.
# 
# Returns:
# 
# - $?: 0 if the value is in the array, 1 otherwise.
# 
# ```bash
# declare -g myArray=( "a" "b" )
# array::isInArray myArray "b" && printf '%s\n' "b is in the array"
# ```
# 
function array::isInArray() { return 0; }

# ## array::makeArraysSameSize
# 
# This function makes sure that all the arrays have the same size.
# It will add empty strings to the arrays that are too short.
# 
# - $@: **array names** _as string_:
#       The arrays (global variable names) to make the same size.
# 
# ```bash
# array::makeArraysSameSize "array1" "array2" "array3"
# ```
# 
function array::makeArraysSameSize() { return 0; }

# ## array::sort
# 
# Sorts an array using the > bash operator (lexicographic order).
# 
# - $1: **array name** _as string_:
#       The global variable name of array to sort.
# 
# ```bash
# declare -g myArray=( "z" "a" "b" )
# array::sort myArray
# printf '%s\n' "${myArray[@]}"
# ```
# 
# > TODO: Update this basic exchange sort implementation.
# 
function array::sort() { return 0; }

# ## array::sortWithCriteria
# 
# Sorts an array using mulitple criteria.
# Excepts multiple arrays. The first array is the one to sort.
# The other arrays are used as criteria. Criteria are used in the order they are given.
# Each criteria array must have the same size as the array to sort.
# Each criteria array must containing integers representing the order of the elements.
# We first sort using the first criteria (from smallest to biggest), then the second, etc.
# 
# - $1: **array name** _as string_:
#       the name of the array to sort (it is sorted in place)
# - $@: **criteria array names** _as string_:
#       the names of the arrays to use as criteria
# 
# Returns:
# 
# - `RETURNED_ARRAY`: An array that contains the corresponding indexes of the sorted array in the original array
# 
# ```bash
# declare -g myArray=( "a" "b" "c" )
# declare -g criteria1=( 3 2 2 )
# declare -g criteria2=( 1 3 2 )
# array::sortWithCriteria myArray criteria1 criteria2
# printf '%s\n' "${myArray[@]}"
# # c b a
# printf '%s\n' "${RETURNED_ARRAY[@]}"
# # 3 2 1
# ```
# 
# > TODO: Update this basic exchange sort implementation.
# 
function array::sortWithCriteria() { return 0; }

# ## core::checkParseResults
# 
# A convenience function to check the parsing results and fails with an error message if there are
# parsing errors.
# Will also display the help if the help option is true.
# 
# This should be called from a command function for which you want to check the parsing results.
# 
# - $1: **display help** _as bool_:
#       the help option
# - $2: **parsing errors** _as string_:
#       the parsing errors
# - $3: function name _as string_:
#       (optional) the function name
#       (defaults to the calling function)
# 
# ```bash
# core::checkParseResults "${help:-}" "${parsingErrors:-}"
# core::checkParseResults "${help:-}" "${parsingErrors:-}" "myFunctionName"
# ```
# 
function core::checkParseResults() { return 0; }

# ## core::fail
# 
# Displays an error message and then exit the program with error.
# 
# - $@: **message** _as string_:
#       the error message to display
# 
# ```bash
# core::fail "This is an error message."
# ```
# 
function core::fail() { return 0; }

# ## core::failWithCode
# 
# Displays an error message and then exit the program with error.
# 
# - $1: **exit code** _as int_:
#       the exit code to use, should be between 1 and 255
# - $@: **message** _as string_:
#       the error message to display
# 
# ```bash
# core::failWithCode 255 "This is an error message."
# ```
# 
function core::failWithCode() { return 0; }

# ## core::getConfigurationDirectory
# 
# Returns the path to the valet configuration directory.
# Creates it if missing.
# 
# Returns:
# 
# - `RETURNED_VALUE`: the path to the valet configuration directory
# 
# ```bash
# core::getConfigurationDirectory
# local directory="${RETURNED_VALUE}"
# ```
# 
function core::getConfigurationDirectory() { return 0; }

# ## core::getLocalStateDirectory
# 
# Returns the path to the valet locla state directory.
# The base directory relative to which user-specific state files should be stored.
# Creates it if missing.
# 
# Returns:
# 
# - `RETURNED_VALUE`: the path to the valet local state directory
# 
# ```bash
# core::getLocalStateDirectory
# local directory="${RETURNED_VALUE}"
# ```
# 
function core::getLocalStateDirectory() { return 0; }

# ## core::getUserDirectory
# 
# Returns the path to the valet user directory.
# Does not create it if missing.
# 
# Returns:
# 
# - `RETURNED_VALUE`: the path to the valet user directory
# 
# ```bash
# core::getUserDirectory
# local directory="${RETURNED_VALUE}"
# ```
# 
function core::getUserDirectory() { return 0; }

# ## core::getVersion
# 
# Returns the version of Valet.
# 
# Returns:
# 
# - `RETURNED_VALUE`: The version of Valet.
# 
# ```bash
# core::getVersion
# printf '%s\n' "The version of Valet is ⌜${RETURNED_VALUE}⌝."
# ```
# 
function core::getVersion() { return 0; }

# ## core::parseArguments
# 
# Parse the arguments and options of a function and return a string that can be evaluated to set the variables.
# This should be called from a command function for which you want to parse the arguments.
# 
# See the documentation for more details on the parser: <https://jcaillon.github.io/valet/docs/new-commands/#-implement-your-command>.
# 
# 
# - $@: **arguments** _as any_:
#       the arguments to parse
# 
# Returns:
# 
# - `RETURNED_VALUE`: a string that can be evaluated to set the parsed variables
# 
# Output example:
# 
# ```
# local arg1 option1
# arg1="xxx"
# option1="xxx"
# ```
# 
# ```bash
# core::parseArguments "$@" && eval "${RETURNED_VALUE}"
# ```
# 
function core::parseArguments() { return 0; }

# ## core::reloadUserCommands
# 
# Forcibly source again the user 'commands' file from the valet user directory.
# 
# ```bash
# core::reloadUserCommands
# ```
# 
function core::reloadUserCommands() { return 0; }

# ## core::resetIncludedFiles
# 
# Allows to reset the included files.
# When calling the source function, it will source all the files again.
# This is useful when we want to reload the libraries.
# 
# ```bash
# core::resetIncludedFiles
# ```
# 
function core::resetIncludedFiles() { return 0; }

# ## core::showHelp
# 
# Show the help for the current function.
# This should be called directly from a command function for which you want to display the help text.
# 
# ```bash
# core::showHelp
# ```
# 
function core::showHelp() { return 0; }

# ## core::sourceFunction
# 
# Source the file associated with a command function.
# This allows you to call a command function without having to source the file manually.
# 
# - $1: **function name** _as string_:
#       the function name
# 
# ```bash
# core::sourceFunction "functionName"
# ```
# 
function core::sourceFunction() { return 0; }

# ## core::sourceUserCommands
# 
# Source the user 'commands' file from the valet user directory.
# If the file does not exist, we build it on the fly.
# 
# ```bash
# core::sourceUserCommands
# ```
# 
function core::sourceUserCommands() { return 0; }

# ## fsfs::itemSelector
# 
# Displays a menu where the user can search and select an item.
# The menu is displayed in full screen.
# Each item can optionally have a description/details shown in a right panel.
# The user can search for an item by typing.
# 
# - $1: **prompt** _as string_:
#       The prompt to display to the user (e.g. Please pick an item).
# - $2: **array name** _as string_:
#       The items to display (name of a global array).
# - $3: select callback function name _as string_:
#       (optional) The function to call when an item is selected
#       (defaults to empty, no callback)
#       this parameter can be left empty to hide the preview right pane;
#       otherwise the callback function should have the following signature:
#   - $1: the current item
#   - $2: the item number;
#   - $3: the current panel width;
#   - it should return the details of the item in the `RETURNED_VALUE` variable.
# - $4: preview title _as string_:
#       (optional) the title of the preview right pane (if any)
#       (defaults to empty)
# 
# Returns:
# 
# - `RETURNED_VALUE`: The selected item value (or empty).
# - `RETURNED_VALUE2`: The selected item index (from the original array).
#                      Or -1 if the user cancelled the selection
# 
# ```bash
# declare -g -a SELECTION_ARRAY
# SELECTION_ARRAY=("blue" "red" "green" "yellow")
# fsfs::itemSelector "What's your favorite color?" SELECTION_ARRAY
# log::info "You selected: ⌜${RETURNED_VALUE}⌝ (index: ⌜${RETURNED_VALUE2}⌝)"
# ```
# 
function fsfs::itemSelector() { return 0; }

# ##  interactive::askForConfirmation
# 
# Ask the user to press the button to continue.
# 
# - $1: **prompt** _as string_:
#       the prompt to display
# 
# Returns:
# 
# - $?:
#   - 0 if the user pressed enter
#   - 1 otherwise
# 
# ```bash
# interactive::askForConfirmation "Press enter to continue."
# ```
# 
function interactive::askForConfirmation() { return 0; }

# ## interactive::askForConfirmationRaw
# 
# Ask the user to press the button to continue.
# 
# This raw version does not display the prompt or the answer.
# 
# Returns:
# 
# - $?:
#   - 0 if the user pressed enter
#   - 1 otherwise
# 
# ```bash
# interactive::askForConfirmationRaw
# ```
# 
function interactive::askForConfirmationRaw() { return 0; }

# ## interactive::clearKeyPressed
# 
# This function reads all the inputs from the user, effectively discarding them.
# 
# ```bash
# interactive::clearKeyPressed
# ```
# 
function interactive::clearKeyPressed() { return 0; }

# ## interactive::createSpace
# 
# This function creates some new lines after the current cursor position.
# Then it moves back to its original position.
# This effectively creates a space in the terminal (scroll up if we are at the bottom).
# It does not create more space than the number of lines in the terminal.
# 
# - $1: **number of lines** _as int_:
#       the number of lines to create
# 
# ```bash
# interactive::createSpace 5
# ```
# 
function interactive::createSpace() { return 0; }

# ## interactive::displayAnswer
# 
# Displays an answer to a previous question.
# 
# The text is wrapped and put inside a box like so:
# 
# ```text
#     ┌─────┐
#     │ No. ├──░
#     └─────┘
# ```
# 
# - $1: **answer** _as string_:
#       the answer to display
# - $2: max width _as int_:
#       (optional) the maximum width of the text in the dialog box
#       (defaults to GLOBAL_COLUMNS)
# 
# ```bash
# interactive::displayAnswer "My answer."
# ```
# 
function interactive::displayAnswer() { return 0; }

# ## interactive::displayDialogBox
# 
# Displays a dialog box with a speaker and a text.
# 
# - $1: **speaker** _as string_:
#       the speaker (system or user)
# - $2: **text** _as string_:
#       the text to display
# - $3: max width _as int_:
#       (optional) the maximum width of the text in the dialog box
#       (defaults to GLOBAL_COLUMNS)
# 
# ```bash
# interactive::displayDialogBox "system" "This is a system message."
# ```
# 
function interactive::displayDialogBox() { return 0; }

# ## interactive::displayQuestion
# 
# Displays a question to the user.
# 
# The text is wrapped and put inside a box like so:
# 
# ```text
#    ┌────────────────────────────────┐
# ░──┤ Is this an important question? │
#    └────────────────────────────────┘
# ```
# 
# - $1: **prompt** _as string_:
#       the prompt to display
# - $2: max width _as int_:
#       (optional) the maximum width of text in the dialog box
#       (defaults to GLOBAL_COLUMNS)
# 
# ```bash
# interactive::displayPrompt "Do you want to continue?"
# ```
# 
function interactive::displayQuestion() { return 0; }

# ## interactive::getCursorPosition
# 
# Get the current cursor position.
# 
# Returns:
# 
# - `CURSOR_LINE`: the line number
# - `CURSOR_COLUMN`: the column number
# 
# ```bash
# interactive::getCursorPosition
# ```
# 
function interactive::getCursorPosition() { return 0; }

# ## interactive::promptYesNo
# 
# Ask the user to yes or no.
# 
# - The user can switch between the two options with the arrow keys or space.
# - The user can validate the choice with the enter key.
# - The user can also validate immediately with the y or n key.
# 
# - $1: **prompt** _as string_:
#       the prompt to display
# - $2: default _as bool_:
#       (optional) the default value to select
#       (defaults to true)
# 
# Returns:
# 
# - $?:
#   - 0 if the user answered yes
#   - 1 otherwise
# - `RETURNED_VALUE`: true or false.
# 
# ```bash
# if interactive::promptYesNo "Do you want to continue?"; then echo "Yes."; else echo "No."; fi
# ```
# 
function interactive::promptYesNo() { return 0; }

# ## interactive::promptYesNoRaw
# 
# Ask the user to yes or no.
# 
# - The user can switch between the two options with the arrow keys or space.
# - The user can validate the choice with the enter key.
# - The user can also validate immediately with the y or n key.
# 
# This raw version does not display the prompt or the answer.
# 
# - $1: default _as bool_:
#       (optional) the default value to select
#       (defaults to true)
# 
# Returns:
# 
# - $?:
#   - 0 if the user answered yes
#   - 1 otherwise
# - `RETURNED_VALUE`: true or false.
# 
# ```bash
# interactive::promptYesNoRaw "Do you want to continue?" && local answer="${RETURNED_VALUE}"
# ```
# 
function interactive::promptYesNoRaw() { return 0; }

# ## interactive::rebindKeymap
# 
# Rebinds all special keys to call a callback function `interactiveOnKeyBindingPress`.
# 
# This allows to use the `-e` option with the read command and receive events for special key press.
# 
# Key binding is a mess because binding is based on the sequence of characters that gets
# generated by the terminal when a key is pressed and this is not standard across all terminals.
# We do our best here to cover most cases but it is by no mean perfect.
# A good base documentation was <https://en.wikipedia.org/wiki/ANSI_escape_code#Terminal_input_sequences>.
# 
# Users of this function can completely change the bindings afterward by implementing
# the `interactiveRebindOverride` function.
# 
# This function should be called before using interactive::waitForKeyPress.
# 
# ```bash
# interactive::rebindKeymap
# ```
# 
# > We do not bother to have a restore function because valet should not be sourced and
# > thus, modifications to the keymap are local to this script.
# > `showkey -a` is a good program to see the sequence of characters sent by the terminal.
# 
function interactive::rebindKeymap() { return 0; }

# ## interactive::startProgress
# 
# Shows a spinner / progress animation with configurable output including a progress bar.
# 
# The animation will be displayed until interactive::stopProgress is called
# or if the max number of frames is reached.
# 
# Outputs to stderr.
# This will run in the background and will not block the main thread.
# The main thread can continue to output logs while this animation is running.
# 
# - $1: output template _as string_:
#       (optional) the template to display
#       (defaults to VALET_CONFIG_PROGRESS_BAR_TEMPLATE="#spinner #percent ░#bar░ #message")
# - $2: max width _as int_:
#       (optional) the maximum width of the progress bar
#       (defaults to VALET_CONFIG_PROGRESS_BAR_SIZE=20)
# - $3: frame delay _as float_:
#       (optional) the time in seconds between each frame of the spinner
#       (defaults to VALET_CONFIG_PROGRESS_ANIMATION_DELAY=0.1)
# - $4: refresh every x frames _as int_:
#       (optional) the number of frames of the spinner to wait before refreshing the progress bar
#       (defaults to VALET_CONFIG_PROGRESS_BAR_UPDATE_INTERVAL=3)
# - $5: max frames _as int_:
#       (optional) the maximum number of frames to display
#       (defaults to 9223372036854775807)
# - $6: spinner _as string_:
#       (optional) the spinner to display (each character is a frame)
#       (defaults to VALET_CONFIG_SPINNER_CHARACTERS="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏")
#       Examples:
#       - ◐◓◑◒
#       - ▖▘▝▗
#       - ⣾⣽⣻⢿⡿⣟⣯⣷
#       - ⢄⢂⢁⡁⡈⡐⡠
#       - ◡⊙◠
#       - ▌▀▐▄
#       - ⠄⠆⠇⠋⠙⠸⠰⠠⠰⠸⠙⠋⠇⠆
# 
# ```bash
# interactive::startProgress "#spinner" "" 0.05 "" "" "⢄⢂⢁⡁⡈⡐⡠"
# wait 4
# interactive::stopProgress
# 
# interactive::startProgress "#spinner #percent ░#bar░ #message" 30 0.05 1
# IDX=0
# while [[ ${IDX} -le 50 ]]; do
#   interactive::updateProgress $((IDX * 2)) "Doing something ${IDX}/50..."
#   IDX=$((IDX + 1))
#   sleep 0.1
# done
# ```
# 
function interactive::startProgress() { return 0; }

# ## interactive::stopProgress
# 
# Stop the progress bar.
# 
# ```bash
# interactive::stopProgress
# ```
# 
function interactive::stopProgress() { return 0; }

# ## interactive::sttyInit
# 
# Disable the echo of the tty. Will no longer display the characters typed by the user.
# 
# ```bash
# interactive::sttyInit
# ```
# 
function interactive::sttyInit() { return 0; }

# ## interactive::sttyRestore
# 
# Enable the echo of the tty. Will display the characters typed by the user.
# 
# - $1: **force** _as bool_:
#       (optional) force the restoration of the stty configuration
#       stty state will not be restored if
#       (defaults to false)
# 
# ```bash
# interactive::sttyRestore
# ```
# shellcheck disable=SC2120
# 
function interactive::sttyRestore() { return 0; }

# ## interactive::switchBackFromFullScreen
# 
# Call this function to switch back from the full screen mode.
# 
# - This function will restore the terminal state and show the cursor.
# - It will also restore the key echoing.
# - If there were error messages during the interactive session, they will be displayed at the end.
# 
# ```bash
# interactive::switchBackFromFullScreen
# ```
# 
function interactive::switchBackFromFullScreen() { return 0; }

# ## interactive::switchToFullScreen
# 
# Call this function to start an interactive session in full screen mode.
# This function will switch to the alternate screen, hide the cursor and clear the screen.
# It will also disable echoing when we type something.
# 
# You should call interactive::switchBackFromFullScreen at the end of the interactive session.
# 
# In the alternate screen, we don't see the error messages so we capture them somewhere else.
# 
# ```bash
# interactive::switchToFullScreen
# ```
# 
function interactive::switchToFullScreen() { return 0; }

# ## interactive::testWaitForChar
# 
# Wait for the user to send a character to stdin (i.e. wait for a key press)
# and prints the character that bash reads.
# 
# Useful to test the `interactive::waitForChar` function and see the char sequence we
# get when pressing a key in a given terminal.
# 
# See @interactive::waitForChar for more information.
# 
# ```bash
# interactive::testWaitForChar
# ```
# 
function interactive::testWaitForChar() { return 0; }

# ## interactive::testWaitForKeyPress
# 
# Wait for the user to press a key and prints it to the screen.
# This function is used to test the `interactive::waitForKeyPress` function.
# 
# See @interactive::waitForKeyPress for more information.
# 
# ```bash
# interactive::testWaitForKeyPress
# ```
# 
function interactive::testWaitForKeyPress() { return 0; }

# ## interactive::updateProgress
# 
# Update the progress bar with a new percentage and message.
# 
# The animation can be started with interactive::startProgress for more options.
# The animation will stop if the updated percentage is 100.
# 
# - $1: **percent** _as int_:
#       the percentage of the progress bar (0 to 100)
# - $2: message _as string_:
#       (optional) the message to display
# 
# ```bash
# interactive::updateProgress 50 "Doing something..."
# ```
# 
function interactive::updateProgress() { return 0; }

# ## interactive::waitForChar
# 
# Wait for a user input (single char).
# You can pass additional parameters to the read command (e.g. to wait for a set amount of time).
# 
# It uses the read builtin command. This will not detect all key combinations.
# The output will depend on the terminal used and the character sequences it sends on each key press.
# 
# For more advanced use cases, you can use interactive::waitForKeyPress.
# This simple implementation does not rely on GNU readline and does not require stty to be initialized.
# 
# Some special keys are translated into more readable strings:
# UP, DOWN, RIGHT, LEFT, BACKSPACE, DEL, PAGE_UP, PAGE_DOWN, HOME, END, ESC, F1-F12, ALT+...
# 
# - $@: **read parameters** _as any_:
#       additional parameters to pass to the read command
# 
# Returns:
# 
# - $?:
#   - 0 if a char was retrieved
#   - 1 otherwise
# - `LAST_KEY_PRESSED`: the last char (key) retrieved.
# 
# ```bash
# interactive::waitForChar
# interactive::waitForChar -t 0.1
# ```
# 
# > <https://en.wikipedia.org/wiki/ANSI_escape_code#Terminal_input_sequences>
# 
function interactive::waitForChar() { return 0; }

# ## interactive::waitForKeyPress
# 
# Wait for a key press (single key).
# You can pass additional parameters to the read command (e.g. to wait for a set amount of time).
# 
# It uses the read builtin command with the option `-e` to use readline behind the scene.
# This means we can detect more key combinations but all keys needs to be binded first...
# Special keys (CTRL+, ALT+, F1-F12, arrows, etc.) are intercepted using binding.
# 
# You must call `interactive::rebindKeymap` and `interactive::sttyInit` before using this function.
# You must also redefine the function `interactiveOnKeyBindingPress` to react to a binded key press.
# See @interactive::testWaitForKeyPress for an implementation example.
# 
# - $@: **read parameters** _as any_:
#       additional parameters to pass to the read command
# 
# Returns:
# 
# - $?:
#   - 0 if a key was pressed
#   - 1 otherwise
# - `LAST_KEY_PRESSED`: the key pressed.
# 
# ```bash
# interactive::waitForKeyPress
# interactive::waitForKeyPress -t 0.1
# ```
# 
# > Due to a bug in bash, if the cursor is at the end of the screen, it will make the screen scroll
# > even when nothing is read... Make sure to not position the cursor at the end of the screen.
# 
function interactive::waitForKeyPress() { return 0; }

# ## io::cat
# 
# Print the content of a file to stdout.
# This is a pure bash equivalent of cat.
# 
# - $1: **path** _as string_:
#       the file to print
# 
# ```bash
# io::cat "myFile"
# ```
# 
# > Also see log::printFile if you want to print a file for a user.
# 
function io::cat() { return 0; }

# ## io::checkAndFail
# 
# Check last return code and fail (exit) if it is an error.
# 
# - $1: **exit code** _as int_:
#       the return code
# - $@: **message** _as string_:
#       the error message to display in case of error
# 
# ```bash
# command_that_could_fail || io::checkAndFail "$?" "The command that could fail has failed!"
# ```
# 
function io::checkAndFail() { return 0; }

# ## io::checkAndWarn
# 
# Check last return code and warn the user in case the return code is not 0.
# 
# - $1: **exit code** _as int_:
#       the last return code
# - $@: **message** _as string_:
#       the warning message to display in case of error
# 
# ```bash
# command_that_could_fail || io::checkAndWarn "$?" "The command that could fail has failed!"
# ```
# 
function io::checkAndWarn() { return 0; }

# ## io::cleanupTempFiles
# 
# Removes all the temporary files and directories that were created by the
# io::createTempFile and io::createTempDirectory functions.
# 
# ```bash
# io::cleanupTempFiles
# ```
# shellcheck disable=SC2016
# 
function io::cleanupTempFiles() { return 0; }

# ## io::countArgs
# 
# Returns the number of arguments passed.
# 
# A convenient function that can be used to:
# 
# - count the files/directories in a directory
#   `io::countArgs "${PWD}"/* && local numberOfFiles="${RETURNED_VALUE}"`
# - count the number of variables starting with VALET_
#   `io::countArgs "${!VALET_@}" && local numberOfVariables="${RETURNED_VALUE}"`
# 
# - $@: **arguments** _as any_:
#       the arguments to count
# 
# Returns:
# 
# - `RETURNED_VALUE`: The number of arguments passed.
# 
# ```bash
# io::countArgs 1 2 3
# ```
# 
function io::countArgs() { return 0; }

# ## io::createFilePathIfNeeded
# 
# Make sure that the given file path exists.
# Create the directory tree and the file if needed.
# 
# - $1: **path** _as string_:
#       the file path to create
# 
# Returns:
# 
# - `RETURNED_VALUE`: The absolute path of the file.
# 
# ```bash
# io::createFilePathIfNeeded "myFile"
# ```
# 
function io::createFilePathIfNeeded() { return 0; }

# ## io::createTempDirectory
# 
# Creates a temporary directory.
# 
# Returns:
# 
# - `RETURNED_VALUE`: The created path.
# 
# ```bash
# io::createTempDirectory
# local directory="${RETURNED_VALUE}"
# ```
# 
# > Directories created this way are automatically cleaned up by the io::cleanupTempFiles
# > function when valet ends.
# 
function io::createTempDirectory() { return 0; }

# ## io::createTempFile
# 
# Creates a temporary file and return its path.
# 
# Returns:
# 
# - `RETURNED_VALUE`: The created path.
# 
# ```bash
# io::createTempFile
# local file="${RETURNED_VALUE}"
# ```
# 
# > Files created this way are automatically cleaned up by the io::cleanupTempFiles
# > function when valet ends.
# 
function io::createTempFile() { return 0; }

# ## io::invoke
# 
# This function call an executable and its arguments.
# If the execution fails, it will fail the script and show the std/err output.
# Otherwise it hides both streams, effectively rendering the execution silent unless it fails.
# 
# It redirects the stdout and stderr to environment variables.
# Equivalent to io::invoke5 true 0 '' '' "${@}"
# 
# - $1: **executable** _as string_:
#       the executable or command
# - $@: **arguments** _as any_:
#       the command and its arguments
# 
# Returns:
# 
# - $?: The exit code of the executable.
# - `RETURNED_VALUE`: The content of stdout.
# - `RETURNED_VALUE2`: The content of stderr.
# 
# ```bash
# io::invoke git add --all
# ```
# 
# > See io::invokef5 for more information.
# 
function io::invoke() { return 0; }

# ## io::invoke2
# 
# This function call an executable and its arguments.
# It redirects the stdout and stderr to environment variables.
# Equivalent to io::invoke5 "${1}" 0 "" "" "${@:2}"
# 
# - $1: **fail** _as bool_:
#       true/false to indicate if the function should fail in case the execution fails.
#       If true and the execution fails, the script will exit.
# - $2: **executable** _as string_:
#       the executable or function to execute
# - $@: **arguments** _as any_:
#       the arguments to pass to the executable
# 
# Returns:
# 
# - $?: The exit code of the executable.
# - `RETURNED_VALUE`: The content of stdout.
# - `RETURNED_VALUE2`: The content of stderr.
# 
# ```bash
# io::invokef2 false git status || core::fail "status failed."
# stdout="${RETURNED_VALUE}"
# stderr="${RETURNED_VALUE2}"
# ```
# 
# > See io::invokef5 for more information.
# 
function io::invoke2() { return 0; }

# ## io::invoke2piped
# 
# This function call an executable and its arguments and input a given string as stdin.
# It redirects the stdout and stderr to environment variables.
# Equivalent to io::invoke5 "${1}" 0 false "${2}" "${@:3}"
# 
# - $1: **fail** _as bool_:
#       true/false to indicate if the function should fail in case the execution fails.
#       If true and the execution fails, the script will exit.
# - $2: **stdin** _as string_:
#       the stdin to pass to the executable
# - $3: **executable** _as string_:
#       the executable or function to execute
# - $@: **arguments** _as any_:
#       the arguments to pass to the executable
# 
# Returns:
# 
# - $?: The exit code of the executable.
# - `RETURNED_VALUE`: The content of stdout.
# - `RETURNED_VALUE2`: The content of stderr.
# 
# ```bash
# io::invoke2piped true "key: val" yq -o json -p yaml -
# stdout="${RETURNED_VALUE}"
# stderr="${RETURNED_VALUE2}"
# ```
# 
# > This is the equivalent of:
# > `myvar="$(printf '%s\n' "mystring" | mycommand)"`
# > But without using a subshell.
# >
# > See io::invokef5 for more information.
# 
function io::invoke2piped() { return 0; }

# ## io::invokef2
# 
# This function call an executable and its arguments.
# It redirects the stdout and stderr to temporary files.
# Equivalent to io::invokef5 "${1}" 0 "" "" "${@:2}"
# 
# - $1: **fail** _as bool_:
#       true/false to indicate if the function should fail in case the execution fails.
#       If true and the execution fails, the script will exit.
# - $2: **executable** _as string_:
#       the executable or function to execute
# - $@: **arguments** _as any_:
#       the arguments to pass to the executable
# 
# Returns:
# 
# - $?: The exit code of the executable.
# - `RETURNED_VALUE`: The file path containing the stdout of the executable.
# - `RETURNED_VALUE2`: The file path containing the stderr of the executable.
# 
# ```bash
# io::invokef2 false git status || core::fail "status failed."
# stdoutFilePath="${RETURNED_VALUE}"
# stderrFilePath="${RETURNED_VALUE2}"
# ```
# 
# > See io::invokef5 for more information.
# 
function io::invokef2() { return 0; }

# ## io::invokef2piped
# 
# This function call an executable and its arguments and input a given string as stdin.
# It redirects the stdout and stderr to temporary files.
# Equivalent to io::invokef5 "${1}" 0 false "${2}" "${@:3}"
# 
# - $1: **fail** _as bool_:
#       true/false to indicate if the function should fail in case the execution fails.
#       If true and the execution fails, the script will exit.
# - $2: **stdin** _as string_:
#       the stdin to pass to the executable
# - $3: **executable** _as string_:
#       the executable or function to execute
# - $@: **arguments** _as any_:
#       the arguments to pass to the executable
# 
# Returns:
# 
# - $?: The exit code of the executable.
# - `RETURNED_VALUE`: The file path containing the stdout of the executable.
# - `RETURNED_VALUE2`: The file path containing the stderr of the executable.
# 
# ```bash
# io::invokef2piped true "key: val" yq -o json -p yaml -
# stdoutFilePath="${RETURNED_VALUE}"
# stderrFilePath="${RETURNED_VALUE2}"
# ```
# 
# > This is the equivalent of:
# > `myvar="$(printf '%s\n' "mystring" | mycommand)"`
# > But without using a subshell.
# >
# > See io::invokef5 for more information.
# 
function io::invokef2piped() { return 0; }

# ## io::invokef5
# 
# This function call an executable and its arguments.
# It redirects the stdout and stderr to temporary files.
# 
# - $1: **fail** _as bool_:
#       true/false to indicate if the function should fail in case the execution fails.
#                      If true and the execution fails, the script will exit.
# - $2: **acceptable codes** _as string_:
#       the acceptable error codes, comma separated
#         (if the error code is matched, then set the output error code to 0)
# - $3: **fail** _as bool_:
#       true/false to indicate if the 4th argument represents a file path or directly the content for stdin
# - $4: **sdtin** _as string_:
#       the stdin (can be empty)
# - $5: **executable** _as string_:
#       the executable or function to execute
# - $@: **arguments** _as any_:
#       the arguments to pass to the executable
# 
# Returns:
# 
# - $?: The exit code of the executable.
# - `RETURNED_VALUE`: The file path containing the stdout of the executable.
# - `RETURNED_VALUE2`: The file path containing the stderr of the executable.
# 
# ```bash
# io::invokef5 "false" "130,2" "false" "This is the stdin" "stuff" "--height=10" || core::fail "stuff failed."
# stdoutFilePath="${RETURNED_VALUE}"
# stderrFilePath="${RETURNED_VALUE2}"
# ```
# 
# > - In windows, this is tremendously faster to do (or any other invoke flavor):
# >   `io::invokef5 false 0 false '' mycommand && myvar="${RETURNED_VALUE}"`
# >   than doing:
# >   `myvar="$(mycommand)".`
# > - On linux, it is slighly faster (but it might be slower if you don't have SSD?).
# > - On linux, you can use a tmpfs directory for massive gains over subshells.
# 
function io::invokef5() { return 0; }

# ## io::isDirectoryWritable
# 
# Check if the directory is writable. Creates the directory if it does not exist.
# 
# - $1: **directory** _as string_:
#       the directory to check
# - $2: test file name _as string_:
#       (optional) the name of the file to create in the directory to test the write access
# 
# Returns:
# 
# - $?:
#   - 0 if the directory is writable
#   - 1 otherwise
# 
# ```bash
# if io::isDirectoryWritable "/path/to/directory"; then
#   echo "The directory is writable."
# fi
# ```
# 
function io::isDirectoryWritable() { return 0; }

# ## io::listDirectories
# 
# List all the directories in the given directory.
# 
# - $1: **directory** _as string_:
#       the directory to list
# - $2: recursive _as bool_:
#       (optional) true to list recursively, false otherwise
#       (defaults to false)
# - $3: hidden _as bool_:
#       (optional) true to list hidden paths, false otherwise
#       (defaults to false)
# - $4: directory filter function name _as string_:
#       (optional) a function name that is called to filter the sub directories (for recursive listing)
#       The function should return 0 if the path is to be kept, 1 otherwise.
#       The function is called with the path as the first argument.
#       (defaults to empty string, no filter)
# 
# Returns:
# 
# - `RETURNED_ARRAY`: An array with the list of all the files.
# 
# ```bash
# io::listDirectories "/path/to/directory" true true myFilterFunction
# for path in "${RETURNED_ARRAY[@]}"; do
#   printf '%s' "${path}"
# done
# ```
# 
function io::listDirectories() { return 0; }

# ## io::listFiles
# 
# List all the files in the given directory.
# 
# - $1: **directory** _as string_:
#       the directory to list
# - $2: recursive _as bool_:
#       (optional) true to list recursively, false otherwise
#       (defaults to false)
# - $3: hidden _as bool_:
#       (optional) true to list hidden paths, false otherwise
#       (defaults to false)
# - $4: directory filter function name _as string_:
#       (optional) a function name that is called to filter the directories (for recursive listing)
#       The function should return 0 if the path is to be kept, 1 otherwise.
#       The function is called with the path as the first argument.
#       (defaults to empty string, no filter)
# 
# Returns:
# 
# - `RETURNED_ARRAY`: An array with the list of all the files.
# 
# ```bash
# io::listFiles "/path/to/directory" true true myFilterFunction
# for path in "${RETURNED_ARRAY[@]}"; do
#   printf '%s' "${path}"
# done
# ```
# 
function io::listFiles() { return 0; }

# ## io::listPaths
# 
# List all the paths in the given directory.
# 
# - $1: **directory** _as string_:
#       the directory to list
# - $2: recursive _as bool_:
#       (optional) true to list recursively, false otherwise
#       (defaults to false)
# - $3: hidden _as bool_:
#       (optional) true to list hidden paths, false otherwise
#       (defaults to false)
# - $4: path filter function name _as string_:
#       (optional) a function name that is called to filter the paths that will be listed
#       The function should return 0 if the path is to be kept, 1 otherwise.
#       The function is called with the path as the first argument.
#       (defaults to empty string, no filter)
# - $5: directory filter function name _as string_:
#       (optional) a function name that is called to filter the directories (for recursive listing)
#       The function should return 0 if the path is to be kept, 1 otherwise.
#       The function is called with the path as the first argument.
#       (defaults to empty string, no filter)
# 
# Returns:
# 
# - `RETURNED_ARRAY`: An array with the list of all the paths.
# 
# ```bash
# io::listPaths "/path/to/directory" true true myFilterFunction myFilterDirectoryFunction
# for path in "${RETURNED_ARRAY[@]}"; do
#   printf '%s' "${path}"
# done
# ```
# 
# > - It will correctly list files under symbolic link directories.
# 
function io::listPaths() { return 0; }

# ## io::readFile
# 
# Reads the content of a file and returns it in the global variable RETURNED_VALUE.
# Uses pure bash.
# 
# - $1: **path** _as string_:
#       the file path to read
# - $2: max char _as int_:
#       (optional) the maximum number of characters to read
#       (defaults to 0, which means read the whole file)
# 
# > If the file does not exist, the function will return an empty string instead of failing.
# 
# Returns:
# 
# - `RETURNED_VALUE`: The content of the file.
# 
# ```bash
# io::readFile "/path/to/file" && local fileContent="${RETURNED_VALUE}"
# io::readFile "/path/to/file" 500 && local fileContent="${RETURNED_VALUE}"
# ```
# 
function io::readFile() { return 0; }

# ## io::readStdIn
# 
# Read the content of the standard input.
# Will immediately return if the standard input is empty.
# 
# Returns:
# 
# - `RETURNED_VALUE`: The content of the standard input.
# 
# ```bash
# io::readStdIn && local stdIn="${RETURNED_VALUE}"
# ```
# 
function io::readStdIn() { return 0; }

# ## io::sleep
# 
# Sleep for the given amount of time.
# This is a pure bash replacement of sleep.
# 
# - $1: **time** _as float_:
#       the time to sleep in seconds (can be a float)
# 
# ```bash
# io:sleep 1.5
# ```
# 
# > The sleep command is not a built-in command in bash, but a separate executable. When you use sleep, you are creating a new process.
# 
function io::sleep() { return 0; }

# ## io::toAbsolutePath
# 
# This function returns the absolute path of a path.
# 
# - $1: **path** _as string_:
#       The path to translate to absolute path.
# 
# Returns:
# 
# - `RETURNED_VALUE`: The absolute path of the path.
# 
# ```bash
# io::toAbsolutePath "myFile"
# local myFileAbsolutePath="${RETURNED_VALUE}"
# ```
# 
# > This is a pure bash alternative to `realpath` or `readlink`.
# 
function io::toAbsolutePath() { return 0; }

# ##  kurl::toFile
# 
# This function is a wrapper around curl.
# It allows you to check the http status code and return 1 if it is not acceptable.
# It io::invokes curl with the following options (do not repeat them): -sSL -w "%{response_code}" -o ${2}.
# 
# - $1: **fail** _as bool_:
#       true/false to indicate if the function should fail in case the execution fails
# - $2: **acceptable codes** _as string_:
#       list of http status codes that are acceptable, comma separated
#       (defaults to 200,201,202,204,301,304,308 if left empty)
# - $3: **path** _as string_:
#       the file in which to save the output of curl
# - $@: **curl arguments** _as any_:
#       options for curl
# 
# Returns:
# 
# - $?:
#   - 0 if the http status code is acceptable
#   - 1 otherwise
# - `RETURNED_VALUE`: the content of stderr
# - `RETURNED_VALUE2`: the http status code
# 
# ```bash
# kurl::toFile "true" "200,201" "/filePath" "https://example.com" || core::fail "The curl command failed."
# ```
# 
function kurl::toFile() { return 0; }

# ## kurl::toVar
# 
# This function is a wrapper around curl.
# It allows you to check the http status code and return 1 if it is not acceptable.
# It io::invokes curl with the following options (do not repeat them): -sSL -w "%{response_code}" -o "tempfile".
# 
# - $1: **fail** _as bool_:
#       true/false to indicate if the function should fail in case the execution fails
# - $2: **acceptable codes** _as string_:
#       list of http status codes that are acceptable, comma separated
#       (defaults to 200,201,202,204,301,304,308 if left empty)
# - $@: **curl arguments** _as any_:
#       options for curl
# 
# Returns:
# 
# - $?:
#   - 0 if the http status code is acceptable
#   - 1 otherwise
# - `RETURNED_VALUE`: the content of the request
# - `RETURNED_VALUE2`: the content of stderr
# - `RETURNED_VALUE3`: the http status code
# 
# ```bash
# kurl::toVar false 200,201 https://example.com || core::fail "The curl command failed."
# ```
# 
function kurl::toVar() { return 0; }

# ## log::debug
# 
# Displays a debug message.
# 
# - $@: **message** _as string_:
#       the debug messages to display
# 
# ```bash
# log::debug "This is a debug message."
# ```
# 
function log::debug() { return 0; }

# ## log::error
# 
# Displays an error message.
# 
# - $@: **message** _as string_:
#       the error messages to display
# 
# ```bash
# log::error "This is an error message."
# ```
# 
# > You probably want to exit immediately after an error and should consider using core::fail function instead.
# 
function log::error() { return 0; }

# ## log::errorTrace
# 
# Displays an error trace message.
# This is a trace message that is always displayed, independently of the log level.
# It can be used before a fatal error to display useful information.
# 
# - $@: **message** _as string_:
#       the trace messages to display
# 
# ```bash
# log::errorTrace "This is a debug message."
# ```
# 
function log::errorTrace() { return 0; }

# ## log::getLevel
# 
# Get the current log level.
# 
# Returns:
# 
# - `RETURNED_VALUE`: The current log level.
# 
# ```bash
# log::getLevel
# printf '%s\n' "The log level is ⌜${RETURNED_VALUE}⌝."
# ```
# 
function log::getLevel() { return 0; }

# ## log::info
# 
# Displays an info message.
# 
# - $@: **message** _as string_:
#       the info messages to display
# 
# ```bash
# log::info "This is an info message."
# ```
# 
function log::info() { return 0; }

# ## log::isDebugEnabled
# 
# Check if the debug mode is enabled.
# 
# Returns:
# 
# - $?:
#   - 0 if debug mode is enabled (log level is debug)
#   - 1 if disabled
# 
# ```bash
# if log::isDebugEnabled; then printf '%s\n' "Debug mode is active."; fi
# ```
# 
function log::isDebugEnabled() { return 0; }

# ## log::isTraceEnabled
# 
# Check if the trace mode is enabled.
# 
# Returns:
# 
# - $?:
#   - 0 if trace mode is enabled (log level is trace)
#   - 1 if disabled
# 
# ```bash
# if log::isTraceEnabled; then printf '%s\n' "Debug mode is active."; fi
# ```
# 
function log::isTraceEnabled() { return 0; }

# ## log::printCallStack
# 
# This function prints the current function stack in the logs.
# 
# - $1: **stack to skip** _as int_:
#       the number of stack to skip (defaults to 2 which skips this function
#       and the first calling function which is usually the onError function)
# 
# ```bash
# log::printCallStack 2
# ```
# 
function log::printCallStack() { return 0; }

# ## log::printFile
# 
# Display a file content with line numbers in the logs.
# The file content will be aligned with the current log output and hard wrapped if necessary.
# 
# - $1: **path** _as string_:
#       the file path to display.
# - $2: max lines _as int_:
#       (optional) max lines to display (defaults to 0 which prints all lines).
# 
# ```bash
# log::printFile "/my/file/path"
# ```
# shellcheck disable=SC2317
# 
function log::printFile() { return 0; }

# ## log::printFileString
# 
# Display a file content with line numbers in the logs.
# The file content will be aligned with the current log output and hard wrapped if necessary.
# 
# - $1: **content** _as string_:
#       the file content.
# - $2: **max lines** _as int_:
#       (optional) max lines to display (defaults to 0 which prints all lines).
# 
# ```bash
# log::printFileString "myfilecontent"
# ```
# shellcheck disable=SC2317
# 
function log::printFileString() { return 0; }

# ## log::printRaw
# 
# Display something in the log stream.
# Does not check the log level.
# 
# - $1: **content** _as string_:
#       the content to print (can contain new lines)
# 
# ```bash
# log::printRaw "my line"
# ```
# shellcheck disable=SC2317
# 
function log::printRaw() { return 0; }

# ## log::printString
# 
# Display a string in the log.
# The string will be aligned with the current log output and hard wrapped if necessary.
# Does not check the log level.
# 
# - $1: **content** _as string_:
#       the content to log (can contain new lines)
# - $2: new line pad string _as string_:
#       (optional) the string with which to prepend each wrapped line
#       (empty by default)
# 
# ```bash
# log::printString "my line"
# ```
# shellcheck disable=SC2317
# 
function log::printString() { return 0; }

# ## log::setLevel
# 
# Set the log level.
# 
# - $1: **log level** _as string_:
#       the log level to set (or defaults to info), acceptable values are:
#   - trace
#   - debug
#   - info
#   - success
#   - warning
#   - error
# - $2: silent _as bool_:
#       (optional) true to silently switch log level, i.e. does not print a message
#       (defaults to false)
# 
# ```bash
# log::setLevel debug
# log::setLevel debug true
# ```
# 
function log::setLevel() { return 0; }

# ## log::success
# 
# Displays a success message.
# 
# - $@: **message** _as string_:
#       the success messages to display
# 
# ```bash
# log::success "This is a success message."
# ```
# 
function log::success() { return 0; }

# ## log::trace
# 
# Displays a trace message.
# 
# - $@: **message** _as string_:
#       the trace messages to display
# 
# ```bash
# log::trace "This is a trace message."
# ```
# 
function log::trace() { return 0; }

# ## log::warning
# 
# Displays a warning.
# 
# - $@: **message** _as string_:
#       the warning messages to display
# 
# ```bash
# log::warning "This is a warning message."
# ```
# 
function log::warning() { return 0; }

# ## profiler::disable
# 
# Disable the profiler if previously activated with profiler::enable.
# 
# ```bash
# profiler::disable
# ```
# 
function profiler::disable() { return 0; }

# ## profiler::enable
# 
# Enables the profiler and start writing to the given file.
# 
# - $1: **path** _as string_:
#       the file to write to.
# 
# ```bash
# profiler::enable "${HOME}/valet-profiler-${BASHPID}.txt"
# ```
# 
# > There can be only one profiler active at a time.
# 
function profiler::enable() { return 0; }

# ## prompt::autocompletion
# 
# Displays an autocompletion input starting at a given location. Allows
# the user to type a text in the given row betwen a starting column and
# ending column (included). Longer text are shifted to fit between
# the two columns.
# 
# This component is a replacement for the `read -e` command, which allows
# to limit the input to a single line and to provide autocompletion.
# 
# The autocompletion box can be hidden, or displayed below/above the input text
# depending on the space available on the screen.
# 
# The user can type character to filter down a list of suggestions,
# navigate up and down between suggestions, insert a suggestion using
# TAB or ENTER, press ESC to close the autocompletion box, and ALT+ENTER to
# submit the input (or just ENTER when the box is closed).
# 
# The autocompletion box will position itself depending on the screen size
# and the starting position of the text.
# 
# The multiple options allows to use this function to ask for any user input
# as long as it is on a single line.
# 
# You can define several callback functions that are called on different events:
# 
# - `autocompletionOnTextUpdate`: Called when the text is updated (after each key press).
# 
# - $1: **start line** _as int_:
#       The line/row at which the autocompleted text starts (this is used to
#       compute how to display the box).
# - $2: **start column** _as int_:
#       The column at which the autocompleted text starts (this is used to
#       compute how to display the box).
# - $3: **stop column** _as int_:
#       The column at which to stop showing the autocompleted text.
#       Longer texts get shifted to display the end of the user input.
# - $4: **array name** _as string_:
#       The items to display (name of a global array which contains the items).
#       If left empty, the autocompletion box will not be displayed. Useful to turn this into a simple prompt.
# - $5: initial text _as string_:
#       (optional) The initial string, which corresponds to the text already entered
#       by the user at the moment the autocompletion box shows up.
#       Allows to prefilter the autocompletion.
#       (defaults to empty)
# - $6: max lines _as int_:
#       optional) The maximum number of lines/rows to use for the autocompletion box.
#       (defaults to a maximized auto-computed value depending on the items and screen size)
# - $7: force box below _as bool_:
#       (optional) If true, the box is forced to be displayed below the input text.
#       Otherwise it will depend on the space required and space available below/above.
#       (defaults to false)
# - $8: show prompt _as bool_:
#       (optional) If true, the prompt is displayed. If false, the prompt is hidden.
#       Useful to turn this into a simple multiple choice list.
#       (defaults to true)
# - $9: force show count _as bool_:
#       (optional) If true, the count of items is always displayed.
#       If false, the count is only displayed when we can'y display all the items at once.
#       (defaults to false)
# - $10: show left cursors _as bool_:
#       (optional) If true, the left cursors are displayed (> for prompt and the > for selected item).
#       Useful to display the most simple auto-completion when false.
#       (defaults to true)
# - $11: filters from n chars _as int_:
#       (optional) The minimum number of characters to type before starting to filter the items.
#       By default, the list is shown full and the user can start typing to filter.
#       Put a value superior to 0 to make it behave like a standard autocompletion.
#       When non-zero, the user can CTRL+SPACE to show the full list.
#       (defaults to 0)
# - $12: accept any value _as bool_:
#       (optional) If true, the left cursors are displayed (> for prompt and the > for selected item).
#       Useful to display the most simple auto-completion when false.
#       (defaults to true)
# 
# Returns:
# 
# - $?:
#   - 0: The user pressed ENTER to validate the text.
#   - 1: The user pressed ESC to close the text box.
# - `RETURNED_VALUE`: The entered value (or empty).
# - `RETURNED_VALUE2`: The string displayed on the screen between the 2 columns at the
#                      moment when the autocompletion was closed.
# 
# ```bash
# prompt::autocompletion "Select an item" item_array_name "onItemSelected" "Details"
# ```
# 
function prompt::autocompletion() { return 0; }

# ## source
# 
# Allows to include a library file or sources a file.
# 
# It replaces the builtin source command to make sure that we do not include the same file twice.
# We replace source instead of creating a new function to allow us to
# specify the included file for spellcheck.
# 
# - $1: **library name** _as string_:
#       the name of the library (array, interactive, string...) or the file path to include.
# - $@: arguments _as any_:
#       (optional) the arguments to pass to the included file (mimics the builtin source command).
# 
# ```bash
#   source string array system
#   source ./my/path my/other/path
# ```
# 
# > - The file can be relative to the current script (script that calls this function).
# > - This function makes sure that we do not include the same file twice.
# > - Use `builtin source` if you want to include the file even if it was already included.
# 
function source() { return 0; }

# ## string::bumpSemanticVersion
# 
# This function allows to bump a semantic version formatted like:
# major.minor.patch-prerelease+build
# 
# - $1: **version** _as string_:
#       the version to bump
# - $2: **level** _as string_:
#       the level to bump (major, minor, patch)
# - $3: clear build and prerelease _as bool_:
#       (optional) clear the prerelease and build
#       (defaults to true)
# 
# Returns:
# 
# - `RETURNED_VALUE`: the new version string
# 
# ```bash
# string::bumpSemanticVersion "1.2.3-prerelease+build" "major"
# local newVersion="${RETURNED_VALUE}"
# ```
# 
function string::bumpSemanticVersion() { return 0; }

# ## string::camelCaseToSnakeCase
# 
# This function convert a camelCase string to a SNAKE_CASE string.
# It uses pure bash.
# Removes all leading underscores.
# 
# - $1: **camelCase string** _as string_:
#       The camelCase string to convert.
# 
# Returns:
# 
# - `RETURNED_VALUE`: The SNAKE_CASE string.
# 
# ```bash
# string::camelCaseToSnakeCase "myCamelCaseString" && local mySnakeCaseString="${RETURNED_VALUE}"
# ```
# 
function string::camelCaseToSnakeCase() { return 0; }

# ## string::compareSemanticVersion
# 
# This function allows to compare two semantic versions formatted like:
# major.minor.patch-prerelease+build
# 
# - $1: **version1** _as string_:
#       the first version to compare
# - $2: **version2** _as string_:
#       the second version to compare
# 
# Returns:
# 
# - `RETURNED_VALUE`:
#   - 0 if the versions are equal,
#   - 1 if version1 is greater,
#   - -1 if version2 is greater
# 
# ```bash
# string::compareSemanticVersion "2.3.4-prerelease+build" "1.2.3-prerelease+build"
# local comparison="${RETURNED_VALUE}"
# ```
# 
# > The prerelease and build are ignored in the comparison.
# 
function string::compareSemanticVersion() { return 0; }

# ## string::count
# 
# Counts the number of occurences of a substring in a string.
# 
# - $1: **string** _as string_:
#       the string in which to search
# - $2: **substring** _as string_:
#       the substring to count
# 
# Returns:
# 
# - `RETURNED_VALUE`: the number of occurences
# 
# ```bash
# string::count "name,firstname,address" "," && local count="${RETURNED_VALUE}"
# ```
# 
# > This is faster than looping over the string and check the substring.
# 
function string::count() { return 0; }

# ## string::cutField
# 
# Allows to get the nth element of a string separated by a given separator.
# This is the equivalent of the cut command "cut -d"${separator}" -f"${fieldNumber}""
# but it uses pure bash to go faster.
# 
# - $1: **string to cut** _as string_:
#       the string to cut
# - $2: **field number** _as int_:
#       the field number to get (starting at 0)
# - $3: separator _as string_:
#       the separator
#       (defaults to tab if not provided)
# 
# Returns:
# 
# - `RETURNED_VALUE`: the extracted field
# 
# ```bash
# string::cutField "field1 field2 field3" 1 " " && local field="${RETURNED_VALUE}"
# printf '%s' "${field}" # will output "field2"
# ```
# 
# > This is faster than:
# >
# > - using read into an array from a here string
# > - using bash parameter expansion to remove before/after the separator
# 
function string::cutField() { return 0; }

# ## string::extractBetween
# 
# Extract the text between two strings within a string.
# Search for the first occurence of the start string and the first occurence
# (after the start index) of the end string.
# Both start and end strings are excluded in the extracted text.
# Both start and end strings must be found to extract something.
# 
# - $1: **string** _as string_:
#       the string in which to search
# - $2: **start string** _as string_:
#       the start string
#       (if empty, then it will extract from the beginning of the string)
# - $3: **end string** _as string_:
#       the end string
#       (if empty, then it will extract until the end of the string)
# 
# Returns:
# 
# - `RETURNED_VALUE`: the extracted text
# 
# ```bash
# string::extractBetween "This is a long text" "is a " " text"
# local extractedText="${RETURNED_VALUE}"
# ```
# 
function string::extractBetween() { return 0; }

# ## string::indexOf
# 
# Find the first index of a string within another string.
# 
# - $1: **string** _as string_:
#       the string in which to search
# - $2: **search** _as string_:
#       the string to search
# - $3: start index _as int_:
#       (optional) the starting index
#       (defaults to 0)
# 
# Returns:
# 
# - `RETURNED_VALUE`: the index of the substring in the string or -1 if not found.
# 
# ```bash
# string::indexOf "This is a long text" "long" && local index="${RETURNED_VALUE}"
# string::indexOf "This is a long text" "long" 10 && local index="${RETURNED_VALUE}"
# ```
# 
function string::indexOf() { return 0; }

# ## string::kebabCaseToCamelCase
# 
# This function convert a kebab-case string to a camelCase string.
# It uses pure bash.
# Removes all leading dashes.
# 
# - $1: **kebab-case string** _as string_:
#       The kebab-case string to convert.
# 
# Returns:
# 
# - `RETURNED_VALUE`: The camelCase string.
# 
# ```bash
# string::kebabCaseToCamelCase "my-kebab-case-string" && local myCamelCaseString="${RETURNED_VALUE}"
# ```
# 
function string::kebabCaseToCamelCase() { return 0; }

# ## string::kebabCaseToSnakeCase
# 
# This function convert a kebab-case string to a SNAKE_CASE string.
# It uses pure bash.
# Removes all leading dashes.
# 
# - $1: **kebab-case string** _as string_:
#       The kebab-case string to convert.
# 
# Returns:
# 
# - `RETURNED_VALUE`: The SNAKE_CASE string.
# 
# ```bash
# string::kebabCaseToSnakeCase "my-kebab-case-string" && local mySnakeCaseString="${RETURNED_VALUE}"
# ```
# 
function string::kebabCaseToSnakeCase() { return 0; }

# ## string::microsecondsToHuman
# 
# Convert microseconds to human readable format.
# 
# - $1: **microseconds** _as int_:
#       the microseconds to convert
# - $2: **format** _as string_:
#      the format to use (defaults to "HH:MM:SS")
#      Usable formats:
#      - %HH: hours
#      - %MM: minutes
#      - %SS: seconds
#      - %LL: milliseconds
#      - %h: hours without leading zero
#      - %m: minutes without leading zero
#      - %s: seconds without leading zero
#      - %l: milliseconds without leading zero
#      - %u: microseconds without leading zero
#      - %M: total minutes
#      - %S: total seconds
#      - %L: total milliseconds
#      - %U: total microseconds
# 
# Returns:
# 
# - `RETURNED_VALUE`: the human readable format
# 
# ```bash
# string::microsecondsToHuman 123456789
# echo "${RETURNED_VALUE}"
# ```
# 
function string::microsecondsToHuman() { return 0; }

# ## string::regexGetFirst
# 
# Matches a string against a regex and returns the first capture group of the matched string.
# 
# - $1: **string** _as string_:
#       the string to match
# - $2: **regex** _as string_:
#       the regex
# 
# Returns:
# 
# - `RETURNED_VALUE`: the first capture group in the matched string.
#                     Empty if no match.
# 
# ```bash
# string::regexGetFirst "name: julien" "name:(.*)"
# echo "${RETURNED_VALUE}"
# ```
# 
# > Regex wiki: https://en.wikibooks.org/wiki/Regular_Expressions/POSIX-Extended_Regular_Expressions
# 
function string::regexGetFirst() { return 0; }

# ## string::split
# 
# Split a string into an array using a separator.
# 
# - $1: **string** _as string_:
#       the string to split
# - $2: **separator** _as string_:
#       the separator (must be a single character!)
# 
# Returns:
# 
# - `RETURNED_ARRAY`: the array of strings
# 
# ```bash
# string::split "name,firstname,address" "," && local -a array=("${RETURNED_ARRAY[@]}")
# ```
# 
# > This is faster than using read into an array from a here string.
# 
function string::split() { return 0; }

# ## string::trim
# 
# Trim leading and trailing whitespaces.
# 
# - $1: **string to trim** _as string_:
#       The string to trim.
# 
# Returns:
# 
# - `RETURNED_VALUE`: The trimmed string.
# 
# ```bash
# string::trim "   example string    " && local trimmedString="${RETURNED_VALUE}"
# ```
# 
function string::trim() { return 0; }

# ## string::trimAll
# 
# Trim all whitespaces and truncate spaces.
# 
# - $1: **string to trim** _as string_:
#       The string to trim.
# 
# Returns:
# 
# - `RETURNED_VALUE`: The trimmed string.
# 
# ```bash
# string::trimAll "   example   string    " && local trimmedString="${RETURNED_VALUE}"
# ```
# 
function string::trimAll() { return 0; }

# ## string::wrapCharacters
# 
# Allows to hard wrap the given string (without new lines) at the given width.
# Wrapping is done at character boundaries without taking spaces into consideration.
# Optionally applies a prefix on each new line.
# 
# - $1: **text** _as string_:
#       the text to wrap
# - $2: wrap width _as string_:
#       (optional) the width to wrap the text at
#       (defaults to GLOBAL_COLUMNS)
# - $3: new line pad string _as string_:
#       (optional) the prefix to apply to each new line
#       (defaults to "")
# - $4: new line wrap width _as string_:
#       (optional) the width to wrap the text for each new line
#       (defaults to the width)
# 
# Returns:
# 
# - `RETURNED_VALUE`: the wrapped string
# 
# ```bash
# string::wrapCharacters "This is a long text that should be wrapped at 20 characters." 20 ---
# local wrappedString="${RETURNED_VALUE}"
# ```
# 
# > This function is written in pure bash and is faster than calling the fold command.
# 
function string::wrapCharacters() { return 0; }

# ## string::wrapSentence
# 
# Allows to soft wrap the given sentence (without new lines) at the given width.
# Optionally applies a prefix on each new line.
# 
# - $1: **text** _as string_:
#       the text to wrap
# - $2: wrap width _as int_:
#       (optional) the width to wrap the text at
#       (defaults to GLOBAL_COLUMNS)
# - $3:*new line pad string _as string_:
#       (optional) the prefix to apply to each new line
#       (defaults to "")
# 
# Returns:
# 
# - `RETURNED_VALUE`: the wrapped text
# 
# ```bash
# string::wrapSentence "This is a long text that should be wrapped at 20 characters." 20
# local wrappedText="${RETURNED_VALUE}"
# ```
# 
# > - This function is written in pure bash and is faster than calling the fold command.
# > - This function effectively trims all the extra spaces in the text (leading, trailing but also in the middle).
# 
function string::wrapSentence() { return 0; }

# ## system::commandExists
# 
# Check if the given command exists.
# 
# - $1: **command name** _as string_:
#       the command name to check.
# 
# Returns:
# 
# - $?
#   - 0 if the command exists
#   - 1 otherwise.
# 
# ```bash
# if system::commandExists "command1"; then
#   printf 'The command exists.'
# fi
# ```
# 
function system::commandExists() { return 0; }

# ## system::date
# 
# Get the current date in the given format.
# 
# - $1: format _as string_:
#       (optional) the format of the date to return
#       (defaults to %(%F_%Hh%Mm%Ss)T).
# 
# Returns:
# 
# - `RETURNED_VALUE`: the current date in the given format.
# 
# ```bash
# system::date
# local date="${RETURNED_VALUE}"
# ```
# 
# > This function avoid to call $(date) in a subshell (date is a an external executable).
# 
function system::date() { return 0; }

# ## system::env
# 
# Get the list of all the environment variables.
# In pure bash, no need for env or printenv.
# 
# Returns:
# 
# - `RETURNED_ARRAY`: An array with the list of all the environment variables.
# 
# ```bash
# system::env
# for var in "${RETURNED_ARRAY[@]}"; do
#   printf '%s=%s\n' "${var}" "${!var}"
# done
# ```
# 
# > This is faster than using mapfile on <(compgen -v).
# 
function system::env() { return 0; }

# ## system::exportTerminalSize
# 
# This function exports the terminal size.
# 
# Returns:
# 
# - `GLOBAL_COLUMNS`: The number of columns in the terminal.
# - `GLOBAL_LINES`: The number of lines in the terminal.
# 
# ```bash
# system::exportTerminalSize
# printf '%s\n' "The terminal has ⌜${GLOBAL_COLUMNS}⌝ columns and ⌜${GLOBAL_LINES}⌝ lines."
# ```
# 
function system::exportTerminalSize() { return 0; }

# ## system::getNotExistingCommands
# 
# This function returns the list of not existing commands for the given names.
# 
# - $@: **command names** _as string_:
#       the list of command names to check.
# 
# Returns:
# 
# - $?
#   - 0 if there are not existing commands
#   - 1 otherwise.
# - `RETURNED_ARRAY`: the list of not existing commands.
# 
# ```bash
# if system::getNotExistingCommands "command1" "command2"; then
#   printf 'The following commands do not exist: %s' "${RETURNED_ARRAY[*]}"
# fi
# ```
# 
function system::getNotExistingCommands() { return 0; }

# ## system::getUndeclaredVariables
# 
# This function returns the list of undeclared variables for the given names.
# 
# - $@: **variable names** _as string_:
#       the list of variable names to check.
# 
# Returns:
# 
# - $?
#   - 0 if there are variable undeclared
#   - 1 otherwise.
# - `RETURNED_ARRAY`: the list of undeclared variables.
# 
# ```bash
# if system::getUndeclaredVariables "var1" "var2"; then
#   printf 'The following variables are not declared: %s' "${RETURNED_ARRAY[*]}"
# fi
# ```
# 
function system::getUndeclaredVariables() { return 0; }

# ## system::os
# 
# Returns the name of the current OS.
# 
# Returns:
# 
# - `RETURNED_VALUE`: the name of the current OS: "darwin", "linux" or "windows".
# 
# ```bash
# system::os
# local osName="${RETURNED_VALUE}"
# ```
# 
function system::os() { return 0; }

# ## test::commentTest
# 
# Call this function to add a paragraph in the report file.
# 
# - $1: **comment** _as string_:
#       the text to add in the report file
# 
# ```bash
# test::commentTest "This is a comment."
# ```
# 
function test::commentTest() { return 0; }

# ## test::endTest
# 
# Call this function after each test to write the test results to the report file.
# This create a new H3 section in the report file with the test description and the exit code.
# 
# - $1: **title** _as string_:
#       the title of the test
# - $2: **exit code** _as int_:
#       the exit code of the test
# - $3: comment _as string_:
#       (optional) a text to explain what is being tested
#       (defaults to "")
# 
# ```bash
# test::endTest "Testing something" $?
# ```
# 
function test::endTest() { return 0; }

