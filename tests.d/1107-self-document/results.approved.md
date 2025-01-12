# Test suite 1107-self-document

## Test script 01.self-document

### Testing selfDocument

Exit code: `0`

**Standard** output:

```plaintext
→ selfDocument --output /tmp/valet.d/d1-1 --core-only

→ cat /tmp/valet.d/d1-1/lib-valet.md
# Valet functions documentation

> Documentation generated for the version 1.2.3 (2013-11-10).

## ansi-codes::*

ANSI codes for text attributes, colors, cursor control, and other common escape sequences.
These codes can be used to format text in the terminal.

They are defined as variables and not as functions. Please check the content of the lib-ansi-codes to learn more:
<https://github.com/jcaillon/valet/blob/latest/libraries.d/lib-ansi-codes>

References:

- https://en.wikipedia.org/wiki/ANSI_escape_code
- https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
- https://paulbourke.net/dataformats/ascii/
- https://www.aivosto.com/articles/control-characters.html
- https://github.com/tmux/tmux/blob/master/tools/ansicode.txt
- https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h2-Functions-using-CSI-_-ordered-by-the-final-character_s_
- https://vt100.net/docs/vt102-ug/chapter5.html
- https://vt100.net/docs/vt100-ug/chapter3.html#S3.3.1

Ascii graphics:

- https://gist.github.com/dsample/79a97f38bf956f37a0f99ace9df367b9
- https://en.wikipedia.org/wiki/List_of_Unicode_characters#Box_Drawing
- https://en.wikipedia.org/wiki/List_of_Unicode_characters#Block_Elements

> While it could be very handy to define a function for each of these instructions,
> it would also be slower to execute (function overhead + multiple printf calls).


## array::appendIfNotPresent

Add a value to an array if it is not already present.

- $1: **array name** _as string_:
      The global variable name of the array.
- $2: **value** _as any:
      The value to add.

Returns:

- $?:
  - 0 if the value was added
  - 1 if it was already present

```bash
declare -g myArray=( "a" "b" )
array::appendIfNotPresent myArray "c"
printf '%s\n' "${myArray[@]}"
```


## array::fuzzyFilterSort

Allows to fuzzy sort an array against a given pattern.
Returns an array containing only the lines matching the pattern.
The array is sorted by (in order):

- the index of the first matched character in the line
- the distance between the first and last matched characters in the line
- the original order in the list

- $1: **pattern** _as string_:
      the pattern to match
- $2: **array name** _as string_:
      the initial array name

Returns:

- `RETURNED_ARRAY`: An array containing the items sorted and filtered
- `RETURNED_ARRAY2`: An array containing the indexes of the matched items in the original array

```bash
array::fuzzyFilterSort "pattern" "myarray" && local filteredArray="${RETURNED_ARRAY}"
array::fuzzyFilterSort "pattern" "myarray" ⌜ ⌝ && local filteredArray="${RETURNED_ARRAY}"
array::fuzzyFilterSort "pattern" "myarray" ⌜ ⌝ 10 && local filteredArray="${RETURNED_ARRAY}"
```

> - All characters in the pattern must be found in the same order in the matched line.
> - Use `shopt -s nocasematch` to make this function is case insensitive.
> - This function is not appropriate for large arrays (>10k elements), see `array::fuzzyFilterSortFileWithGrepAndAwk` for large arrays.


## array::fuzzyFilterSortFileWithGrepAndAwk

Allows to fuzzy sort a file against a given pattern.
Outputs a file containing only the lines matching the pattern.
The array is sorted by (in order):

- the index of the first matched character in the line
- the distance between the first and last matched characters in the line

- $1: **pattern** _as string_:
      The pattern to filter the file with.
- $2: **file to filer** _as string_:
      The input file to filter.
- $3: **output filtered file** _as string_:
      The output file containing the filtered lines.
- $4: **output correspondences file** _as string_:
      The output file containing the indexes of the matched lines in the original file.

```bash
array::fuzzyFilterSortFileWithGrepAndAwk file.txt filtered.txt correspondences.txt
```

> This is not a pure bash function! Use `array::fuzzyFilterSort` for pure bash alternative.
> This function is useful for very large arrays.


## array::isInArray

Check if a value is in an array.
It uses pure bash.

- $1: **array name** _as string_:
      The global variable name of the array.
- $2: **value** _as any_:
      The value to check.

Returns:

- $?: 0 if the value is in the array, 1 otherwise.

```bash
declare -g myArray=( "a" "b" )
array::isInArray myArray "b" && printf '%s\n' "b is in the array"
```


## array::makeArraysSameSize

This function makes sure that all the arrays have the same size.
It will add empty strings to the arrays that are too short.

- $@: **array names** _as string_:
      The arrays (global variable names) to make the same size.

```bash
array::makeArraysSameSize "array1" "array2" "array3"
```


## array::sort

Sorts an array using the > bash operator (lexicographic order).

- $1: **array name** _as string_:
      The global variable name of array to sort.

```bash
declare -g myArray=(z f b h a j)
array::sort myArray
echo "${myArray[*]}"
```

> - This function uses a quicksort algorithm.
> - It is not appropriate for large array, use the `sort` binary for such cases.


## array::sortWithCriteria

Sorts an array using multiple criteria.
Excepts multiple arrays. The first array is the one to sort.
The other arrays are used as criteria. Criteria are used in the order they are given.
Each criteria array must have the same size as the array to sort.
Each criteria array must containing integers representing the order of the elements.
We first sort using the first criteria (from smallest to biggest), then the second, etc.

- $1: **array name** _as string_:
      The name of the array to sort (it will be sorted in place).
- $@: **criteria array names** _as string_:
      The names of the arrays to use as criteria.
      Each array must have the same size as the array to sort and contain only numbers.

Returns:

- `RETURNED_ARRAY`: An array that contains the corresponding indexes of the sorted array in the original array

```bash
declare -g myArray=( "a" "b" "c" )
declare -g criteria1=( 3 2 2 )
declare -g criteria2=( 1 3 2 )
array::sortWithCriteria myArray criteria1 criteria2
echo "${myArray[@]}"
# c b a
echo "${RETURNED_ARRAY[@]}"
# 3 2 1
```

> - This function uses a quicksort algorithm.
> - It is not appropriate for large array, use the `sort` binary for such cases.


## benchmark::run

This function runs a benchmark on given functions.

First, it will run the 1st function (the baseline) for a given number of time and
mark the number of times it was able to run it in that given time.

Then, it will run all the functions for the same number of time and
print the difference between the baseline and the other functions.

- $1: **baseline** _as string_:
      the name of the function to use as baseline
- $2: **functions** _as string_:
      The names of the functions to benchmark, comma separated.
- $3: time _as int_:
      (optional) Can be set using the variable `_OPTION_TIME`.
      The time in seconds for which to run the baseline.
      (defaults to 3s)
- $4: max runs _as int_:
      (optional) Can be set using the variable `_OPTION_MAX_RUNS`.
      The maximum number of runs to do for each function.
      (defaults to -1 which means no limit)

```bash
benchmark::run "baseline" "function1,function2" 1 100
```


## core::checkParseResults

A convenience function to check the parsing results and fails with an error message if there are
parsing errors.
Will also display the help if the help option is true.

This should be called from a command function for which you want to check the parsing results.

- $1: **display help** _as bool_:
      the help option
- $2: **parsing errors** _as string_:
      the parsing errors
- $3: function name _as string_:
      (optional) the function name
      (defaults to the calling function)

```bash
core::checkParseResults "${help:-}" "${parsingErrors:-}"
core::checkParseResults "${help:-}" "${parsingErrors:-}" "myFunctionName"
```


## core::deleteUserCommands

Delete the user 'commands' file from the valet user directory.

You probably want to reload the user commands afterward using `core::reloadUserCommands`.

```bash
core::deleteUserCommands
```


## core::fail

Displays an error message and then exit the program with error.

- $@: **message** _as string_:
      the error message to display

```bash
core::fail "This is an error message."
```


## core::failWithCode

Displays an error message and then exit the program with error.

- $1: **exit code** _as int_:
      the exit code to use, should be between 1 and 255
- $@: **message** _as string_:
      the error message to display

```bash
core::failWithCode 255 "This is an error message."
```


## core::getConfigurationDirectory

Returns the path to the valet configuration directory.
Creates it if missing.

Returns:

- `RETURNED_VALUE`: the path to the valet configuration directory

```bash
core::getConfigurationDirectory
local directory="${RETURNED_VALUE}"
```


## core::getLocalStateDirectory

Returns the path to the valet local state directory.
The base directory relative to which user-specific state files should be stored.
Creates it if missing.

Returns:

- `RETURNED_VALUE`: the path to the valet local state directory

```bash
core::getLocalStateDirectory
local directory="${RETURNED_VALUE}"
```


## core::getProgramElapsedMicroseconds

Get the elapsed time in µs since the program started.

Returns:

- `RETURNED_VALUE`: the elapsed time in µs since the program started.

```bash
core::getElapsedProgramTime
echo "${RETURNED_VALUE}"
string::microsecondsToHuman "${RETURNED_VALUE}"
echo "Human time: ${RETURNED_VALUE}"
```

> Fun fact: this function will fail in 2038 on 32-bit systems because the number of seconds will overflow.


## core::getUserDirectory

Returns the path to the valet user directory.
Does not create it if missing.

Returns:

- `RETURNED_VALUE`: the path to the valet user directory

```bash
core::getUserDirectory
local directory="${RETURNED_VALUE}"
```


## core::getVersion

Returns the version of Valet.

Returns:

- `RETURNED_VALUE`: The version of Valet.

```bash
core::getVersion
printf '%s\n' "The version of Valet is ⌜${RETURNED_VALUE}⌝."
```


## core::parseArguments

Parse the arguments and options of a function and return a string that can be evaluated to set the variables.
This should be called from a command function for which you want to parse the arguments.

See the documentation for more details on the parser: <https://jcaillon.github.io/valet/docs/new-commands/#-implement-your-command>.


- $@: **arguments** _as any_:
      the arguments to parse

Returns:

- `RETURNED_VALUE`: a string that can be evaluated to set the parsed variables

Output example:

```
local arg1 option1
arg1="xxx"
option1="xxx"
```

```bash
core::parseArguments "$@" && eval "${RETURNED_VALUE}"
```


## core::reloadUserCommands

Forcibly source again the user 'commands' file from the valet user directory.

```bash
core::reloadUserCommands
```


## core::resetIncludedFiles

Allows to reset the included files.
When calling the source function, it will source all the files again.
This is useful when we want to reload the libraries.

```bash
core::resetIncludedFiles
```


## core::showHelp

Show the help for the current function.
This should be called directly from a command function for which you want to display the help text.

```bash
core::showHelp
```


## core::sourceFunction

Source the file associated with a command function.
This allows you to call a command function without having to source the file manually.

- $1: **function name** _as string_:
      the function name

```bash
core::sourceFunction "functionName"
```


## core::sourceUserCommands

Source the user 'commands' file from the valet user directory.
If the file does not exist, we build it on the fly.

```bash
core::sourceUserCommands
```


## curl::toFile

This function is a wrapper around curl.
It allows you to check the http status code and return 1 if it is not acceptable.
It io::invokes curl with the following options (do not repeat them): -sSL -w "%{response_code}" -o ${2}.

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails
- $2: **acceptable codes** _as string_:
      list of http status codes that are acceptable, comma separated
      (defaults to 200,201,202,204,301,304,308 if left empty)
- $3: **path** _as string_:
      the file in which to save the output of curl
- $@: **curl arguments** _as any_:
      options for curl

Returns:

- $?:
  - 0 if the http status code is acceptable
  - 1 otherwise
- `RETURNED_VALUE`: the content of stderr
- `RETURNED_VALUE2`: the http status code

```bash
curl::toFile "true" "200,201" "/filePath" "https://example.com" || core::fail "The curl command failed."
```


## curl::toVar

This function is a wrapper around curl.
It allows you to check the http status code and return 1 if it is not acceptable.
It io::invokes curl with the following options (do not repeat them): -sSL -w "%{response_code}" -o "tempfile".

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails
- $2: **acceptable codes** _as string_:
      list of http status codes that are acceptable, comma separated
      (defaults to 200,201,202,204,301,304,308 if left empty)
- $@: **curl arguments** _as any_:
      options for curl

Returns:

- $?:
  - 0 if the http status code is acceptable
  - 1 otherwise
- `RETURNED_VALUE`: the content of the request
- `RETURNED_VALUE2`: the content of stderr
- `RETURNED_VALUE3`: the http status code

```bash
curl::toVar false 200,201 https://example.com || core::fail "The curl command failed."
```


## fsfs::itemSelector

Displays a menu where the user can search and select an item.
The menu is displayed in full screen.
Each item can optionally have a description/details shown in a right panel.
The user can search for an item by typing.

- $1: **prompt** _as string_:
      The prompt to display to the user (e.g. Please pick an item).
- $2: **array name** _as string_:
      The items to display (name of a global array).
- $3: select callback function name _as string_:
      (optional) The function to call when an item is selected
      (defaults to empty, no callback)
      this parameter can be left empty to hide the preview right pane;
      otherwise the callback function should have the following signature:
  - $1: the current item
  - $2: the item number;
  - $3: the current panel width;
  - it should return the details of the item in the `RETURNED_VALUE` variable.
- $4: preview title _as string_:
      (optional) the title of the preview right pane (if any)
      (defaults to empty)

Returns:

- `RETURNED_VALUE`: The selected item value (or empty).
- `RETURNED_VALUE2`: The selected item index (from the original array).
                     Or -1 if the user cancelled the selection

```bash
declare -g -a SELECTION_ARRAY
SELECTION_ARRAY=("blue" "red" "green" "yellow")
fsfs::itemSelector "What's your favorite color?" SELECTION_ARRAY
log::info "You selected: ⌜${RETURNED_VALUE}⌝ (index: ⌜${RETURNED_VALUE2}⌝)"
```


##  interactive::askForConfirmation

Ask the user to press the button to continue.

- $1: **prompt** _as string_:
      the prompt to display

Returns:

- $?:
  - 0 if the user pressed enter
  - 1 otherwise

```bash
interactive::askForConfirmation "Press enter to continue."
```


## interactive::askForConfirmationRaw

Ask the user to press the button to continue.

This raw version does not display the prompt or the answer.

Returns:

- $?:
  - 0 if the user pressed enter
  - 1 otherwise

```bash
interactive::askForConfirmationRaw
```


## interactive::clearBox

Clear a "box" in the terminal.
Will return the cursor at the current position at the end (using GLOBAL_CURSOR_LINE and GLOBAL_CURSOR_COLUMN).

- $1: **top** _as int_:
      the left position of the box
- $2: **left** _as int_:
      the top position of the box
- $3: **width** _as int_:
      the width of the box
- $4: **height** _as int_:
      the height of the box

```bash
interactive::getCursorPosition
interactive::clearBox 1 1 10 5
```


## interactive::clearKeyPressed

This function reads all the inputs from the user, effectively discarding them.

```bash
interactive::clearKeyPressed
```


## interactive::createSpace

This function creates some new lines after the current cursor position.
Then it moves back to its original position.
This effectively creates a space in the terminal (scroll up if we are at the bottom).
It does not create more space than the number of lines in the terminal.

- $1: **number of lines** _as int_:
      the number of lines to create

```bash
interactive::createSpace 5
```


## interactive::displayAnswer

Displays an answer to a previous question.

The text is wrapped and put inside a box like so:

```text
    ┌─────┐
    │ No. ├──░
    └─────┘
```

- $1: **answer** _as string_:
      the answer to display
- $2: max width _as int_:
      (optional) the maximum width of the text in the dialog box
      (defaults to GLOBAL_COLUMNS)

```bash
interactive::displayAnswer "My answer."
```


## interactive::displayDialogBox

Displays a dialog box with a speaker and a text.

- $1: **speaker** _as string_:
      the speaker (system or user)
- $2: **text** _as string_:
      the text to display
- $3: max width _as int_:
      (optional) the maximum width of the text in the dialog box
      (defaults to GLOBAL_COLUMNS)

```bash
interactive::displayDialogBox "system" "This is a system message."
```


## interactive::displayQuestion

Displays a question to the user.

The text is wrapped and put inside a box like so:

```text
   ┌────────────────────────────────┐
░──┤ Is this an important question? │
   └────────────────────────────────┘
```

- $1: **prompt** _as string_:
      the prompt to display
- $2: max width _as int_:
      (optional) the maximum width of text in the dialog box
      (defaults to GLOBAL_COLUMNS)

```bash
interactive::displayPrompt "Do you want to continue?"
```


## interactive::getBestAutocompleteBox

This function returns the best position and size for an autocomplete box that would open
at the given position.

- The box will be placed below the current position if possible, but can be placed
  above if there is not enough space below.
- The box will be placed on the same column as the current position if possible, but can be placed
  on the left side if there is not enough space on the right to display the full width of the box.
- The box will have the desired height and width if possible, but will be reduced if there is
  not enough space in the terminal.
- The box will not be placed on the same line as the current position if notOnCurrentLine is set to true.
  Otherwise it can use the current position line.

- $1: **current line** _as int_:
      the current line of the cursor (1 based)
- $2: **current column** _as int_:
      the current column of the cursor (1 based)
- $3: **desired height** _as int_:
      the desired height of the box
- $4: **desired width** _as int_:
      the desired width of the box
- $5: **max height** _as int_:
      the maximum height of the box
- $6: force below _as bool_:
      (optional) force the box to be below the current position
      (defaults to false)
- $7: not on current line _as bool_:
      (optional) the box will not be placed on the same line as the current position
      (defaults to true)
- $8: terminal width _as int_:
      (optional) the width of the terminal
      (defaults to GLOBAL_COLUMNS)
- $9: terminal height _as int_:
      (optional) the height of the terminal
      (defaults to GLOBAL_LINES)

Returns:

- `RETURNED_VALUE`: the top position of the box (1 based)
- `RETURNED_VALUE2`: the left position of the box (1 based)
- `RETURNED_VALUE3`: the width of the box
- `RETURNED_VALUE4`: the height of the box

```bash
interactive::getBestAutocompleteBox 1 1 10 5
```


## interactive::getCursorPosition

Get the current cursor position.

Returns:

- `GLOBAL_CURSOR_LINE`: the line number
- `GLOBAL_CURSOR_COLUMN`: the column number

```bash
interactive::getCursorPosition
```


## interactive::getTerminalSize

This function exports the terminal size.

Returns:

- `GLOBAL_COLUMNS`: The number of columns in the terminal.
- `GLOBAL_LINES`: The number of lines in the terminal.

```bash
interactive::getTerminalSize
printf '%s\n' "The terminal has ⌜${GLOBAL_COLUMNS}⌝ columns and ⌜${GLOBAL_LINES}⌝ lines."
```


## interactive::promptYesNo

Ask the user to yes or no.

- The user can switch between the two options with the arrow keys or space.
- The user can validate the choice with the enter key.
- The user can also validate immediately with the y or n key.

- $1: **prompt** _as string_:
      the prompt to display
- $2: default _as bool_:
      (optional) the default value to select
      (defaults to true)

Returns:

- $?:
  - 0 if the user answered yes
  - 1 otherwise
- `RETURNED_VALUE`: true or false.

```bash
if interactive::promptYesNo "Do you want to continue?"; then echo "Yes."; else echo "No."; fi
```


## interactive::promptYesNoRaw

Ask the user to yes or no.

- The user can switch between the two options with the arrow keys or space.
- The user can validate the choice with the enter key.
- The user can also validate immediately with the y or n key.

This raw version does not display the prompt or the answer.

- $1: default _as bool_:
      (optional) the default value to select
      (defaults to true)

Returns:

- $?:
  - 0 if the user answered yes
  - 1 otherwise
- `RETURNED_VALUE`: true or false.

```bash
interactive::promptYesNoRaw "Do you want to continue?" && local answer="${RETURNED_VALUE}"
```


## interactive::rebindKeymap

Rebinds all special keys to call a given callback function.
See @interactive::testWaitForKeyPress for an implementation example.

This allows to use the `-e` option with the read command and receive events for special key press.

Key binding is a mess because binding is based on the sequence of characters that gets
generated by the terminal when a key is pressed and this is not standard across all terminals.
We do our best here to cover most cases but it is by no mean perfect.
A good base documentation was <https://en.wikipedia.org/wiki/ANSI_escape_code#Terminal_input_sequences>.

Users of this function can completely change the bindings afterward by implementing
the `interactiveRebindOverride` function.

This function should be called before using interactive::waitForKeyPress.

You can call `interactive::resetBindings` to restore the default bindings. However, this is not
necessary as the bindings are local to the script.

```bash
interactive::rebindKeymap
```

> `showkey -a` is a good program to see the sequence of characters sent by the terminal.


## interactive::resetBindings

Reset the key bindings to the default ones.

```bash
interactive::resetBindings
```


## interactive::restoreInterruptTrap

Restore the original trap for the interrupt signal (SIGINT).
To be called after interactive::setInterruptTrap.

```bash
interactive::restoreInterruptTrap
```


## interactive::setInterruptTrap

Set a trap to catch the interrupt signal (SIGINT).
When the user presses Ctrl+C, the GLOBAL_SESSION_INTERRUPTED variable will be set to true.

```bash
interactive::setInterruptTrap
```


## interactive::startProgress

Shows a spinner / progress animation with configurable output including a progress bar.

The animation will be displayed until interactive::stopProgress is called
or if the max number of frames is reached.

Outputs to stderr.
This will run in the background and will not block the main thread.
The main thread can continue to output logs while this animation is running.

- $1: output template _as string_:
      (optional) the template to display
      (defaults to VALET_CONFIG_PROGRESS_BAR_TEMPLATE="#spinner #percent ░#bar░ #message")
- $2: max width _as int_:
      (optional) the maximum width of the progress bar
      (defaults to VALET_CONFIG_PROGRESS_BAR_SIZE=20)
- $3: frame delay _as float_:
      (optional) the time in seconds between each frame of the spinner
      (defaults to VALET_CONFIG_PROGRESS_ANIMATION_DELAY=0.1)
- $4: refresh every x frames _as int_:
      (optional) the number of frames of the spinner to wait before refreshing the progress bar
      (defaults to VALET_CONFIG_PROGRESS_BAR_UPDATE_INTERVAL=3)
- $5: max frames _as int_:
      (optional) the maximum number of frames to display
      (defaults to 9223372036854775807)
- $6: spinner _as string_:
      (optional) the spinner to display (each character is a frame)
      (defaults to VALET_CONFIG_SPINNER_CHARACTERS="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏")
      Examples:
      - ◐◓◑◒
      - ▖▘▝▗
      - ⣾⣽⣻⢿⡿⣟⣯⣷
      - ⢄⢂⢁⡁⡈⡐⡠
      - ◡⊙◠
      - ▌▀▐▄
      - ⠄⠆⠇⠋⠙⠸⠰⠠⠰⠸⠙⠋⠇⠆

```bash
interactive::startProgress "#spinner" "" 0.05 "" "" "⢄⢂⢁⡁⡈⡐⡠"
wait 4
interactive::stopProgress

interactive::startProgress "#spinner #percent ░#bar░ #message" 30 0.05 1
IDX=0
while [[ ${IDX} -le 50 ]]; do
  interactive::updateProgress $((IDX * 2)) "Doing something ${IDX}/50..."
  IDX=$((IDX + 1))
  sleep 0.1
done
```


## interactive::stopProgress

Stop the progress bar.

```bash
interactive::stopProgress
```


## interactive::sttyInit

Disable the echo of the tty. Will no longer display the characters typed by the user.

```bash
interactive::sttyInit
```


## interactive::sttyRestore

Enable the echo of the tty. Will display the characters typed by the user.

- $1: **force** _as bool_:
      (optional) force the restoration of the stty configuration
      stty state will not be restored if
      (defaults to false)

```bash
interactive::sttyRestore
```
shellcheck disable=SC2120


## interactive::switchBackFromFullScreen

Call this function to switch back from the full screen mode.

- This function will restore the terminal state and show the cursor.
- It will also restore the key echoing.
- If there were error messages during the interactive session, they will be displayed at the end.

```bash
interactive::switchBackFromFullScreen
```


## interactive::switchToFullScreen

Call this function to start an interactive session in full screen mode.
This function will switch to the alternate screen, hide the cursor and clear the screen.
It will also disable echoing when we type something.

You should call interactive::switchBackFromFullScreen at the end of the interactive session.

In the alternate screen, we don't see the error messages so we capture them somewhere else.

```bash
interactive::switchToFullScreen
```


## interactive::testWaitForChar

Wait for the user to send a character to stdin (i.e. wait for a key press)
and prints the character that bash reads.

Useful to test the `interactive::waitForChar` function and see the char sequence we
get when pressing a key in a given terminal.

See @interactive::waitForChar for more information.

```bash
interactive::testWaitForChar
```


## interactive::testWaitForKeyPress

Wait for the user to press a key and prints it to the screen.
This function is used to test the `interactive::waitForKeyPress` function.

See @interactive::waitForKeyPress for more information.

```bash
interactive::testWaitForKeyPress
```


## interactive::updateProgress

Update the progress bar with a new percentage and message.

The animation can be started with interactive::startProgress for more options.
The animation will stop if the updated percentage is 100.

- $1: **percent** _as int_:
      the percentage of the progress bar (0 to 100)
- $2: message _as string_:
      (optional) the message to display

```bash
interactive::updateProgress 50 "Doing something..."
```


## interactive::waitForChar

Wait for a user input (single char).
You can pass additional parameters to the read command (e.g. to wait for a set amount of time).

It uses the read builtin command. This will not detect all key combinations.
The output will depend on the terminal used and the character sequences it sends on each key press.

For more advanced use cases, you can use interactive::waitForKeyPress.
This simple implementation does not rely on GNU readline and does not require stty to be initialized.

Some special keys are translated into more readable strings:
UP, DOWN, RIGHT, LEFT, BACKSPACE, DEL, PAGE_UP, PAGE_DOWN, HOME, END, ESC, F1-F12, ALT+...

- $@: **read parameters** _as any_:
      additional parameters to pass to the read command

Returns:

- $?:
  - 0 if a char was retrieved
  - 1 otherwise
- `LAST_KEY_PRESSED`: the last char (key) retrieved.

```bash
interactive::waitForChar
interactive::waitForChar -t 0.1
```

> <https://en.wikipedia.org/wiki/ANSI_escape_code#Terminal_input_sequences>


## interactive::waitForKeyPress

Wait for a key press (single key).
You can pass additional parameters to the read command (e.g. to wait for a set amount of time).

It uses the read builtin command with the option `-e` to use readline behind the scene.
This means we can detect more key combinations but all keys needs to be bound first...
Special keys (CTRL+, ALT+, F1-F12, arrows, etc.) are intercepted using binding.

You must call `interactive::rebindKeymap` and `interactive::sttyInit` before using this function.

- $@: **read parameters** _as any_:
      additional parameters to pass to the read command

Returns:

- $?:
  - 0 if a key was pressed
  - 1 otherwise
- `LAST_KEY_PRESSED`: the key pressed.

```bash
interactive::waitForKeyPress
interactive::waitForKeyPress -t 0.1
```

> Due to a bug in bash, if the cursor is at the end of the screen, it will make the screen scroll
> even when nothing is read... Make sure to not position the cursor at the end of the screen.


## io::cat

Print the content of a file to stdout.
This is a pure bash equivalent of cat.

- $1: **path** _as string_:
      the file to print

```bash
io::cat "myFile"
```

> Also see log::printFile if you want to print a file for a user.


## io::checkAndFail

Check last return code and fail (exit) if it is an error.

- $1: **exit code** _as int_:
      the return code
- $@: **message** _as string_:
      the error message to display in case of error

```bash
command_that_could_fail || io::checkAndFail "$?" "The command that could fail has failed!"
```


## io::checkAndWarn

Check last return code and warn the user in case the return code is not 0.

- $1: **exit code** _as int_:
      the last return code
- $@: **message** _as string_:
      the warning message to display in case of error

```bash
command_that_could_fail || io::checkAndWarn "$?" "The command that could fail has failed!"
```


## io::cleanupTempFiles

Removes all the temporary files and directories that were created by the
io::createTempFile and io::createTempDirectory functions.

```bash
io::cleanupTempFiles
```
shellcheck disable=SC2016


## io::convertFromWindowsPath

Convert a Windows path to a unix path.

- $1: **path** _as string_:
      the path to convert

Returns:

- `RETURNED_VALUE`: The unix path.

```bash
io::convertFromWindowsPath "C:\path\to\file"
```

> Handles paths starting with `X:\`.


## io::convertToWindowsPath

Convert a unix path to a Windows path.

- $1: **path** _as string_:
      the path to convert

Returns:

- `RETURNED_VALUE`: The Windows path.

```bash
io::convertToWindowsPath "/path/to/file"
```

> Handles paths starting with `/mnt/x/` or `/x/`.


## io::countArgs

Returns the number of arguments passed.

A convenient function that can be used to:

- count the files/directories in a directory
  `io::countArgs "${PWD}"/* && local numberOfFiles="${RETURNED_VALUE}"`
- count the number of variables starting with VALET_
  `io::countArgs "${!VALET_@}" && local numberOfVariables="${RETURNED_VALUE}"`

- $@: **arguments** _as any_:
      the arguments to count

Returns:

- `RETURNED_VALUE`: The number of arguments passed.

```bash
io::countArgs 1 2 3
```


## io::createDirectoryIfNeeded

Create the directory tree if needed.

- $1: **path** _as string_:
      The directory path to create.

Returns:

- `RETURNED_VALUE`: The absolute path to the directory.

```bash
io::createDirectoryIfNeeded "/my/directory"
```


## io::createFilePathIfNeeded

Make sure that the given file path exists.
Create the directory tree and the file if needed.

- $1: **path** _as string_:
      the file path to create

Returns:

- `RETURNED_VALUE`: The absolute path of the file.

```bash
io::createFilePathIfNeeded "myFile"
```


## io::createLink

Create a soft or hard link (original ← link).

Reminder:

- A soft (symbolic) link is a new file that contains a reference to another file or directory in the
  form of an absolute or relative path.
- A hard link is a directory entry that associates a new pathname with an existing
  file (inode + data block) on a file system.

This function allows to create a symbolic link on Windows as well as on Unix.

- $1: **linked path** _as string_:
      the path to link to (the original file)
- $2: **link path** _as string_:
      the path where to create the link
- $3: hard link _as boolean_:
      (optional) true to create a hard link, false to create a symbolic link
      (defaults to false)
- $4: force _as boolean_:
      (optional) true to overwrite the link or file if it already exists.
      Otherwise, the function will fail on an existing link.
      (defaults to true)

```bash
io::createLink "/path/to/link" "/path/to/linked"
io::createLink "/path/to/link" "/path/to/linked" true
```

> On unix, the function uses the `ln` command.
> On Windows, the function uses `powershell` (and optionally ls to check the existing link).


## io::createTempDirectory

Creates a temporary directory.

Returns:

- `RETURNED_VALUE`: The created path.

```bash
io::createTempDirectory
local directory="${RETURNED_VALUE}"
```

> Directories created this way are automatically cleaned up by the io::cleanupTempFiles
> function when valet ends.


## io::createTempFile

Creates a temporary file and return its path.

Returns:

- `RETURNED_VALUE`: The created path.

```bash
io::createTempFile
local file="${RETURNED_VALUE}"
```

> Files created this way are automatically cleaned up by the io::cleanupTempFiles
> function when valet ends.


## io::invoke

This function call an executable and its arguments.
If the execution fails, it will fail the script and show the std/err output.
Otherwise it hides both streams, effectively rendering the execution silent unless it fails.

It redirects the stdout and stderr to environment variables.
Equivalent to io::invoke5 true 0 '' '' "${@}"

- $1: **executable** _as string_:
      the executable or command
- $@: **arguments** _as any_:
      the command and its arguments

Returns:

- $?: The exit code of the executable.
- `RETURNED_VALUE`: The content of stdout.
- `RETURNED_VALUE2`: The content of stderr.

```bash
io::invoke git add --all
```

> See io::invokef5 for more information.


## io::invoke2

This function call an executable and its arguments.
It redirects the stdout and stderr to environment variables.
Equivalent to io::invoke5 "${1}" 0 "" "" "${@:2}"

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable

Returns:

- $?: The exit code of the executable.
- `RETURNED_VALUE`: The content of stdout.
- `RETURNED_VALUE2`: The content of stderr.

```bash
io::invokef2 false git status || core::fail "status failed."
stdout="${RETURNED_VALUE}"
stderr="${RETURNED_VALUE2}"
```

> See io::invokef5 for more information.


## io::invoke2piped

This function call an executable and its arguments and input a given string as stdin.
It redirects the stdout and stderr to environment variables.
Equivalent to io::invoke5 "${1}" 0 false "${2}" "${@:3}"

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: **stdin** _as string_:
      the stdin to pass to the executable
- $3: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable

Returns:

- $?: The exit code of the executable.
- `RETURNED_VALUE`: The content of stdout.
- `RETURNED_VALUE2`: The content of stderr.

```bash
io::invoke2piped true "key: val" yq -o json -p yaml -
stdout="${RETURNED_VALUE}"
stderr="${RETURNED_VALUE2}"
```

> This is the equivalent of:
> `myvar="$(printf '%s\n' "mystring" | mycommand)"`
> But without using a subshell.
>
> See io::invokef5 for more information.


## io::invoke5

This function call an executable and its arguments.
It redirects the stdout and stderr to environment variables.
It calls invoke5 and reads the files to set the environment variables.

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: **acceptable codes** _as string_:
      the acceptable error codes, comma separated
      (if the error code is matched, then set the output error code to 0)
- $3: **stdin from file** _as bool_:
      true/false to indicate if the 4th argument represents a file path or directly the content for stdin
- $4: **stdin** _as string_:
      the stdin (can be empty)
- $5: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable

Returns:

- $?: The exit code of the executable.
- `RETURNED_VALUE`: The content of stdout.
- `RETURNED_VALUE2`: The content of stderr.

```bash
io::invoke5 "false" "130,2" "false" "This is the stdin" "stuff" "--height=10" || core::fail "stuff failed."
stdout="${RETURNED_VALUE}"
stderr="${RETURNED_VALUE2}"
```

> See io::invokef5 for more information.


## io::invokef2

This function call an executable and its arguments.
It redirects the stdout and stderr to temporary files.
Equivalent to io::invokef5 "${1}" 0 "" "" "${@:2}"

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable

Returns:

- $?: The exit code of the executable.
- `RETURNED_VALUE`: The file path containing the stdout of the executable.
- `RETURNED_VALUE2`: The file path containing the stderr of the executable.

```bash
io::invokef2 false git status || core::fail "status failed."
stdoutFilePath="${RETURNED_VALUE}"
stderrFilePath="${RETURNED_VALUE2}"
```

> See io::invokef5 for more information.


## io::invokef2piped

This function call an executable and its arguments and input a given string as stdin.
It redirects the stdout and stderr to temporary files.
Equivalent to io::invokef5 "${1}" 0 false "${2}" "${@:3}"

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: **stdin** _as string_:
      the stdin to pass to the executable
- $3: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable

Returns:

- $?: The exit code of the executable.
- `RETURNED_VALUE`: The file path containing the stdout of the executable.
- `RETURNED_VALUE2`: The file path containing the stderr of the executable.

```bash
io::invokef2piped true "key: val" yq -o json -p yaml -
stdoutFilePath="${RETURNED_VALUE}"
stderrFilePath="${RETURNED_VALUE2}"
```

> This is the equivalent of:
> `myvar="$(printf '%s\n' "mystring" | mycommand)"`
> But without using a subshell.
>
> See io::invokef5 for more information.


## io::invokef5

This function call an executable and its arguments.
It redirects the stdout and stderr to temporary files.

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails.
                     If true and the execution fails, the script will exit.
- $2: **acceptable codes** _as string_:
      the acceptable error codes, comma separated
        (if the error code is matched, then set the output error code to 0)
- $3: **sdtin from file** _as bool_:
      true/false to indicate if the 4th argument represents a file path or directly the content for stdin
- $4: **sdtin** _as string_:
      the stdin (can be empty)
- $5: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable

Returns:

- $?: The exit code of the executable.
- `RETURNED_VALUE`: The file path containing the stdout of the executable.
- `RETURNED_VALUE2`: The file path containing the stderr of the executable.

```bash
io::invokef5 "false" "130,2" "false" "This is the stdin" "stuff" "--height=10" || core::fail "stuff failed."
stdoutFilePath="${RETURNED_VALUE}"
stderrFilePath="${RETURNED_VALUE2}"
```

> - In windows, this is tremendously faster to do (or any other invoke flavor):
>   `io::invokef5 false 0 false '' mycommand && myvar="${RETURNED_VALUE}"`
>   than doing:
>   `myvar="$(mycommand)".`
> - On linux, it is slightly faster (but it might be slower if you don't have SSD?).
> - On linux, you can use a tmpfs directory for massive gains over subshells.


## io::isDirectoryWritable

Check if the directory is writable. Creates the directory if it does not exist.

- $1: **directory** _as string_:
      the directory to check
- $2: test file name _as string_:
      (optional) the name of the file to create in the directory to test the write access

Returns:

- $?:
  - 0 if the directory is writable
  - 1 otherwise

```bash
if io::isDirectoryWritable "/path/to/directory"; then
  echo "The directory is writable."
fi
```


## io::listDirectories

List all the directories in the given directory.

- $1: **directory** _as string_:
      the directory to list
- $2: recursive _as bool_:
      (optional) true to list recursively, false otherwise
      (defaults to false)
- $3: hidden _as bool_:
      (optional) true to list hidden paths, false otherwise
      (defaults to false)
- $4: directory filter function name _as string_:
      (optional) a function name that is called to filter the sub directories (for recursive listing)
      The function should return 0 if the path is to be kept, 1 otherwise.
      The function is called with the path as the first argument.
      (defaults to empty string, no filter)

Returns:

- `RETURNED_ARRAY`: An array with the list of all the files.

```bash
io::listDirectories "/path/to/directory" true true myFilterFunction
for path in "${RETURNED_ARRAY[@]}"; do
  printf '%s' "${path}"
done
```


## io::listFiles

List all the files in the given directory.

- $1: **directory** _as string_:
      the directory to list
- $2: recursive _as bool_:
      (optional) true to list recursively, false otherwise
      (defaults to false)
- $3: hidden _as bool_:
      (optional) true to list hidden paths, false otherwise
      (defaults to false)
- $4: directory filter function name _as string_:
      (optional) a function name that is called to filter the directories (for recursive listing)
      The function should return 0 if the path is to be kept, 1 otherwise.
      The function is called with the path as the first argument.
      (defaults to empty string, no filter)

Returns:

- `RETURNED_ARRAY`: An array with the list of all the files.

```bash
io::listFiles "/path/to/directory" true true myFilterFunction
for path in "${RETURNED_ARRAY[@]}"; do
  printf '%s' "${path}"
done
```


## io::listPaths

List all the paths in the given directory.

- $1: **directory** _as string_:
      the directory to list
- $2: recursive _as bool_:
      (optional) true to list recursively, false otherwise
      (defaults to false)
- $3: hidden _as bool_:
      (optional) true to list hidden paths, false otherwise
      (defaults to false)
- $4: path filter function name _as string_:
      (optional) a function name that is called to filter the paths that will be listed
      The function should return 0 if the path is to be kept, 1 otherwise.
      The function is called with the path as the first argument.
      (defaults to empty string, no filter)
- $5: directory filter function name _as string_:
      (optional) a function name that is called to filter the directories (for recursive listing)
      The function should return 0 if the path is to be kept, 1 otherwise.
      The function is called with the path as the first argument.
      (defaults to empty string, no filter)

Returns:

- `RETURNED_ARRAY`: An array with the list of all the paths.

```bash
io::listPaths "/path/to/directory" true true myFilterFunction myFilterDirectoryFunction
for path in "${RETURNED_ARRAY[@]}"; do
  printf '%s' "${path}"
done
```

> - It will correctly list files under symbolic link directories.


## io::readFile

Reads the content of a file and returns it in the global variable RETURNED_VALUE.
Uses pure bash.

- $1: **path** _as string_:
      the file path to read
- $2: max char _as int_:
      (optional) the maximum number of characters to read
      (defaults to 0, which means read the whole file)

> If the file does not exist, the function will return an empty string instead of failing.

Returns:

- `RETURNED_VALUE`: The content of the file.

```bash
io::readFile "/path/to/file" && local fileContent="${RETURNED_VALUE}"
io::readFile "/path/to/file" 500 && local fileContent="${RETURNED_VALUE}"
```


## io::readStdIn

Read the content of the standard input.
Will immediately return if the standard input is empty.

Returns:

- `RETURNED_VALUE`: The content of the standard input.

```bash
io::readStdIn && local stdIn="${RETURNED_VALUE}"
```


## io::sleep

Sleep for the given amount of time.
This is a pure bash replacement of sleep.

- $1: **time** _as float_:
      the time to sleep in seconds (can be a float)

```bash
io:sleep 1.5
```

> The sleep command is not a built-in command in bash, but a separate executable. When you use sleep, you are creating a new process.


## io::toAbsolutePath

This function returns the absolute path of a path.

- $1: **path** _as string_:
      The path to translate to absolute path.

Returns:

- `RETURNED_VALUE`: The absolute path of the path.

```bash
io::toAbsolutePath "myFile"
local myFileAbsolutePath="${RETURNED_VALUE}"
```

> This is a pure bash alternative to `realpath` or `readlink`.


## io::windowsCreateTempDirectory

Create a temporary directory on Windows and return the path both for Windows and Unix.

This is useful for creating temporary directories that can be used in both Windows and Unix.

Returns:

- `RETURNED_VALUE`: The Windows path.
- `RETURNED_VALUE2`: The Unix path.

```bash
io::windowsCreateTempDirectory
```

> Directories created this way are automatically cleaned up by the io::cleanupTempFiles
> function when valet ends.


## io::windowsCreateTempFile

Create a temporary file on Windows and return the path both for Windows and Unix.

This is useful for creating temporary files that can be used in both Windows and Unix.

Returns:

- `RETURNED_VALUE`: The Windows path.
- `RETURNED_VALUE2`: The Unix path.

```bash
io::windowsCreateTempFile
```

> Files created this way are automatically cleaned up by the io::cleanupTempFiles
> function when valet ends.


## io::windowsPowershellBatchEnd

This function will run all the commands that were batched with `io::windowsPowershellBatchStart`.

Returns:

- $?
  - 0 if the command was successful
  - 1 otherwise.
- `RETURNED_VALUE`: The content of stdout.
- `RETURNED_VALUE2`: The content of stderr.

```bash
io::windowsPowershellBatchStart
io::windowsRunInPowershell "Write-Host \"Hello\""
io::windowsRunInPowershell "Write-Host \"World\""
io::windowsPowershellBatchEnd
```


## io::windowsPowershellBatchStart

After running this function, all commands that should be executed by
`io::windowsRunInPowershell` will be added to a batch that will only be played
when `io::windowsPowershellBatchEnd` is called.

This is a convenient way to run multiple commands in a single PowerShell session.
It makes up for the fact that running a new PowerShell session for each command is slow.

```bash
io::windowsPowershellBatchStart
io::windowsRunInPowershell "Write-Host \"Hello\""
io::windowsRunInPowershell "Write-Host \"World\""
io::windowsPowershellBatchEnd
```


## io::windowsRunInPowershell

Runs a PowerShell command.
This is mostly useful on Windows.

- $1: **command** _as string_:
      the command to run.
- $2: run as administrator _as boolean_:
      (optional) whether to run the command as administrator.
      (defaults to false).

Returns:

- $?
  - 0 if the command was successful
  - 1 otherwise.
- `RETURNED_VALUE`: The content of stdout.
- `RETURNED_VALUE2`: The content of stderr.

```bash
io::windowsRunInPowershell "Write-Host \"Press any key:\"; Write-Host -Object ('The key that was pressed was: {0}' -f [System.Console]::ReadKey().Key.ToString());"
```


## log::debug

Displays a debug message.

- $@: **message** _as string_:
      the debug messages to display

```bash
log::debug "This is a debug message."
```


## log::error

Displays an error message.

- $@: **message** _as string_:
      the error messages to display

```bash
log::error "This is an error message."
```

> You probably want to exit immediately after an error and should consider using core::fail function instead.


## log::errorTrace

Displays an error trace message.
This is a trace message that is always displayed, independently of the log level.
It can be used before a fatal error to display useful information.

- $@: **message** _as string_:
      the trace messages to display

```bash
log::errorTrace "This is a debug message."
```


## log::getLevel

Get the current log level.

Returns:

- `RETURNED_VALUE`: The current log level.

```bash
log::getLevel
printf '%s\n' "The log level is ⌜${RETURNED_VALUE}⌝."
```


## log::info

Displays an info message.

- $@: **message** _as string_:
      the info messages to display

```bash
log::info "This is an info message."
```


## log::isDebugEnabled

Check if the debug mode is enabled.

Returns:

- $?:
  - 0 if debug mode is enabled (log level is debug)
  - 1 if disabled

```bash
if log::isDebugEnabled; then printf '%s\n' "Debug mode is active."; fi
```


## log::isTraceEnabled

Check if the trace mode is enabled.

Returns:

- $?:
  - 0 if trace mode is enabled (log level is trace)
  - 1 if disabled

```bash
if log::isTraceEnabled; then printf '%s\n' "Debug mode is active."; fi
```


## log::printCallStack

This function prints the current function stack in the logs.

- $1: Stack to skip _as int_:
      (optional) Can be set using the variable `_OPTION_STACK_TO_SKIP`.
      The number of stack to skip.
      (defaults to 2 which skips this function and the first calling function
      which is usually the onError function)

```bash
log::printCallStack
log::printCallStack 0
```


## log::printFile

Display a file content with line numbers in the logs.
The file content will be aligned with the current log output and hard wrapped if necessary.

- $1: **path** _as string_:
      the file path to display.
- $2: max lines _as int_:
      (optional) max lines to display (defaults to 0 which prints all lines).

```bash
log::printFile "/my/file/path"
```
shellcheck disable=SC2317


## log::printFileString

Display a file content with line numbers in the logs.
The file content will be aligned with the current log output and hard wrapped if necessary.

- $1: **content** _as string_:
      the file content.
- $2: **max lines** _as int_:
      (optional) max lines to display (defaults to 0 which prints all lines).

```bash
log::printFileString "myfilecontent"
```
shellcheck disable=SC2317


## log::printRaw

Display something in the log stream.
Does not check the log level.

- $1: **content** _as string_:
      the content to print (can contain new lines)

```bash
log::printRaw "my line"
```
shellcheck disable=SC2317


## log::printString

Display a string in the log.
The string will be aligned with the current log output and hard wrapped if necessary.
Does not check the log level.

- $1: **content** _as string_:
      the content to log (can contain new lines)
- $2: new line pad string _as string_:
      (optional) the string with which to prepend each wrapped line
      (empty by default)

```bash
log::printString "my line"
```
shellcheck disable=SC2317


## log::setLevel

Set the log level.

- $1: **log level** _as string_:
      the log level to set (or defaults to info), acceptable values are:
  - trace
  - debug
  - info
  - success
  - warning
  - error
- $2: silent _as bool_:
      (optional) true to silently switch log level, i.e. does not print a message
      (defaults to false)

```bash
log::setLevel debug
log::setLevel debug true
```


## log::success

Displays a success message.

- $@: **message** _as string_:
      the success messages to display

```bash
log::success "This is a success message."
```


## log::trace

Displays a trace message.

- $@: **message** _as string_:
      the trace messages to display

```bash
log::trace "This is a trace message."
```


## log::warning

Displays a warning.

- $@: **message** _as string_:
      the warning messages to display

```bash
log::warning "This is a warning message."
```


## profiler::disable

Disable the profiler if previously activated with profiler::enable.

```bash
profiler::disable
```


## profiler::enable

Enables the profiler and start writing to the given file.

- $1: **path** _as string_:
      the file to write to.

```bash
profiler::enable "${HOME}/valet-profiler-${BASHPID}.txt"
```

> There can be only one profiler active at a time.


## prompt_getDisplayedPromptString

This function return a string that can be printed in a terminal in order to display a text
and position the cursor at a given index in the input text.

If the string is too long to fit in the screen, it will be truncated and ellipsis will be displayed
at the beginning and/or at the end of the string.

The cursor will be displayed under the character at the given index of the input text and
it makes sure that the cursor is always visible in the screen.

This function is useful to display a long prompt on a single line.

An example:

```text
_PROMPT_STRING_SCREEN_WIDTH=10
_PROMPT_STRING_INDEX=20
_PROMPT_STRING="This is a long string that will be displayed in the screen."
#                                ^ input index 20
prompt_getDisplayedPromptString 20 10
# output: "…g string…"
#                  ^ screen cursor (at index 8)
```

- $_PROMPT_STRING: **input string** _as string_:
      the string to display
- $_PROMPT_STRING_INDEX: **input index** _as int_:
      the index of the character (in the input string) that should be under the cursor
- $_PROMPT_STRING_SCREEN_WIDTH: **screen width** _as int_:
      the width of the screen

Returns:

- `RETURNED_VALUE`: the string to display in the screen
- `RETURNED_VALUE2`: the index at which to position the cursor on screen

```bash
prompt_getDisplayedPromptString "This is a long string that will be displayed in the screen." 20 10
```


## source

Allows to include a library file or sources a file.

It replaces the builtin source command to make sure that we do not include the same file twice.
We replace source instead of creating a new function to allow us to
specify the included file for spellcheck.

- $1: **library name** _as string_:
      the name of the library (array, interactive, string...) or the file path to include.
- $@: arguments _as any_:
      (optional) the arguments to pass to the included file (mimics the builtin source command).

```bash
  source string array system
  source ./my/path my/other/path
```

> - The file can be relative to the current script (script that calls this function).
> - This function makes sure that we do not include the same file twice.
> - Use `builtin source` if you want to include the file even if it was already included.


## string::bumpSemanticVersion

This function allows to bump a semantic version formatted like:
major.minor.patch-prerelease+build

- $1: **version** _as string_:
      the version to bump
- $2: **level** _as string_:
      the level to bump (major, minor, patch)
- $3: clear build and prerelease _as bool_:
      (optional) clear the prerelease and build
      (defaults to true)

Returns:

- `RETURNED_VALUE`: the new version string

```bash
string::bumpSemanticVersion "1.2.3-prerelease+build" "major"
local newVersion="${RETURNED_VALUE}"
```


## string::camelCaseToSnakeCase

This function convert a camelCase string to a SNAKE_CASE string.
It uses pure bash.
Removes all leading underscores.

- $1: **camelCase string** _as string_:
      The camelCase string to convert.

Returns:

- `RETURNED_VALUE`: The SNAKE_CASE string.

```bash
string::camelCaseToSnakeCase "myCamelCaseString" && local mySnakeCaseString="${RETURNED_VALUE}"
```


## string::compareSemanticVersion

This function allows to compare two semantic versions formatted like:
major.minor.patch-prerelease+build

- $1: **version1** _as string_:
      the first version to compare
- $2: **version2** _as string_:
      the second version to compare

Returns:

- `RETURNED_VALUE`:
  - 0 if the versions are equal,
  - 1 if version1 is greater,
  - -1 if version2 is greater

```bash
string::compareSemanticVersion "2.3.4-prerelease+build" "1.2.3-prerelease+build"
local comparison="${RETURNED_VALUE}"
```

> The prerelease and build are ignored in the comparison.


## string::count

Counts the number of occurrences of a substring in a string.

- $1: **string** _as string_:
      the string in which to search
- $2: **substring** _as string_:
      the substring to count

Returns:

- `RETURNED_VALUE`: the number of occurrences

```bash
string::count "name,firstname,address" "," && local count="${RETURNED_VALUE}"
```

> This is faster than looping over the string and check the substring.


## string::cutField

Allows to get the nth element of a string separated by a given separator.
This is the equivalent of the cut command "cut -d"${separator}" -f"${fieldNumber}""
but it uses pure bash to go faster.

- $1: **string to cut** _as string_:
      the string to cut
- $2: **field number** _as int_:
      the field number to get (starting at 0)
- $3: separator _as string_:
      the separator
      (defaults to tab if not provided)

Returns:

- `RETURNED_VALUE`: the extracted field

```bash
string::cutField "field1 field2 field3" 1 " " && local field="${RETURNED_VALUE}"
printf '%s' "${field}" # will output "field2"
```

> This is faster than:
>
> - using read into an array from a here string
> - using bash parameter expansion to remove before/after the separator


## string::extractBetween

Extract the text between two strings within a string.
Search for the first occurrence of the start string and the first occurrence
(after the start index) of the end string.
Both start and end strings are excluded in the extracted text.
Both start and end strings must be found to extract something.

- $1: **string** _as string_:
      the string in which to search
- $2: **start string** _as string_:
      the start string
      (if empty, then it will extract from the beginning of the string)
- $3: **end string** _as string_:
      the end string
      (if empty, then it will extract until the end of the string)

Returns:

- `RETURNED_VALUE`: the extracted text

```bash
string::extractBetween "This is a long text" "is a " " text"
local extractedText="${RETURNED_VALUE}"
```


## string::highlight

Highlight a pattern (each character of this pattern) in a string.

- $1: **text** _as string_:
      The text to highlight.
- $2: **pattern** _as string_:
      The pattern to highlight.
- $3: highlight ansi code _as string_:
      (optional) Can be set using the variable `_OPTION_HIGHLIGHT_ANSI`.
      The ANSI code to use for highlighting.
      (defaults to VALET_CONFIG_COLOR_HIGHLIGHT)
- $4: reset ansi code _as string_:
      (optional) Can be set using the variable `_OPTION_RESET_ANSI`.
      The ANSI code to use for resetting the highlighting.
      (defaults to VALET_CONFIG_COLOR_DEFAULT)

Returns:

- `RETURNED_VALUE`: the highlighted text

```bash
string::highlight "This is a text to highlight." "ttttt"
echo "${RETURNED_VALUE}"
```

> - All characters in the pattern must be found in the same order in the matched line.
> - This functions is case insensitive.


## string::indexOf

Find the first index of a string within another string.

- $1: **string** _as string_:
      the string in which to search
- $2: **search** _as string_:
      the string to search
- $3: start index _as int_:
      (optional) the starting index
      (defaults to 0)

Returns:

- `RETURNED_VALUE`: the index of the substring in the string or -1 if not found.

```bash
string::indexOf "This is a long text" "long" && local index="${RETURNED_VALUE}"
string::indexOf "This is a long text" "long" 10 && local index="${RETURNED_VALUE}"
```


## string::kebabCaseToCamelCase

This function convert a kebab-case string to a camelCase string.
It uses pure bash.
Removes all leading dashes.

- $1: **kebab-case string** _as string_:
      The kebab-case string to convert.

Returns:

- `RETURNED_VALUE`: The camelCase string.

```bash
string::kebabCaseToCamelCase "my-kebab-case-string" && local myCamelCaseString="${RETURNED_VALUE}"
```


## string::kebabCaseToSnakeCase

This function convert a kebab-case string to a SNAKE_CASE string.
It uses pure bash.
Removes all leading dashes.

- $1: **kebab-case string** _as string_:
      The kebab-case string to convert.

Returns:

- `RETURNED_VALUE`: The SNAKE_CASE string.

```bash
string::kebabCaseToSnakeCase "my-kebab-case-string" && local mySnakeCaseString="${RETURNED_VALUE}"
```


## string::microsecondsToHuman

Convert microseconds to human readable format.

- $1: **microseconds** _as int_:
      the microseconds to convert
- $2: format _as string_:
     (optional) Can be set using the variable `_OPTION_FORMAT`.
     the format to use (defaults to "%HH:%MM:%SS")
     Usable formats:
     - %HH: hours
     - %MM: minutes
     - %SS: seconds
     - %LL: milliseconds
     - %h: hours without leading zero
     - %m: minutes without leading zero
     - %s: seconds without leading zero
     - %l: milliseconds without leading zero
     - %u: microseconds without leading zero
     - %M: total minutes
     - %S: total seconds
     - %L: total milliseconds
     - %U: total microseconds

Returns:

- `RETURNED_VALUE`: the human readable format

```bash
string::microsecondsToHuman 123456789
echo "${RETURNED_VALUE}"
```


## string::regexGetFirst

Matches a string against a regex and returns the first capture group of the matched string.

- $1: **string** _as string_:
      the string to match
- $2: **regex** _as string_:
      the regex

Returns:

- `RETURNED_VALUE`: the first capture group in the matched string.
                    Empty if no match.

```bash
string::regexGetFirst "name: julien" "name:(.*)"
echo "${RETURNED_VALUE}"
```

> Regex wiki: https://en.wikibooks.org/wiki/Regular_Expressions/POSIX-Extended_Regular_Expressions


## string::split

Split a string into an array using a separator.

- $1: **string** _as string_:
      the string to split
- $2: **separator** _as string_:
      the separator (must be a single character!)

Returns:

- `RETURNED_ARRAY`: the array of strings

```bash
string::split "name,first name,address" "," && local -a array=("${RETURNED_ARRAY[@]}")
```

> This is faster than using read into an array from a here string.


## string::trim

Trim leading and trailing whitespaces.

- $1: **string to trim** _as string_:
      The string to trim.

Returns:

- `RETURNED_VALUE`: The trimmed string.

```bash
string::trim "   example string    " && local trimmedString="${RETURNED_VALUE}"
```


## string::trimAll

Trim all whitespaces and truncate spaces.

- $1: **string to trim** _as string_:
      The string to trim.

Returns:

- `RETURNED_VALUE`: The trimmed string.

```bash
string::trimAll "   example   string    " && local trimmedString="${RETURNED_VALUE}"
```


## string::wrapCharacters

Allows to hard wrap the given string at the given width.
Wrapping is done at character boundaries, see string::warpText for word wrapping.
Optionally appends padding characters on each new line.

- $1: **text** _as string_:
      The text to wrap.
- $2: wrap width _as string_:
      (optional) Can be set using the variable `_OPTION_WRAP_WIDTH`.
      The width to wrap the text at.
      Note that length of the optional padding characters are subtracted from the
      width to make sure the text fits in the given width.
      (defaults to GLOBAL_COLUMNS)
- $3: padding characters _as string_:
      (optional) Can be set using the variable `_OPTION_PADDING_CHARS`.
      The characters to apply as padding on the left of each new line.
      E.g. '  ' will add 2 spaces on the left of each new line.
      (defaults to 0)
- $4: first line width _as int_:
      (optional) Can be set using the variable `_OPTION_FIRST_LINE_WIDTH`.
      The width to use for the first line.
      (defaults to the width)

Returns:

- `RETURNED_VALUE`: the wrapped string
- `RETURNED_VALUE2`: the length taken on the last line

```bash
string::wrapCharacters "This is a long text that should be wrapped at 20 characters." 20 --- 5
echo "${RETURNED_VALUE}"
```

> - This function is written in pure bash and is faster than calling the fold command.
> - It considers escape sequence for text formatting and does not count them as visible characters.
> - Leading spaces after a newly wrapped line are removed.


## string::wrapText

Allows to soft wrap the given text at the given width.
Wrapping is done at word boundaries.
Optionally appends padding characters on each new line.

- $1: **text** _as string_:
      The text to wrap.
- $2: wrap width _as string_:
      (optional) Can be set using the variable `_OPTION_WRAP_WIDTH`.
      The width to wrap the text at.
      Note that length of the optional padding characters are subtracted from the
      width to make sure the text fits in the given width.
      (defaults to GLOBAL_COLUMNS)
- $3: padding characters _as string_:
      (optional) Can be set using the variable `_OPTION_PADDING_CHARS`.
      The characters to apply as padding on the left of each new line.
      E.g. '  ' will add 2 spaces on the left of each new line.
      (defaults to 0)
- $4: first line width _as int_:
      (optional) Can be set using the variable `_OPTION_FIRST_LINE_WIDTH`.
      The width to use for the first line.
      (defaults to the width)

Returns:

- `RETURNED_VALUE`: the wrapped text

```bash
string::wrapText "This is a long text that should be wrapped at 20 characters." 20 '  ' 5
echo "${RETURNED_VALUE}"
```

> - This function is written in pure bash and is faster than calling the fold command.
> - This function effectively trims all the extra spaces in the text (leading, trailing but also in the middle).
> - It considers escape sequence for text formatting and does not count them as visible characters.


## system::addToPath

Add the given path to the PATH environment variable for various shells,
by adding the appropriate export command to the appropriate file.

Will also export the PATH variable in the current bash.

- $1: **path** _as string_:
      the path to add to the PATH environment variable.

```bash
system::addToPath "/path/to/bin"
```


## system::commandExists

Check if the given command exists.

- $1: **command name** _as string_:
      the command name to check.

Returns:

- $?
  - 0 if the command exists
  - 1 otherwise.

```bash
if system::commandExists "command1"; then
  printf 'The command exists.'
fi
```


## system::date

Get the current date in the given format.

- $1: format _as string_:
      (optional) the format of the date to return
      (defaults to %(%F_%Hh%Mm%Ss)T).

Returns:

- `RETURNED_VALUE`: the current date in the given format.

```bash
system::date
local date="${RETURNED_VALUE}"
```

> This function avoid to call $(date) in a subshell (date is a an external executable).


## system::env

Get the list of all the environment variables.
In pure bash, no need for env or printenv.

Returns:

- `RETURNED_ARRAY`: An array with the list of all the environment variables.

```bash
system::env
for var in "${RETURNED_ARRAY[@]}"; do
  printf '%s=%s\n' "${var}" "${!var}"
done
```

> This is faster than using mapfile on <(compgen -v).


## system::getNotExistingCommands

This function returns the list of not existing commands for the given names.

- $@: **command names** _as string_:
      the list of command names to check.

Returns:

- $?
  - 0 if there are not existing commands
  - 1 otherwise.
- `RETURNED_ARRAY`: the list of not existing commands.

```bash
if system::getNotExistingCommands "command1" "command2"; then
  printf 'The following commands do not exist: %s' "${RETURNED_ARRAY[*]}"
fi
```


## system::getUndeclaredVariables

This function returns the list of undeclared variables for the given names.

- $@: **variable names** _as string_:
      the list of variable names to check.

Returns:

- $?
  - 0 if there are variable undeclared
  - 1 otherwise.
- `RETURNED_ARRAY`: the list of undeclared variables.

```bash
if system::getUndeclaredVariables "var1" "var2"; then
  printf 'The following variables are not declared: %s' "${RETURNED_ARRAY[*]}"
fi
```


## system::isRoot

Check if the script is running as root.

Returns:

- $?
  - 0 if the script is running as root
  - 1 otherwise.

```bash
if system::isRoot; then
  printf 'The script is running as root.'
fi
```


## system::os

Returns the name of the current OS.

Returns:

- `RETURNED_VALUE`: the name of the current OS: "darwin", "linux" or "windows".

```bash
system::os
local osName="${RETURNED_VALUE}"
```


## system::windowsAddToPath

Add the given path to the PATH environment variable on Windows (current user only).

Will also export the PATH variable in the current bash.

- $1: **path** _as string_:
      the path to add to the PATH environment variable.
      The path can be in unix format, it will be converted to windows format.

```bash
system::windowsAddToPath "/path/to/bin"
```

> This function is only available on Windows, it uses `powershell` to directly modify the registry.


## system::windowsGetEnvVar

Get the value of an environment variable for the current user on Windows.

- $1: **variable name** _as string_:
      the name of the environment variable to get.

Returns:

- `RETURNED_VALUE`: the value of the environment variable.

```bash
system::windowsGetEnvVar "MY_VAR"
echo "${RETURNED_VALUE}"
```


## system::windowsSetEnvVar

Set an environment variable for the current user on Windows.

- $1: **variable name** _as string_:
      the name of the environment variable to set.
- $2: **variable value** _as string_:
      the value of the environment variable to set.

```bash
system::windowsSetEnvVar "MY_VAR" "my_value"
```

> This function is only available on Windows, it uses `powershell` to directly modify the registry.


## test::commentTest

Call this function to add a paragraph in the report file.

- $1: **comment** _as string_:
      the text to add in the report file

```bash
test::commentTest "This is a comment."
```


## test::endTest

Call this function after each test to write the test results to the report file.
This create a new H3 section in the report file with the test description and the exit code.

- $1: **title** _as string_:
      the title of the test
- $2: **exit code** _as int_:
      the exit code of the test
- $3: comment _as string_:
      (optional) a text to explain what is being tested
      (defaults to "")

```bash
test::endTest "Testing something" $?
```




> Documentation generated for the version 1.2.3 (2013-11-10).

→ cat /tmp/valet.d/d1-1/lib-valet
#!/usr/bin/env bash
# This script contains the documentation of all the valet library functions.
# It can be used in your editor to provide auto-completion and documentation.
#
# Documentation generated for the version 1.2.3 (2013-11-10).

# ## ansi-codes::*
# 
# ANSI codes for text attributes, colors, cursor control, and other common escape sequences.
# These codes can be used to format text in the terminal.
# 
# They are defined as variables and not as functions. Please check the content of the lib-ansi-codes to learn more:
# <https://github.com/jcaillon/valet/blob/latest/libraries.d/lib-ansi-codes>
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
# - https://en.wikipedia.org/wiki/List_of_Unicode_characters#Box_Drawing
# - https://en.wikipedia.org/wiki/List_of_Unicode_characters#Block_Elements
# 
# > While it could be very handy to define a function for each of these instructions,
# > it would also be slower to execute (function overhead + multiple printf calls).
# 
function ansi-codes::*() { :; }

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
function array::appendIfNotPresent() { :; }

# ## array::fuzzyFilterSort
# 
# Allows to fuzzy sort an array against a given pattern.
# Returns an array containing only the lines matching the pattern.
# The array is sorted by (in order):
# 
# - the index of the first matched character in the line
# - the distance between the first and last matched characters in the line
# - the original order in the list
# 
# - $1: **pattern** _as string_:
#       the pattern to match
# - $2: **array name** _as string_:
#       the initial array name
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
# > - Use `shopt -s nocasematch` to make this function is case insensitive.
# > - This function is not appropriate for large arrays (>10k elements), see `array::fuzzyFilterSortFileWithGrepAndAwk` for large arrays.
# 
function array::fuzzyFilterSort() { :; }

# ## array::fuzzyFilterSortFileWithGrepAndAwk
# 
# Allows to fuzzy sort a file against a given pattern.
# Outputs a file containing only the lines matching the pattern.
# The array is sorted by (in order):
# 
# - the index of the first matched character in the line
# - the distance between the first and last matched characters in the line
# 
# - $1: **pattern** _as string_:
#       The pattern to filter the file with.
# - $2: **file to filer** _as string_:
#       The input file to filter.
# - $3: **output filtered file** _as string_:
#       The output file containing the filtered lines.
# - $4: **output correspondences file** _as string_:
#       The output file containing the indexes of the matched lines in the original file.
# 
# ```bash
# array::fuzzyFilterSortFileWithGrepAndAwk file.txt filtered.txt correspondences.txt
# ```
# 
# > This is not a pure bash function! Use `array::fuzzyFilterSort` for pure bash alternative.
# > This function is useful for very large arrays.
# 
function array::fuzzyFilterSortFileWithGrepAndAwk() { :; }

# ## array::isInArray
# 
# Check if a value is in an array.
# It uses pure bash.
# 
# - $1: **array name** _as string_:
#       The global variable name of the array.
# - $2: **value** _as any_:
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
function array::isInArray() { :; }

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
function array::makeArraysSameSize() { :; }

# ## array::sort
# 
# Sorts an array using the > bash operator (lexicographic order).
# 
# - $1: **array name** _as string_:
#       The global variable name of array to sort.
# 
# ```bash
# declare -g myArray=(z f b h a j)
# array::sort myArray
# echo "${myArray[*]}"
# ```
# 
# > - This function uses a quicksort algorithm.
# > - It is not appropriate for large array, use the `sort` binary for such cases.
# 
function array::sort() { :; }

# ## array::sortWithCriteria
# 
# Sorts an array using multiple criteria.
# Excepts multiple arrays. The first array is the one to sort.
# The other arrays are used as criteria. Criteria are used in the order they are given.
# Each criteria array must have the same size as the array to sort.
# Each criteria array must containing integers representing the order of the elements.
# We first sort using the first criteria (from smallest to biggest), then the second, etc.
# 
# - $1: **array name** _as string_:
#       The name of the array to sort (it will be sorted in place).
# - $@: **criteria array names** _as string_:
#       The names of the arrays to use as criteria.
#       Each array must have the same size as the array to sort and contain only numbers.
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
# echo "${myArray[@]}"
# # c b a
# echo "${RETURNED_ARRAY[@]}"
# # 3 2 1
# ```
# 
# > - This function uses a quicksort algorithm.
# > - It is not appropriate for large array, use the `sort` binary for such cases.
# 
function array::sortWithCriteria() { :; }

# ## benchmark::run
# 
# This function runs a benchmark on given functions.
# 
# First, it will run the 1st function (the baseline) for a given number of time and
# mark the number of times it was able to run it in that given time.
# 
# Then, it will run all the functions for the same number of time and
# print the difference between the baseline and the other functions.
# 
# - $1: **baseline** _as string_:
#       the name of the function to use as baseline
# - $2: **functions** _as string_:
#       The names of the functions to benchmark, comma separated.
# - $3: time _as int_:
#       (optional) Can be set using the variable `_OPTION_TIME`.
#       The time in seconds for which to run the baseline.
#       (defaults to 3s)
# - $4: max runs _as int_:
#       (optional) Can be set using the variable `_OPTION_MAX_RUNS`.
#       The maximum number of runs to do for each function.
#       (defaults to -1 which means no limit)
# 
# ```bash
# benchmark::run "baseline" "function1,function2" 1 100
# ```
# 
function benchmark::run() { :; }

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
function core::checkParseResults() { :; }

# ## core::deleteUserCommands
# 
# Delete the user 'commands' file from the valet user directory.
# 
# You probably want to reload the user commands afterward using `core::reloadUserCommands`.
# 
# ```bash
# core::deleteUserCommands
# ```
# 
function core::deleteUserCommands() { :; }

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
function core::fail() { :; }

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
function core::failWithCode() { :; }

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
function core::getConfigurationDirectory() { :; }

# ## core::getLocalStateDirectory
# 
# Returns the path to the valet local state directory.
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
function core::getLocalStateDirectory() { :; }

# ## core::getProgramElapsedMicroseconds
# 
# Get the elapsed time in µs since the program started.
# 
# Returns:
# 
# - `RETURNED_VALUE`: the elapsed time in µs since the program started.
# 
# ```bash
# core::getElapsedProgramTime
# echo "${RETURNED_VALUE}"
# string::microsecondsToHuman "${RETURNED_VALUE}"
# echo "Human time: ${RETURNED_VALUE}"
# ```
# 
# > Fun fact: this function will fail in 2038 on 32-bit systems because the number of seconds will overflow.
# 
function core::getProgramElapsedMicroseconds() { :; }

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
function core::getUserDirectory() { :; }

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
function core::getVersion() { :; }

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
function core::parseArguments() { :; }

# ## core::reloadUserCommands
# 
# Forcibly source again the user 'commands' file from the valet user directory.
# 
# ```bash
# core::reloadUserCommands
# ```
# 
function core::reloadUserCommands() { :; }

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
function core::resetIncludedFiles() { :; }

# ## core::showHelp
# 
# Show the help for the current function.
# This should be called directly from a command function for which you want to display the help text.
# 
# ```bash
# core::showHelp
# ```
# 
function core::showHelp() { :; }

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
function core::sourceFunction() { :; }

# ## core::sourceUserCommands
# 
# Source the user 'commands' file from the valet user directory.
# If the file does not exist, we build it on the fly.
# 
# ```bash
# core::sourceUserCommands
# ```
# 
function core::sourceUserCommands() { :; }

# ## curl::toFile
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
# curl::toFile "true" "200,201" "/filePath" "https://example.com" || core::fail "The curl command failed."
# ```
# 
function curl::toFile() { :; }

# ## curl::toVar
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
# curl::toVar false 200,201 https://example.com || core::fail "The curl command failed."
# ```
# 
function curl::toVar() { :; }

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
function fsfs::itemSelector() { :; }

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
function interactive::askForConfirmation() { :; }

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
function interactive::askForConfirmationRaw() { :; }

# ## interactive::clearBox
# 
# Clear a "box" in the terminal.
# Will return the cursor at the current position at the end (using GLOBAL_CURSOR_LINE and GLOBAL_CURSOR_COLUMN).
# 
# - $1: **top** _as int_:
#       the left position of the box
# - $2: **left** _as int_:
#       the top position of the box
# - $3: **width** _as int_:
#       the width of the box
# - $4: **height** _as int_:
#       the height of the box
# 
# ```bash
# interactive::getCursorPosition
# interactive::clearBox 1 1 10 5
# ```
# 
function interactive::clearBox() { :; }

# ## interactive::clearKeyPressed
# 
# This function reads all the inputs from the user, effectively discarding them.
# 
# ```bash
# interactive::clearKeyPressed
# ```
# 
function interactive::clearKeyPressed() { :; }

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
function interactive::createSpace() { :; }

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
function interactive::displayAnswer() { :; }

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
function interactive::displayDialogBox() { :; }

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
function interactive::displayQuestion() { :; }

# ## interactive::getBestAutocompleteBox
# 
# This function returns the best position and size for an autocomplete box that would open
# at the given position.
# 
# - The box will be placed below the current position if possible, but can be placed
#   above if there is not enough space below.
# - The box will be placed on the same column as the current position if possible, but can be placed
#   on the left side if there is not enough space on the right to display the full width of the box.
# - The box will have the desired height and width if possible, but will be reduced if there is
#   not enough space in the terminal.
# - The box will not be placed on the same line as the current position if notOnCurrentLine is set to true.
#   Otherwise it can use the current position line.
# 
# - $1: **current line** _as int_:
#       the current line of the cursor (1 based)
# - $2: **current column** _as int_:
#       the current column of the cursor (1 based)
# - $3: **desired height** _as int_:
#       the desired height of the box
# - $4: **desired width** _as int_:
#       the desired width of the box
# - $5: **max height** _as int_:
#       the maximum height of the box
# - $6: force below _as bool_:
#       (optional) force the box to be below the current position
#       (defaults to false)
# - $7: not on current line _as bool_:
#       (optional) the box will not be placed on the same line as the current position
#       (defaults to true)
# - $8: terminal width _as int_:
#       (optional) the width of the terminal
#       (defaults to GLOBAL_COLUMNS)
# - $9: terminal height _as int_:
#       (optional) the height of the terminal
#       (defaults to GLOBAL_LINES)
# 
# Returns:
# 
# - `RETURNED_VALUE`: the top position of the box (1 based)
# - `RETURNED_VALUE2`: the left position of the box (1 based)
# - `RETURNED_VALUE3`: the width of the box
# - `RETURNED_VALUE4`: the height of the box
# 
# ```bash
# interactive::getBestAutocompleteBox 1 1 10 5
# ```
# 
function interactive::getBestAutocompleteBox() { :; }

# ## interactive::getCursorPosition
# 
# Get the current cursor position.
# 
# Returns:
# 
# - `GLOBAL_CURSOR_LINE`: the line number
# - `GLOBAL_CURSOR_COLUMN`: the column number
# 
# ```bash
# interactive::getCursorPosition
# ```
# 
function interactive::getCursorPosition() { :; }

# ## interactive::getTerminalSize
# 
# This function exports the terminal size.
# 
# Returns:
# 
# - `GLOBAL_COLUMNS`: The number of columns in the terminal.
# - `GLOBAL_LINES`: The number of lines in the terminal.
# 
# ```bash
# interactive::getTerminalSize
# printf '%s\n' "The terminal has ⌜${GLOBAL_COLUMNS}⌝ columns and ⌜${GLOBAL_LINES}⌝ lines."
# ```
# 
function interactive::getTerminalSize() { :; }

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
function interactive::promptYesNo() { :; }

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
function interactive::promptYesNoRaw() { :; }

# ## interactive::rebindKeymap
# 
# Rebinds all special keys to call a given callback function.
# See @interactive::testWaitForKeyPress for an implementation example.
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
# You can call `interactive::resetBindings` to restore the default bindings. However, this is not
# necessary as the bindings are local to the script.
# 
# ```bash
# interactive::rebindKeymap
# ```
# 
# > `showkey -a` is a good program to see the sequence of characters sent by the terminal.
# 
function interactive::rebindKeymap() { :; }

# ## interactive::resetBindings
# 
# Reset the key bindings to the default ones.
# 
# ```bash
# interactive::resetBindings
# ```
# 
function interactive::resetBindings() { :; }

# ## interactive::restoreInterruptTrap
# 
# Restore the original trap for the interrupt signal (SIGINT).
# To be called after interactive::setInterruptTrap.
# 
# ```bash
# interactive::restoreInterruptTrap
# ```
# 
function interactive::restoreInterruptTrap() { :; }

# ## interactive::setInterruptTrap
# 
# Set a trap to catch the interrupt signal (SIGINT).
# When the user presses Ctrl+C, the GLOBAL_SESSION_INTERRUPTED variable will be set to true.
# 
# ```bash
# interactive::setInterruptTrap
# ```
# 
function interactive::setInterruptTrap() { :; }

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
function interactive::startProgress() { :; }

# ## interactive::stopProgress
# 
# Stop the progress bar.
# 
# ```bash
# interactive::stopProgress
# ```
# 
function interactive::stopProgress() { :; }

# ## interactive::sttyInit
# 
# Disable the echo of the tty. Will no longer display the characters typed by the user.
# 
# ```bash
# interactive::sttyInit
# ```
# 
function interactive::sttyInit() { :; }

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
function interactive::sttyRestore() { :; }

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
function interactive::switchBackFromFullScreen() { :; }

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
function interactive::switchToFullScreen() { :; }

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
function interactive::testWaitForChar() { :; }

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
function interactive::testWaitForKeyPress() { :; }

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
function interactive::updateProgress() { :; }

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
function interactive::waitForChar() { :; }

# ## interactive::waitForKeyPress
# 
# Wait for a key press (single key).
# You can pass additional parameters to the read command (e.g. to wait for a set amount of time).
# 
# It uses the read builtin command with the option `-e` to use readline behind the scene.
# This means we can detect more key combinations but all keys needs to be bound first...
# Special keys (CTRL+, ALT+, F1-F12, arrows, etc.) are intercepted using binding.
# 
# You must call `interactive::rebindKeymap` and `interactive::sttyInit` before using this function.
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
function interactive::waitForKeyPress() { :; }

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
function io::cat() { :; }

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
function io::checkAndFail() { :; }

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
function io::checkAndWarn() { :; }

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
function io::cleanupTempFiles() { :; }

# ## io::convertFromWindowsPath
# 
# Convert a Windows path to a unix path.
# 
# - $1: **path** _as string_:
#       the path to convert
# 
# Returns:
# 
# - `RETURNED_VALUE`: The unix path.
# 
# ```bash
# io::convertFromWindowsPath "C:\path\to\file"
# ```
# 
# > Handles paths starting with `X:\`.
# 
function io::convertFromWindowsPath() { :; }

# ## io::convertToWindowsPath
# 
# Convert a unix path to a Windows path.
# 
# - $1: **path** _as string_:
#       the path to convert
# 
# Returns:
# 
# - `RETURNED_VALUE`: The Windows path.
# 
# ```bash
# io::convertToWindowsPath "/path/to/file"
# ```
# 
# > Handles paths starting with `/mnt/x/` or `/x/`.
# 
function io::convertToWindowsPath() { :; }

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
function io::countArgs() { :; }

# ## io::createDirectoryIfNeeded
# 
# Create the directory tree if needed.
# 
# - $1: **path** _as string_:
#       The directory path to create.
# 
# Returns:
# 
# - `RETURNED_VALUE`: The absolute path to the directory.
# 
# ```bash
# io::createDirectoryIfNeeded "/my/directory"
# ```
# 
function io::createDirectoryIfNeeded() { :; }

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
function io::createFilePathIfNeeded() { :; }

# ## io::createLink
# 
# Create a soft or hard link (original ← link).
# 
# Reminder:
# 
# - A soft (symbolic) link is a new file that contains a reference to another file or directory in the
#   form of an absolute or relative path.
# - A hard link is a directory entry that associates a new pathname with an existing
#   file (inode + data block) on a file system.
# 
# This function allows to create a symbolic link on Windows as well as on Unix.
# 
# - $1: **linked path** _as string_:
#       the path to link to (the original file)
# - $2: **link path** _as string_:
#       the path where to create the link
# - $3: hard link _as boolean_:
#       (optional) true to create a hard link, false to create a symbolic link
#       (defaults to false)
# - $4: force _as boolean_:
#       (optional) true to overwrite the link or file if it already exists.
#       Otherwise, the function will fail on an existing link.
#       (defaults to true)
# 
# ```bash
# io::createLink "/path/to/link" "/path/to/linked"
# io::createLink "/path/to/link" "/path/to/linked" true
# ```
# 
# > On unix, the function uses the `ln` command.
# > On Windows, the function uses `powershell` (and optionally ls to check the existing link).
# 
function io::createLink() { :; }

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
function io::createTempDirectory() { :; }

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
function io::createTempFile() { :; }

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
function io::invoke() { :; }

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
function io::invoke2() { :; }

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
function io::invoke2piped() { :; }

# ## io::invoke5
# 
# This function call an executable and its arguments.
# It redirects the stdout and stderr to environment variables.
# It calls invoke5 and reads the files to set the environment variables.
# 
# - $1: **fail** _as bool_:
#       true/false to indicate if the function should fail in case the execution fails.
#       If true and the execution fails, the script will exit.
# - $2: **acceptable codes** _as string_:
#       the acceptable error codes, comma separated
#       (if the error code is matched, then set the output error code to 0)
# - $3: **stdin from file** _as bool_:
#       true/false to indicate if the 4th argument represents a file path or directly the content for stdin
# - $4: **stdin** _as string_:
#       the stdin (can be empty)
# - $5: **executable** _as string_:
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
# io::invoke5 "false" "130,2" "false" "This is the stdin" "stuff" "--height=10" || core::fail "stuff failed."
# stdout="${RETURNED_VALUE}"
# stderr="${RETURNED_VALUE2}"
# ```
# 
# > See io::invokef5 for more information.
# 
function io::invoke5() { :; }

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
function io::invokef2() { :; }

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
function io::invokef2piped() { :; }

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
# - $3: **sdtin from file** _as bool_:
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
# > - On linux, it is slightly faster (but it might be slower if you don't have SSD?).
# > - On linux, you can use a tmpfs directory for massive gains over subshells.
# 
function io::invokef5() { :; }

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
function io::isDirectoryWritable() { :; }

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
function io::listDirectories() { :; }

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
function io::listFiles() { :; }

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
function io::listPaths() { :; }

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
function io::readFile() { :; }

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
function io::readStdIn() { :; }

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
function io::sleep() { :; }

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
function io::toAbsolutePath() { :; }

# ## io::windowsCreateTempDirectory
# 
# Create a temporary directory on Windows and return the path both for Windows and Unix.
# 
# This is useful for creating temporary directories that can be used in both Windows and Unix.
# 
# Returns:
# 
# - `RETURNED_VALUE`: The Windows path.
# - `RETURNED_VALUE2`: The Unix path.
# 
# ```bash
# io::windowsCreateTempDirectory
# ```
# 
# > Directories created this way are automatically cleaned up by the io::cleanupTempFiles
# > function when valet ends.
# 
function io::windowsCreateTempDirectory() { :; }

# ## io::windowsCreateTempFile
# 
# Create a temporary file on Windows and return the path both for Windows and Unix.
# 
# This is useful for creating temporary files that can be used in both Windows and Unix.
# 
# Returns:
# 
# - `RETURNED_VALUE`: The Windows path.
# - `RETURNED_VALUE2`: The Unix path.
# 
# ```bash
# io::windowsCreateTempFile
# ```
# 
# > Files created this way are automatically cleaned up by the io::cleanupTempFiles
# > function when valet ends.
# 
function io::windowsCreateTempFile() { :; }

# ## io::windowsPowershellBatchEnd
# 
# This function will run all the commands that were batched with `io::windowsPowershellBatchStart`.
# 
# Returns:
# 
# - $?
#   - 0 if the command was successful
#   - 1 otherwise.
# - `RETURNED_VALUE`: The content of stdout.
# - `RETURNED_VALUE2`: The content of stderr.
# 
# ```bash
# io::windowsPowershellBatchStart
# io::windowsRunInPowershell "Write-Host \"Hello\""
# io::windowsRunInPowershell "Write-Host \"World\""
# io::windowsPowershellBatchEnd
# ```
# 
function io::windowsPowershellBatchEnd() { :; }

# ## io::windowsPowershellBatchStart
# 
# After running this function, all commands that should be executed by
# `io::windowsRunInPowershell` will be added to a batch that will only be played
# when `io::windowsPowershellBatchEnd` is called.
# 
# This is a convenient way to run multiple commands in a single PowerShell session.
# It makes up for the fact that running a new PowerShell session for each command is slow.
# 
# ```bash
# io::windowsPowershellBatchStart
# io::windowsRunInPowershell "Write-Host \"Hello\""
# io::windowsRunInPowershell "Write-Host \"World\""
# io::windowsPowershellBatchEnd
# ```
# 
function io::windowsPowershellBatchStart() { :; }

# ## io::windowsRunInPowershell
# 
# Runs a PowerShell command.
# This is mostly useful on Windows.
# 
# - $1: **command** _as string_:
#       the command to run.
# - $2: run as administrator _as boolean_:
#       (optional) whether to run the command as administrator.
#       (defaults to false).
# 
# Returns:
# 
# - $?
#   - 0 if the command was successful
#   - 1 otherwise.
# - `RETURNED_VALUE`: The content of stdout.
# - `RETURNED_VALUE2`: The content of stderr.
# 
# ```bash
# io::windowsRunInPowershell "Write-Host \"Press any key:\"; Write-Host -Object ('The key that was pressed was: {0}' -f [System.Console]::ReadKey().Key.ToString());"
# ```
# 
function io::windowsRunInPowershell() { :; }

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
function log::debug() { :; }

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
function log::error() { :; }

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
function log::errorTrace() { :; }

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
function log::getLevel() { :; }

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
function log::info() { :; }

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
function log::isDebugEnabled() { :; }

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
function log::isTraceEnabled() { :; }

# ## log::printCallStack
# 
# This function prints the current function stack in the logs.
# 
# - $1: Stack to skip _as int_:
#       (optional) Can be set using the variable `_OPTION_STACK_TO_SKIP`.
#       The number of stack to skip.
#       (defaults to 2 which skips this function and the first calling function
#       which is usually the onError function)
# 
# ```bash
# log::printCallStack
# log::printCallStack 0
# ```
# 
function log::printCallStack() { :; }

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
function log::printFile() { :; }

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
function log::printFileString() { :; }

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
function log::printRaw() { :; }

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
function log::printString() { :; }

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
function log::setLevel() { :; }

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
function log::success() { :; }

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
function log::trace() { :; }

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
function log::warning() { :; }

# ## profiler::disable
# 
# Disable the profiler if previously activated with profiler::enable.
# 
# ```bash
# profiler::disable
# ```
# 
function profiler::disable() { :; }

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
function profiler::enable() { :; }

# ## prompt_getDisplayedPromptString
# 
# This function return a string that can be printed in a terminal in order to display a text
# and position the cursor at a given index in the input text.
# 
# If the string is too long to fit in the screen, it will be truncated and ellipsis will be displayed
# at the beginning and/or at the end of the string.
# 
# The cursor will be displayed under the character at the given index of the input text and
# it makes sure that the cursor is always visible in the screen.
# 
# This function is useful to display a long prompt on a single line.
# 
# An example:
# 
# ```text
# _PROMPT_STRING_SCREEN_WIDTH=10
# _PROMPT_STRING_INDEX=20
# _PROMPT_STRING="This is a long string that will be displayed in the screen."
# #                                ^ input index 20
# prompt_getDisplayedPromptString 20 10
# # output: "…g string…"
# #                  ^ screen cursor (at index 8)
# ```
# 
# - $_PROMPT_STRING: **input string** _as string_:
#       the string to display
# - $_PROMPT_STRING_INDEX: **input index** _as int_:
#       the index of the character (in the input string) that should be under the cursor
# - $_PROMPT_STRING_SCREEN_WIDTH: **screen width** _as int_:
#       the width of the screen
# 
# Returns:
# 
# - `RETURNED_VALUE`: the string to display in the screen
# - `RETURNED_VALUE2`: the index at which to position the cursor on screen
# 
# ```bash
# prompt_getDisplayedPromptString "This is a long string that will be displayed in the screen." 20 10
# ```
# 
function prompt_getDisplayedPromptString() { :; }

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
function source() { :; }

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
function string::bumpSemanticVersion() { :; }

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
function string::camelCaseToSnakeCase() { :; }

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
function string::compareSemanticVersion() { :; }

# ## string::count
# 
# Counts the number of occurrences of a substring in a string.
# 
# - $1: **string** _as string_:
#       the string in which to search
# - $2: **substring** _as string_:
#       the substring to count
# 
# Returns:
# 
# - `RETURNED_VALUE`: the number of occurrences
# 
# ```bash
# string::count "name,firstname,address" "," && local count="${RETURNED_VALUE}"
# ```
# 
# > This is faster than looping over the string and check the substring.
# 
function string::count() { :; }

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
function string::cutField() { :; }

# ## string::extractBetween
# 
# Extract the text between two strings within a string.
# Search for the first occurrence of the start string and the first occurrence
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
function string::extractBetween() { :; }

# ## string::highlight
# 
# Highlight a pattern (each character of this pattern) in a string.
# 
# - $1: **text** _as string_:
#       The text to highlight.
# - $2: **pattern** _as string_:
#       The pattern to highlight.
# - $3: highlight ansi code _as string_:
#       (optional) Can be set using the variable `_OPTION_HIGHLIGHT_ANSI`.
#       The ANSI code to use for highlighting.
#       (defaults to VALET_CONFIG_COLOR_HIGHLIGHT)
# - $4: reset ansi code _as string_:
#       (optional) Can be set using the variable `_OPTION_RESET_ANSI`.
#       The ANSI code to use for resetting the highlighting.
#       (defaults to VALET_CONFIG_COLOR_DEFAULT)
# 
# Returns:
# 
# - `RETURNED_VALUE`: the highlighted text
# 
# ```bash
# string::highlight "This is a text to highlight." "ttttt"
# echo "${RETURNED_VALUE}"
# ```
# 
# > - All characters in the pattern must be found in the same order in the matched line.
# > - This functions is case insensitive.
# 
function string::highlight() { :; }

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
function string::indexOf() { :; }

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
function string::kebabCaseToCamelCase() { :; }

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
function string::kebabCaseToSnakeCase() { :; }

# ## string::microsecondsToHuman
# 
# Convert microseconds to human readable format.
# 
# - $1: **microseconds** _as int_:
#       the microseconds to convert
# - $2: format _as string_:
#      (optional) Can be set using the variable `_OPTION_FORMAT`.
#      the format to use (defaults to "%HH:%MM:%SS")
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
function string::microsecondsToHuman() { :; }

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
function string::regexGetFirst() { :; }

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
# string::split "name,first name,address" "," && local -a array=("${RETURNED_ARRAY[@]}")
# ```
# 
# > This is faster than using read into an array from a here string.
# 
function string::split() { :; }

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
function string::trim() { :; }

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
function string::trimAll() { :; }

# ## string::wrapCharacters
# 
# Allows to hard wrap the given string at the given width.
# Wrapping is done at character boundaries, see string::warpText for word wrapping.
# Optionally appends padding characters on each new line.
# 
# - $1: **text** _as string_:
#       The text to wrap.
# - $2: wrap width _as string_:
#       (optional) Can be set using the variable `_OPTION_WRAP_WIDTH`.
#       The width to wrap the text at.
#       Note that length of the optional padding characters are subtracted from the
#       width to make sure the text fits in the given width.
#       (defaults to GLOBAL_COLUMNS)
# - $3: padding characters _as string_:
#       (optional) Can be set using the variable `_OPTION_PADDING_CHARS`.
#       The characters to apply as padding on the left of each new line.
#       E.g. '  ' will add 2 spaces on the left of each new line.
#       (defaults to 0)
# - $4: first line width _as int_:
#       (optional) Can be set using the variable `_OPTION_FIRST_LINE_WIDTH`.
#       The width to use for the first line.
#       (defaults to the width)
# 
# Returns:
# 
# - `RETURNED_VALUE`: the wrapped string
# - `RETURNED_VALUE2`: the length taken on the last line
# 
# ```bash
# string::wrapCharacters "This is a long text that should be wrapped at 20 characters." 20 --- 5
# echo "${RETURNED_VALUE}"
# ```
# 
# > - This function is written in pure bash and is faster than calling the fold command.
# > - It considers escape sequence for text formatting and does not count them as visible characters.
# > - Leading spaces after a newly wrapped line are removed.
# 
function string::wrapCharacters() { :; }

# ## string::wrapText
# 
# Allows to soft wrap the given text at the given width.
# Wrapping is done at word boundaries.
# Optionally appends padding characters on each new line.
# 
# - $1: **text** _as string_:
#       The text to wrap.
# - $2: wrap width _as string_:
#       (optional) Can be set using the variable `_OPTION_WRAP_WIDTH`.
#       The width to wrap the text at.
#       Note that length of the optional padding characters are subtracted from the
#       width to make sure the text fits in the given width.
#       (defaults to GLOBAL_COLUMNS)
# - $3: padding characters _as string_:
#       (optional) Can be set using the variable `_OPTION_PADDING_CHARS`.
#       The characters to apply as padding on the left of each new line.
#       E.g. '  ' will add 2 spaces on the left of each new line.
#       (defaults to 0)
# - $4: first line width _as int_:
#       (optional) Can be set using the variable `_OPTION_FIRST_LINE_WIDTH`.
#       The width to use for the first line.
#       (defaults to the width)
# 
# Returns:
# 
# - `RETURNED_VALUE`: the wrapped text
# 
# ```bash
# string::wrapText "This is a long text that should be wrapped at 20 characters." 20 '  ' 5
# echo "${RETURNED_VALUE}"
# ```
# 
# > - This function is written in pure bash and is faster than calling the fold command.
# > - This function effectively trims all the extra spaces in the text (leading, trailing but also in the middle).
# > - It considers escape sequence for text formatting and does not count them as visible characters.
# 
function string::wrapText() { :; }

# ## system::addToPath
# 
# Add the given path to the PATH environment variable for various shells,
# by adding the appropriate export command to the appropriate file.
# 
# Will also export the PATH variable in the current bash.
# 
# - $1: **path** _as string_:
#       the path to add to the PATH environment variable.
# 
# ```bash
# system::addToPath "/path/to/bin"
# ```
# 
function system::addToPath() { :; }

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
function system::commandExists() { :; }

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
function system::date() { :; }

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
function system::env() { :; }

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
function system::getNotExistingCommands() { :; }

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
function system::getUndeclaredVariables() { :; }

# ## system::isRoot
# 
# Check if the script is running as root.
# 
# Returns:
# 
# - $?
#   - 0 if the script is running as root
#   - 1 otherwise.
# 
# ```bash
# if system::isRoot; then
#   printf 'The script is running as root.'
# fi
# ```
# 
function system::isRoot() { :; }

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
function system::os() { :; }

# ## system::windowsAddToPath
# 
# Add the given path to the PATH environment variable on Windows (current user only).
# 
# Will also export the PATH variable in the current bash.
# 
# - $1: **path** _as string_:
#       the path to add to the PATH environment variable.
#       The path can be in unix format, it will be converted to windows format.
# 
# ```bash
# system::windowsAddToPath "/path/to/bin"
# ```
# 
# > This function is only available on Windows, it uses `powershell` to directly modify the registry.
# 
function system::windowsAddToPath() { :; }

# ## system::windowsGetEnvVar
# 
# Get the value of an environment variable for the current user on Windows.
# 
# - $1: **variable name** _as string_:
#       the name of the environment variable to get.
# 
# Returns:
# 
# - `RETURNED_VALUE`: the value of the environment variable.
# 
# ```bash
# system::windowsGetEnvVar "MY_VAR"
# echo "${RETURNED_VALUE}"
# ```
# 
function system::windowsGetEnvVar() { :; }

# ## system::windowsSetEnvVar
# 
# Set an environment variable for the current user on Windows.
# 
# - $1: **variable name** _as string_:
#       the name of the environment variable to set.
# - $2: **variable value** _as string_:
#       the value of the environment variable to set.
# 
# ```bash
# system::windowsSetEnvVar "MY_VAR" "my_value"
# ```
# 
# > This function is only available on Windows, it uses `powershell` to directly modify the registry.
# 
function system::windowsSetEnvVar() { :; }

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
function test::commentTest() { :; }

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
function test::endTest() { :; }



→ cat /tmp/valet.d/d1-1/valet.code-snippets
{
// Documentation generated for the version 1.2.3 (2013-11-10).

"ansi-codes::*": {
  "prefix": "ansi-codes::*",
  "description": "ANSI codes for text attributes, colors, cursor control, and other common escape sequences...",
  "scope": "",
  "body": [ "ansi-codes::*$0" ]
},

"ansi-codes::*#withdoc": {
  "prefix": "ansi-codes::*#withdoc",
  "description": "ANSI codes for text attributes, colors, cursor control, and other common escape sequences...",
  "scope": "",
  "body": [ "# ## ansi-codes::*\n# \n# ANSI codes for text attributes, colors, cursor control, and other common escape sequences.\n# These codes can be used to format text in the terminal.\n# \n# They are defined as variables and not as functions. Please check the content of the lib-ansi-codes to learn more:\n# <https://github.com/jcaillon/valet/blob/latest/libraries.d/lib-ansi-codes>\n# \n# References:\n# \n# - https://en.wikipedia.org/wiki/ANSI_escape_code\n# - https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797\n# - https://paulbourke.net/dataformats/ascii/\n# - https://www.aivosto.com/articles/control-characters.html\n# - https://github.com/tmux/tmux/blob/master/tools/ansicode.txt\n# - https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h2-Functions-using-CSI-_-ordered-by-the-final-character_s_\n# - https://vt100.net/docs/vt102-ug/chapter5.html\n# - https://vt100.net/docs/vt100-ug/chapter3.html#S3.3.1\n# \n# Ascii graphics:\n# \n# - https://gist.github.com/dsample/79a97f38bf956f37a0f99ace9df367b9\n# - https://en.wikipedia.org/wiki/List_of_Unicode_characters#Box_Drawing\n# - https://en.wikipedia.org/wiki/List_of_Unicode_characters#Block_Elements\n# \n# > While it could be very handy to define a function for each of these instructions,\n# > it would also be slower to execute (function overhead + multiple printf calls).\n# \nansi-codes::*$0" ]
},

"array::appendIfNotPresent": {
  "prefix": "array::appendIfNotPresent",
  "description": "Add a value to an array if it is not already present...",
  "scope": "",
  "body": [ "array::appendIfNotPresent \"${1:**array name**}\"$0" ]
},

"array::appendIfNotPresent#withdoc": {
  "prefix": "array::appendIfNotPresent#withdoc",
  "description": "Add a value to an array if it is not already present...",
  "scope": "",
  "body": [ "# ## array::appendIfNotPresent\n# \n# Add a value to an array if it is not already present.\n# \n# - \\$1: **array name** _as string_:\n#       The global variable name of the array.\n# - \\$2: **value** _as any:\n#       The value to add.\n# \n# Returns:\n# \n# - \\$?:\n#   - 0 if the value was added\n#   - 1 if it was already present\n# \n# ```bash\n# declare -g myArray=( \"a\" \"b\" )\n# array::appendIfNotPresent myArray \"c\"\n# printf '%s\\n' \"\\${myArray[@]}\"\n# ```\n# \narray::appendIfNotPresent \"${1:**array name**}\"$0" ]
},

"array::fuzzyFilterSort": {
  "prefix": "array::fuzzyFilterSort",
  "description": "Allows to fuzzy sort an array against a given pattern...",
  "scope": "",
  "body": [ "array::fuzzyFilterSort \"${1:**pattern**}\" \"${2:**array name**}\"$0" ]
},

"array::fuzzyFilterSort#withdoc": {
  "prefix": "array::fuzzyFilterSort#withdoc",
  "description": "Allows to fuzzy sort an array against a given pattern...",
  "scope": "",
  "body": [ "# ## array::fuzzyFilterSort\n# \n# Allows to fuzzy sort an array against a given pattern.\n# Returns an array containing only the lines matching the pattern.\n# The array is sorted by (in order):\n# \n# - the index of the first matched character in the line\n# - the distance between the first and last matched characters in the line\n# - the original order in the list\n# \n# - \\$1: **pattern** _as string_:\n#       the pattern to match\n# - \\$2: **array name** _as string_:\n#       the initial array name\n# \n# Returns:\n# \n# - `RETURNED_ARRAY`: An array containing the items sorted and filtered\n# - `RETURNED_ARRAY2`: An array containing the indexes of the matched items in the original array\n# \n# ```bash\n# array::fuzzyFilterSort \"pattern\" \"myarray\" && local filteredArray=\"\\${RETURNED_ARRAY}\"\n# array::fuzzyFilterSort \"pattern\" \"myarray\" ⌜ ⌝ && local filteredArray=\"\\${RETURNED_ARRAY}\"\n# array::fuzzyFilterSort \"pattern\" \"myarray\" ⌜ ⌝ 10 && local filteredArray=\"\\${RETURNED_ARRAY}\"\n# ```\n# \n# > - All characters in the pattern must be found in the same order in the matched line.\n# > - Use `shopt -s nocasematch` to make this function is case insensitive.\n# > - This function is not appropriate for large arrays (>10k elements), see `array::fuzzyFilterSortFileWithGrepAndAwk` for large arrays.\n# \narray::fuzzyFilterSort \"${1:**pattern**}\" \"${2:**array name**}\"$0" ]
},

"array::fuzzyFilterSortFileWithGrepAndAwk": {
  "prefix": "array::fuzzyFilterSortFileWithGrepAndAwk",
  "description": "Allows to fuzzy sort a file against a given pattern...",
  "scope": "",
  "body": [ "array::fuzzyFilterSortFileWithGrepAndAwk \"${1:**pattern**}\" \"${2:**file to filer**}\" \"${3:**output filtered file**}\" \"${4:**output correspondences file**}\"$0" ]
},

"array::fuzzyFilterSortFileWithGrepAndAwk#withdoc": {
  "prefix": "array::fuzzyFilterSortFileWithGrepAndAwk#withdoc",
  "description": "Allows to fuzzy sort a file against a given pattern...",
  "scope": "",
  "body": [ "# ## array::fuzzyFilterSortFileWithGrepAndAwk\n# \n# Allows to fuzzy sort a file against a given pattern.\n# Outputs a file containing only the lines matching the pattern.\n# The array is sorted by (in order):\n# \n# - the index of the first matched character in the line\n# - the distance between the first and last matched characters in the line\n# \n# - \\$1: **pattern** _as string_:\n#       The pattern to filter the file with.\n# - \\$2: **file to filer** _as string_:\n#       The input file to filter.\n# - \\$3: **output filtered file** _as string_:\n#       The output file containing the filtered lines.\n# - \\$4: **output correspondences file** _as string_:\n#       The output file containing the indexes of the matched lines in the original file.\n# \n# ```bash\n# array::fuzzyFilterSortFileWithGrepAndAwk file.txt filtered.txt correspondences.txt\n# ```\n# \n# > This is not a pure bash function! Use `array::fuzzyFilterSort` for pure bash alternative.\n# > This function is useful for very large arrays.\n# \narray::fuzzyFilterSortFileWithGrepAndAwk \"${1:**pattern**}\" \"${2:**file to filer**}\" \"${3:**output filtered file**}\" \"${4:**output correspondences file**}\"$0" ]
},

"array::isInArray": {
  "prefix": "array::isInArray",
  "description": "Check if a value is in an array...",
  "scope": "",
  "body": [ "array::isInArray \"${1:**array name**}\" \"${2:**value**}\"$0" ]
},

"array::isInArray#withdoc": {
  "prefix": "array::isInArray#withdoc",
  "description": "Check if a value is in an array...",
  "scope": "",
  "body": [ "# ## array::isInArray\n# \n# Check if a value is in an array.\n# It uses pure bash.\n# \n# - \\$1: **array name** _as string_:\n#       The global variable name of the array.\n# - \\$2: **value** _as any_:\n#       The value to check.\n# \n# Returns:\n# \n# - \\$?: 0 if the value is in the array, 1 otherwise.\n# \n# ```bash\n# declare -g myArray=( \"a\" \"b\" )\n# array::isInArray myArray \"b\" && printf '%s\\n' \"b is in the array\"\n# ```\n# \narray::isInArray \"${1:**array name**}\" \"${2:**value**}\"$0" ]
},

"array::makeArraysSameSize": {
  "prefix": "array::makeArraysSameSize",
  "description": "This function makes sure that all the arrays have the same size...",
  "scope": "",
  "body": [ "array::makeArraysSameSize \"${99:**array names**}\"$0" ]
},

"array::makeArraysSameSize#withdoc": {
  "prefix": "array::makeArraysSameSize#withdoc",
  "description": "This function makes sure that all the arrays have the same size...",
  "scope": "",
  "body": [ "# ## array::makeArraysSameSize\n# \n# This function makes sure that all the arrays have the same size.\n# It will add empty strings to the arrays that are too short.\n# \n# - \\$@: **array names** _as string_:\n#       The arrays (global variable names) to make the same size.\n# \n# ```bash\n# array::makeArraysSameSize \"array1\" \"array2\" \"array3\"\n# ```\n# \narray::makeArraysSameSize \"${99:**array names**}\"$0" ]
},

"array::sort": {
  "prefix": "array::sort",
  "description": "Sorts an array using the > bash operator (lexicographic order)...",
  "scope": "",
  "body": [ "array::sort \"${1:**array name**}\"$0" ]
},

"array::sort#withdoc": {
  "prefix": "array::sort#withdoc",
  "description": "Sorts an array using the > bash operator (lexicographic order)...",
  "scope": "",
  "body": [ "# ## array::sort\n# \n# Sorts an array using the > bash operator (lexicographic order).\n# \n# - \\$1: **array name** _as string_:\n#       The global variable name of array to sort.\n# \n# ```bash\n# declare -g myArray=(z f b h a j)\n# array::sort myArray\n# echo \"\\${myArray[*]}\"\n# ```\n# \n# > - This function uses a quicksort algorithm.\n# > - It is not appropriate for large array, use the `sort` binary for such cases.\n# \narray::sort \"${1:**array name**}\"$0" ]
},

"array::sortWithCriteria": {
  "prefix": "array::sortWithCriteria",
  "description": "Sorts an array using multiple criteria...",
  "scope": "",
  "body": [ "array::sortWithCriteria \"${1:**array name**}\" \"${99:**criteria array names**}\"$0" ]
},

"array::sortWithCriteria#withdoc": {
  "prefix": "array::sortWithCriteria#withdoc",
  "description": "Sorts an array using multiple criteria...",
  "scope": "",
  "body": [ "# ## array::sortWithCriteria\n# \n# Sorts an array using multiple criteria.\n# Excepts multiple arrays. The first array is the one to sort.\n# The other arrays are used as criteria. Criteria are used in the order they are given.\n# Each criteria array must have the same size as the array to sort.\n# Each criteria array must containing integers representing the order of the elements.\n# We first sort using the first criteria (from smallest to biggest), then the second, etc.\n# \n# - \\$1: **array name** _as string_:\n#       The name of the array to sort (it will be sorted in place).\n# - \\$@: **criteria array names** _as string_:\n#       The names of the arrays to use as criteria.\n#       Each array must have the same size as the array to sort and contain only numbers.\n# \n# Returns:\n# \n# - `RETURNED_ARRAY`: An array that contains the corresponding indexes of the sorted array in the original array\n# \n# ```bash\n# declare -g myArray=( \"a\" \"b\" \"c\" )\n# declare -g criteria1=( 3 2 2 )\n# declare -g criteria2=( 1 3 2 )\n# array::sortWithCriteria myArray criteria1 criteria2\n# echo \"\\${myArray[@]}\"\n# # c b a\n# echo \"\\${RETURNED_ARRAY[@]}\"\n# # 3 2 1\n# ```\n# \n# > - This function uses a quicksort algorithm.\n# > - It is not appropriate for large array, use the `sort` binary for such cases.\n# \narray::sortWithCriteria \"${1:**array name**}\" \"${99:**criteria array names**}\"$0" ]
},

"benchmark::run": {
  "prefix": "benchmark::run",
  "description": "This function runs a benchmark on given functions...",
  "scope": "",
  "body": [ "benchmark::run \"${1:**baseline**}\" \"${2:**functions**}\" \"${3:time}\" \"${4:max runs}\"$0" ]
},

"benchmark::run#withdoc": {
  "prefix": "benchmark::run#withdoc",
  "description": "This function runs a benchmark on given functions...",
  "scope": "",
  "body": [ "# ## benchmark::run\n# \n# This function runs a benchmark on given functions.\n# \n# First, it will run the 1st function (the baseline) for a given number of time and\n# mark the number of times it was able to run it in that given time.\n# \n# Then, it will run all the functions for the same number of time and\n# print the difference between the baseline and the other functions.\n# \n# - \\$1: **baseline** _as string_:\n#       the name of the function to use as baseline\n# - \\$2: **functions** _as string_:\n#       The names of the functions to benchmark, comma separated.\n# - \\$3: time _as int_:\n#       (optional) Can be set using the variable `_OPTION_TIME`.\n#       The time in seconds for which to run the baseline.\n#       (defaults to 3s)\n# - \\$4: max runs _as int_:\n#       (optional) Can be set using the variable `_OPTION_MAX_RUNS`.\n#       The maximum number of runs to do for each function.\n#       (defaults to -1 which means no limit)\n# \n# ```bash\n# benchmark::run \"baseline\" \"function1,function2\" 1 100\n# ```\n# \nbenchmark::run \"${1:**baseline**}\" \"${2:**functions**}\" \"${3:time}\" \"${4:max runs}\"$0" ]
},

"core::checkParseResults": {
  "prefix": "core::checkParseResults",
  "description": "A convenience function to check the parsing results and fails with an error message if there are parsing errors...",
  "scope": "",
  "body": [ "core::checkParseResults \"${1:**display help**}\" \"${2:**parsing errors**}\" \"${3:function name}\"$0" ]
},

"core::checkParseResults#withdoc": {
  "prefix": "core::checkParseResults#withdoc",
  "description": "A convenience function to check the parsing results and fails with an error message if there are parsing errors...",
  "scope": "",
  "body": [ "# ## core::checkParseResults\n# \n# A convenience function to check the parsing results and fails with an error message if there are\n# parsing errors.\n# Will also display the help if the help option is true.\n# \n# This should be called from a command function for which you want to check the parsing results.\n# \n# - \\$1: **display help** _as bool_:\n#       the help option\n# - \\$2: **parsing errors** _as string_:\n#       the parsing errors\n# - \\$3: function name _as string_:\n#       (optional) the function name\n#       (defaults to the calling function)\n# \n# ```bash\n# core::checkParseResults \"\\${help:-}\" \"\\${parsingErrors:-}\"\n# core::checkParseResults \"\\${help:-}\" \"\\${parsingErrors:-}\" \"myFunctionName\"\n# ```\n# \ncore::checkParseResults \"${1:**display help**}\" \"${2:**parsing errors**}\" \"${3:function name}\"$0" ]
},

"core::deleteUserCommands": {
  "prefix": "core::deleteUserCommands",
  "description": "Delete the user 'commands' file from the valet user directory...",
  "scope": "",
  "body": [ "core::deleteUserCommands$0" ]
},

"core::deleteUserCommands#withdoc": {
  "prefix": "core::deleteUserCommands#withdoc",
  "description": "Delete the user 'commands' file from the valet user directory...",
  "scope": "",
  "body": [ "# ## core::deleteUserCommands\n# \n# Delete the user 'commands' file from the valet user directory.\n# \n# You probably want to reload the user commands afterward using `core::reloadUserCommands`.\n# \n# ```bash\n# core::deleteUserCommands\n# ```\n# \ncore::deleteUserCommands$0" ]
},

"core::fail": {
  "prefix": "core::fail",
  "description": "Displays an error message and then exit the program with error...",
  "scope": "",
  "body": [ "core::fail \"${99:**message**}\"$0" ]
},

"core::fail#withdoc": {
  "prefix": "core::fail#withdoc",
  "description": "Displays an error message and then exit the program with error...",
  "scope": "",
  "body": [ "# ## core::fail\n# \n# Displays an error message and then exit the program with error.\n# \n# - \\$@: **message** _as string_:\n#       the error message to display\n# \n# ```bash\n# core::fail \"This is an error message.\"\n# ```\n# \ncore::fail \"${99:**message**}\"$0" ]
},

"core::failWithCode": {
  "prefix": "core::failWithCode",
  "description": "Displays an error message and then exit the program with error...",
  "scope": "",
  "body": [ "core::failWithCode \"${1:**exit code**}\" \"${99:**message**}\"$0" ]
},

"core::failWithCode#withdoc": {
  "prefix": "core::failWithCode#withdoc",
  "description": "Displays an error message and then exit the program with error...",
  "scope": "",
  "body": [ "# ## core::failWithCode\n# \n# Displays an error message and then exit the program with error.\n# \n# - \\$1: **exit code** _as int_:\n#       the exit code to use, should be between 1 and 255\n# - \\$@: **message** _as string_:\n#       the error message to display\n# \n# ```bash\n# core::failWithCode 255 \"This is an error message.\"\n# ```\n# \ncore::failWithCode \"${1:**exit code**}\" \"${99:**message**}\"$0" ]
},

"core::getConfigurationDirectory": {
  "prefix": "core::getConfigurationDirectory",
  "description": "Returns the path to the valet configuration directory...",
  "scope": "",
  "body": [ "core::getConfigurationDirectory$0" ]
},

"core::getConfigurationDirectory#withdoc": {
  "prefix": "core::getConfigurationDirectory#withdoc",
  "description": "Returns the path to the valet configuration directory...",
  "scope": "",
  "body": [ "# ## core::getConfigurationDirectory\n# \n# Returns the path to the valet configuration directory.\n# Creates it if missing.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the path to the valet configuration directory\n# \n# ```bash\n# core::getConfigurationDirectory\n# local directory=\"\\${RETURNED_VALUE}\"\n# ```\n# \ncore::getConfigurationDirectory$0" ]
},

"core::getLocalStateDirectory": {
  "prefix": "core::getLocalStateDirectory",
  "description": "Returns the path to the valet local state directory...",
  "scope": "",
  "body": [ "core::getLocalStateDirectory$0" ]
},

"core::getLocalStateDirectory#withdoc": {
  "prefix": "core::getLocalStateDirectory#withdoc",
  "description": "Returns the path to the valet local state directory...",
  "scope": "",
  "body": [ "# ## core::getLocalStateDirectory\n# \n# Returns the path to the valet local state directory.\n# The base directory relative to which user-specific state files should be stored.\n# Creates it if missing.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the path to the valet local state directory\n# \n# ```bash\n# core::getLocalStateDirectory\n# local directory=\"\\${RETURNED_VALUE}\"\n# ```\n# \ncore::getLocalStateDirectory$0" ]
},

"core::getProgramElapsedMicroseconds": {
  "prefix": "core::getProgramElapsedMicroseconds",
  "description": "Get the elapsed time in µs since the program started...",
  "scope": "",
  "body": [ "core::getProgramElapsedMicroseconds$0" ]
},

"core::getProgramElapsedMicroseconds#withdoc": {
  "prefix": "core::getProgramElapsedMicroseconds#withdoc",
  "description": "Get the elapsed time in µs since the program started...",
  "scope": "",
  "body": [ "# ## core::getProgramElapsedMicroseconds\n# \n# Get the elapsed time in µs since the program started.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the elapsed time in µs since the program started.\n# \n# ```bash\n# core::getElapsedProgramTime\n# echo \"\\${RETURNED_VALUE}\"\n# string::microsecondsToHuman \"\\${RETURNED_VALUE}\"\n# echo \"Human time: \\${RETURNED_VALUE}\"\n# ```\n# \n# > Fun fact: this function will fail in 2038 on 32-bit systems because the number of seconds will overflow.\n# \ncore::getProgramElapsedMicroseconds$0" ]
},

"core::getUserDirectory": {
  "prefix": "core::getUserDirectory",
  "description": "Returns the path to the valet user directory...",
  "scope": "",
  "body": [ "core::getUserDirectory$0" ]
},

"core::getUserDirectory#withdoc": {
  "prefix": "core::getUserDirectory#withdoc",
  "description": "Returns the path to the valet user directory...",
  "scope": "",
  "body": [ "# ## core::getUserDirectory\n# \n# Returns the path to the valet user directory.\n# Does not create it if missing.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the path to the valet user directory\n# \n# ```bash\n# core::getUserDirectory\n# local directory=\"\\${RETURNED_VALUE}\"\n# ```\n# \ncore::getUserDirectory$0" ]
},

"core::getVersion": {
  "prefix": "core::getVersion",
  "description": "Returns the version of Valet...",
  "scope": "",
  "body": [ "core::getVersion$0" ]
},

"core::getVersion#withdoc": {
  "prefix": "core::getVersion#withdoc",
  "description": "Returns the version of Valet...",
  "scope": "",
  "body": [ "# ## core::getVersion\n# \n# Returns the version of Valet.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The version of Valet.\n# \n# ```bash\n# core::getVersion\n# printf '%s\\n' \"The version of Valet is ⌜\\${RETURNED_VALUE}⌝.\"\n# ```\n# \ncore::getVersion$0" ]
},

"core::parseArguments": {
  "prefix": "core::parseArguments",
  "description": "Parse the arguments and options of a function and return a string that can be evaluated to set the variables...",
  "scope": "",
  "body": [ "core::parseArguments \"${99:**arguments**}\"$0" ]
},

"core::parseArguments#withdoc": {
  "prefix": "core::parseArguments#withdoc",
  "description": "Parse the arguments and options of a function and return a string that can be evaluated to set the variables...",
  "scope": "",
  "body": [ "# ## core::parseArguments\n# \n# Parse the arguments and options of a function and return a string that can be evaluated to set the variables.\n# This should be called from a command function for which you want to parse the arguments.\n# \n# See the documentation for more details on the parser: <https://jcaillon.github.io/valet/docs/new-commands/#-implement-your-command>.\n# \n# \n# - \\$@: **arguments** _as any_:\n#       the arguments to parse\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: a string that can be evaluated to set the parsed variables\n# \n# Output example:\n# \n# ```\n# local arg1 option1\n# arg1=\"xxx\"\n# option1=\"xxx\"\n# ```\n# \n# ```bash\n# core::parseArguments \"\\$@\" && eval \"\\${RETURNED_VALUE}\"\n# ```\n# \ncore::parseArguments \"${99:**arguments**}\"$0" ]
},

"core::reloadUserCommands": {
  "prefix": "core::reloadUserCommands",
  "description": "Forcibly source again the user 'commands' file from the valet user directory...",
  "scope": "",
  "body": [ "core::reloadUserCommands$0" ]
},

"core::reloadUserCommands#withdoc": {
  "prefix": "core::reloadUserCommands#withdoc",
  "description": "Forcibly source again the user 'commands' file from the valet user directory...",
  "scope": "",
  "body": [ "# ## core::reloadUserCommands\n# \n# Forcibly source again the user 'commands' file from the valet user directory.\n# \n# ```bash\n# core::reloadUserCommands\n# ```\n# \ncore::reloadUserCommands$0" ]
},

"core::resetIncludedFiles": {
  "prefix": "core::resetIncludedFiles",
  "description": "Allows to reset the included files...",
  "scope": "",
  "body": [ "core::resetIncludedFiles$0" ]
},

"core::resetIncludedFiles#withdoc": {
  "prefix": "core::resetIncludedFiles#withdoc",
  "description": "Allows to reset the included files...",
  "scope": "",
  "body": [ "# ## core::resetIncludedFiles\n# \n# Allows to reset the included files.\n# When calling the source function, it will source all the files again.\n# This is useful when we want to reload the libraries.\n# \n# ```bash\n# core::resetIncludedFiles\n# ```\n# \ncore::resetIncludedFiles$0" ]
},

"core::showHelp": {
  "prefix": "core::showHelp",
  "description": "Show the help for the current function...",
  "scope": "",
  "body": [ "core::showHelp$0" ]
},

"core::showHelp#withdoc": {
  "prefix": "core::showHelp#withdoc",
  "description": "Show the help for the current function...",
  "scope": "",
  "body": [ "# ## core::showHelp\n# \n# Show the help for the current function.\n# This should be called directly from a command function for which you want to display the help text.\n# \n# ```bash\n# core::showHelp\n# ```\n# \ncore::showHelp$0" ]
},

"core::sourceFunction": {
  "prefix": "core::sourceFunction",
  "description": "Source the file associated with a command function...",
  "scope": "",
  "body": [ "core::sourceFunction \"${1:**function name**}\"$0" ]
},

"core::sourceFunction#withdoc": {
  "prefix": "core::sourceFunction#withdoc",
  "description": "Source the file associated with a command function...",
  "scope": "",
  "body": [ "# ## core::sourceFunction\n# \n# Source the file associated with a command function.\n# This allows you to call a command function without having to source the file manually.\n# \n# - \\$1: **function name** _as string_:\n#       the function name\n# \n# ```bash\n# core::sourceFunction \"functionName\"\n# ```\n# \ncore::sourceFunction \"${1:**function name**}\"$0" ]
},

"core::sourceUserCommands": {
  "prefix": "core::sourceUserCommands",
  "description": "Source the user 'commands' file from the valet user directory...",
  "scope": "",
  "body": [ "core::sourceUserCommands$0" ]
},

"core::sourceUserCommands#withdoc": {
  "prefix": "core::sourceUserCommands#withdoc",
  "description": "Source the user 'commands' file from the valet user directory...",
  "scope": "",
  "body": [ "# ## core::sourceUserCommands\n# \n# Source the user 'commands' file from the valet user directory.\n# If the file does not exist, we build it on the fly.\n# \n# ```bash\n# core::sourceUserCommands\n# ```\n# \ncore::sourceUserCommands$0" ]
},

"curl::toFile": {
  "prefix": "curl::toFile",
  "description": "This function is a wrapper around curl...",
  "scope": "",
  "body": [ "curl::toFile \"${1:**fail**}\" \"${2:**acceptable codes**}\" \"${3:**path**}\" \"${99:**curl arguments**}\"$0" ]
},

"curl::toFile#withdoc": {
  "prefix": "curl::toFile#withdoc",
  "description": "This function is a wrapper around curl...",
  "scope": "",
  "body": [ "# ## curl::toFile\n# \n# This function is a wrapper around curl.\n# It allows you to check the http status code and return 1 if it is not acceptable.\n# It io::invokes curl with the following options (do not repeat them): -sSL -w \"%{response_code}\" -o \\${2}.\n# \n# - \\$1: **fail** _as bool_:\n#       true/false to indicate if the function should fail in case the execution fails\n# - \\$2: **acceptable codes** _as string_:\n#       list of http status codes that are acceptable, comma separated\n#       (defaults to 200,201,202,204,301,304,308 if left empty)\n# - \\$3: **path** _as string_:\n#       the file in which to save the output of curl\n# - \\$@: **curl arguments** _as any_:\n#       options for curl\n# \n# Returns:\n# \n# - \\$?:\n#   - 0 if the http status code is acceptable\n#   - 1 otherwise\n# - `RETURNED_VALUE`: the content of stderr\n# - `RETURNED_VALUE2`: the http status code\n# \n# ```bash\n# curl::toFile \"true\" \"200,201\" \"/filePath\" \"https://example.com\" || core::fail \"The curl command failed.\"\n# ```\n# \ncurl::toFile \"${1:**fail**}\" \"${2:**acceptable codes**}\" \"${3:**path**}\" \"${99:**curl arguments**}\"$0" ]
},

"curl::toVar": {
  "prefix": "curl::toVar",
  "description": "This function is a wrapper around curl...",
  "scope": "",
  "body": [ "curl::toVar \"${1:**fail**}\" \"${2:**acceptable codes**}\" \"${99:**curl arguments**}\"$0" ]
},

"curl::toVar#withdoc": {
  "prefix": "curl::toVar#withdoc",
  "description": "This function is a wrapper around curl...",
  "scope": "",
  "body": [ "# ## curl::toVar\n# \n# This function is a wrapper around curl.\n# It allows you to check the http status code and return 1 if it is not acceptable.\n# It io::invokes curl with the following options (do not repeat them): -sSL -w \"%{response_code}\" -o \"tempfile\".\n# \n# - \\$1: **fail** _as bool_:\n#       true/false to indicate if the function should fail in case the execution fails\n# - \\$2: **acceptable codes** _as string_:\n#       list of http status codes that are acceptable, comma separated\n#       (defaults to 200,201,202,204,301,304,308 if left empty)\n# - \\$@: **curl arguments** _as any_:\n#       options for curl\n# \n# Returns:\n# \n# - \\$?:\n#   - 0 if the http status code is acceptable\n#   - 1 otherwise\n# - `RETURNED_VALUE`: the content of the request\n# - `RETURNED_VALUE2`: the content of stderr\n# - `RETURNED_VALUE3`: the http status code\n# \n# ```bash\n# curl::toVar false 200,201 https://example.com || core::fail \"The curl command failed.\"\n# ```\n# \ncurl::toVar \"${1:**fail**}\" \"${2:**acceptable codes**}\" \"${99:**curl arguments**}\"$0" ]
},

"fsfs::itemSelector": {
  "prefix": "fsfs::itemSelector",
  "description": "Displays a menu where the user can search and select an item...",
  "scope": "",
  "body": [ "fsfs::itemSelector \"${1:**prompt**}\" \"${2:**array name**}\" \"${3:select callback function name}\" \"${4:preview title}\"$0" ]
},

"fsfs::itemSelector#withdoc": {
  "prefix": "fsfs::itemSelector#withdoc",
  "description": "Displays a menu where the user can search and select an item...",
  "scope": "",
  "body": [ "# ## fsfs::itemSelector\n# \n# Displays a menu where the user can search and select an item.\n# The menu is displayed in full screen.\n# Each item can optionally have a description/details shown in a right panel.\n# The user can search for an item by typing.\n# \n# - \\$1: **prompt** _as string_:\n#       The prompt to display to the user (e.g. Please pick an item).\n# - \\$2: **array name** _as string_:\n#       The items to display (name of a global array).\n# - \\$3: select callback function name _as string_:\n#       (optional) The function to call when an item is selected\n#       (defaults to empty, no callback)\n#       this parameter can be left empty to hide the preview right pane;\n#       otherwise the callback function should have the following signature:\n#   - \\$1: the current item\n#   - \\$2: the item number;\n#   - \\$3: the current panel width;\n#   - it should return the details of the item in the `RETURNED_VALUE` variable.\n# - \\$4: preview title _as string_:\n#       (optional) the title of the preview right pane (if any)\n#       (defaults to empty)\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The selected item value (or empty).\n# - `RETURNED_VALUE2`: The selected item index (from the original array).\n#                      Or -1 if the user cancelled the selection\n# \n# ```bash\n# declare -g -a SELECTION_ARRAY\n# SELECTION_ARRAY=(\"blue\" \"red\" \"green\" \"yellow\")\n# fsfs::itemSelector \"What's your favorite color?\" SELECTION_ARRAY\n# log::info \"You selected: ⌜\\${RETURNED_VALUE}⌝ (index: ⌜\\${RETURNED_VALUE2}⌝)\"\n# ```\n# \nfsfs::itemSelector \"${1:**prompt**}\" \"${2:**array name**}\" \"${3:select callback function name}\" \"${4:preview title}\"$0" ]
},

"interactive::askForConfirmation": {
  "prefix": "interactive::askForConfirmation",
  "description": "Ask the user to press the button to continue...",
  "scope": "",
  "body": [ "interactive::askForConfirmation \"${1:**prompt**}\"$0" ]
},

"interactive::askForConfirmation#withdoc": {
  "prefix": "interactive::askForConfirmation#withdoc",
  "description": "Ask the user to press the button to continue...",
  "scope": "",
  "body": [ "# ##  interactive::askForConfirmation\n# \n# Ask the user to press the button to continue.\n# \n# - \\$1: **prompt** _as string_:\n#       the prompt to display\n# \n# Returns:\n# \n# - \\$?:\n#   - 0 if the user pressed enter\n#   - 1 otherwise\n# \n# ```bash\n# interactive::askForConfirmation \"Press enter to continue.\"\n# ```\n# \ninteractive::askForConfirmation \"${1:**prompt**}\"$0" ]
},

"interactive::askForConfirmationRaw": {
  "prefix": "interactive::askForConfirmationRaw",
  "description": "Ask the user to press the button to continue...",
  "scope": "",
  "body": [ "interactive::askForConfirmationRaw$0" ]
},

"interactive::askForConfirmationRaw#withdoc": {
  "prefix": "interactive::askForConfirmationRaw#withdoc",
  "description": "Ask the user to press the button to continue...",
  "scope": "",
  "body": [ "# ## interactive::askForConfirmationRaw\n# \n# Ask the user to press the button to continue.\n# \n# This raw version does not display the prompt or the answer.\n# \n# Returns:\n# \n# - \\$?:\n#   - 0 if the user pressed enter\n#   - 1 otherwise\n# \n# ```bash\n# interactive::askForConfirmationRaw\n# ```\n# \ninteractive::askForConfirmationRaw$0" ]
},

"interactive::clearBox": {
  "prefix": "interactive::clearBox",
  "description": "Clear a \"box\" in the terminal...",
  "scope": "",
  "body": [ "interactive::clearBox \"${1:**top**}\" \"${2:**left**}\" \"${3:**width**}\" \"${4:**height**}\"$0" ]
},

"interactive::clearBox#withdoc": {
  "prefix": "interactive::clearBox#withdoc",
  "description": "Clear a \"box\" in the terminal...",
  "scope": "",
  "body": [ "# ## interactive::clearBox\n# \n# Clear a \"box\" in the terminal.\n# Will return the cursor at the current position at the end (using GLOBAL_CURSOR_LINE and GLOBAL_CURSOR_COLUMN).\n# \n# - \\$1: **top** _as int_:\n#       the left position of the box\n# - \\$2: **left** _as int_:\n#       the top position of the box\n# - \\$3: **width** _as int_:\n#       the width of the box\n# - \\$4: **height** _as int_:\n#       the height of the box\n# \n# ```bash\n# interactive::getCursorPosition\n# interactive::clearBox 1 1 10 5\n# ```\n# \ninteractive::clearBox \"${1:**top**}\" \"${2:**left**}\" \"${3:**width**}\" \"${4:**height**}\"$0" ]
},

"interactive::clearKeyPressed": {
  "prefix": "interactive::clearKeyPressed",
  "description": "This function reads all the inputs from the user, effectively discarding them...",
  "scope": "",
  "body": [ "interactive::clearKeyPressed$0" ]
},

"interactive::clearKeyPressed#withdoc": {
  "prefix": "interactive::clearKeyPressed#withdoc",
  "description": "This function reads all the inputs from the user, effectively discarding them...",
  "scope": "",
  "body": [ "# ## interactive::clearKeyPressed\n# \n# This function reads all the inputs from the user, effectively discarding them.\n# \n# ```bash\n# interactive::clearKeyPressed\n# ```\n# \ninteractive::clearKeyPressed$0" ]
},

"interactive::createSpace": {
  "prefix": "interactive::createSpace",
  "description": "This function creates some new lines after the current cursor position...",
  "scope": "",
  "body": [ "interactive::createSpace \"${1:**number of lines**}\"$0" ]
},

"interactive::createSpace#withdoc": {
  "prefix": "interactive::createSpace#withdoc",
  "description": "This function creates some new lines after the current cursor position...",
  "scope": "",
  "body": [ "# ## interactive::createSpace\n# \n# This function creates some new lines after the current cursor position.\n# Then it moves back to its original position.\n# This effectively creates a space in the terminal (scroll up if we are at the bottom).\n# It does not create more space than the number of lines in the terminal.\n# \n# - \\$1: **number of lines** _as int_:\n#       the number of lines to create\n# \n# ```bash\n# interactive::createSpace 5\n# ```\n# \ninteractive::createSpace \"${1:**number of lines**}\"$0" ]
},

"interactive::displayAnswer": {
  "prefix": "interactive::displayAnswer",
  "description": "Displays an answer to a previous question...",
  "scope": "",
  "body": [ "interactive::displayAnswer \"${1:**answer**}\" \"${2:max width}\"$0" ]
},

"interactive::displayAnswer#withdoc": {
  "prefix": "interactive::displayAnswer#withdoc",
  "description": "Displays an answer to a previous question...",
  "scope": "",
  "body": [ "# ## interactive::displayAnswer\n# \n# Displays an answer to a previous question.\n# \n# The text is wrapped and put inside a box like so:\n# \n# ```text\n#     ┌─────┐\n#     │ No. ├──░\n#     └─────┘\n# ```\n# \n# - \\$1: **answer** _as string_:\n#       the answer to display\n# - \\$2: max width _as int_:\n#       (optional) the maximum width of the text in the dialog box\n#       (defaults to GLOBAL_COLUMNS)\n# \n# ```bash\n# interactive::displayAnswer \"My answer.\"\n# ```\n# \ninteractive::displayAnswer \"${1:**answer**}\" \"${2:max width}\"$0" ]
},

"interactive::displayDialogBox": {
  "prefix": "interactive::displayDialogBox",
  "description": "Displays a dialog box with a speaker and a text...",
  "scope": "",
  "body": [ "interactive::displayDialogBox \"${1:**speaker**}\" \"${2:**text**}\" \"${3:max width}\"$0" ]
},

"interactive::displayDialogBox#withdoc": {
  "prefix": "interactive::displayDialogBox#withdoc",
  "description": "Displays a dialog box with a speaker and a text...",
  "scope": "",
  "body": [ "# ## interactive::displayDialogBox\n# \n# Displays a dialog box with a speaker and a text.\n# \n# - \\$1: **speaker** _as string_:\n#       the speaker (system or user)\n# - \\$2: **text** _as string_:\n#       the text to display\n# - \\$3: max width _as int_:\n#       (optional) the maximum width of the text in the dialog box\n#       (defaults to GLOBAL_COLUMNS)\n# \n# ```bash\n# interactive::displayDialogBox \"system\" \"This is a system message.\"\n# ```\n# \ninteractive::displayDialogBox \"${1:**speaker**}\" \"${2:**text**}\" \"${3:max width}\"$0" ]
},

"interactive::displayQuestion": {
  "prefix": "interactive::displayQuestion",
  "description": "Displays a question to the user...",
  "scope": "",
  "body": [ "interactive::displayQuestion \"${1:**prompt**}\" \"${2:max width}\"$0" ]
},

"interactive::displayQuestion#withdoc": {
  "prefix": "interactive::displayQuestion#withdoc",
  "description": "Displays a question to the user...",
  "scope": "",
  "body": [ "# ## interactive::displayQuestion\n# \n# Displays a question to the user.\n# \n# The text is wrapped and put inside a box like so:\n# \n# ```text\n#    ┌────────────────────────────────┐\n# ░──┤ Is this an important question? │\n#    └────────────────────────────────┘\n# ```\n# \n# - \\$1: **prompt** _as string_:\n#       the prompt to display\n# - \\$2: max width _as int_:\n#       (optional) the maximum width of text in the dialog box\n#       (defaults to GLOBAL_COLUMNS)\n# \n# ```bash\n# interactive::displayPrompt \"Do you want to continue?\"\n# ```\n# \ninteractive::displayQuestion \"${1:**prompt**}\" \"${2:max width}\"$0" ]
},

"interactive::getBestAutocompleteBox": {
  "prefix": "interactive::getBestAutocompleteBox",
  "description": "This function returns the best position and size for an autocomplete box that would open at the given position...",
  "scope": "",
  "body": [ "interactive::getBestAutocompleteBox \"${1:**current line**}\" \"${2:**current column**}\" \"${3:**desired height**}\" \"${4:**desired width**}\" \"${5:**max height**}\" \"${6:force below}\" \"${7:not on current line}\" \"${8:terminal width}\" \"${9:terminal height}\"$0" ]
},

"interactive::getBestAutocompleteBox#withdoc": {
  "prefix": "interactive::getBestAutocompleteBox#withdoc",
  "description": "This function returns the best position and size for an autocomplete box that would open at the given position...",
  "scope": "",
  "body": [ "# ## interactive::getBestAutocompleteBox\n# \n# This function returns the best position and size for an autocomplete box that would open\n# at the given position.\n# \n# - The box will be placed below the current position if possible, but can be placed\n#   above if there is not enough space below.\n# - The box will be placed on the same column as the current position if possible, but can be placed\n#   on the left side if there is not enough space on the right to display the full width of the box.\n# - The box will have the desired height and width if possible, but will be reduced if there is\n#   not enough space in the terminal.\n# - The box will not be placed on the same line as the current position if notOnCurrentLine is set to true.\n#   Otherwise it can use the current position line.\n# \n# - \\$1: **current line** _as int_:\n#       the current line of the cursor (1 based)\n# - \\$2: **current column** _as int_:\n#       the current column of the cursor (1 based)\n# - \\$3: **desired height** _as int_:\n#       the desired height of the box\n# - \\$4: **desired width** _as int_:\n#       the desired width of the box\n# - \\$5: **max height** _as int_:\n#       the maximum height of the box\n# - \\$6: force below _as bool_:\n#       (optional) force the box to be below the current position\n#       (defaults to false)\n# - \\$7: not on current line _as bool_:\n#       (optional) the box will not be placed on the same line as the current position\n#       (defaults to true)\n# - \\$8: terminal width _as int_:\n#       (optional) the width of the terminal\n#       (defaults to GLOBAL_COLUMNS)\n# - \\$9: terminal height _as int_:\n#       (optional) the height of the terminal\n#       (defaults to GLOBAL_LINES)\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the top position of the box (1 based)\n# - `RETURNED_VALUE2`: the left position of the box (1 based)\n# - `RETURNED_VALUE3`: the width of the box\n# - `RETURNED_VALUE4`: the height of the box\n# \n# ```bash\n# interactive::getBestAutocompleteBox 1 1 10 5\n# ```\n# \ninteractive::getBestAutocompleteBox \"${1:**current line**}\" \"${2:**current column**}\" \"${3:**desired height**}\" \"${4:**desired width**}\" \"${5:**max height**}\" \"${6:force below}\" \"${7:not on current line}\" \"${8:terminal width}\" \"${9:terminal height}\"$0" ]
},

"interactive::getCursorPosition": {
  "prefix": "interactive::getCursorPosition",
  "description": "Get the current cursor position...",
  "scope": "",
  "body": [ "interactive::getCursorPosition$0" ]
},

"interactive::getCursorPosition#withdoc": {
  "prefix": "interactive::getCursorPosition#withdoc",
  "description": "Get the current cursor position...",
  "scope": "",
  "body": [ "# ## interactive::getCursorPosition\n# \n# Get the current cursor position.\n# \n# Returns:\n# \n# - `GLOBAL_CURSOR_LINE`: the line number\n# - `GLOBAL_CURSOR_COLUMN`: the column number\n# \n# ```bash\n# interactive::getCursorPosition\n# ```\n# \ninteractive::getCursorPosition$0" ]
},

"interactive::getTerminalSize": {
  "prefix": "interactive::getTerminalSize",
  "description": "This function exports the terminal size...",
  "scope": "",
  "body": [ "interactive::getTerminalSize$0" ]
},

"interactive::getTerminalSize#withdoc": {
  "prefix": "interactive::getTerminalSize#withdoc",
  "description": "This function exports the terminal size...",
  "scope": "",
  "body": [ "# ## interactive::getTerminalSize\n# \n# This function exports the terminal size.\n# \n# Returns:\n# \n# - `GLOBAL_COLUMNS`: The number of columns in the terminal.\n# - `GLOBAL_LINES`: The number of lines in the terminal.\n# \n# ```bash\n# interactive::getTerminalSize\n# printf '%s\\n' \"The terminal has ⌜\\${GLOBAL_COLUMNS}⌝ columns and ⌜\\${GLOBAL_LINES}⌝ lines.\"\n# ```\n# \ninteractive::getTerminalSize$0" ]
},

"interactive::promptYesNo": {
  "prefix": "interactive::promptYesNo",
  "description": "Ask the user to yes or no...",
  "scope": "",
  "body": [ "interactive::promptYesNo \"${1:**prompt**}\" \"${2:default}\"$0" ]
},

"interactive::promptYesNo#withdoc": {
  "prefix": "interactive::promptYesNo#withdoc",
  "description": "Ask the user to yes or no...",
  "scope": "",
  "body": [ "# ## interactive::promptYesNo\n# \n# Ask the user to yes or no.\n# \n# - The user can switch between the two options with the arrow keys or space.\n# - The user can validate the choice with the enter key.\n# - The user can also validate immediately with the y or n key.\n# \n# - \\$1: **prompt** _as string_:\n#       the prompt to display\n# - \\$2: default _as bool_:\n#       (optional) the default value to select\n#       (defaults to true)\n# \n# Returns:\n# \n# - \\$?:\n#   - 0 if the user answered yes\n#   - 1 otherwise\n# - `RETURNED_VALUE`: true or false.\n# \n# ```bash\n# if interactive::promptYesNo \"Do you want to continue?\"; then echo \"Yes.\"; else echo \"No.\"; fi\n# ```\n# \ninteractive::promptYesNo \"${1:**prompt**}\" \"${2:default}\"$0" ]
},

"interactive::promptYesNoRaw": {
  "prefix": "interactive::promptYesNoRaw",
  "description": "Ask the user to yes or no...",
  "scope": "",
  "body": [ "interactive::promptYesNoRaw \"${1:default}\"$0" ]
},

"interactive::promptYesNoRaw#withdoc": {
  "prefix": "interactive::promptYesNoRaw#withdoc",
  "description": "Ask the user to yes or no...",
  "scope": "",
  "body": [ "# ## interactive::promptYesNoRaw\n# \n# Ask the user to yes or no.\n# \n# - The user can switch between the two options with the arrow keys or space.\n# - The user can validate the choice with the enter key.\n# - The user can also validate immediately with the y or n key.\n# \n# This raw version does not display the prompt or the answer.\n# \n# - \\$1: default _as bool_:\n#       (optional) the default value to select\n#       (defaults to true)\n# \n# Returns:\n# \n# - \\$?:\n#   - 0 if the user answered yes\n#   - 1 otherwise\n# - `RETURNED_VALUE`: true or false.\n# \n# ```bash\n# interactive::promptYesNoRaw \"Do you want to continue?\" && local answer=\"\\${RETURNED_VALUE}\"\n# ```\n# \ninteractive::promptYesNoRaw \"${1:default}\"$0" ]
},

"interactive::rebindKeymap": {
  "prefix": "interactive::rebindKeymap",
  "description": "Rebinds all special keys to call a given callback function...",
  "scope": "",
  "body": [ "interactive::rebindKeymap$0" ]
},

"interactive::rebindKeymap#withdoc": {
  "prefix": "interactive::rebindKeymap#withdoc",
  "description": "Rebinds all special keys to call a given callback function...",
  "scope": "",
  "body": [ "# ## interactive::rebindKeymap\n# \n# Rebinds all special keys to call a given callback function.\n# See @interactive::testWaitForKeyPress for an implementation example.\n# \n# This allows to use the `-e` option with the read command and receive events for special key press.\n# \n# Key binding is a mess because binding is based on the sequence of characters that gets\n# generated by the terminal when a key is pressed and this is not standard across all terminals.\n# We do our best here to cover most cases but it is by no mean perfect.\n# A good base documentation was <https://en.wikipedia.org/wiki/ANSI_escape_code#Terminal_input_sequences>.\n# \n# Users of this function can completely change the bindings afterward by implementing\n# the `interactiveRebindOverride` function.\n# \n# This function should be called before using interactive::waitForKeyPress.\n# \n# You can call `interactive::resetBindings` to restore the default bindings. However, this is not\n# necessary as the bindings are local to the script.\n# \n# ```bash\n# interactive::rebindKeymap\n# ```\n# \n# > `showkey -a` is a good program to see the sequence of characters sent by the terminal.\n# \ninteractive::rebindKeymap$0" ]
},

"interactive::resetBindings": {
  "prefix": "interactive::resetBindings",
  "description": "Reset the key bindings to the default ones...",
  "scope": "",
  "body": [ "interactive::resetBindings$0" ]
},

"interactive::resetBindings#withdoc": {
  "prefix": "interactive::resetBindings#withdoc",
  "description": "Reset the key bindings to the default ones...",
  "scope": "",
  "body": [ "# ## interactive::resetBindings\n# \n# Reset the key bindings to the default ones.\n# \n# ```bash\n# interactive::resetBindings\n# ```\n# \ninteractive::resetBindings$0" ]
},

"interactive::restoreInterruptTrap": {
  "prefix": "interactive::restoreInterruptTrap",
  "description": "Restore the original trap for the interrupt signal (SIGINT)...",
  "scope": "",
  "body": [ "interactive::restoreInterruptTrap$0" ]
},

"interactive::restoreInterruptTrap#withdoc": {
  "prefix": "interactive::restoreInterruptTrap#withdoc",
  "description": "Restore the original trap for the interrupt signal (SIGINT)...",
  "scope": "",
  "body": [ "# ## interactive::restoreInterruptTrap\n# \n# Restore the original trap for the interrupt signal (SIGINT).\n# To be called after interactive::setInterruptTrap.\n# \n# ```bash\n# interactive::restoreInterruptTrap\n# ```\n# \ninteractive::restoreInterruptTrap$0" ]
},

"interactive::setInterruptTrap": {
  "prefix": "interactive::setInterruptTrap",
  "description": "Set a trap to catch the interrupt signal (SIGINT)...",
  "scope": "",
  "body": [ "interactive::setInterruptTrap$0" ]
},

"interactive::setInterruptTrap#withdoc": {
  "prefix": "interactive::setInterruptTrap#withdoc",
  "description": "Set a trap to catch the interrupt signal (SIGINT)...",
  "scope": "",
  "body": [ "# ## interactive::setInterruptTrap\n# \n# Set a trap to catch the interrupt signal (SIGINT).\n# When the user presses Ctrl+C, the GLOBAL_SESSION_INTERRUPTED variable will be set to true.\n# \n# ```bash\n# interactive::setInterruptTrap\n# ```\n# \ninteractive::setInterruptTrap$0" ]
},

"interactive::startProgress": {
  "prefix": "interactive::startProgress",
  "description": "Shows a spinner / progress animation with configurable output including a progress bar...",
  "scope": "",
  "body": [ "interactive::startProgress \"${1:output template}\" \"${2:max width}\" \"${3:frame delay}\" \"${4:refresh every x frames}\" \"${5:max frames}\" \"${6:spinner}\"$0" ]
},

"interactive::startProgress#withdoc": {
  "prefix": "interactive::startProgress#withdoc",
  "description": "Shows a spinner / progress animation with configurable output including a progress bar...",
  "scope": "",
  "body": [ "# ## interactive::startProgress\n# \n# Shows a spinner / progress animation with configurable output including a progress bar.\n# \n# The animation will be displayed until interactive::stopProgress is called\n# or if the max number of frames is reached.\n# \n# Outputs to stderr.\n# This will run in the background and will not block the main thread.\n# The main thread can continue to output logs while this animation is running.\n# \n# - \\$1: output template _as string_:\n#       (optional) the template to display\n#       (defaults to VALET_CONFIG_PROGRESS_BAR_TEMPLATE=\"#spinner #percent ░#bar░ #message\")\n# - \\$2: max width _as int_:\n#       (optional) the maximum width of the progress bar\n#       (defaults to VALET_CONFIG_PROGRESS_BAR_SIZE=20)\n# - \\$3: frame delay _as float_:\n#       (optional) the time in seconds between each frame of the spinner\n#       (defaults to VALET_CONFIG_PROGRESS_ANIMATION_DELAY=0.1)\n# - \\$4: refresh every x frames _as int_:\n#       (optional) the number of frames of the spinner to wait before refreshing the progress bar\n#       (defaults to VALET_CONFIG_PROGRESS_BAR_UPDATE_INTERVAL=3)\n# - \\$5: max frames _as int_:\n#       (optional) the maximum number of frames to display\n#       (defaults to 9223372036854775807)\n# - \\$6: spinner _as string_:\n#       (optional) the spinner to display (each character is a frame)\n#       (defaults to VALET_CONFIG_SPINNER_CHARACTERS=\"⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏\")\n#       Examples:\n#       - ◐◓◑◒\n#       - ▖▘▝▗\n#       - ⣾⣽⣻⢿⡿⣟⣯⣷\n#       - ⢄⢂⢁⡁⡈⡐⡠\n#       - ◡⊙◠\n#       - ▌▀▐▄\n#       - ⠄⠆⠇⠋⠙⠸⠰⠠⠰⠸⠙⠋⠇⠆\n# \n# ```bash\n# interactive::startProgress \"#spinner\" \"\" 0.05 \"\" \"\" \"⢄⢂⢁⡁⡈⡐⡠\"\n# wait 4\n# interactive::stopProgress\n# \n# interactive::startProgress \"#spinner #percent ░#bar░ #message\" 30 0.05 1\n# IDX=0\n# while [[ \\${IDX} -le 50 ]]; do\n#   interactive::updateProgress \\$((IDX * 2)) \"Doing something \\${IDX}/50...\"\n#   IDX=\\$((IDX + 1))\n#   sleep 0.1\n# done\n# ```\n# \ninteractive::startProgress \"${1:output template}\" \"${2:max width}\" \"${3:frame delay}\" \"${4:refresh every x frames}\" \"${5:max frames}\" \"${6:spinner}\"$0" ]
},

"interactive::stopProgress": {
  "prefix": "interactive::stopProgress",
  "description": "Stop the progress bar...",
  "scope": "",
  "body": [ "interactive::stopProgress$0" ]
},

"interactive::stopProgress#withdoc": {
  "prefix": "interactive::stopProgress#withdoc",
  "description": "Stop the progress bar...",
  "scope": "",
  "body": [ "# ## interactive::stopProgress\n# \n# Stop the progress bar.\n# \n# ```bash\n# interactive::stopProgress\n# ```\n# \ninteractive::stopProgress$0" ]
},

"interactive::sttyInit": {
  "prefix": "interactive::sttyInit",
  "description": "Disable the echo of the tty...",
  "scope": "",
  "body": [ "interactive::sttyInit$0" ]
},

"interactive::sttyInit#withdoc": {
  "prefix": "interactive::sttyInit#withdoc",
  "description": "Disable the echo of the tty...",
  "scope": "",
  "body": [ "# ## interactive::sttyInit\n# \n# Disable the echo of the tty. Will no longer display the characters typed by the user.\n# \n# ```bash\n# interactive::sttyInit\n# ```\n# \ninteractive::sttyInit$0" ]
},

"interactive::sttyRestore": {
  "prefix": "interactive::sttyRestore",
  "description": "Enable the echo of the tty...",
  "scope": "",
  "body": [ "interactive::sttyRestore \"${1:**force**}\"$0" ]
},

"interactive::sttyRestore#withdoc": {
  "prefix": "interactive::sttyRestore#withdoc",
  "description": "Enable the echo of the tty...",
  "scope": "",
  "body": [ "# ## interactive::sttyRestore\n# \n# Enable the echo of the tty. Will display the characters typed by the user.\n# \n# - \\$1: **force** _as bool_:\n#       (optional) force the restoration of the stty configuration\n#       stty state will not be restored if\n#       (defaults to false)\n# \n# ```bash\n# interactive::sttyRestore\n# ```\n# shellcheck disable=SC2120\n# \ninteractive::sttyRestore \"${1:**force**}\"$0" ]
},

"interactive::switchBackFromFullScreen": {
  "prefix": "interactive::switchBackFromFullScreen",
  "description": "Call this function to switch back from the full screen mode...",
  "scope": "",
  "body": [ "interactive::switchBackFromFullScreen$0" ]
},

"interactive::switchBackFromFullScreen#withdoc": {
  "prefix": "interactive::switchBackFromFullScreen#withdoc",
  "description": "Call this function to switch back from the full screen mode...",
  "scope": "",
  "body": [ "# ## interactive::switchBackFromFullScreen\n# \n# Call this function to switch back from the full screen mode.\n# \n# - This function will restore the terminal state and show the cursor.\n# - It will also restore the key echoing.\n# - If there were error messages during the interactive session, they will be displayed at the end.\n# \n# ```bash\n# interactive::switchBackFromFullScreen\n# ```\n# \ninteractive::switchBackFromFullScreen$0" ]
},

"interactive::switchToFullScreen": {
  "prefix": "interactive::switchToFullScreen",
  "description": "Call this function to start an interactive session in full screen mode...",
  "scope": "",
  "body": [ "interactive::switchToFullScreen$0" ]
},

"interactive::switchToFullScreen#withdoc": {
  "prefix": "interactive::switchToFullScreen#withdoc",
  "description": "Call this function to start an interactive session in full screen mode...",
  "scope": "",
  "body": [ "# ## interactive::switchToFullScreen\n# \n# Call this function to start an interactive session in full screen mode.\n# This function will switch to the alternate screen, hide the cursor and clear the screen.\n# It will also disable echoing when we type something.\n# \n# You should call interactive::switchBackFromFullScreen at the end of the interactive session.\n# \n# In the alternate screen, we don't see the error messages so we capture them somewhere else.\n# \n# ```bash\n# interactive::switchToFullScreen\n# ```\n# \ninteractive::switchToFullScreen$0" ]
},

"interactive::testWaitForChar": {
  "prefix": "interactive::testWaitForChar",
  "description": "Wait for the user to send a character to stdin (i...",
  "scope": "",
  "body": [ "interactive::testWaitForChar$0" ]
},

"interactive::testWaitForChar#withdoc": {
  "prefix": "interactive::testWaitForChar#withdoc",
  "description": "Wait for the user to send a character to stdin (i...",
  "scope": "",
  "body": [ "# ## interactive::testWaitForChar\n# \n# Wait for the user to send a character to stdin (i.e. wait for a key press)\n# and prints the character that bash reads.\n# \n# Useful to test the `interactive::waitForChar` function and see the char sequence we\n# get when pressing a key in a given terminal.\n# \n# See @interactive::waitForChar for more information.\n# \n# ```bash\n# interactive::testWaitForChar\n# ```\n# \ninteractive::testWaitForChar$0" ]
},

"interactive::testWaitForKeyPress": {
  "prefix": "interactive::testWaitForKeyPress",
  "description": "Wait for the user to press a key and prints it to the screen...",
  "scope": "",
  "body": [ "interactive::testWaitForKeyPress$0" ]
},

"interactive::testWaitForKeyPress#withdoc": {
  "prefix": "interactive::testWaitForKeyPress#withdoc",
  "description": "Wait for the user to press a key and prints it to the screen...",
  "scope": "",
  "body": [ "# ## interactive::testWaitForKeyPress\n# \n# Wait for the user to press a key and prints it to the screen.\n# This function is used to test the `interactive::waitForKeyPress` function.\n# \n# See @interactive::waitForKeyPress for more information.\n# \n# ```bash\n# interactive::testWaitForKeyPress\n# ```\n# \ninteractive::testWaitForKeyPress$0" ]
},

"interactive::updateProgress": {
  "prefix": "interactive::updateProgress",
  "description": "Update the progress bar with a new percentage and message...",
  "scope": "",
  "body": [ "interactive::updateProgress \"${1:**percent**}\" \"${2:message}\"$0" ]
},

"interactive::updateProgress#withdoc": {
  "prefix": "interactive::updateProgress#withdoc",
  "description": "Update the progress bar with a new percentage and message...",
  "scope": "",
  "body": [ "# ## interactive::updateProgress\n# \n# Update the progress bar with a new percentage and message.\n# \n# The animation can be started with interactive::startProgress for more options.\n# The animation will stop if the updated percentage is 100.\n# \n# - \\$1: **percent** _as int_:\n#       the percentage of the progress bar (0 to 100)\n# - \\$2: message _as string_:\n#       (optional) the message to display\n# \n# ```bash\n# interactive::updateProgress 50 \"Doing something...\"\n# ```\n# \ninteractive::updateProgress \"${1:**percent**}\" \"${2:message}\"$0" ]
},

"interactive::waitForChar": {
  "prefix": "interactive::waitForChar",
  "description": "Wait for a user input (single char)...",
  "scope": "",
  "body": [ "interactive::waitForChar \"${99:**read parameters**}\"$0" ]
},

"interactive::waitForChar#withdoc": {
  "prefix": "interactive::waitForChar#withdoc",
  "description": "Wait for a user input (single char)...",
  "scope": "",
  "body": [ "# ## interactive::waitForChar\n# \n# Wait for a user input (single char).\n# You can pass additional parameters to the read command (e.g. to wait for a set amount of time).\n# \n# It uses the read builtin command. This will not detect all key combinations.\n# The output will depend on the terminal used and the character sequences it sends on each key press.\n# \n# For more advanced use cases, you can use interactive::waitForKeyPress.\n# This simple implementation does not rely on GNU readline and does not require stty to be initialized.\n# \n# Some special keys are translated into more readable strings:\n# UP, DOWN, RIGHT, LEFT, BACKSPACE, DEL, PAGE_UP, PAGE_DOWN, HOME, END, ESC, F1-F12, ALT+...\n# \n# - \\$@: **read parameters** _as any_:\n#       additional parameters to pass to the read command\n# \n# Returns:\n# \n# - \\$?:\n#   - 0 if a char was retrieved\n#   - 1 otherwise\n# - `LAST_KEY_PRESSED`: the last char (key) retrieved.\n# \n# ```bash\n# interactive::waitForChar\n# interactive::waitForChar -t 0.1\n# ```\n# \n# > <https://en.wikipedia.org/wiki/ANSI_escape_code#Terminal_input_sequences>\n# \ninteractive::waitForChar \"${99:**read parameters**}\"$0" ]
},

"interactive::waitForKeyPress": {
  "prefix": "interactive::waitForKeyPress",
  "description": "Wait for a key press (single key)...",
  "scope": "",
  "body": [ "interactive::waitForKeyPress \"${99:**read parameters**}\"$0" ]
},

"interactive::waitForKeyPress#withdoc": {
  "prefix": "interactive::waitForKeyPress#withdoc",
  "description": "Wait for a key press (single key)...",
  "scope": "",
  "body": [ "# ## interactive::waitForKeyPress\n# \n# Wait for a key press (single key).\n# You can pass additional parameters to the read command (e.g. to wait for a set amount of time).\n# \n# It uses the read builtin command with the option `-e` to use readline behind the scene.\n# This means we can detect more key combinations but all keys needs to be bound first...\n# Special keys (CTRL+, ALT+, F1-F12, arrows, etc.) are intercepted using binding.\n# \n# You must call `interactive::rebindKeymap` and `interactive::sttyInit` before using this function.\n# \n# - \\$@: **read parameters** _as any_:\n#       additional parameters to pass to the read command\n# \n# Returns:\n# \n# - \\$?:\n#   - 0 if a key was pressed\n#   - 1 otherwise\n# - `LAST_KEY_PRESSED`: the key pressed.\n# \n# ```bash\n# interactive::waitForKeyPress\n# interactive::waitForKeyPress -t 0.1\n# ```\n# \n# > Due to a bug in bash, if the cursor is at the end of the screen, it will make the screen scroll\n# > even when nothing is read... Make sure to not position the cursor at the end of the screen.\n# \ninteractive::waitForKeyPress \"${99:**read parameters**}\"$0" ]
},

"io::cat": {
  "prefix": "io::cat",
  "description": "Print the content of a file to stdout...",
  "scope": "",
  "body": [ "io::cat \"${1:**path**}\"$0" ]
},

"io::cat#withdoc": {
  "prefix": "io::cat#withdoc",
  "description": "Print the content of a file to stdout...",
  "scope": "",
  "body": [ "# ## io::cat\n# \n# Print the content of a file to stdout.\n# This is a pure bash equivalent of cat.\n# \n# - \\$1: **path** _as string_:\n#       the file to print\n# \n# ```bash\n# io::cat \"myFile\"\n# ```\n# \n# > Also see log::printFile if you want to print a file for a user.\n# \nio::cat \"${1:**path**}\"$0" ]
},

"io::checkAndFail": {
  "prefix": "io::checkAndFail",
  "description": "Check last return code and fail (exit) if it is an error...",
  "scope": "",
  "body": [ "io::checkAndFail \"${1:**exit code**}\" \"${99:**message**}\"$0" ]
},

"io::checkAndFail#withdoc": {
  "prefix": "io::checkAndFail#withdoc",
  "description": "Check last return code and fail (exit) if it is an error...",
  "scope": "",
  "body": [ "# ## io::checkAndFail\n# \n# Check last return code and fail (exit) if it is an error.\n# \n# - \\$1: **exit code** _as int_:\n#       the return code\n# - \\$@: **message** _as string_:\n#       the error message to display in case of error\n# \n# ```bash\n# command_that_could_fail || io::checkAndFail \"\\$?\" \"The command that could fail has failed!\"\n# ```\n# \nio::checkAndFail \"${1:**exit code**}\" \"${99:**message**}\"$0" ]
},

"io::checkAndWarn": {
  "prefix": "io::checkAndWarn",
  "description": "Check last return code and warn the user in case the return code is not 0...",
  "scope": "",
  "body": [ "io::checkAndWarn \"${1:**exit code**}\" \"${99:**message**}\"$0" ]
},

"io::checkAndWarn#withdoc": {
  "prefix": "io::checkAndWarn#withdoc",
  "description": "Check last return code and warn the user in case the return code is not 0...",
  "scope": "",
  "body": [ "# ## io::checkAndWarn\n# \n# Check last return code and warn the user in case the return code is not 0.\n# \n# - \\$1: **exit code** _as int_:\n#       the last return code\n# - \\$@: **message** _as string_:\n#       the warning message to display in case of error\n# \n# ```bash\n# command_that_could_fail || io::checkAndWarn \"\\$?\" \"The command that could fail has failed!\"\n# ```\n# \nio::checkAndWarn \"${1:**exit code**}\" \"${99:**message**}\"$0" ]
},

"io::cleanupTempFiles": {
  "prefix": "io::cleanupTempFiles",
  "description": "Removes all the temporary files and directories that were created by the io::createTempFile and io::createTempDirectory functions...",
  "scope": "",
  "body": [ "io::cleanupTempFiles$0" ]
},

"io::cleanupTempFiles#withdoc": {
  "prefix": "io::cleanupTempFiles#withdoc",
  "description": "Removes all the temporary files and directories that were created by the io::createTempFile and io::createTempDirectory functions...",
  "scope": "",
  "body": [ "# ## io::cleanupTempFiles\n# \n# Removes all the temporary files and directories that were created by the\n# io::createTempFile and io::createTempDirectory functions.\n# \n# ```bash\n# io::cleanupTempFiles\n# ```\n# shellcheck disable=SC2016\n# \nio::cleanupTempFiles$0" ]
},

"io::convertFromWindowsPath": {
  "prefix": "io::convertFromWindowsPath",
  "description": "Convert a Windows path to a unix path...",
  "scope": "",
  "body": [ "io::convertFromWindowsPath \"${1:**path**}\"$0" ]
},

"io::convertFromWindowsPath#withdoc": {
  "prefix": "io::convertFromWindowsPath#withdoc",
  "description": "Convert a Windows path to a unix path...",
  "scope": "",
  "body": [ "# ## io::convertFromWindowsPath\n# \n# Convert a Windows path to a unix path.\n# \n# - \\$1: **path** _as string_:\n#       the path to convert\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The unix path.\n# \n# ```bash\n# io::convertFromWindowsPath \"C:\\path\\to\\file\"\n# ```\n# \n# > Handles paths starting with `X:\\`.\n# \nio::convertFromWindowsPath \"${1:**path**}\"$0" ]
},

"io::convertToWindowsPath": {
  "prefix": "io::convertToWindowsPath",
  "description": "Convert a unix path to a Windows path...",
  "scope": "",
  "body": [ "io::convertToWindowsPath \"${1:**path**}\"$0" ]
},

"io::convertToWindowsPath#withdoc": {
  "prefix": "io::convertToWindowsPath#withdoc",
  "description": "Convert a unix path to a Windows path...",
  "scope": "",
  "body": [ "# ## io::convertToWindowsPath\n# \n# Convert a unix path to a Windows path.\n# \n# - \\$1: **path** _as string_:\n#       the path to convert\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The Windows path.\n# \n# ```bash\n# io::convertToWindowsPath \"/path/to/file\"\n# ```\n# \n# > Handles paths starting with `/mnt/x/` or `/x/`.\n# \nio::convertToWindowsPath \"${1:**path**}\"$0" ]
},

"io::countArgs": {
  "prefix": "io::countArgs",
  "description": "Returns the number of arguments passed...",
  "scope": "",
  "body": [ "io::countArgs \"${99:**arguments**}\"$0" ]
},

"io::countArgs#withdoc": {
  "prefix": "io::countArgs#withdoc",
  "description": "Returns the number of arguments passed...",
  "scope": "",
  "body": [ "# ## io::countArgs\n# \n# Returns the number of arguments passed.\n# \n# A convenient function that can be used to:\n# \n# - count the files/directories in a directory\n#   `io::countArgs \"\\${PWD}\"/* && local numberOfFiles=\"\\${RETURNED_VALUE}\"`\n# - count the number of variables starting with VALET_\n#   `io::countArgs \"\\${!VALET_@}\" && local numberOfVariables=\"\\${RETURNED_VALUE}\"`\n# \n# - \\$@: **arguments** _as any_:\n#       the arguments to count\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The number of arguments passed.\n# \n# ```bash\n# io::countArgs 1 2 3\n# ```\n# \nio::countArgs \"${99:**arguments**}\"$0" ]
},

"io::createDirectoryIfNeeded": {
  "prefix": "io::createDirectoryIfNeeded",
  "description": "Create the directory tree if needed...",
  "scope": "",
  "body": [ "io::createDirectoryIfNeeded \"${1:**path**}\"$0" ]
},

"io::createDirectoryIfNeeded#withdoc": {
  "prefix": "io::createDirectoryIfNeeded#withdoc",
  "description": "Create the directory tree if needed...",
  "scope": "",
  "body": [ "# ## io::createDirectoryIfNeeded\n# \n# Create the directory tree if needed.\n# \n# - \\$1: **path** _as string_:\n#       The directory path to create.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The absolute path to the directory.\n# \n# ```bash\n# io::createDirectoryIfNeeded \"/my/directory\"\n# ```\n# \nio::createDirectoryIfNeeded \"${1:**path**}\"$0" ]
},

"io::createFilePathIfNeeded": {
  "prefix": "io::createFilePathIfNeeded",
  "description": "Make sure that the given file path exists...",
  "scope": "",
  "body": [ "io::createFilePathIfNeeded \"${1:**path**}\"$0" ]
},

"io::createFilePathIfNeeded#withdoc": {
  "prefix": "io::createFilePathIfNeeded#withdoc",
  "description": "Make sure that the given file path exists...",
  "scope": "",
  "body": [ "# ## io::createFilePathIfNeeded\n# \n# Make sure that the given file path exists.\n# Create the directory tree and the file if needed.\n# \n# - \\$1: **path** _as string_:\n#       the file path to create\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The absolute path of the file.\n# \n# ```bash\n# io::createFilePathIfNeeded \"myFile\"\n# ```\n# \nio::createFilePathIfNeeded \"${1:**path**}\"$0" ]
},

"io::createLink": {
  "prefix": "io::createLink",
  "description": "Create a soft or hard link (original ← link)...",
  "scope": "",
  "body": [ "io::createLink \"${1:**linked path**}\" \"${2:**link path**}\" \"${3:hard link}\" \"${4:force}\"$0" ]
},

"io::createLink#withdoc": {
  "prefix": "io::createLink#withdoc",
  "description": "Create a soft or hard link (original ← link)...",
  "scope": "",
  "body": [ "# ## io::createLink\n# \n# Create a soft or hard link (original ← link).\n# \n# Reminder:\n# \n# - A soft (symbolic) link is a new file that contains a reference to another file or directory in the\n#   form of an absolute or relative path.\n# - A hard link is a directory entry that associates a new pathname with an existing\n#   file (inode + data block) on a file system.\n# \n# This function allows to create a symbolic link on Windows as well as on Unix.\n# \n# - \\$1: **linked path** _as string_:\n#       the path to link to (the original file)\n# - \\$2: **link path** _as string_:\n#       the path where to create the link\n# - \\$3: hard link _as boolean_:\n#       (optional) true to create a hard link, false to create a symbolic link\n#       (defaults to false)\n# - \\$4: force _as boolean_:\n#       (optional) true to overwrite the link or file if it already exists.\n#       Otherwise, the function will fail on an existing link.\n#       (defaults to true)\n# \n# ```bash\n# io::createLink \"/path/to/link\" \"/path/to/linked\"\n# io::createLink \"/path/to/link\" \"/path/to/linked\" true\n# ```\n# \n# > On unix, the function uses the `ln` command.\n# > On Windows, the function uses `powershell` (and optionally ls to check the existing link).\n# \nio::createLink \"${1:**linked path**}\" \"${2:**link path**}\" \"${3:hard link}\" \"${4:force}\"$0" ]
},

"io::createTempDirectory": {
  "prefix": "io::createTempDirectory",
  "description": "Creates a temporary directory...",
  "scope": "",
  "body": [ "io::createTempDirectory$0" ]
},

"io::createTempDirectory#withdoc": {
  "prefix": "io::createTempDirectory#withdoc",
  "description": "Creates a temporary directory...",
  "scope": "",
  "body": [ "# ## io::createTempDirectory\n# \n# Creates a temporary directory.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The created path.\n# \n# ```bash\n# io::createTempDirectory\n# local directory=\"\\${RETURNED_VALUE}\"\n# ```\n# \n# > Directories created this way are automatically cleaned up by the io::cleanupTempFiles\n# > function when valet ends.\n# \nio::createTempDirectory$0" ]
},

"io::createTempFile": {
  "prefix": "io::createTempFile",
  "description": "Creates a temporary file and return its path...",
  "scope": "",
  "body": [ "io::createTempFile$0" ]
},

"io::createTempFile#withdoc": {
  "prefix": "io::createTempFile#withdoc",
  "description": "Creates a temporary file and return its path...",
  "scope": "",
  "body": [ "# ## io::createTempFile\n# \n# Creates a temporary file and return its path.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The created path.\n# \n# ```bash\n# io::createTempFile\n# local file=\"\\${RETURNED_VALUE}\"\n# ```\n# \n# > Files created this way are automatically cleaned up by the io::cleanupTempFiles\n# > function when valet ends.\n# \nio::createTempFile$0" ]
},

"io::invoke": {
  "prefix": "io::invoke",
  "description": "This function call an executable and its arguments...",
  "scope": "",
  "body": [ "io::invoke \"${1:**executable**}\" \"${99:**arguments**}\"$0" ]
},

"io::invoke#withdoc": {
  "prefix": "io::invoke#withdoc",
  "description": "This function call an executable and its arguments...",
  "scope": "",
  "body": [ "# ## io::invoke\n# \n# This function call an executable and its arguments.\n# If the execution fails, it will fail the script and show the std/err output.\n# Otherwise it hides both streams, effectively rendering the execution silent unless it fails.\n# \n# It redirects the stdout and stderr to environment variables.\n# Equivalent to io::invoke5 true 0 '' '' \"\\${@}\"\n# \n# - \\$1: **executable** _as string_:\n#       the executable or command\n# - \\$@: **arguments** _as any_:\n#       the command and its arguments\n# \n# Returns:\n# \n# - \\$?: The exit code of the executable.\n# - `RETURNED_VALUE`: The content of stdout.\n# - `RETURNED_VALUE2`: The content of stderr.\n# \n# ```bash\n# io::invoke git add --all\n# ```\n# \n# > See io::invokef5 for more information.\n# \nio::invoke \"${1:**executable**}\" \"${99:**arguments**}\"$0" ]
},

"io::invoke2": {
  "prefix": "io::invoke2",
  "description": "This function call an executable and its arguments...",
  "scope": "",
  "body": [ "io::invoke2 \"${1:**fail**}\" \"${2:**executable**}\" \"${99:**arguments**}\"$0" ]
},

"io::invoke2#withdoc": {
  "prefix": "io::invoke2#withdoc",
  "description": "This function call an executable and its arguments...",
  "scope": "",
  "body": [ "# ## io::invoke2\n# \n# This function call an executable and its arguments.\n# It redirects the stdout and stderr to environment variables.\n# Equivalent to io::invoke5 \"\\${1}\" 0 \"\" \"\" \"\\${@:2}\"\n# \n# - \\$1: **fail** _as bool_:\n#       true/false to indicate if the function should fail in case the execution fails.\n#       If true and the execution fails, the script will exit.\n# - \\$2: **executable** _as string_:\n#       the executable or function to execute\n# - \\$@: **arguments** _as any_:\n#       the arguments to pass to the executable\n# \n# Returns:\n# \n# - \\$?: The exit code of the executable.\n# - `RETURNED_VALUE`: The content of stdout.\n# - `RETURNED_VALUE2`: The content of stderr.\n# \n# ```bash\n# io::invokef2 false git status || core::fail \"status failed.\"\n# stdout=\"\\${RETURNED_VALUE}\"\n# stderr=\"\\${RETURNED_VALUE2}\"\n# ```\n# \n# > See io::invokef5 for more information.\n# \nio::invoke2 \"${1:**fail**}\" \"${2:**executable**}\" \"${99:**arguments**}\"$0" ]
},

"io::invoke2piped": {
  "prefix": "io::invoke2piped",
  "description": "This function call an executable and its arguments and input a given string as stdin...",
  "scope": "",
  "body": [ "io::invoke2piped \"${1:**fail**}\" \"${2:**stdin**}\" \"${3:**executable**}\" \"${99:**arguments**}\"$0" ]
},

"io::invoke2piped#withdoc": {
  "prefix": "io::invoke2piped#withdoc",
  "description": "This function call an executable and its arguments and input a given string as stdin...",
  "scope": "",
  "body": [ "# ## io::invoke2piped\n# \n# This function call an executable and its arguments and input a given string as stdin.\n# It redirects the stdout and stderr to environment variables.\n# Equivalent to io::invoke5 \"\\${1}\" 0 false \"\\${2}\" \"\\${@:3}\"\n# \n# - \\$1: **fail** _as bool_:\n#       true/false to indicate if the function should fail in case the execution fails.\n#       If true and the execution fails, the script will exit.\n# - \\$2: **stdin** _as string_:\n#       the stdin to pass to the executable\n# - \\$3: **executable** _as string_:\n#       the executable or function to execute\n# - \\$@: **arguments** _as any_:\n#       the arguments to pass to the executable\n# \n# Returns:\n# \n# - \\$?: The exit code of the executable.\n# - `RETURNED_VALUE`: The content of stdout.\n# - `RETURNED_VALUE2`: The content of stderr.\n# \n# ```bash\n# io::invoke2piped true \"key: val\" yq -o json -p yaml -\n# stdout=\"\\${RETURNED_VALUE}\"\n# stderr=\"\\${RETURNED_VALUE2}\"\n# ```\n# \n# > This is the equivalent of:\n# > `myvar=\"\\$(printf '%s\\n' \"mystring\" | mycommand)\"`\n# > But without using a subshell.\n# >\n# > See io::invokef5 for more information.\n# \nio::invoke2piped \"${1:**fail**}\" \"${2:**stdin**}\" \"${3:**executable**}\" \"${99:**arguments**}\"$0" ]
},

"io::invoke5": {
  "prefix": "io::invoke5",
  "description": "This function call an executable and its arguments...",
  "scope": "",
  "body": [ "io::invoke5 \"${1:**fail**}\" \"${2:**acceptable codes**}\" \"${3:**stdin from file**}\" \"${4:**stdin**}\" \"${5:**executable**}\" \"${99:**arguments**}\"$0" ]
},

"io::invoke5#withdoc": {
  "prefix": "io::invoke5#withdoc",
  "description": "This function call an executable and its arguments...",
  "scope": "",
  "body": [ "# ## io::invoke5\n# \n# This function call an executable and its arguments.\n# It redirects the stdout and stderr to environment variables.\n# It calls invoke5 and reads the files to set the environment variables.\n# \n# - \\$1: **fail** _as bool_:\n#       true/false to indicate if the function should fail in case the execution fails.\n#       If true and the execution fails, the script will exit.\n# - \\$2: **acceptable codes** _as string_:\n#       the acceptable error codes, comma separated\n#       (if the error code is matched, then set the output error code to 0)\n# - \\$3: **stdin from file** _as bool_:\n#       true/false to indicate if the 4th argument represents a file path or directly the content for stdin\n# - \\$4: **stdin** _as string_:\n#       the stdin (can be empty)\n# - \\$5: **executable** _as string_:\n#       the executable or function to execute\n# - \\$@: **arguments** _as any_:\n#       the arguments to pass to the executable\n# \n# Returns:\n# \n# - \\$?: The exit code of the executable.\n# - `RETURNED_VALUE`: The content of stdout.\n# - `RETURNED_VALUE2`: The content of stderr.\n# \n# ```bash\n# io::invoke5 \"false\" \"130,2\" \"false\" \"This is the stdin\" \"stuff\" \"--height=10\" || core::fail \"stuff failed.\"\n# stdout=\"\\${RETURNED_VALUE}\"\n# stderr=\"\\${RETURNED_VALUE2}\"\n# ```\n# \n# > See io::invokef5 for more information.\n# \nio::invoke5 \"${1:**fail**}\" \"${2:**acceptable codes**}\" \"${3:**stdin from file**}\" \"${4:**stdin**}\" \"${5:**executable**}\" \"${99:**arguments**}\"$0" ]
},

"io::invokef2": {
  "prefix": "io::invokef2",
  "description": "This function call an executable and its arguments...",
  "scope": "",
  "body": [ "io::invokef2 \"${1:**fail**}\" \"${2:**executable**}\" \"${99:**arguments**}\"$0" ]
},

"io::invokef2#withdoc": {
  "prefix": "io::invokef2#withdoc",
  "description": "This function call an executable and its arguments...",
  "scope": "",
  "body": [ "# ## io::invokef2\n# \n# This function call an executable and its arguments.\n# It redirects the stdout and stderr to temporary files.\n# Equivalent to io::invokef5 \"\\${1}\" 0 \"\" \"\" \"\\${@:2}\"\n# \n# - \\$1: **fail** _as bool_:\n#       true/false to indicate if the function should fail in case the execution fails.\n#       If true and the execution fails, the script will exit.\n# - \\$2: **executable** _as string_:\n#       the executable or function to execute\n# - \\$@: **arguments** _as any_:\n#       the arguments to pass to the executable\n# \n# Returns:\n# \n# - \\$?: The exit code of the executable.\n# - `RETURNED_VALUE`: The file path containing the stdout of the executable.\n# - `RETURNED_VALUE2`: The file path containing the stderr of the executable.\n# \n# ```bash\n# io::invokef2 false git status || core::fail \"status failed.\"\n# stdoutFilePath=\"\\${RETURNED_VALUE}\"\n# stderrFilePath=\"\\${RETURNED_VALUE2}\"\n# ```\n# \n# > See io::invokef5 for more information.\n# \nio::invokef2 \"${1:**fail**}\" \"${2:**executable**}\" \"${99:**arguments**}\"$0" ]
},

"io::invokef2piped": {
  "prefix": "io::invokef2piped",
  "description": "This function call an executable and its arguments and input a given string as stdin...",
  "scope": "",
  "body": [ "io::invokef2piped \"${1:**fail**}\" \"${2:**stdin**}\" \"${3:**executable**}\" \"${99:**arguments**}\"$0" ]
},

"io::invokef2piped#withdoc": {
  "prefix": "io::invokef2piped#withdoc",
  "description": "This function call an executable and its arguments and input a given string as stdin...",
  "scope": "",
  "body": [ "# ## io::invokef2piped\n# \n# This function call an executable and its arguments and input a given string as stdin.\n# It redirects the stdout and stderr to temporary files.\n# Equivalent to io::invokef5 \"\\${1}\" 0 false \"\\${2}\" \"\\${@:3}\"\n# \n# - \\$1: **fail** _as bool_:\n#       true/false to indicate if the function should fail in case the execution fails.\n#       If true and the execution fails, the script will exit.\n# - \\$2: **stdin** _as string_:\n#       the stdin to pass to the executable\n# - \\$3: **executable** _as string_:\n#       the executable or function to execute\n# - \\$@: **arguments** _as any_:\n#       the arguments to pass to the executable\n# \n# Returns:\n# \n# - \\$?: The exit code of the executable.\n# - `RETURNED_VALUE`: The file path containing the stdout of the executable.\n# - `RETURNED_VALUE2`: The file path containing the stderr of the executable.\n# \n# ```bash\n# io::invokef2piped true \"key: val\" yq -o json -p yaml -\n# stdoutFilePath=\"\\${RETURNED_VALUE}\"\n# stderrFilePath=\"\\${RETURNED_VALUE2}\"\n# ```\n# \n# > This is the equivalent of:\n# > `myvar=\"\\$(printf '%s\\n' \"mystring\" | mycommand)\"`\n# > But without using a subshell.\n# >\n# > See io::invokef5 for more information.\n# \nio::invokef2piped \"${1:**fail**}\" \"${2:**stdin**}\" \"${3:**executable**}\" \"${99:**arguments**}\"$0" ]
},

"io::invokef5": {
  "prefix": "io::invokef5",
  "description": "This function call an executable and its arguments...",
  "scope": "",
  "body": [ "io::invokef5 \"${1:**fail**}\" \"${2:**acceptable codes**}\" \"${3:**sdtin from file**}\" \"${4:**sdtin**}\" \"${5:**executable**}\" \"${99:**arguments**}\"$0" ]
},

"io::invokef5#withdoc": {
  "prefix": "io::invokef5#withdoc",
  "description": "This function call an executable and its arguments...",
  "scope": "",
  "body": [ "# ## io::invokef5\n# \n# This function call an executable and its arguments.\n# It redirects the stdout and stderr to temporary files.\n# \n# - \\$1: **fail** _as bool_:\n#       true/false to indicate if the function should fail in case the execution fails.\n#                      If true and the execution fails, the script will exit.\n# - \\$2: **acceptable codes** _as string_:\n#       the acceptable error codes, comma separated\n#         (if the error code is matched, then set the output error code to 0)\n# - \\$3: **sdtin from file** _as bool_:\n#       true/false to indicate if the 4th argument represents a file path or directly the content for stdin\n# - \\$4: **sdtin** _as string_:\n#       the stdin (can be empty)\n# - \\$5: **executable** _as string_:\n#       the executable or function to execute\n# - \\$@: **arguments** _as any_:\n#       the arguments to pass to the executable\n# \n# Returns:\n# \n# - \\$?: The exit code of the executable.\n# - `RETURNED_VALUE`: The file path containing the stdout of the executable.\n# - `RETURNED_VALUE2`: The file path containing the stderr of the executable.\n# \n# ```bash\n# io::invokef5 \"false\" \"130,2\" \"false\" \"This is the stdin\" \"stuff\" \"--height=10\" || core::fail \"stuff failed.\"\n# stdoutFilePath=\"\\${RETURNED_VALUE}\"\n# stderrFilePath=\"\\${RETURNED_VALUE2}\"\n# ```\n# \n# > - In windows, this is tremendously faster to do (or any other invoke flavor):\n# >   `io::invokef5 false 0 false '' mycommand && myvar=\"\\${RETURNED_VALUE}\"`\n# >   than doing:\n# >   `myvar=\"\\$(mycommand)\".`\n# > - On linux, it is slightly faster (but it might be slower if you don't have SSD?).\n# > - On linux, you can use a tmpfs directory for massive gains over subshells.\n# \nio::invokef5 \"${1:**fail**}\" \"${2:**acceptable codes**}\" \"${3:**sdtin from file**}\" \"${4:**sdtin**}\" \"${5:**executable**}\" \"${99:**arguments**}\"$0" ]
},

"io::isDirectoryWritable": {
  "prefix": "io::isDirectoryWritable",
  "description": "Check if the directory is writable...",
  "scope": "",
  "body": [ "io::isDirectoryWritable \"${1:**directory**}\" \"${2:test file name}\"$0" ]
},

"io::isDirectoryWritable#withdoc": {
  "prefix": "io::isDirectoryWritable#withdoc",
  "description": "Check if the directory is writable...",
  "scope": "",
  "body": [ "# ## io::isDirectoryWritable\n# \n# Check if the directory is writable. Creates the directory if it does not exist.\n# \n# - \\$1: **directory** _as string_:\n#       the directory to check\n# - \\$2: test file name _as string_:\n#       (optional) the name of the file to create in the directory to test the write access\n# \n# Returns:\n# \n# - \\$?:\n#   - 0 if the directory is writable\n#   - 1 otherwise\n# \n# ```bash\n# if io::isDirectoryWritable \"/path/to/directory\"; then\n#   echo \"The directory is writable.\"\n# fi\n# ```\n# \nio::isDirectoryWritable \"${1:**directory**}\" \"${2:test file name}\"$0" ]
},

"io::listDirectories": {
  "prefix": "io::listDirectories",
  "description": "List all the directories in the given directory...",
  "scope": "",
  "body": [ "io::listDirectories \"${1:**directory**}\" \"${2:recursive}\" \"${3:hidden}\" \"${4:directory filter function name}\"$0" ]
},

"io::listDirectories#withdoc": {
  "prefix": "io::listDirectories#withdoc",
  "description": "List all the directories in the given directory...",
  "scope": "",
  "body": [ "# ## io::listDirectories\n# \n# List all the directories in the given directory.\n# \n# - \\$1: **directory** _as string_:\n#       the directory to list\n# - \\$2: recursive _as bool_:\n#       (optional) true to list recursively, false otherwise\n#       (defaults to false)\n# - \\$3: hidden _as bool_:\n#       (optional) true to list hidden paths, false otherwise\n#       (defaults to false)\n# - \\$4: directory filter function name _as string_:\n#       (optional) a function name that is called to filter the sub directories (for recursive listing)\n#       The function should return 0 if the path is to be kept, 1 otherwise.\n#       The function is called with the path as the first argument.\n#       (defaults to empty string, no filter)\n# \n# Returns:\n# \n# - `RETURNED_ARRAY`: An array with the list of all the files.\n# \n# ```bash\n# io::listDirectories \"/path/to/directory\" true true myFilterFunction\n# for path in \"\\${RETURNED_ARRAY[@]}\"; do\n#   printf '%s' \"\\${path}\"\n# done\n# ```\n# \nio::listDirectories \"${1:**directory**}\" \"${2:recursive}\" \"${3:hidden}\" \"${4:directory filter function name}\"$0" ]
},

"io::listFiles": {
  "prefix": "io::listFiles",
  "description": "List all the files in the given directory...",
  "scope": "",
  "body": [ "io::listFiles \"${1:**directory**}\" \"${2:recursive}\" \"${3:hidden}\" \"${4:directory filter function name}\"$0" ]
},

"io::listFiles#withdoc": {
  "prefix": "io::listFiles#withdoc",
  "description": "List all the files in the given directory...",
  "scope": "",
  "body": [ "# ## io::listFiles\n# \n# List all the files in the given directory.\n# \n# - \\$1: **directory** _as string_:\n#       the directory to list\n# - \\$2: recursive _as bool_:\n#       (optional) true to list recursively, false otherwise\n#       (defaults to false)\n# - \\$3: hidden _as bool_:\n#       (optional) true to list hidden paths, false otherwise\n#       (defaults to false)\n# - \\$4: directory filter function name _as string_:\n#       (optional) a function name that is called to filter the directories (for recursive listing)\n#       The function should return 0 if the path is to be kept, 1 otherwise.\n#       The function is called with the path as the first argument.\n#       (defaults to empty string, no filter)\n# \n# Returns:\n# \n# - `RETURNED_ARRAY`: An array with the list of all the files.\n# \n# ```bash\n# io::listFiles \"/path/to/directory\" true true myFilterFunction\n# for path in \"\\${RETURNED_ARRAY[@]}\"; do\n#   printf '%s' \"\\${path}\"\n# done\n# ```\n# \nio::listFiles \"${1:**directory**}\" \"${2:recursive}\" \"${3:hidden}\" \"${4:directory filter function name}\"$0" ]
},

"io::listPaths": {
  "prefix": "io::listPaths",
  "description": "List all the paths in the given directory...",
  "scope": "",
  "body": [ "io::listPaths \"${1:**directory**}\" \"${2:recursive}\" \"${3:hidden}\" \"${4:path filter function name}\" \"${5:directory filter function name}\"$0" ]
},

"io::listPaths#withdoc": {
  "prefix": "io::listPaths#withdoc",
  "description": "List all the paths in the given directory...",
  "scope": "",
  "body": [ "# ## io::listPaths\n# \n# List all the paths in the given directory.\n# \n# - \\$1: **directory** _as string_:\n#       the directory to list\n# - \\$2: recursive _as bool_:\n#       (optional) true to list recursively, false otherwise\n#       (defaults to false)\n# - \\$3: hidden _as bool_:\n#       (optional) true to list hidden paths, false otherwise\n#       (defaults to false)\n# - \\$4: path filter function name _as string_:\n#       (optional) a function name that is called to filter the paths that will be listed\n#       The function should return 0 if the path is to be kept, 1 otherwise.\n#       The function is called with the path as the first argument.\n#       (defaults to empty string, no filter)\n# - \\$5: directory filter function name _as string_:\n#       (optional) a function name that is called to filter the directories (for recursive listing)\n#       The function should return 0 if the path is to be kept, 1 otherwise.\n#       The function is called with the path as the first argument.\n#       (defaults to empty string, no filter)\n# \n# Returns:\n# \n# - `RETURNED_ARRAY`: An array with the list of all the paths.\n# \n# ```bash\n# io::listPaths \"/path/to/directory\" true true myFilterFunction myFilterDirectoryFunction\n# for path in \"\\${RETURNED_ARRAY[@]}\"; do\n#   printf '%s' \"\\${path}\"\n# done\n# ```\n# \n# > - It will correctly list files under symbolic link directories.\n# \nio::listPaths \"${1:**directory**}\" \"${2:recursive}\" \"${3:hidden}\" \"${4:path filter function name}\" \"${5:directory filter function name}\"$0" ]
},

"io::readFile": {
  "prefix": "io::readFile",
  "description": "Reads the content of a file and returns it in the global variable RETURNED_VALUE...",
  "scope": "",
  "body": [ "io::readFile \"${1:**path**}\" \"${2:max char}\"$0" ]
},

"io::readFile#withdoc": {
  "prefix": "io::readFile#withdoc",
  "description": "Reads the content of a file and returns it in the global variable RETURNED_VALUE...",
  "scope": "",
  "body": [ "# ## io::readFile\n# \n# Reads the content of a file and returns it in the global variable RETURNED_VALUE.\n# Uses pure bash.\n# \n# - \\$1: **path** _as string_:\n#       the file path to read\n# - \\$2: max char _as int_:\n#       (optional) the maximum number of characters to read\n#       (defaults to 0, which means read the whole file)\n# \n# > If the file does not exist, the function will return an empty string instead of failing.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The content of the file.\n# \n# ```bash\n# io::readFile \"/path/to/file\" && local fileContent=\"\\${RETURNED_VALUE}\"\n# io::readFile \"/path/to/file\" 500 && local fileContent=\"\\${RETURNED_VALUE}\"\n# ```\n# \nio::readFile \"${1:**path**}\" \"${2:max char}\"$0" ]
},

"io::readStdIn": {
  "prefix": "io::readStdIn",
  "description": "Read the content of the standard input...",
  "scope": "",
  "body": [ "io::readStdIn$0" ]
},

"io::readStdIn#withdoc": {
  "prefix": "io::readStdIn#withdoc",
  "description": "Read the content of the standard input...",
  "scope": "",
  "body": [ "# ## io::readStdIn\n# \n# Read the content of the standard input.\n# Will immediately return if the standard input is empty.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The content of the standard input.\n# \n# ```bash\n# io::readStdIn && local stdIn=\"\\${RETURNED_VALUE}\"\n# ```\n# \nio::readStdIn$0" ]
},

"io::sleep": {
  "prefix": "io::sleep",
  "description": "Sleep for the given amount of time...",
  "scope": "",
  "body": [ "io::sleep \"${1:**time**}\"$0" ]
},

"io::sleep#withdoc": {
  "prefix": "io::sleep#withdoc",
  "description": "Sleep for the given amount of time...",
  "scope": "",
  "body": [ "# ## io::sleep\n# \n# Sleep for the given amount of time.\n# This is a pure bash replacement of sleep.\n# \n# - \\$1: **time** _as float_:\n#       the time to sleep in seconds (can be a float)\n# \n# ```bash\n# io:sleep 1.5\n# ```\n# \n# > The sleep command is not a built-in command in bash, but a separate executable. When you use sleep, you are creating a new process.\n# \nio::sleep \"${1:**time**}\"$0" ]
},

"io::toAbsolutePath": {
  "prefix": "io::toAbsolutePath",
  "description": "This function returns the absolute path of a path...",
  "scope": "",
  "body": [ "io::toAbsolutePath \"${1:**path**}\"$0" ]
},

"io::toAbsolutePath#withdoc": {
  "prefix": "io::toAbsolutePath#withdoc",
  "description": "This function returns the absolute path of a path...",
  "scope": "",
  "body": [ "# ## io::toAbsolutePath\n# \n# This function returns the absolute path of a path.\n# \n# - \\$1: **path** _as string_:\n#       The path to translate to absolute path.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The absolute path of the path.\n# \n# ```bash\n# io::toAbsolutePath \"myFile\"\n# local myFileAbsolutePath=\"\\${RETURNED_VALUE}\"\n# ```\n# \n# > This is a pure bash alternative to `realpath` or `readlink`.\n# \nio::toAbsolutePath \"${1:**path**}\"$0" ]
},

"io::windowsCreateTempDirectory": {
  "prefix": "io::windowsCreateTempDirectory",
  "description": "Create a temporary directory on Windows and return the path both for Windows and Unix...",
  "scope": "",
  "body": [ "io::windowsCreateTempDirectory$0" ]
},

"io::windowsCreateTempDirectory#withdoc": {
  "prefix": "io::windowsCreateTempDirectory#withdoc",
  "description": "Create a temporary directory on Windows and return the path both for Windows and Unix...",
  "scope": "",
  "body": [ "# ## io::windowsCreateTempDirectory\n# \n# Create a temporary directory on Windows and return the path both for Windows and Unix.\n# \n# This is useful for creating temporary directories that can be used in both Windows and Unix.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The Windows path.\n# - `RETURNED_VALUE2`: The Unix path.\n# \n# ```bash\n# io::windowsCreateTempDirectory\n# ```\n# \n# > Directories created this way are automatically cleaned up by the io::cleanupTempFiles\n# > function when valet ends.\n# \nio::windowsCreateTempDirectory$0" ]
},

"io::windowsCreateTempFile": {
  "prefix": "io::windowsCreateTempFile",
  "description": "Create a temporary file on Windows and return the path both for Windows and Unix...",
  "scope": "",
  "body": [ "io::windowsCreateTempFile$0" ]
},

"io::windowsCreateTempFile#withdoc": {
  "prefix": "io::windowsCreateTempFile#withdoc",
  "description": "Create a temporary file on Windows and return the path both for Windows and Unix...",
  "scope": "",
  "body": [ "# ## io::windowsCreateTempFile\n# \n# Create a temporary file on Windows and return the path both for Windows and Unix.\n# \n# This is useful for creating temporary files that can be used in both Windows and Unix.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The Windows path.\n# - `RETURNED_VALUE2`: The Unix path.\n# \n# ```bash\n# io::windowsCreateTempFile\n# ```\n# \n# > Files created this way are automatically cleaned up by the io::cleanupTempFiles\n# > function when valet ends.\n# \nio::windowsCreateTempFile$0" ]
},

"io::windowsPowershellBatchEnd": {
  "prefix": "io::windowsPowershellBatchEnd",
  "description": "This function will run all the commands that were batched with `io::windowsPowershellBatchStart`...",
  "scope": "",
  "body": [ "io::windowsPowershellBatchEnd$0" ]
},

"io::windowsPowershellBatchEnd#withdoc": {
  "prefix": "io::windowsPowershellBatchEnd#withdoc",
  "description": "This function will run all the commands that were batched with `io::windowsPowershellBatchStart`...",
  "scope": "",
  "body": [ "# ## io::windowsPowershellBatchEnd\n# \n# This function will run all the commands that were batched with `io::windowsPowershellBatchStart`.\n# \n# Returns:\n# \n# - \\$?\n#   - 0 if the command was successful\n#   - 1 otherwise.\n# - `RETURNED_VALUE`: The content of stdout.\n# - `RETURNED_VALUE2`: The content of stderr.\n# \n# ```bash\n# io::windowsPowershellBatchStart\n# io::windowsRunInPowershell \"Write-Host \\\"Hello\\\"\"\n# io::windowsRunInPowershell \"Write-Host \\\"World\\\"\"\n# io::windowsPowershellBatchEnd\n# ```\n# \nio::windowsPowershellBatchEnd$0" ]
},

"io::windowsPowershellBatchStart": {
  "prefix": "io::windowsPowershellBatchStart",
  "description": "After running this function, all commands that should be executed by `io::windowsRunInPowershell` will be added to a batch that will only be played when `io::windowsPowershellBatchEnd` is called...",
  "scope": "",
  "body": [ "io::windowsPowershellBatchStart$0" ]
},

"io::windowsPowershellBatchStart#withdoc": {
  "prefix": "io::windowsPowershellBatchStart#withdoc",
  "description": "After running this function, all commands that should be executed by `io::windowsRunInPowershell` will be added to a batch that will only be played when `io::windowsPowershellBatchEnd` is called...",
  "scope": "",
  "body": [ "# ## io::windowsPowershellBatchStart\n# \n# After running this function, all commands that should be executed by\n# `io::windowsRunInPowershell` will be added to a batch that will only be played\n# when `io::windowsPowershellBatchEnd` is called.\n# \n# This is a convenient way to run multiple commands in a single PowerShell session.\n# It makes up for the fact that running a new PowerShell session for each command is slow.\n# \n# ```bash\n# io::windowsPowershellBatchStart\n# io::windowsRunInPowershell \"Write-Host \\\"Hello\\\"\"\n# io::windowsRunInPowershell \"Write-Host \\\"World\\\"\"\n# io::windowsPowershellBatchEnd\n# ```\n# \nio::windowsPowershellBatchStart$0" ]
},

"io::windowsRunInPowershell": {
  "prefix": "io::windowsRunInPowershell",
  "description": "Runs a PowerShell command...",
  "scope": "",
  "body": [ "io::windowsRunInPowershell \"${1:**command**}\" \"${2:run as administrator}\"$0" ]
},

"io::windowsRunInPowershell#withdoc": {
  "prefix": "io::windowsRunInPowershell#withdoc",
  "description": "Runs a PowerShell command...",
  "scope": "",
  "body": [ "# ## io::windowsRunInPowershell\n# \n# Runs a PowerShell command.\n# This is mostly useful on Windows.\n# \n# - \\$1: **command** _as string_:\n#       the command to run.\n# - \\$2: run as administrator _as boolean_:\n#       (optional) whether to run the command as administrator.\n#       (defaults to false).\n# \n# Returns:\n# \n# - \\$?\n#   - 0 if the command was successful\n#   - 1 otherwise.\n# - `RETURNED_VALUE`: The content of stdout.\n# - `RETURNED_VALUE2`: The content of stderr.\n# \n# ```bash\n# io::windowsRunInPowershell \"Write-Host \\\"Press any key:\\\"; Write-Host -Object ('The key that was pressed was: {0}' -f [System.Console]::ReadKey().Key.ToString());\"\n# ```\n# \nio::windowsRunInPowershell \"${1:**command**}\" \"${2:run as administrator}\"$0" ]
},

"log::debug": {
  "prefix": "log::debug",
  "description": "Displays a debug message...",
  "scope": "",
  "body": [ "log::debug \"${99:**message**}\"$0" ]
},

"log::debug#withdoc": {
  "prefix": "log::debug#withdoc",
  "description": "Displays a debug message...",
  "scope": "",
  "body": [ "# ## log::debug\n# \n# Displays a debug message.\n# \n# - \\$@: **message** _as string_:\n#       the debug messages to display\n# \n# ```bash\n# log::debug \"This is a debug message.\"\n# ```\n# \nlog::debug \"${99:**message**}\"$0" ]
},

"log::error": {
  "prefix": "log::error",
  "description": "Displays an error message...",
  "scope": "",
  "body": [ "log::error \"${99:**message**}\"$0" ]
},

"log::error#withdoc": {
  "prefix": "log::error#withdoc",
  "description": "Displays an error message...",
  "scope": "",
  "body": [ "# ## log::error\n# \n# Displays an error message.\n# \n# - \\$@: **message** _as string_:\n#       the error messages to display\n# \n# ```bash\n# log::error \"This is an error message.\"\n# ```\n# \n# > You probably want to exit immediately after an error and should consider using core::fail function instead.\n# \nlog::error \"${99:**message**}\"$0" ]
},

"log::errorTrace": {
  "prefix": "log::errorTrace",
  "description": "Displays an error trace message...",
  "scope": "",
  "body": [ "log::errorTrace \"${99:**message**}\"$0" ]
},

"log::errorTrace#withdoc": {
  "prefix": "log::errorTrace#withdoc",
  "description": "Displays an error trace message...",
  "scope": "",
  "body": [ "# ## log::errorTrace\n# \n# Displays an error trace message.\n# This is a trace message that is always displayed, independently of the log level.\n# It can be used before a fatal error to display useful information.\n# \n# - \\$@: **message** _as string_:\n#       the trace messages to display\n# \n# ```bash\n# log::errorTrace \"This is a debug message.\"\n# ```\n# \nlog::errorTrace \"${99:**message**}\"$0" ]
},

"log::getLevel": {
  "prefix": "log::getLevel",
  "description": "Get the current log level...",
  "scope": "",
  "body": [ "log::getLevel$0" ]
},

"log::getLevel#withdoc": {
  "prefix": "log::getLevel#withdoc",
  "description": "Get the current log level...",
  "scope": "",
  "body": [ "# ## log::getLevel\n# \n# Get the current log level.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The current log level.\n# \n# ```bash\n# log::getLevel\n# printf '%s\\n' \"The log level is ⌜\\${RETURNED_VALUE}⌝.\"\n# ```\n# \nlog::getLevel$0" ]
},

"log::info": {
  "prefix": "log::info",
  "description": "Displays an info message...",
  "scope": "",
  "body": [ "log::info \"${99:**message**}\"$0" ]
},

"log::info#withdoc": {
  "prefix": "log::info#withdoc",
  "description": "Displays an info message...",
  "scope": "",
  "body": [ "# ## log::info\n# \n# Displays an info message.\n# \n# - \\$@: **message** _as string_:\n#       the info messages to display\n# \n# ```bash\n# log::info \"This is an info message.\"\n# ```\n# \nlog::info \"${99:**message**}\"$0" ]
},

"log::isDebugEnabled": {
  "prefix": "log::isDebugEnabled",
  "description": "Check if the debug mode is enabled...",
  "scope": "",
  "body": [ "log::isDebugEnabled$0" ]
},

"log::isDebugEnabled#withdoc": {
  "prefix": "log::isDebugEnabled#withdoc",
  "description": "Check if the debug mode is enabled...",
  "scope": "",
  "body": [ "# ## log::isDebugEnabled\n# \n# Check if the debug mode is enabled.\n# \n# Returns:\n# \n# - \\$?:\n#   - 0 if debug mode is enabled (log level is debug)\n#   - 1 if disabled\n# \n# ```bash\n# if log::isDebugEnabled; then printf '%s\\n' \"Debug mode is active.\"; fi\n# ```\n# \nlog::isDebugEnabled$0" ]
},

"log::isTraceEnabled": {
  "prefix": "log::isTraceEnabled",
  "description": "Check if the trace mode is enabled...",
  "scope": "",
  "body": [ "log::isTraceEnabled$0" ]
},

"log::isTraceEnabled#withdoc": {
  "prefix": "log::isTraceEnabled#withdoc",
  "description": "Check if the trace mode is enabled...",
  "scope": "",
  "body": [ "# ## log::isTraceEnabled\n# \n# Check if the trace mode is enabled.\n# \n# Returns:\n# \n# - \\$?:\n#   - 0 if trace mode is enabled (log level is trace)\n#   - 1 if disabled\n# \n# ```bash\n# if log::isTraceEnabled; then printf '%s\\n' \"Debug mode is active.\"; fi\n# ```\n# \nlog::isTraceEnabled$0" ]
},

"log::printCallStack": {
  "prefix": "log::printCallStack",
  "description": "This function prints the current function stack in the logs...",
  "scope": "",
  "body": [ "log::printCallStack \"${1:Stack to skip}\"$0" ]
},

"log::printCallStack#withdoc": {
  "prefix": "log::printCallStack#withdoc",
  "description": "This function prints the current function stack in the logs...",
  "scope": "",
  "body": [ "# ## log::printCallStack\n# \n# This function prints the current function stack in the logs.\n# \n# - \\$1: Stack to skip _as int_:\n#       (optional) Can be set using the variable `_OPTION_STACK_TO_SKIP`.\n#       The number of stack to skip.\n#       (defaults to 2 which skips this function and the first calling function\n#       which is usually the onError function)\n# \n# ```bash\n# log::printCallStack\n# log::printCallStack 0\n# ```\n# \nlog::printCallStack \"${1:Stack to skip}\"$0" ]
},

"log::printFile": {
  "prefix": "log::printFile",
  "description": "Display a file content with line numbers in the logs...",
  "scope": "",
  "body": [ "log::printFile \"${1:**path**}\" \"${2:max lines}\"$0" ]
},

"log::printFile#withdoc": {
  "prefix": "log::printFile#withdoc",
  "description": "Display a file content with line numbers in the logs...",
  "scope": "",
  "body": [ "# ## log::printFile\n# \n# Display a file content with line numbers in the logs.\n# The file content will be aligned with the current log output and hard wrapped if necessary.\n# \n# - \\$1: **path** _as string_:\n#       the file path to display.\n# - \\$2: max lines _as int_:\n#       (optional) max lines to display (defaults to 0 which prints all lines).\n# \n# ```bash\n# log::printFile \"/my/file/path\"\n# ```\n# shellcheck disable=SC2317\n# \nlog::printFile \"${1:**path**}\" \"${2:max lines}\"$0" ]
},

"log::printFileString": {
  "prefix": "log::printFileString",
  "description": "Display a file content with line numbers in the logs...",
  "scope": "",
  "body": [ "log::printFileString \"${1:**content**}\" \"${2:**max lines**}\"$0" ]
},

"log::printFileString#withdoc": {
  "prefix": "log::printFileString#withdoc",
  "description": "Display a file content with line numbers in the logs...",
  "scope": "",
  "body": [ "# ## log::printFileString\n# \n# Display a file content with line numbers in the logs.\n# The file content will be aligned with the current log output and hard wrapped if necessary.\n# \n# - \\$1: **content** _as string_:\n#       the file content.\n# - \\$2: **max lines** _as int_:\n#       (optional) max lines to display (defaults to 0 which prints all lines).\n# \n# ```bash\n# log::printFileString \"myfilecontent\"\n# ```\n# shellcheck disable=SC2317\n# \nlog::printFileString \"${1:**content**}\" \"${2:**max lines**}\"$0" ]
},

"log::printRaw": {
  "prefix": "log::printRaw",
  "description": "Display something in the log stream...",
  "scope": "",
  "body": [ "log::printRaw \"${1:**content**}\"$0" ]
},

"log::printRaw#withdoc": {
  "prefix": "log::printRaw#withdoc",
  "description": "Display something in the log stream...",
  "scope": "",
  "body": [ "# ## log::printRaw\n# \n# Display something in the log stream.\n# Does not check the log level.\n# \n# - \\$1: **content** _as string_:\n#       the content to print (can contain new lines)\n# \n# ```bash\n# log::printRaw \"my line\"\n# ```\n# shellcheck disable=SC2317\n# \nlog::printRaw \"${1:**content**}\"$0" ]
},

"log::printString": {
  "prefix": "log::printString",
  "description": "Display a string in the log...",
  "scope": "",
  "body": [ "log::printString \"${1:**content**}\" \"${2:new line pad string}\"$0" ]
},

"log::printString#withdoc": {
  "prefix": "log::printString#withdoc",
  "description": "Display a string in the log...",
  "scope": "",
  "body": [ "# ## log::printString\n# \n# Display a string in the log.\n# The string will be aligned with the current log output and hard wrapped if necessary.\n# Does not check the log level.\n# \n# - \\$1: **content** _as string_:\n#       the content to log (can contain new lines)\n# - \\$2: new line pad string _as string_:\n#       (optional) the string with which to prepend each wrapped line\n#       (empty by default)\n# \n# ```bash\n# log::printString \"my line\"\n# ```\n# shellcheck disable=SC2317\n# \nlog::printString \"${1:**content**}\" \"${2:new line pad string}\"$0" ]
},

"log::setLevel": {
  "prefix": "log::setLevel",
  "description": "Set the log level...",
  "scope": "",
  "body": [ "log::setLevel \"${1:**log level**}\" \"${2:silent}\"$0" ]
},

"log::setLevel#withdoc": {
  "prefix": "log::setLevel#withdoc",
  "description": "Set the log level...",
  "scope": "",
  "body": [ "# ## log::setLevel\n# \n# Set the log level.\n# \n# - \\$1: **log level** _as string_:\n#       the log level to set (or defaults to info), acceptable values are:\n#   - trace\n#   - debug\n#   - info\n#   - success\n#   - warning\n#   - error\n# - \\$2: silent _as bool_:\n#       (optional) true to silently switch log level, i.e. does not print a message\n#       (defaults to false)\n# \n# ```bash\n# log::setLevel debug\n# log::setLevel debug true\n# ```\n# \nlog::setLevel \"${1:**log level**}\" \"${2:silent}\"$0" ]
},

"log::success": {
  "prefix": "log::success",
  "description": "Displays a success message...",
  "scope": "",
  "body": [ "log::success \"${99:**message**}\"$0" ]
},

"log::success#withdoc": {
  "prefix": "log::success#withdoc",
  "description": "Displays a success message...",
  "scope": "",
  "body": [ "# ## log::success\n# \n# Displays a success message.\n# \n# - \\$@: **message** _as string_:\n#       the success messages to display\n# \n# ```bash\n# log::success \"This is a success message.\"\n# ```\n# \nlog::success \"${99:**message**}\"$0" ]
},

"log::trace": {
  "prefix": "log::trace",
  "description": "Displays a trace message...",
  "scope": "",
  "body": [ "log::trace \"${99:**message**}\"$0" ]
},

"log::trace#withdoc": {
  "prefix": "log::trace#withdoc",
  "description": "Displays a trace message...",
  "scope": "",
  "body": [ "# ## log::trace\n# \n# Displays a trace message.\n# \n# - \\$@: **message** _as string_:\n#       the trace messages to display\n# \n# ```bash\n# log::trace \"This is a trace message.\"\n# ```\n# \nlog::trace \"${99:**message**}\"$0" ]
},

"log::warning": {
  "prefix": "log::warning",
  "description": "Displays a warning...",
  "scope": "",
  "body": [ "log::warning \"${99:**message**}\"$0" ]
},

"log::warning#withdoc": {
  "prefix": "log::warning#withdoc",
  "description": "Displays a warning...",
  "scope": "",
  "body": [ "# ## log::warning\n# \n# Displays a warning.\n# \n# - \\$@: **message** _as string_:\n#       the warning messages to display\n# \n# ```bash\n# log::warning \"This is a warning message.\"\n# ```\n# \nlog::warning \"${99:**message**}\"$0" ]
},

"profiler::disable": {
  "prefix": "profiler::disable",
  "description": "Disable the profiler if previously activated with profiler::enable...",
  "scope": "",
  "body": [ "profiler::disable$0" ]
},

"profiler::disable#withdoc": {
  "prefix": "profiler::disable#withdoc",
  "description": "Disable the profiler if previously activated with profiler::enable...",
  "scope": "",
  "body": [ "# ## profiler::disable\n# \n# Disable the profiler if previously activated with profiler::enable.\n# \n# ```bash\n# profiler::disable\n# ```\n# \nprofiler::disable$0" ]
},

"profiler::enable": {
  "prefix": "profiler::enable",
  "description": "Enables the profiler and start writing to the given file...",
  "scope": "",
  "body": [ "profiler::enable \"${1:**path**}\"$0" ]
},

"profiler::enable#withdoc": {
  "prefix": "profiler::enable#withdoc",
  "description": "Enables the profiler and start writing to the given file...",
  "scope": "",
  "body": [ "# ## profiler::enable\n# \n# Enables the profiler and start writing to the given file.\n# \n# - \\$1: **path** _as string_:\n#       the file to write to.\n# \n# ```bash\n# profiler::enable \"\\${HOME}/valet-profiler-\\${BASHPID}.txt\"\n# ```\n# \n# > There can be only one profiler active at a time.\n# \nprofiler::enable \"${1:**path**}\"$0" ]
},

"prompt_getDisplayedPromptString": {
  "prefix": "prompt_getDisplayedPromptString",
  "description": "This function return a string that can be printed in a terminal in order to display a text and position the cursor at a given index in the input text...",
  "scope": "",
  "body": [ "prompt_getDisplayedPromptString$0" ]
},

"prompt_getDisplayedPromptString#withdoc": {
  "prefix": "prompt_getDisplayedPromptString#withdoc",
  "description": "This function return a string that can be printed in a terminal in order to display a text and position the cursor at a given index in the input text...",
  "scope": "",
  "body": [ "# ## prompt_getDisplayedPromptString\n# \n# This function return a string that can be printed in a terminal in order to display a text\n# and position the cursor at a given index in the input text.\n# \n# If the string is too long to fit in the screen, it will be truncated and ellipsis will be displayed\n# at the beginning and/or at the end of the string.\n# \n# The cursor will be displayed under the character at the given index of the input text and\n# it makes sure that the cursor is always visible in the screen.\n# \n# This function is useful to display a long prompt on a single line.\n# \n# An example:\n# \n# ```text\n# _PROMPT_STRING_SCREEN_WIDTH=10\n# _PROMPT_STRING_INDEX=20\n# _PROMPT_STRING=\"This is a long string that will be displayed in the screen.\"\n# #                                ^ input index 20\n# prompt_getDisplayedPromptString 20 10\n# # output: \"…g string…\"\n# #                  ^ screen cursor (at index 8)\n# ```\n# \n# - \\$_PROMPT_STRING: **input string** _as string_:\n#       the string to display\n# - \\$_PROMPT_STRING_INDEX: **input index** _as int_:\n#       the index of the character (in the input string) that should be under the cursor\n# - \\$_PROMPT_STRING_SCREEN_WIDTH: **screen width** _as int_:\n#       the width of the screen\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the string to display in the screen\n# - `RETURNED_VALUE2`: the index at which to position the cursor on screen\n# \n# ```bash\n# prompt_getDisplayedPromptString \"This is a long string that will be displayed in the screen.\" 20 10\n# ```\n# \nprompt_getDisplayedPromptString$0" ]
},

"source": {
  "prefix": "source",
  "description": "Allows to include a library file or sources a file...",
  "scope": "",
  "body": [ "source \"${1:**library name**}\" \"${99:arguments}\"$0" ]
},

"source#withdoc": {
  "prefix": "source#withdoc",
  "description": "Allows to include a library file or sources a file...",
  "scope": "",
  "body": [ "# ## source\n# \n# Allows to include a library file or sources a file.\n# \n# It replaces the builtin source command to make sure that we do not include the same file twice.\n# We replace source instead of creating a new function to allow us to\n# specify the included file for spellcheck.\n# \n# - \\$1: **library name** _as string_:\n#       the name of the library (array, interactive, string...) or the file path to include.\n# - \\$@: arguments _as any_:\n#       (optional) the arguments to pass to the included file (mimics the builtin source command).\n# \n# ```bash\n#   source string array system\n#   source ./my/path my/other/path\n# ```\n# \n# > - The file can be relative to the current script (script that calls this function).\n# > - This function makes sure that we do not include the same file twice.\n# > - Use `builtin source` if you want to include the file even if it was already included.\n# \nsource \"${1:**library name**}\" \"${99:arguments}\"$0" ]
},

"string::bumpSemanticVersion": {
  "prefix": "string::bumpSemanticVersion",
  "description": "This function allows to bump a semantic version formatted like: major...",
  "scope": "",
  "body": [ "string::bumpSemanticVersion \"${1:**version**}\" \"${2:**level**}\" \"${3:clear build and prerelease}\"$0" ]
},

"string::bumpSemanticVersion#withdoc": {
  "prefix": "string::bumpSemanticVersion#withdoc",
  "description": "This function allows to bump a semantic version formatted like: major...",
  "scope": "",
  "body": [ "# ## string::bumpSemanticVersion\n# \n# This function allows to bump a semantic version formatted like:\n# major.minor.patch-prerelease+build\n# \n# - \\$1: **version** _as string_:\n#       the version to bump\n# - \\$2: **level** _as string_:\n#       the level to bump (major, minor, patch)\n# - \\$3: clear build and prerelease _as bool_:\n#       (optional) clear the prerelease and build\n#       (defaults to true)\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the new version string\n# \n# ```bash\n# string::bumpSemanticVersion \"1.2.3-prerelease+build\" \"major\"\n# local newVersion=\"\\${RETURNED_VALUE}\"\n# ```\n# \nstring::bumpSemanticVersion \"${1:**version**}\" \"${2:**level**}\" \"${3:clear build and prerelease}\"$0" ]
},

"string::camelCaseToSnakeCase": {
  "prefix": "string::camelCaseToSnakeCase",
  "description": "This function convert a camelCase string to a SNAKE_CASE string...",
  "scope": "",
  "body": [ "string::camelCaseToSnakeCase \"${1:**camelCase string**}\"$0" ]
},

"string::camelCaseToSnakeCase#withdoc": {
  "prefix": "string::camelCaseToSnakeCase#withdoc",
  "description": "This function convert a camelCase string to a SNAKE_CASE string...",
  "scope": "",
  "body": [ "# ## string::camelCaseToSnakeCase\n# \n# This function convert a camelCase string to a SNAKE_CASE string.\n# It uses pure bash.\n# Removes all leading underscores.\n# \n# - \\$1: **camelCase string** _as string_:\n#       The camelCase string to convert.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The SNAKE_CASE string.\n# \n# ```bash\n# string::camelCaseToSnakeCase \"myCamelCaseString\" && local mySnakeCaseString=\"\\${RETURNED_VALUE}\"\n# ```\n# \nstring::camelCaseToSnakeCase \"${1:**camelCase string**}\"$0" ]
},

"string::compareSemanticVersion": {
  "prefix": "string::compareSemanticVersion",
  "description": "This function allows to compare two semantic versions formatted like: major...",
  "scope": "",
  "body": [ "string::compareSemanticVersion \"${1:**version1**}\" \"${2:**version2**}\"$0" ]
},

"string::compareSemanticVersion#withdoc": {
  "prefix": "string::compareSemanticVersion#withdoc",
  "description": "This function allows to compare two semantic versions formatted like: major...",
  "scope": "",
  "body": [ "# ## string::compareSemanticVersion\n# \n# This function allows to compare two semantic versions formatted like:\n# major.minor.patch-prerelease+build\n# \n# - \\$1: **version1** _as string_:\n#       the first version to compare\n# - \\$2: **version2** _as string_:\n#       the second version to compare\n# \n# Returns:\n# \n# - `RETURNED_VALUE`:\n#   - 0 if the versions are equal,\n#   - 1 if version1 is greater,\n#   - -1 if version2 is greater\n# \n# ```bash\n# string::compareSemanticVersion \"2.3.4-prerelease+build\" \"1.2.3-prerelease+build\"\n# local comparison=\"\\${RETURNED_VALUE}\"\n# ```\n# \n# > The prerelease and build are ignored in the comparison.\n# \nstring::compareSemanticVersion \"${1:**version1**}\" \"${2:**version2**}\"$0" ]
},

"string::count": {
  "prefix": "string::count",
  "description": "Counts the number of occurrences of a substring in a string...",
  "scope": "",
  "body": [ "string::count \"${1:**string**}\" \"${2:**substring**}\"$0" ]
},

"string::count#withdoc": {
  "prefix": "string::count#withdoc",
  "description": "Counts the number of occurrences of a substring in a string...",
  "scope": "",
  "body": [ "# ## string::count\n# \n# Counts the number of occurrences of a substring in a string.\n# \n# - \\$1: **string** _as string_:\n#       the string in which to search\n# - \\$2: **substring** _as string_:\n#       the substring to count\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the number of occurrences\n# \n# ```bash\n# string::count \"name,firstname,address\" \",\" && local count=\"\\${RETURNED_VALUE}\"\n# ```\n# \n# > This is faster than looping over the string and check the substring.\n# \nstring::count \"${1:**string**}\" \"${2:**substring**}\"$0" ]
},

"string::cutField": {
  "prefix": "string::cutField",
  "description": "Allows to get the nth element of a string separated by a given separator...",
  "scope": "",
  "body": [ "string::cutField \"${1:**string to cut**}\" \"${2:**field number**}\" \"${3:separator}\"$0" ]
},

"string::cutField#withdoc": {
  "prefix": "string::cutField#withdoc",
  "description": "Allows to get the nth element of a string separated by a given separator...",
  "scope": "",
  "body": [ "# ## string::cutField\n# \n# Allows to get the nth element of a string separated by a given separator.\n# This is the equivalent of the cut command \"cut -d\"\\${separator}\" -f\"\\${fieldNumber}\"\"\n# but it uses pure bash to go faster.\n# \n# - \\$1: **string to cut** _as string_:\n#       the string to cut\n# - \\$2: **field number** _as int_:\n#       the field number to get (starting at 0)\n# - \\$3: separator _as string_:\n#       the separator\n#       (defaults to tab if not provided)\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the extracted field\n# \n# ```bash\n# string::cutField \"field1 field2 field3\" 1 \" \" && local field=\"\\${RETURNED_VALUE}\"\n# printf '%s' \"\\${field}\" # will output \"field2\"\n# ```\n# \n# > This is faster than:\n# >\n# > - using read into an array from a here string\n# > - using bash parameter expansion to remove before/after the separator\n# \nstring::cutField \"${1:**string to cut**}\" \"${2:**field number**}\" \"${3:separator}\"$0" ]
},

"string::extractBetween": {
  "prefix": "string::extractBetween",
  "description": "Extract the text between two strings within a string...",
  "scope": "",
  "body": [ "string::extractBetween \"${1:**string**}\" \"${2:**start string**}\" \"${3:**end string**}\"$0" ]
},

"string::extractBetween#withdoc": {
  "prefix": "string::extractBetween#withdoc",
  "description": "Extract the text between two strings within a string...",
  "scope": "",
  "body": [ "# ## string::extractBetween\n# \n# Extract the text between two strings within a string.\n# Search for the first occurrence of the start string and the first occurrence\n# (after the start index) of the end string.\n# Both start and end strings are excluded in the extracted text.\n# Both start and end strings must be found to extract something.\n# \n# - \\$1: **string** _as string_:\n#       the string in which to search\n# - \\$2: **start string** _as string_:\n#       the start string\n#       (if empty, then it will extract from the beginning of the string)\n# - \\$3: **end string** _as string_:\n#       the end string\n#       (if empty, then it will extract until the end of the string)\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the extracted text\n# \n# ```bash\n# string::extractBetween \"This is a long text\" \"is a \" \" text\"\n# local extractedText=\"\\${RETURNED_VALUE}\"\n# ```\n# \nstring::extractBetween \"${1:**string**}\" \"${2:**start string**}\" \"${3:**end string**}\"$0" ]
},

"string::highlight": {
  "prefix": "string::highlight",
  "description": "Highlight a pattern (each character of this pattern) in a string...",
  "scope": "",
  "body": [ "string::highlight \"${1:**text**}\" \"${2:**pattern**}\" \"${3:highlight ansi code}\" \"${4:reset ansi code}\"$0" ]
},

"string::highlight#withdoc": {
  "prefix": "string::highlight#withdoc",
  "description": "Highlight a pattern (each character of this pattern) in a string...",
  "scope": "",
  "body": [ "# ## string::highlight\n# \n# Highlight a pattern (each character of this pattern) in a string.\n# \n# - \\$1: **text** _as string_:\n#       The text to highlight.\n# - \\$2: **pattern** _as string_:\n#       The pattern to highlight.\n# - \\$3: highlight ansi code _as string_:\n#       (optional) Can be set using the variable `_OPTION_HIGHLIGHT_ANSI`.\n#       The ANSI code to use for highlighting.\n#       (defaults to VALET_CONFIG_COLOR_HIGHLIGHT)\n# - \\$4: reset ansi code _as string_:\n#       (optional) Can be set using the variable `_OPTION_RESET_ANSI`.\n#       The ANSI code to use for resetting the highlighting.\n#       (defaults to VALET_CONFIG_COLOR_DEFAULT)\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the highlighted text\n# \n# ```bash\n# string::highlight \"This is a text to highlight.\" \"ttttt\"\n# echo \"\\${RETURNED_VALUE}\"\n# ```\n# \n# > - All characters in the pattern must be found in the same order in the matched line.\n# > - This functions is case insensitive.\n# \nstring::highlight \"${1:**text**}\" \"${2:**pattern**}\" \"${3:highlight ansi code}\" \"${4:reset ansi code}\"$0" ]
},

"string::indexOf": {
  "prefix": "string::indexOf",
  "description": "Find the first index of a string within another string...",
  "scope": "",
  "body": [ "string::indexOf \"${1:**string**}\" \"${2:**search**}\" \"${3:start index}\"$0" ]
},

"string::indexOf#withdoc": {
  "prefix": "string::indexOf#withdoc",
  "description": "Find the first index of a string within another string...",
  "scope": "",
  "body": [ "# ## string::indexOf\n# \n# Find the first index of a string within another string.\n# \n# - \\$1: **string** _as string_:\n#       the string in which to search\n# - \\$2: **search** _as string_:\n#       the string to search\n# - \\$3: start index _as int_:\n#       (optional) the starting index\n#       (defaults to 0)\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the index of the substring in the string or -1 if not found.\n# \n# ```bash\n# string::indexOf \"This is a long text\" \"long\" && local index=\"\\${RETURNED_VALUE}\"\n# string::indexOf \"This is a long text\" \"long\" 10 && local index=\"\\${RETURNED_VALUE}\"\n# ```\n# \nstring::indexOf \"${1:**string**}\" \"${2:**search**}\" \"${3:start index}\"$0" ]
},

"string::kebabCaseToCamelCase": {
  "prefix": "string::kebabCaseToCamelCase",
  "description": "This function convert a kebab-case string to a camelCase string...",
  "scope": "",
  "body": [ "string::kebabCaseToCamelCase \"${1:**kebab-case string**}\"$0" ]
},

"string::kebabCaseToCamelCase#withdoc": {
  "prefix": "string::kebabCaseToCamelCase#withdoc",
  "description": "This function convert a kebab-case string to a camelCase string...",
  "scope": "",
  "body": [ "# ## string::kebabCaseToCamelCase\n# \n# This function convert a kebab-case string to a camelCase string.\n# It uses pure bash.\n# Removes all leading dashes.\n# \n# - \\$1: **kebab-case string** _as string_:\n#       The kebab-case string to convert.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The camelCase string.\n# \n# ```bash\n# string::kebabCaseToCamelCase \"my-kebab-case-string\" && local myCamelCaseString=\"\\${RETURNED_VALUE}\"\n# ```\n# \nstring::kebabCaseToCamelCase \"${1:**kebab-case string**}\"$0" ]
},

"string::kebabCaseToSnakeCase": {
  "prefix": "string::kebabCaseToSnakeCase",
  "description": "This function convert a kebab-case string to a SNAKE_CASE string...",
  "scope": "",
  "body": [ "string::kebabCaseToSnakeCase \"${1:**kebab-case string**}\"$0" ]
},

"string::kebabCaseToSnakeCase#withdoc": {
  "prefix": "string::kebabCaseToSnakeCase#withdoc",
  "description": "This function convert a kebab-case string to a SNAKE_CASE string...",
  "scope": "",
  "body": [ "# ## string::kebabCaseToSnakeCase\n# \n# This function convert a kebab-case string to a SNAKE_CASE string.\n# It uses pure bash.\n# Removes all leading dashes.\n# \n# - \\$1: **kebab-case string** _as string_:\n#       The kebab-case string to convert.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The SNAKE_CASE string.\n# \n# ```bash\n# string::kebabCaseToSnakeCase \"my-kebab-case-string\" && local mySnakeCaseString=\"\\${RETURNED_VALUE}\"\n# ```\n# \nstring::kebabCaseToSnakeCase \"${1:**kebab-case string**}\"$0" ]
},

"string::microsecondsToHuman": {
  "prefix": "string::microsecondsToHuman",
  "description": "Convert microseconds to human readable format...",
  "scope": "",
  "body": [ "string::microsecondsToHuman \"${1:**microseconds**}\" \"${2:format}\"$0" ]
},

"string::microsecondsToHuman#withdoc": {
  "prefix": "string::microsecondsToHuman#withdoc",
  "description": "Convert microseconds to human readable format...",
  "scope": "",
  "body": [ "# ## string::microsecondsToHuman\n# \n# Convert microseconds to human readable format.\n# \n# - \\$1: **microseconds** _as int_:\n#       the microseconds to convert\n# - \\$2: format _as string_:\n#      (optional) Can be set using the variable `_OPTION_FORMAT`.\n#      the format to use (defaults to \"%HH:%MM:%SS\")\n#      Usable formats:\n#      - %HH: hours\n#      - %MM: minutes\n#      - %SS: seconds\n#      - %LL: milliseconds\n#      - %h: hours without leading zero\n#      - %m: minutes without leading zero\n#      - %s: seconds without leading zero\n#      - %l: milliseconds without leading zero\n#      - %u: microseconds without leading zero\n#      - %M: total minutes\n#      - %S: total seconds\n#      - %L: total milliseconds\n#      - %U: total microseconds\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the human readable format\n# \n# ```bash\n# string::microsecondsToHuman 123456789\n# echo \"\\${RETURNED_VALUE}\"\n# ```\n# \nstring::microsecondsToHuman \"${1:**microseconds**}\" \"${2:format}\"$0" ]
},

"string::regexGetFirst": {
  "prefix": "string::regexGetFirst",
  "description": "Matches a string against a regex and returns the first capture group of the matched string...",
  "scope": "",
  "body": [ "string::regexGetFirst \"${1:**string**}\" \"${2:**regex**}\"$0" ]
},

"string::regexGetFirst#withdoc": {
  "prefix": "string::regexGetFirst#withdoc",
  "description": "Matches a string against a regex and returns the first capture group of the matched string...",
  "scope": "",
  "body": [ "# ## string::regexGetFirst\n# \n# Matches a string against a regex and returns the first capture group of the matched string.\n# \n# - \\$1: **string** _as string_:\n#       the string to match\n# - \\$2: **regex** _as string_:\n#       the regex\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the first capture group in the matched string.\n#                     Empty if no match.\n# \n# ```bash\n# string::regexGetFirst \"name: julien\" \"name:(.*)\"\n# echo \"\\${RETURNED_VALUE}\"\n# ```\n# \n# > Regex wiki: https://en.wikibooks.org/wiki/Regular_Expressions/POSIX-Extended_Regular_Expressions\n# \nstring::regexGetFirst \"${1:**string**}\" \"${2:**regex**}\"$0" ]
},

"string::split": {
  "prefix": "string::split",
  "description": "Split a string into an array using a separator...",
  "scope": "",
  "body": [ "string::split \"${1:**string**}\" \"${2:**separator**}\"$0" ]
},

"string::split#withdoc": {
  "prefix": "string::split#withdoc",
  "description": "Split a string into an array using a separator...",
  "scope": "",
  "body": [ "# ## string::split\n# \n# Split a string into an array using a separator.\n# \n# - \\$1: **string** _as string_:\n#       the string to split\n# - \\$2: **separator** _as string_:\n#       the separator (must be a single character!)\n# \n# Returns:\n# \n# - `RETURNED_ARRAY`: the array of strings\n# \n# ```bash\n# string::split \"name,first name,address\" \",\" && local -a array=(\"\\${RETURNED_ARRAY[@]}\")\n# ```\n# \n# > This is faster than using read into an array from a here string.\n# \nstring::split \"${1:**string**}\" \"${2:**separator**}\"$0" ]
},

"string::trim": {
  "prefix": "string::trim",
  "description": "Trim leading and trailing whitespaces...",
  "scope": "",
  "body": [ "string::trim \"${1:**string to trim**}\"$0" ]
},

"string::trim#withdoc": {
  "prefix": "string::trim#withdoc",
  "description": "Trim leading and trailing whitespaces...",
  "scope": "",
  "body": [ "# ## string::trim\n# \n# Trim leading and trailing whitespaces.\n# \n# - \\$1: **string to trim** _as string_:\n#       The string to trim.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The trimmed string.\n# \n# ```bash\n# string::trim \"   example string    \" && local trimmedString=\"\\${RETURNED_VALUE}\"\n# ```\n# \nstring::trim \"${1:**string to trim**}\"$0" ]
},

"string::trimAll": {
  "prefix": "string::trimAll",
  "description": "Trim all whitespaces and truncate spaces...",
  "scope": "",
  "body": [ "string::trimAll \"${1:**string to trim**}\"$0" ]
},

"string::trimAll#withdoc": {
  "prefix": "string::trimAll#withdoc",
  "description": "Trim all whitespaces and truncate spaces...",
  "scope": "",
  "body": [ "# ## string::trimAll\n# \n# Trim all whitespaces and truncate spaces.\n# \n# - \\$1: **string to trim** _as string_:\n#       The string to trim.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: The trimmed string.\n# \n# ```bash\n# string::trimAll \"   example   string    \" && local trimmedString=\"\\${RETURNED_VALUE}\"\n# ```\n# \nstring::trimAll \"${1:**string to trim**}\"$0" ]
},

"string::wrapCharacters": {
  "prefix": "string::wrapCharacters",
  "description": "Allows to hard wrap the given string at the given width...",
  "scope": "",
  "body": [ "string::wrapCharacters \"${1:**text**}\" \"${2:wrap width}\" \"${3:padding characters}\" \"${4:first line width}\"$0" ]
},

"string::wrapCharacters#withdoc": {
  "prefix": "string::wrapCharacters#withdoc",
  "description": "Allows to hard wrap the given string at the given width...",
  "scope": "",
  "body": [ "# ## string::wrapCharacters\n# \n# Allows to hard wrap the given string at the given width.\n# Wrapping is done at character boundaries, see string::warpText for word wrapping.\n# Optionally appends padding characters on each new line.\n# \n# - \\$1: **text** _as string_:\n#       The text to wrap.\n# - \\$2: wrap width _as string_:\n#       (optional) Can be set using the variable `_OPTION_WRAP_WIDTH`.\n#       The width to wrap the text at.\n#       Note that length of the optional padding characters are subtracted from the\n#       width to make sure the text fits in the given width.\n#       (defaults to GLOBAL_COLUMNS)\n# - \\$3: padding characters _as string_:\n#       (optional) Can be set using the variable `_OPTION_PADDING_CHARS`.\n#       The characters to apply as padding on the left of each new line.\n#       E.g. '  ' will add 2 spaces on the left of each new line.\n#       (defaults to 0)\n# - \\$4: first line width _as int_:\n#       (optional) Can be set using the variable `_OPTION_FIRST_LINE_WIDTH`.\n#       The width to use for the first line.\n#       (defaults to the width)\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the wrapped string\n# - `RETURNED_VALUE2`: the length taken on the last line\n# \n# ```bash\n# string::wrapCharacters \"This is a long text that should be wrapped at 20 characters.\" 20 --- 5\n# echo \"\\${RETURNED_VALUE}\"\n# ```\n# \n# > - This function is written in pure bash and is faster than calling the fold command.\n# > - It considers escape sequence for text formatting and does not count them as visible characters.\n# > - Leading spaces after a newly wrapped line are removed.\n# \nstring::wrapCharacters \"${1:**text**}\" \"${2:wrap width}\" \"${3:padding characters}\" \"${4:first line width}\"$0" ]
},

"string::wrapText": {
  "prefix": "string::wrapText",
  "description": "Allows to soft wrap the given text at the given width...",
  "scope": "",
  "body": [ "string::wrapText \"${1:**text**}\" \"${2:wrap width}\" \"${3:padding characters}\" \"${4:first line width}\"$0" ]
},

"string::wrapText#withdoc": {
  "prefix": "string::wrapText#withdoc",
  "description": "Allows to soft wrap the given text at the given width...",
  "scope": "",
  "body": [ "# ## string::wrapText\n# \n# Allows to soft wrap the given text at the given width.\n# Wrapping is done at word boundaries.\n# Optionally appends padding characters on each new line.\n# \n# - \\$1: **text** _as string_:\n#       The text to wrap.\n# - \\$2: wrap width _as string_:\n#       (optional) Can be set using the variable `_OPTION_WRAP_WIDTH`.\n#       The width to wrap the text at.\n#       Note that length of the optional padding characters are subtracted from the\n#       width to make sure the text fits in the given width.\n#       (defaults to GLOBAL_COLUMNS)\n# - \\$3: padding characters _as string_:\n#       (optional) Can be set using the variable `_OPTION_PADDING_CHARS`.\n#       The characters to apply as padding on the left of each new line.\n#       E.g. '  ' will add 2 spaces on the left of each new line.\n#       (defaults to 0)\n# - \\$4: first line width _as int_:\n#       (optional) Can be set using the variable `_OPTION_FIRST_LINE_WIDTH`.\n#       The width to use for the first line.\n#       (defaults to the width)\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the wrapped text\n# \n# ```bash\n# string::wrapText \"This is a long text that should be wrapped at 20 characters.\" 20 '  ' 5\n# echo \"\\${RETURNED_VALUE}\"\n# ```\n# \n# > - This function is written in pure bash and is faster than calling the fold command.\n# > - This function effectively trims all the extra spaces in the text (leading, trailing but also in the middle).\n# > - It considers escape sequence for text formatting and does not count them as visible characters.\n# \nstring::wrapText \"${1:**text**}\" \"${2:wrap width}\" \"${3:padding characters}\" \"${4:first line width}\"$0" ]
},

"system::addToPath": {
  "prefix": "system::addToPath",
  "description": "Add the given path to the PATH environment variable for various shells, by adding the appropriate export command to the appropriate file...",
  "scope": "",
  "body": [ "system::addToPath \"${1:**path**}\"$0" ]
},

"system::addToPath#withdoc": {
  "prefix": "system::addToPath#withdoc",
  "description": "Add the given path to the PATH environment variable for various shells, by adding the appropriate export command to the appropriate file...",
  "scope": "",
  "body": [ "# ## system::addToPath\n# \n# Add the given path to the PATH environment variable for various shells,\n# by adding the appropriate export command to the appropriate file.\n# \n# Will also export the PATH variable in the current bash.\n# \n# - \\$1: **path** _as string_:\n#       the path to add to the PATH environment variable.\n# \n# ```bash\n# system::addToPath \"/path/to/bin\"\n# ```\n# \nsystem::addToPath \"${1:**path**}\"$0" ]
},

"system::commandExists": {
  "prefix": "system::commandExists",
  "description": "Check if the given command exists...",
  "scope": "",
  "body": [ "system::commandExists \"${1:**command name**}\"$0" ]
},

"system::commandExists#withdoc": {
  "prefix": "system::commandExists#withdoc",
  "description": "Check if the given command exists...",
  "scope": "",
  "body": [ "# ## system::commandExists\n# \n# Check if the given command exists.\n# \n# - \\$1: **command name** _as string_:\n#       the command name to check.\n# \n# Returns:\n# \n# - \\$?\n#   - 0 if the command exists\n#   - 1 otherwise.\n# \n# ```bash\n# if system::commandExists \"command1\"; then\n#   printf 'The command exists.'\n# fi\n# ```\n# \nsystem::commandExists \"${1:**command name**}\"$0" ]
},

"system::date": {
  "prefix": "system::date",
  "description": "Get the current date in the given format...",
  "scope": "",
  "body": [ "system::date \"${1:format}\"$0" ]
},

"system::date#withdoc": {
  "prefix": "system::date#withdoc",
  "description": "Get the current date in the given format...",
  "scope": "",
  "body": [ "# ## system::date\n# \n# Get the current date in the given format.\n# \n# - \\$1: format _as string_:\n#       (optional) the format of the date to return\n#       (defaults to %(%F_%Hh%Mm%Ss)T).\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the current date in the given format.\n# \n# ```bash\n# system::date\n# local date=\"\\${RETURNED_VALUE}\"\n# ```\n# \n# > This function avoid to call \\$(date) in a subshell (date is a an external executable).\n# \nsystem::date \"${1:format}\"$0" ]
},

"system::env": {
  "prefix": "system::env",
  "description": "Get the list of all the environment variables...",
  "scope": "",
  "body": [ "system::env$0" ]
},

"system::env#withdoc": {
  "prefix": "system::env#withdoc",
  "description": "Get the list of all the environment variables...",
  "scope": "",
  "body": [ "# ## system::env\n# \n# Get the list of all the environment variables.\n# In pure bash, no need for env or printenv.\n# \n# Returns:\n# \n# - `RETURNED_ARRAY`: An array with the list of all the environment variables.\n# \n# ```bash\n# system::env\n# for var in \"\\${RETURNED_ARRAY[@]}\"; do\n#   printf '%s=%s\\n' \"\\${var}\" \"\\${!var}\"\n# done\n# ```\n# \n# > This is faster than using mapfile on <(compgen -v).\n# \nsystem::env$0" ]
},

"system::getNotExistingCommands": {
  "prefix": "system::getNotExistingCommands",
  "description": "This function returns the list of not existing commands for the given names...",
  "scope": "",
  "body": [ "system::getNotExistingCommands \"${99:**command names**}\"$0" ]
},

"system::getNotExistingCommands#withdoc": {
  "prefix": "system::getNotExistingCommands#withdoc",
  "description": "This function returns the list of not existing commands for the given names...",
  "scope": "",
  "body": [ "# ## system::getNotExistingCommands\n# \n# This function returns the list of not existing commands for the given names.\n# \n# - \\$@: **command names** _as string_:\n#       the list of command names to check.\n# \n# Returns:\n# \n# - \\$?\n#   - 0 if there are not existing commands\n#   - 1 otherwise.\n# - `RETURNED_ARRAY`: the list of not existing commands.\n# \n# ```bash\n# if system::getNotExistingCommands \"command1\" \"command2\"; then\n#   printf 'The following commands do not exist: %s' \"\\${RETURNED_ARRAY[*]}\"\n# fi\n# ```\n# \nsystem::getNotExistingCommands \"${99:**command names**}\"$0" ]
},

"system::getUndeclaredVariables": {
  "prefix": "system::getUndeclaredVariables",
  "description": "This function returns the list of undeclared variables for the given names...",
  "scope": "",
  "body": [ "system::getUndeclaredVariables \"${99:**variable names**}\"$0" ]
},

"system::getUndeclaredVariables#withdoc": {
  "prefix": "system::getUndeclaredVariables#withdoc",
  "description": "This function returns the list of undeclared variables for the given names...",
  "scope": "",
  "body": [ "# ## system::getUndeclaredVariables\n# \n# This function returns the list of undeclared variables for the given names.\n# \n# - \\$@: **variable names** _as string_:\n#       the list of variable names to check.\n# \n# Returns:\n# \n# - \\$?\n#   - 0 if there are variable undeclared\n#   - 1 otherwise.\n# - `RETURNED_ARRAY`: the list of undeclared variables.\n# \n# ```bash\n# if system::getUndeclaredVariables \"var1\" \"var2\"; then\n#   printf 'The following variables are not declared: %s' \"\\${RETURNED_ARRAY[*]}\"\n# fi\n# ```\n# \nsystem::getUndeclaredVariables \"${99:**variable names**}\"$0" ]
},

"system::isRoot": {
  "prefix": "system::isRoot",
  "description": "Check if the script is running as root...",
  "scope": "",
  "body": [ "system::isRoot$0" ]
},

"system::isRoot#withdoc": {
  "prefix": "system::isRoot#withdoc",
  "description": "Check if the script is running as root...",
  "scope": "",
  "body": [ "# ## system::isRoot\n# \n# Check if the script is running as root.\n# \n# Returns:\n# \n# - \\$?\n#   - 0 if the script is running as root\n#   - 1 otherwise.\n# \n# ```bash\n# if system::isRoot; then\n#   printf 'The script is running as root.'\n# fi\n# ```\n# \nsystem::isRoot$0" ]
},

"system::os": {
  "prefix": "system::os",
  "description": "Returns the name of the current OS...",
  "scope": "",
  "body": [ "system::os$0" ]
},

"system::os#withdoc": {
  "prefix": "system::os#withdoc",
  "description": "Returns the name of the current OS...",
  "scope": "",
  "body": [ "# ## system::os\n# \n# Returns the name of the current OS.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the name of the current OS: \"darwin\", \"linux\" or \"windows\".\n# \n# ```bash\n# system::os\n# local osName=\"\\${RETURNED_VALUE}\"\n# ```\n# \nsystem::os$0" ]
},

"system::windowsAddToPath": {
  "prefix": "system::windowsAddToPath",
  "description": "Add the given path to the PATH environment variable on Windows (current user only)...",
  "scope": "",
  "body": [ "system::windowsAddToPath \"${1:**path**}\"$0" ]
},

"system::windowsAddToPath#withdoc": {
  "prefix": "system::windowsAddToPath#withdoc",
  "description": "Add the given path to the PATH environment variable on Windows (current user only)...",
  "scope": "",
  "body": [ "# ## system::windowsAddToPath\n# \n# Add the given path to the PATH environment variable on Windows (current user only).\n# \n# Will also export the PATH variable in the current bash.\n# \n# - \\$1: **path** _as string_:\n#       the path to add to the PATH environment variable.\n#       The path can be in unix format, it will be converted to windows format.\n# \n# ```bash\n# system::windowsAddToPath \"/path/to/bin\"\n# ```\n# \n# > This function is only available on Windows, it uses `powershell` to directly modify the registry.\n# \nsystem::windowsAddToPath \"${1:**path**}\"$0" ]
},

"system::windowsGetEnvVar": {
  "prefix": "system::windowsGetEnvVar",
  "description": "Get the value of an environment variable for the current user on Windows...",
  "scope": "",
  "body": [ "system::windowsGetEnvVar \"${1:**variable name**}\"$0" ]
},

"system::windowsGetEnvVar#withdoc": {
  "prefix": "system::windowsGetEnvVar#withdoc",
  "description": "Get the value of an environment variable for the current user on Windows...",
  "scope": "",
  "body": [ "# ## system::windowsGetEnvVar\n# \n# Get the value of an environment variable for the current user on Windows.\n# \n# - \\$1: **variable name** _as string_:\n#       the name of the environment variable to get.\n# \n# Returns:\n# \n# - `RETURNED_VALUE`: the value of the environment variable.\n# \n# ```bash\n# system::windowsGetEnvVar \"MY_VAR\"\n# echo \"\\${RETURNED_VALUE}\"\n# ```\n# \nsystem::windowsGetEnvVar \"${1:**variable name**}\"$0" ]
},

"system::windowsSetEnvVar": {
  "prefix": "system::windowsSetEnvVar",
  "description": "Set an environment variable for the current user on Windows...",
  "scope": "",
  "body": [ "system::windowsSetEnvVar \"${1:**variable name**}\" \"${2:**variable value**}\"$0" ]
},

"system::windowsSetEnvVar#withdoc": {
  "prefix": "system::windowsSetEnvVar#withdoc",
  "description": "Set an environment variable for the current user on Windows...",
  "scope": "",
  "body": [ "# ## system::windowsSetEnvVar\n# \n# Set an environment variable for the current user on Windows.\n# \n# - \\$1: **variable name** _as string_:\n#       the name of the environment variable to set.\n# - \\$2: **variable value** _as string_:\n#       the value of the environment variable to set.\n# \n# ```bash\n# system::windowsSetEnvVar \"MY_VAR\" \"my_value\"\n# ```\n# \n# > This function is only available on Windows, it uses `powershell` to directly modify the registry.\n# \nsystem::windowsSetEnvVar \"${1:**variable name**}\" \"${2:**variable value**}\"$0" ]
},

"test::commentTest": {
  "prefix": "test::commentTest",
  "description": "Call this function to add a paragraph in the report file...",
  "scope": "",
  "body": [ "test::commentTest \"${1:**comment**}\"$0" ]
},

"test::commentTest#withdoc": {
  "prefix": "test::commentTest#withdoc",
  "description": "Call this function to add a paragraph in the report file...",
  "scope": "",
  "body": [ "# ## test::commentTest\n# \n# Call this function to add a paragraph in the report file.\n# \n# - \\$1: **comment** _as string_:\n#       the text to add in the report file\n# \n# ```bash\n# test::commentTest \"This is a comment.\"\n# ```\n# \ntest::commentTest \"${1:**comment**}\"$0" ]
},

"test::endTest": {
  "prefix": "test::endTest",
  "description": "Call this function after each test to write the test results to the report file...",
  "scope": "",
  "body": [ "test::endTest \"${1:**title**}\" \"${2:**exit code**}\" \"${3:comment}\"$0" ]
},

"test::endTest#withdoc": {
  "prefix": "test::endTest#withdoc",
  "description": "Call this function after each test to write the test results to the report file...",
  "scope": "",
  "body": [ "# ## test::endTest\n# \n# Call this function after each test to write the test results to the report file.\n# This create a new H3 section in the report file with the test description and the exit code.\n# \n# - \\$1: **title** _as string_:\n#       the title of the test\n# - \\$2: **exit code** _as int_:\n#       the exit code of the test\n# - \\$3: comment _as string_:\n#       (optional) a text to explain what is being tested\n#       (defaults to \"\")\n# \n# ```bash\n# test::endTest \"Testing something\" \\$?\n# ```\n# \ntest::endTest \"${1:**title**}\" \"${2:**exit code**}\" \"${3:comment}\"$0" ]
},
	"[[:digit:]]": {
		"prefix": "[[:digit:]]",
		"description": "Regex digits, similar to [0-9]",
		"scope": "",
		"body": [
			"[[:digit:]]"
		]
	},
	"[[:xdigit:]]": {
		"prefix": "[[:xdigit:]]",
		"description": "Regex hexadecimal digits, similar to [0-9A-Fa-f]",
		"scope": "",
		"body": [
			"[[:xdigit:]]"
		]
	},
	"[[:punct:]]": {
		"prefix": "[[:punct:]]",
		"description": "Regex punctuation, similar to [.,!?:…]",
		"scope": "",
		"body": [
			"[[:punct:]]"
		]
	},
	"[[:blank:]]": {
		"prefix": "[[:blank:]]",
		"description": "Regex space and TAB characters only, similar to [ \\t]",
		"scope": "",
		"body": [
			"[[:blank:]]"
		]
	},
	"[[:space:]]": {
		"prefix": "[[:space:]]",
		"description": "Regex blank (whitespace) characters, similar to [ \\t\\n\\r\\f\\v]",
		"scope": "",
		"body": [
			"[[:space:]]"
		]
	},
	"[[:cntrl:]]": {
		"prefix": "[[:cntrl:]]",
		"description": "Regex control characters",
		"scope": "",
		"body": [
			"[[:cntrl:]]"
		]
	},
	"[[:graph:]]": {
		"prefix": "[[:graph:]]",
		"description": "Regex printed characters, similar to [^\\t\\n\\r\\f\\v]",
		"scope": "",
		"body": [
			"[[:graph:]]"
		]
	},
	"[[:print:]]": {
		"prefix": "[[:print:]]",
		"description": "Regex printed characters and space, similar to [^ \\t\\n\\r\\f\\v]",
		"scope": "",
		"body": [
			"[[:print:]]"
		]
	},
	"[[:alnum:]]": {
		"prefix": "[[:alnum:]]",
		"description": "Regex digits, upper- and lowercase letters, similar to [[:alpha:][:digit:]]",
		"scope": "",
		"body": [
			"[[:alnum:]]$0"
		]
	},
	"[[:alpha:]]": {
		"prefix": "[[:alpha:]]",
		"description": "Regex upper- and lowercase letters, similar to [[:upper:][:lower:]]",
		"scope": "",
		"body": [
			"[[:alpha:]]$0"
		]
	},
	"[[:lower:]]": {
		"prefix": "[[:lower:]]",
		"description": "Regex lowercase letters, similar to [a-z]",
		"scope": "",
		"body": [
			"[[:lower:]]$0"
		]
	},
	"[[:upper:]]": {
		"prefix": [
			"[[:upper:]]",
			"regex [[:upper:]]"
		],
		"description": "Regex uppercase letters , similar to [A-Z]",
		"scope": "",
		"body": [
			"[[:upper:]]$0"
		]
	},
	"set bash options": {
		"prefix": "set bash options",
		"description": "Set good bash options",
		"scope": "",
		"body": [
			"set -Eeu -o pipefail$0"
		]
	},
	"new command alt": {
		"prefix": "new command alt",
		"description": "A new command alternative definition for Valet",
		"scope": "",
		"body": [
			"##<<VALET_COMMAND",
			"# command: $1",
			"# function: $2",
			"# shortDescription: A short sentence.",
			"# description: |-",
			"#   A long description that can use ⌜quotes⌝.",
			"# sudo: false",
			"# hideInMenu: false",
			"# arguments:",
			"# - name: firstArg",
			"#   description: |-",
			"#     First argument.",
			"# - name: more...",
			"#   description: |-",
			"#     Will be an an array of strings.",
			"# options:",
			"# - name: -o, --option1",
			"#   description: |-",
			"#     First option.",
			"#   noEnvironmentVariable: true",
			"# - name: -2, --this-is-option2 <level>",
			"#   description: |-",
			"#     An option with a value.",
			"#   noEnvironmentVariable: false",
			"# examples:",
			"# - name: command -o -2 value1 arg1 more1 more2",
			"#   description: |-",
			"#     Call command with option1, option2 and some arguments.",
			"##VALET_COMMAND",
			"function $2() {",
			"  core::parseArguments \"$@\" && eval \"${RETURNED_VALUE}\"",
			"  core::checkParseResults \"${help:-}\" \"${parsingErrors:-}\"",
			"  $0",
			"}"
		]
	},
	"new command": {
		"prefix": "new command",
		"description": "A new command definition for Valet",
		"scope": "",
		"body": [
			": \"---",
			"command: $1",
			"function: $2",
			"shortDescription: A short sentence.",
			"description: |-",
			"  A long description that can use ⌜quotes⌝.",
			"sudo: false",
			"hideInMenu: false",
			"arguments:",
			"- name: firstArg",
			"  description: |-",
			"    First argument.",
			"- name: more...",
			"  description: |-",
			"    Will be an an array of strings.",
			"options:",
			"- name: -o, --option1",
			"  description: |-",
			"    First option.",
			"  noEnvironmentVariable: true",
			"- name: -2, --this-is-option2 <level>",
			"  description: |-",
			"    An option with a value.",
			"  noEnvironmentVariable: false",
			"examples:",
			"- name: command -o -2 value1 arg1 more1 more2",
			"  description: |-",
			"    Call command with option1, option2 and some arguments.",
			": \"---",
			"function $2() {",
			"  core::parseArguments \"$@\" && eval \"${RETURNED_VALUE}\"",
			"  core::checkParseResults \"${help:-}\" \"${parsingErrors:-}\"",
			"  $0",
			"}"
		]
	},
	"comment section": {
		"prefix": "comment section",
		"description": "",
		"scope": "",
		"body": [
			"#===============================================================",
			"# >>> $1",
			"#===============================================================",
			"$0"
		]
	},
	"quote": {
		"prefix": "quote",
		"description": "",
		"scope": "",
		"body": [
			"⌜$1⌝$0"
		]
	},
	"read file to array and loop": {
		"prefix": "read file to array and loop",
		"description": "Read file to array and loop",
		"scope": "",
		"body": [
			"readarray -d $'\\n' fileLines < file",
			"for myString in \"${fileLines[@]}\"; do",
			"  # the difference is also that myString will end with the delimiter, so you might want to remove it",
			"  # Alternatively, you can run readarray with -t but in that case you will not have an array element for empty lines",
			"  echo \"${myString%$'\\n'}\"",
			"done"
		]
	},
	"loop through lines of string": {
		"prefix": "loop through lines of string",
		"description": "Loop through each line of a string (keep empty lines)",
		"scope": "",
		"body": [
			"while read -r line; do",
			"  echo \"${line}\"",
			"done <<< \"${var1}\""
		]
	},
	"loop through lines of string (for)": {
		"prefix": "loop through lines of string (for)",
		"description": "Loop through each line of a string (does not keep empty lines)",
		"scope": "",
		"body": [
			"local IFS=$'\\n'",
			"for line in ${var1}; do",
			"  echo \"${line}\"",
			"done"
		]
	},
	"read file loop on all lines": {
		"prefix": "read file loop on all lines",
		"description": "Read a file, line by line",
		"scope": "",
		"body": [
			"while read -r line || [[ -n ${line:-} ]]; do",
			"  echo \"${line}\"",
			"done < file"
		]
	},
	"source": {
		"prefix": "source",
		"description": "Source a file for Valet, add the necessary comment for shellcheck.",
		"scope": "",
		"body": [
			"# shellcheck source=../lib-valet",
			"source $1",
			"$0",
			""
		]
	},
	"RETURNED_VALUE": {
		"prefix": "RETURNED_VALUE",
		"description": "",
		"scope": "",
		"body": [
			"RETURNED_VALUE$0"
		]
	},
	"RETURNED_VALUE2": {
		"prefix": "RETURNED_VALUE2",
		"description": "",
		"scope": "",
		"body": [
			"RETURNED_VALUE2$0"
		]
	},
	"RETURNED_VALUE3": {
		"prefix": "RETURNED_VALUE3",
		"description": "",
		"scope": "",
		"body": [
			"RETURNED_VALUE3$0"
		]
	},
	"RETURNED_ARRAY": {
		"prefix": "RETURNED_ARRAY",
		"description": "",
		"scope": "",
		"body": [
			"RETURNED_ARRAY$0"
		]
	},
	"RETURNED_ARRAY2": {
		"prefix": "RETURNED_ARRAY2",
		"description": "",
		"scope": "",
		"body": [
			"RETURNED_ARRAY2$0"
		]
	},
	"RETURNED_ARRAY3": {
		"prefix": "RETURNED_ARRAY3",
		"description": "",
		"scope": "",
		"body": [
			"RETURNED_ARRAY3$0"
		]
	},
	"RETURNED_ASSOCIATIVE_ARRAY": {
		"prefix": "RETURNED_ASSOCIATIVE_ARRAY",
		"description": "",
		"scope": "",
		"body": [
			"RETURNED_ASSOCIATIVE_ARRAY$0"
		]
	},
	"IFS": {
		"prefix": "IFS",
		"description": "A list of characters that separate fields; used when the shell splits words as part of expansion. ",
		"scope": "",
		"body": [
			"IFS$0"
		]
	},
	"$GLOBAL_COLUMNS": {
		"prefix": "$GLOBAL_COLUMNS",
		"description": "The current number or columns displayed by the terminal, refresh by interactive::getTerminalSize on resize.",
		"scope": "",
		"body": [
			"\\${GLOBAL_COLUMNS}$0"
		]
	},
	"$GLOBAL_LINES": {
		"prefix": "$GLOBAL_LINES",
		"description": "The current number or lines displayed by the terminal, refresh by interactive::getTerminalSize on resize.",
		"scope": "",
		"body": [
			"\\${GLOBAL_LINES}$0"
		]
	},
	"$GLOBAL_CURSOR_LINE": {
		"prefix": "$GLOBAL_CURSOR_LINE",
		"description": "The position of the cursor. You need to refresh it by calling interactive::getCursorPosition.",
		"scope": "",
		"body": [
			"\\${GLOBAL_CURSOR_LINE}$0"
		]
	},
	"$GLOBAL_CURSOR_COLUMN": {
		"prefix": "$GLOBAL_CURSOR_COLUMN",
		"description": "The position of the cursor. You need to refresh it by calling interactive::getCursorPosition.",
		"scope": "",
		"body": [
			"\\${GLOBAL_CURSOR_COLUMN}$0"
		]
	},
	"$LAST_KEY_PRESSED": {
		"prefix": "$LAST_KEY_PRESSED",
		"description": "",
		"scope": "",
		"body": [
			"\\${LAST_KEY_PRESSED}$0"
		]
	},
	"$RETURNED_VALUE": {
		"prefix": "$RETURNED_VALUE",
		"description": "",
		"scope": "",
		"body": [
			"\\${RETURNED_VALUE}$0"
		]
	},
	"$RETURNED_VALUE2": {
		"prefix": "$RETURNED_VALUE2",
		"description": "",
		"scope": "",
		"body": [
			"\\${RETURNED_VALUE2}$0"
		]
	},
	"$RETURNED_VALUE3": {
		"prefix": "$RETURNED_VALUE3",
		"description": "",
		"scope": "",
		"body": [
			"\\${RETURNED_VALUE3}$0"
		]
	},
	"$RETURNED_ARRAY": {
		"prefix": "$RETURNED_ARRAY",
		"description": "",
		"scope": "",
		"body": [
			"\\${RETURNED_ARRAY}$0"
		]
	},
	"$RETURNED_ARRAY2": {
		"prefix": "$RETURNED_ARRAY2",
		"description": "",
		"scope": "",
		"body": [
			"\\${RETURNED_ARRAY2}$0"
		]
	},
	"$RETURNED_ARRAY3": {
		"prefix": "$RETURNED_ARRAY3",
		"description": "",
		"scope": "",
		"body": [
			"\\${RETURNED_ARRAY3}$0"
		]
	},
	"$RETURNED_ASSOCIATIVE_ARRAY": {
		"prefix": "$RETURNED_ASSOCIATIVE_ARRAY",
		"description": "",
		"scope": "",
		"body": [
			"\\${RETURNED_ASSOCIATIVE_ARRAY}$0"
		]
	},
	"$BASHOPTS": {
		"prefix": "$BASHOPTS",
		"body": [
			"\\${BASHOPTS}$0"
		],
		"scope": "",
		"description": "A colon-separated list of enabled shell options. Each word in the list is a valid argument for the -s option to the shopt builtin command (see The Shopt Builtin). The options appearing in BASHOPTS are those reported as ‘on’ by ‘shopt’. If this variable is in the environment when Bash starts up, each shell option in the list will be enabled before reading any startup files. This variable is readonly."
	},
	"$BASHPID": {
		"prefix": "$BASHPID",
		"body": [
			"\\${BASHPID}$0"
		],
		"scope": "",
		"description": "Expands to the process ID of the current Bash process. This differs from $$ under certain circumstances, such as subshells that do not require Bash to be re-initialized. Assignments to BASHPID have no effect. If BASHPID is unset, it loses its special properties, even if it is subsequently reset."
	},
	"$BASH_ALIASES": {
		"prefix": "$BASH_ALIASES",
		"body": [
			"\\${BASH_ALIASES}$0"
		],
		"scope": "",
		"description": "An associative array variable whose members correspond to the internal list of aliases as maintained by the alias builtin. (see Bourne Shell Builtins). Elements added to this array appear in the alias list; however, unsetting array elements currently does not cause aliases to be removed from the alias list. If BASH_ALIASES is unset, it loses its special properties, even if it is subsequently reset."
	},
	"$BASH_ARGC": {
		"prefix": "$BASH_ARGC",
		"body": [
			"\\${BASH_ARGC}$0"
		],
		"scope": "",
		"description": "An array variable whose values are the number of parameters in each frame of the current bash execution call stack. The number of parameters to the current subroutine (shell function or script executed with . or source) is at the top of the stack. When a subroutine is executed, the number of parameters passed is pushed onto BASH_ARGC. The shell sets BASH_ARGC only when in extended debugging mode (see The Shopt Builtin for a description of the extdebug option to the shopt builtin). Setting extdebug after the shell has started to execute a script, or referencing this variable when extdebug is not set, may result in inconsistent values."
	},
	"$BASH_ARGV": {
		"prefix": "$BASH_ARGV",
		"body": [
			"\\${BASH_ARGV}$0"
		],
		"scope": "",
		"description": "An array variable containing all of the parameters in the current bash execution call stack. The final parameter of the last subroutine call is at the top of the stack; the first parameter of the initial call is at the bottom. When a subroutine is executed, the parameters supplied are pushed onto BASH_ARGV. The shell sets BASH_ARGV only when in extended debugging mode (see The Shopt Builtin for a description of the extdebug option to the shopt builtin). Setting extdebug after the shell has started to execute a script, or referencing this variable when extdebug is not set, may result in inconsistent values."
	},
	"$BASH_ARGV0": {
		"prefix": "$BASH_ARGV0",
		"body": [
			"\\${BASH_ARGV0}$0"
		],
		"scope": "",
		"description": "When referenced, this variable expands to the name of the shell or shell script (identical to $0; See Special Parameters, for the description of special parameter 0). Assignment to BASH_ARGV0 causes the value assigned to also be assigned to $0. If BASH_ARGV0 is unset, it loses its special properties, even if it is subsequently reset."
	},
	"$BASH_CMDS": {
		"prefix": "$BASH_CMDS",
		"body": [
			"\\${BASH_CMDS}$0"
		],
		"scope": "",
		"description": "An associative array variable whose members correspond to the internal hash table of commands as maintained by the hash builtin (see Bourne Shell Builtins). Elements added to this array appear in the hash table; however, unsetting array elements currently does not cause command names to be removed from the hash table. If BASH_CMDS is unset, it loses its special properties, even if it is subsequently reset."
	},
	"$BASH_COMMAND": {
		"prefix": "$BASH_COMMAND",
		"body": [
			"\\${BASH_COMMAND}$0"
		],
		"scope": "",
		"description": "The command currently being executed or about to be executed, unless the shell is executing a command as the result of a trap, in which case it is the command executing at the time of the trap. If BASH_COMMAND is unset, it loses its special properties, even if it is subsequently reset."
	},
	"$BASH_COMPAT": {
		"prefix": "$BASH_COMPAT",
		"body": [
			"\\${BASH_COMPAT}$0"
		],
		"scope": "",
		"description": "The value is used to set the shell’s compatibility level. See Shell Compatibility Mode, for a description of the various compatibility levels and their effects. The value may be a decimal number (e.g., 4.2) or an integer (e.g., 42) corresponding to the desired compatibility level. If BASH_COMPAT is unset or set to the empty string, the compatibility level is set to the default for the current version. If BASH_COMPAT is set to a value that is not one of the valid compatibility levels, the shell prints an error message and sets the compatibility level to the default for the current version. The valid values correspond to the compatibility levels described below (see Shell Compatibility Mode). For example, 4.2 and 42 are valid values that correspond to the compat42 shopt option and set the compatibility level to 42. The current version is also a valid value."
	},
	"$BASH_ENV": {
		"prefix": "$BASH_ENV",
		"body": [
			"\\${BASH_ENV}$0"
		],
		"scope": "",
		"description": "If this variable is set when Bash is invoked to execute a shell script, its value is expanded and used as the name of a startup file to read before executing the script. See Bash Startup Files."
	},
	"$BASH_EXECUTION_STRING": {
		"prefix": "$BASH_EXECUTION_STRING",
		"body": [
			"\\${BASH_EXECUTION_STRING}$0"
		],
		"scope": "",
		"description": "The command argument to the -c invocation option."
	},
	"$BASH_LINENO": {
		"prefix": "$BASH_LINENO",
		"body": [
			"\\${BASH_LINENO}$0"
		],
		"scope": "",
		"description": "An array variable whose members are the line numbers in source files where each corresponding member of FUNCNAME was invoked. ${BASH_LINENO[$i]} is the line number in the source file (${BASH_SOURCE[$i+1]}) where ${FUNCNAME[$i]} was called (or ${BASH_LINENO[$i-1]} if referenced within another shell function). Use LINENO to obtain the current line number."
	},
	"$BASH_LOADABLES_PATH": {
		"prefix": "$BASH_LOADABLES_PATH",
		"body": [
			"\\${BASH_LOADABLES_PATH}$0"
		],
		"scope": "",
		"description": "A colon-separated list of directories in which the shell looks for dynamically loadable builtins specified by the enable command."
	},
	"$BASH_REMATCH": {
		"prefix": "$BASH_REMATCH",
		"body": [
			"\\${BASH_REMATCH}$0"
		],
		"scope": "",
		"description": "An array variable whose members are assigned by the ‘=~’ binary operator to the [[ conditional command (see Conditional Constructs). The element with index 0 is the portion of the string matching the entire regular expression. The element with index n is the portion of the string matching the nth parenthesized subexpression."
	},
	"$BASH_SOURCE": {
		"prefix": "$BASH_SOURCE",
		"body": [
			"\\${BASH_SOURCE}$0"
		],
		"scope": "",
		"description": "An array variable whose members are the source filenames where the corresponding shell function names in the FUNCNAME array variable are defined. The shell function ${FUNCNAME[$i]} is defined in the file ${BASH_SOURCE[$i]} and called from ${BASH_SOURCE[$i+1]}"
	},
	"$BASH_SUBSHELL": {
		"prefix": "$BASH_SUBSHELL",
		"body": [
			"\\${BASH_SUBSHELL}$0"
		],
		"scope": "",
		"description": "Incremented by one within each subshell or subshell environment when the shell begins executing in that environment. The initial value is 0. If BASH_SUBSHELL is unset, it loses its special properties, even if it is subsequently reset."
	},
	"$BASH_VERSINFO": {
		"prefix": "$BASH_VERSINFO",
		"body": [
			"\\${BASH_VERSINFO}$0"
		],
		"scope": "",
		"description": "A readonly array variable (see Arrays) whose members hold version information for this instance of Bash. The values assigned to the array members are as follows:"
	},
	"$BASH_VERSINFO[0]": {
		"prefix": "$BASH_VERSINFO[0]",
		"body": [
			"\\${BASH_VERSINFO[0]}$0"
		],
		"scope": "",
		"description": "The major version number (the release)."
	},
	"$BASH_VERSINFO[1]": {
		"prefix": "$BASH_VERSINFO[1]",
		"body": [
			"\\${BASH_VERSINFO[1]}$0"
		],
		"scope": "",
		"description": "The minor version number (the version)."
	},
	"$BASH_VERSINFO[2]": {
		"prefix": "$BASH_VERSINFO[2]",
		"body": [
			"\\${BASH_VERSINFO[2]}$0"
		],
		"scope": "",
		"description": "The patch level."
	},
	"$BASH_VERSINFO[3]": {
		"prefix": "$BASH_VERSINFO[3]",
		"body": [
			"\\${BASH_VERSINFO[3]}$0"
		],
		"scope": "",
		"description": "The build version."
	},
	"$BASH_VERSINFO[4]": {
		"prefix": "$BASH_VERSINFO[4]",
		"body": [
			"\\${BASH_VERSINFO[4]}$0"
		],
		"scope": "",
		"description": "The release status (e.g., beta1)."
	},
	"$BASH_VERSINFO[5]": {
		"prefix": "$BASH_VERSINFO[5]",
		"body": [
			"\\${BASH_VERSINFO[5]}$0"
		],
		"scope": "",
		"description": "The value of MACHTYPE. "
	},
	"$BASH_VERSION": {
		"prefix": "$BASH_VERSION",
		"body": [
			"\\${BASH_VERSION}$0"
		],
		"scope": "",
		"description": "The version number of the current instance of Bash."
	},
	"$BASH_XTRACEFD": {
		"prefix": "$BASH_XTRACEFD",
		"body": [
			"\\${BASH_XTRACEFD}$0"
		],
		"scope": "",
		"description": "If set to an integer corresponding to a valid file descriptor, Bash will write the trace output generated when ‘set -x’ is enabled to that file descriptor. This allows tracing output to be separated from diagnostic and error messages. The file descriptor is closed when BASH_XTRACEFD is unset or assigned a new value. Unsetting BASH_XTRACEFD or assigning it the empty string causes the trace output to be sent to the standard error. Note that setting BASH_XTRACEFD to 2 (the standard error file descriptor) and then unsetting it will result in the standard error being closed."
	},
	"$CHILD_MAX": {
		"prefix": "$CHILD_MAX",
		"body": [
			"\\${CHILD_MAX}$0"
		],
		"scope": "",
		"description": "Set the number of exited child status values for the shell to remember. Bash will not allow this value to be decreased below a POSIX-mandated minimum, and there is a maximum value (currently 8192) that this may not exceed. The minimum value is system-dependent."
	},
	"$COLUMNS": {
		"prefix": "$COLUMNS",
		"body": [
			"\\${COLUMNS}$0"
		],
		"scope": "",
		"description": "Used by the select command to determine the terminal width when printing selection lists. Automatically set if the checkwinsize option is enabled (see The Shopt Builtin), or in an interactive shell upon receipt of a SIGWINCH."
	},
	"$COMP_CWORD": {
		"prefix": "$COMP_CWORD",
		"body": [
			"\\${COMP_CWORD}$0"
		],
		"scope": "",
		"description": "An index into ${COMP_WORDS} of the word containing the current cursor position. This variable is available only in shell functions invoked by the programmable completion facilities (see Programmable Completion)."
	},
	"$COMP_LINE": {
		"prefix": "$COMP_LINE",
		"body": [
			"\\${COMP_LINE}$0"
		],
		"scope": "",
		"description": "The current command line. This variable is available only in shell functions and external commands invoked by the programmable completion facilities (see Programmable Completion)."
	},
	"$COMP_POINT": {
		"prefix": "$COMP_POINT",
		"body": [
			"\\${COMP_POINT}$0"
		],
		"scope": "",
		"description": "The index of the current cursor position relative to the beginning of the current command. If the current cursor position is at the end of the current command, the value of this variable is equal to ${#COMP_LINE}. This variable is available only in shell functions and external commands invoked by the programmable completion facilities (see Programmable Completion)."
	},
	"$COMP_TYPE": {
		"prefix": "$COMP_TYPE",
		"body": [
			"\\${COMP_TYPE}$0"
		],
		"scope": "",
		"description": "Set to an integer value corresponding to the type of completion attempted that caused a completion function to be called: TAB, for normal completion, ‘?’, for listing completions after successive tabs, ‘!’, for listing alternatives on partial word completion, ‘@’, to list completions if the word is not unmodified, or ‘%’, for menu completion. This variable is available only in shell functions and external commands invoked by the programmable completion facilities (see Programmable Completion)."
	},
	"$COMP_KEY": {
		"prefix": "$COMP_KEY",
		"body": [
			"\\${COMP_KEY}$0"
		],
		"scope": "",
		"description": "The key (or final key of a key sequence) used to invoke the current completion function."
	},
	"$COMP_WORDBREAKS": {
		"prefix": "$COMP_WORDBREAKS",
		"body": [
			"\\${COMP_WORDBREAKS}$0"
		],
		"scope": "",
		"description": "The set of characters that the Readline library treats as word separators when performing word completion. If COMP_WORDBREAKS is unset, it loses its special properties, even if it is subsequently reset."
	},
	"$COMP_WORDS": {
		"prefix": "$COMP_WORDS",
		"body": [
			"\\${COMP_WORDS}$0"
		],
		"scope": "",
		"description": "An array variable consisting of the individual words in the current command line. The line is split into words as Readline would split it, using COMP_WORDBREAKS as described above. This variable is available only in shell functions invoked by the programmable completion facilities (see Programmable Completion)."
	},
	"$COMPREPLY": {
		"prefix": "$COMPREPLY",
		"body": [
			"\\${COMPREPLY}$0"
		],
		"scope": "",
		"description": "An array variable from which Bash reads the possible completions generated by a shell function invoked by the programmable completion facility (see Programmable Completion). Each array element contains one possible completion."
	},
	"$COPROC": {
		"prefix": "$COPROC",
		"body": [
			"\\${COPROC}$0"
		],
		"scope": "",
		"description": "An array variable created to hold the file descriptors for output from and input to an unnamed coprocess (see Coprocesses)."
	},
	"$DIRSTACK": {
		"prefix": "$DIRSTACK",
		"body": [
			"\\${DIRSTACK}$0"
		],
		"scope": "",
		"description": "An array variable containing the current contents of the directory stack. Directories appear in the stack in the order they are displayed by the dirs builtin. Assigning to members of this array variable may be used to modify directories already in the stack, but the pushd and popd builtins must be used to add and remove directories. Assignment to this variable will not change the current directory. If DIRSTACK is unset, it loses its special properties, even if it is subsequently reset."
	},
	"$EMACS": {
		"prefix": "$EMACS",
		"body": [
			"\\${EMACS}$0"
		],
		"scope": "",
		"description": "If Bash finds this variable in the environment when the shell starts with value ‘t’, it assumes that the shell is running in an Emacs shell buffer and disables line editing."
	},
	"$ENV": {
		"prefix": "$ENV",
		"body": [
			"\\${ENV}$0"
		],
		"scope": "",
		"description": "Expanded and executed similarly to BASH_ENV (see Bash Startup Files) when an interactive shell is invoked in POSIX Mode (see Bash POSIX Mode)."
	},
	"$EPOCHREALTIME": {
		"prefix": "$EPOCHREALTIME",
		"body": [
			"\\${EPOCHREALTIME}$0"
		],
		"scope": "",
		"description": "Each time this parameter is referenced, it expands to the number of seconds since the Unix Epoch as a floating point value with micro-second granularity (see the documentation for the C library function time for the definition of Epoch). Assignments to EPOCHREALTIME are ignored. If EPOCHREALTIME is unset, it loses its special properties, even if it is subsequently reset."
	},
	"$EPOCHSECONDS": {
		"prefix": "$EPOCHSECONDS",
		"body": [
			"\\${EPOCHSECONDS}$0"
		],
		"scope": "",
		"description": "Each time this parameter is referenced, it expands to the number of seconds since the Unix Epoch (see the documentation for the C library function time for the definition of Epoch). Assignments to EPOCHSECONDS are ignored. If EPOCHSECONDS is unset, it loses its special properties, even if it is subsequently reset."
	},
	"$EUID": {
		"prefix": "$EUID",
		"body": [
			"\\${EUID}$0"
		],
		"scope": "",
		"description": "The numeric effective user id of the current user. This variable is readonly."
	},
	"$EXECIGNORE": {
		"prefix": "$EXECIGNORE",
		"body": [
			"\\${EXECIGNORE}$0"
		],
		"scope": "",
		"description": "A colon-separated list of shell patterns (see Pattern Matching) defining the list of filenames to be ignored by command search using PATH. Files whose full pathnames match one of these patterns are not considered executable files for the purposes of completion and command execution via PATH lookup. This does not affect the behavior of the [, test, and [[ commands. Full pathnames in the command hash table are not subject to EXECIGNORE. Use this variable to ignore shared library files that have the executable bit set, but are not executable files. The pattern matching honors the setting of the extglob shell option."
	},
	"$FCEDIT": {
		"prefix": "$FCEDIT",
		"body": [
			"\\${FCEDIT}$0"
		],
		"scope": "",
		"description": "The editor used as a default by the -e option to the fc builtin command."
	},
	"$FIGNORE": {
		"prefix": "$FIGNORE",
		"body": [
			"\\${FIGNORE}$0"
		],
		"scope": "",
		"description": "A colon-separated list of suffixes to ignore when performing filename completion. A filename whose suffix matches one of the entries in FIGNORE is excluded from the list of matched filenames. A sample value is ‘.o:~’"
	},
	"$FUNCNAME": {
		"prefix": "$FUNCNAME",
		"body": [
			"\\${FUNCNAME}$0"
		],
		"scope": "",
		"description": "An array variable containing the names of all shell functions currently in the execution call stack. The element with index 0 is the name of any currently-executing shell function. The bottom-most element (the one with the highest index) is main. This variable exists only when a shell function is executing. Assignments to FUNCNAME have no effect. If FUNCNAME is unset, it loses its special properties, even if it is subsequently reset. This variable can be used with BASH_LINENO and BASH_SOURCE. Each element of FUNCNAME has corresponding elements in BASH_LINENO and BASH_SOURCE to describe the call stack. For instance, ${FUNCNAME[$i]} was called from the file ${BASH_SOURCE[$i+1]} at line number ${BASH_LINENO[$i]}. The caller builtin displays the current call stack using this information."
	},
	"$FUNCNEST": {
		"prefix": "$FUNCNEST",
		"body": [
			"\\${FUNCNEST}$0"
		],
		"scope": "",
		"description": "If set to a numeric value greater than 0, defines a maximum function nesting level. Function invocations that exceed this nesting level will cause the current command to abort."
	},
	"$GLOBIGNORE": {
		"prefix": "$GLOBIGNORE",
		"body": [
			"\\${GLOBIGNORE}$0"
		],
		"scope": "",
		"description": "A colon-separated list of patterns defining the set of file names to be ignored by filename expansion. If a file name matched by a filename expansion pattern also matches one of the patterns in GLOBIGNORE, it is removed from the list of matches. The pattern matching honors the setting of the extglob shell option."
	},
	"$GROUPS": {
		"prefix": "$GROUPS",
		"body": [
			"\\${GROUPS}$0"
		],
		"scope": "",
		"description": "An array variable containing the list of groups of which the current user is a member. Assignments to GROUPS have no effect. If GROUPS is unset, it loses its special properties, even if it is subsequently reset."
	},
	"$histchars": {
		"prefix": "$histchars",
		"body": [
			"\\${histchars}$0"
		],
		"scope": "",
		"description": "Up to three characters which control history expansion, quick substitution, and tokenization (see History Expansion). The first character is the history expansion character, that is, the character which signifies the start of a history expansion, normally ‘!’. The second character is the character which signifies ‘quick substitution’ when seen as the first character on a line, normally ‘^’. The optional third character is the character which indicates that the remainder of the line is a comment when found as the first character of a word, usually ‘#’. The history comment character causes history substitution to be skipped for the remaining words on the line. It does not necessarily cause the shell parser to treat the rest of the line as a comment."
	},
	"$HISTCMD": {
		"prefix": "$HISTCMD",
		"body": [
			"\\${HISTCMD}$0"
		],
		"scope": "",
		"description": "The history number, or index in the history list, of the current command. Assignments to HISTCMD are ignored. If HISTCMD is unset, it loses its special properties, even if it is subsequently reset."
	},
	"$HISTCONTROL": {
		"prefix": "$HISTCONTROL",
		"body": [
			"\\${HISTCONTROL}$0"
		],
		"scope": "",
		"description": "A colon-separated list of values controlling how commands are saved on the history list. If the list of values includes ‘ignorespace’, lines which begin with a space character are not saved in the history list. A value of ‘ignoredups’ causes lines which match the previous history entry to not be saved. A value of ‘ignoreboth’ is shorthand for ‘ignorespace’ and ‘ignoredups’. A value of ‘erasedups’ causes all previous lines matching the current line to be removed from the history list before that line is saved. Any value not in the above list is ignored. If HISTCONTROL is unset, or does not include a valid value, all lines read by the shell parser are saved on the history list, subject to the value of HISTIGNORE. The second and subsequent lines of a multi-line compound command are not tested, and are added to the history regardless of the value of HISTCONTROL."
	},
	"$HISTFILE": {
		"prefix": "$HISTFILE",
		"body": [
			"\\${HISTFILE}$0"
		],
		"scope": "",
		"description": "The name of the file to which the command history is saved. The default value is ~/.bash_history."
	},
	"$HISTFILESIZE": {
		"prefix": "$HISTFILESIZE",
		"body": [
			"\\${HISTFILESIZE}$0"
		],
		"scope": "",
		"description": "The maximum number of lines contained in the history file. When this variable is assigned a value, the history file is truncated, if necessary, to contain no more than that number of lines by removing the oldest entries. The history file is also truncated to this size after writing it when a shell exits. If the value is 0, the history file is truncated to zero size. Non-numeric values and numeric values less than zero inhibit truncation. The shell sets the default value to the value of HISTSIZE after reading any startup files."
	},
	"$HISTIGNORE": {
		"prefix": "$HISTIGNORE",
		"body": [
			"\\${HISTIGNORE}$0"
		],
		"scope": "",
		"description": "A colon-separated list of patterns used to decide which command lines should be saved on the history list. Each pattern is anchored at the beginning of the line and must match the complete line (no implicit ‘*’ is appended). Each pattern is tested against the line after the checks specified by HISTCONTROL are applied. In addition to the normal shell pattern matching characters, ‘&’ matches the previous history line. ‘&’ may be escaped using a backslash; the backslash is removed before attempting a match. The second and subsequent lines of a multi-line compound command are not tested, and are added to the history regardless of the value of HISTIGNORE. The pattern matching honors the setting of the extglob shell option. HISTIGNORE subsumes the function of HISTCONTROL. A pattern of ‘&’ is identical to ignoredups, and a pattern of ‘[ ]*’ is identical to ignorespace. Combining these two patterns, separating them with a colon, provides the functionality of ignoreboth."
	},
	"$HISTSIZE": {
		"prefix": "$HISTSIZE",
		"body": [
			"\\${HISTSIZE}$0"
		],
		"scope": "",
		"description": "The maximum number of commands to remember on the history list. If the value is 0, commands are not saved in the history list. Numeric values less than zero result in every command being saved on the history list (there is no limit). The shell sets the default value to 500 after reading any startup files."
	},
	"$HISTTIMEFORMAT": {
		"prefix": "$HISTTIMEFORMAT",
		"body": [
			"\\${HISTTIMEFORMAT}$0"
		],
		"scope": "",
		"description": "If this variable is set and not null, its value is used as a format string for strftime to print the time stamp associated with each history entry displayed by the history builtin. If this variable is set, time stamps are written to the history file so they may be preserved across shell sessions. This uses the history comment character to distinguish timestamps from other history lines."
	},
	"$HOSTFILE": {
		"prefix": "$HOSTFILE",
		"body": [
			"\\${HOSTFILE}$0"
		],
		"scope": "",
		"description": "Contains the name of a file in the same format as /etc/hosts that should be read when the shell needs to complete a hostname. The list of possible hostname completions may be changed while the shell is running; the next time hostname completion is attempted after the value is changed, Bash adds the contents of the new file to the existing list. If HOSTFILE is set, but has no value, or does not name a readable file, Bash attempts to read /etc/hosts to obtain the list of possible hostname completions. When HOSTFILE is unset, the hostname list is cleared."
	},
	"$HOSTNAME": {
		"prefix": "$HOSTNAME",
		"body": [
			"\\${HOSTNAME}$0"
		],
		"scope": "",
		"description": "The name of the current host."
	},
	"$HOSTTYPE": {
		"prefix": "$HOSTTYPE",
		"body": [
			"\\${HOSTTYPE}$0"
		],
		"scope": "",
		"description": "A string describing the machine Bash is running on."
	},
	"$IGNOREEOF": {
		"prefix": "$IGNOREEOF",
		"body": [
			"\\${IGNOREEOF}$0"
		],
		"scope": "",
		"description": "Controls the action of the shell on receipt of an EOF character as the sole input. If set, the value denotes the number of consecutive EOF characters that can be read as the first character on an input line before the shell will exit. If the variable exists but does not have a numeric value, or has no value, then the default is 10. If the variable does not exist, then EOF signifies the end of input to the shell. This is only in effect for interactive shells."
	},
	"$INPUTRC": {
		"prefix": "$INPUTRC",
		"body": [
			"\\${INPUTRC}$0"
		],
		"scope": "",
		"description": "The name of the Readline initialization file, overriding the default of ~/.inputrc."
	},
	"$INSIDE_EMACS": {
		"prefix": "$INSIDE_EMACS",
		"body": [
			"\\${INSIDE_EMACS}$0"
		],
		"scope": "",
		"description": "If Bash finds this variable in the environment when the shell starts, it assumes that the shell is running in an Emacs shell buffer and may disable line editing depending on the value of TERM."
	},
	"$LANG": {
		"prefix": "$LANG",
		"body": [
			"\\${LANG}$0"
		],
		"scope": "",
		"description": "Used to determine the locale category for any category not specifically selected with a variable starting with LC_."
	},
	"$LC_ALL": {
		"prefix": "$LC_ALL",
		"body": [
			"\\${LC_ALL}$0"
		],
		"scope": "",
		"description": "This variable overrides the value of LANG and any other LC_ variable specifying a locale category."
	},
	"$LC_COLLATE": {
		"prefix": "$LC_COLLATE",
		"body": [
			"\\${LC_COLLATE}$0"
		],
		"scope": "",
		"description": "This variable determines the collation order used when sorting the results of filename expansion, and determines the behavior of range expressions, equivalence classes, and collating sequences within filename expansion and pattern matching (see Filename Expansion)."
	},
	"$LC_CTYPE": {
		"prefix": "$LC_CTYPE",
		"body": [
			"\\${LC_CTYPE}$0"
		],
		"scope": "",
		"description": "This variable determines the interpretation of characters and the behavior of character classes within filename expansion and pattern matching (see Filename Expansion)."
	},
	"$LC_MESSAGES": {
		"prefix": "$LC_MESSAGES",
		"body": [
			"\\${LC_MESSAGES}$0"
		],
		"scope": "",
		"description": "This variable determines the locale used to translate double-quoted strings preceded by a ‘$’ (see Locale-Specific Translation)."
	},
	"$LC_NUMERIC": {
		"prefix": "$LC_NUMERIC",
		"body": [
			"\\${LC_NUMERIC}$0"
		],
		"scope": "",
		"description": "This variable determines the locale category used for number formatting."
	},
	"$LC_TIME": {
		"prefix": "$LC_TIME",
		"body": [
			"\\${LC_TIME}$0"
		],
		"scope": "",
		"description": "This variable determines the locale category used for data and time formatting."
	},
	"$LINENO": {
		"prefix": "$LINENO",
		"body": [
			"\\${LINENO}$0"
		],
		"scope": "",
		"description": "The line number in the script or shell function currently executing. If LINENO is unset, it loses its special properties, even if it is subsequently reset."
	},
	"$LINES": {
		"prefix": "$LINES",
		"body": [
			"\\${LINES}$0"
		],
		"scope": "",
		"description": "Used by the select command to determine the column length for printing selection lists. Automatically set if the checkwinsize option is enabled (see The Shopt Builtin), or in an interactive shell upon receipt of a SIGWINCH."
	},
	"$MACHTYPE": {
		"prefix": "$MACHTYPE",
		"body": [
			"\\${MACHTYPE}$0"
		],
		"scope": "",
		"description": "A string that fully describes the system type on which Bash is executing, in the standard GNU cpu-company-system format."
	},
	"$MAILCHECK": {
		"prefix": "$MAILCHECK",
		"body": [
			"\\${MAILCHECK}$0"
		],
		"scope": "",
		"description": "How often (in seconds) that the shell should check for mail in the files specified in the MAILPATH or MAIL variables. The default is 60 seconds. When it is time to check for mail, the shell does so before displaying the primary prompt. If this variable is unset, or set to a value that is not a number greater than or equal to zero, the shell disables mail checking."
	},
	"$MAPFILE": {
		"prefix": "$MAPFILE",
		"body": [
			"\\${MAPFILE}$0"
		],
		"scope": "",
		"description": "An array variable created to hold the text read by the mapfile builtin when no variable name is supplied."
	},
	"$OLDPWD": {
		"prefix": "$OLDPWD",
		"body": [
			"\\${OLDPWD}$0"
		],
		"scope": "",
		"description": "The previous working directory as set by the cd builtin."
	},
	"$OPTERR": {
		"prefix": "$OPTERR",
		"body": [
			"\\${OPTERR}$0"
		],
		"scope": "",
		"description": "If set to the value 1, Bash displays error messages generated by the getopts builtin command."
	},
	"$OSTYPE": {
		"prefix": "$OSTYPE",
		"body": [
			"\\${OSTYPE}$0"
		],
		"scope": "",
		"description": "A string describing the operating system Bash is running on."
	},
	"$PIPESTATUS": {
		"prefix": "$PIPESTATUS",
		"body": [
			"\\${PIPESTATUS}$0"
		],
		"scope": "",
		"description": "An array variable (see Arrays) containing a list of exit status values from the processes in the most-recently-executed foreground pipeline (which may contain only a single command)."
	},
	"$POSIXLY_CORRECT": {
		"prefix": "$POSIXLY_CORRECT",
		"body": [
			"\\${POSIXLY_CORRECT}$0"
		],
		"scope": "",
		"description": "If this variable is in the environment when Bash starts, the shell enters POSIX mode (see Bash POSIX Mode) before reading the startup files, as if the --posix invocation option had been supplied. If it is set while the shell is running, Bash enables POSIX mode, as if the command set -o posix had been executed. When the shell enters POSIX mode, it sets this variable if it was not already set."
	},
	"$PPID": {
		"prefix": "$PPID",
		"body": [
			"\\${PPID}$0"
		],
		"scope": "",
		"description": "The process ID of the shell’s parent process. This variable is readonly."
	},
	"$PROMPT_COMMAND": {
		"prefix": "$PROMPT_COMMAND",
		"body": [
			"\\${PROMPT_COMMAND}$0"
		],
		"scope": "",
		"description": "If this variable is set, and is an array, the value of each set element is interpreted as a command to execute before printing the primary prompt ($PS1). If this is set but not an array variable, its value is used as a command to execute instead."
	},
	"$PROMPT_DIRTRIM": {
		"prefix": "$PROMPT_DIRTRIM",
		"body": [
			"\\${PROMPT_DIRTRIM}$0"
		],
		"scope": "",
		"description": "If set to a number greater than zero, the value is used as the number of trailing directory components to retain when expanding the \\w and \\W prompt string escapes (see Controlling the Prompt). Characters removed are replaced with an ellipsis."
	},
	"$PS0": {
		"prefix": "$PS0",
		"body": [
			"\\${PS0}$0"
		],
		"scope": "",
		"description": "The value of this parameter is expanded like PS1 and displayed by interactive shells after reading a command and before the command is executed."
	},
	"$PS3": {
		"prefix": "$PS3",
		"body": [
			"\\${PS3}$0"
		],
		"scope": "",
		"description": "The value of this variable is used as the prompt for the select command. If this variable is not set, the select command prompts with ‘#? ’"
	},
	"$PS4": {
		"prefix": "$PS4",
		"body": [
			"\\${PS4}$0"
		],
		"scope": "",
		"description": "The value of this parameter is expanded like PS1 and the expanded value is the prompt printed before the command line is echoed when the -x option is set (see The Set Builtin). The first character of the expanded value is replicated multiple times, as necessary, to indicate multiple levels of indirection. The default is ‘+ ’."
	},
	"$PWD": {
		"prefix": "$PWD",
		"body": [
			"\\${PWD}$0"
		],
		"scope": "",
		"description": "The current working directory as set by the cd builtin."
	},
	"$RANDOM": {
		"prefix": "$RANDOM",
		"body": [
			"\\${RANDOM}$0"
		],
		"scope": "",
		"description": "Each time this parameter is referenced, it expands to a random integer between 0 and 32767. Assigning a value to this variable seeds the random number generator. If RANDOM is unset, it loses its special properties, even if it is subsequently reset."
	},
	"$READLINE_ARGUMENT": {
		"prefix": "$READLINE_ARGUMENT",
		"body": [
			"\\${READLINE_ARGUMENT}$0"
		],
		"scope": "",
		"description": "Any numeric argument given to a Readline command that was defined using ‘bind -x’ (see Bash Builtin Commands when it was invoked."
	},
	"$READLINE_LINE": {
		"prefix": "$READLINE_LINE",
		"body": [
			"\\${READLINE_LINE}$0"
		],
		"scope": "",
		"description": "The contents of the Readline line buffer, for use with ‘bind -x’ (see Bash Builtin Commands)."
	},
	"$READLINE_MARK": {
		"prefix": "$READLINE_MARK",
		"body": [
			"\\${READLINE_MARK}$0"
		],
		"scope": "",
		"description": "The position of the mark (saved insertion point) in the Readline line buffer, for use with ‘bind -x’ (see Bash Builtin Commands). The characters between the insertion point and the mark are often called the region."
	},
	"$READLINE_POINT": {
		"prefix": "$READLINE_POINT",
		"body": [
			"\\${READLINE_POINT}$0"
		],
		"scope": "",
		"description": "The position of the insertion point in the Readline line buffer, for use with ‘bind -x’ (see Bash Builtin Commands)."
	},
	"$REPLY": {
		"prefix": "$REPLY",
		"body": [
			"\\${REPLY}$0"
		],
		"scope": "",
		"description": "The default variable for the read builtin."
	},
	"$SECONDS": {
		"prefix": "$SECONDS",
		"body": [
			"\\${SECONDS}$0"
		],
		"scope": "",
		"description": "This variable expands to the number of seconds since the shell was started. Assignment to this variable resets the count to the value assigned, and the expanded value becomes the value assigned plus the number of seconds since the assignment. The number of seconds at shell invocation and the current time are always determined by querying the system clock. If SECONDS is unset, it loses its special properties, even if it is subsequently reset."
	},
	"$SHELL": {
		"prefix": "$SHELL",
		"body": [
			"\\${SHELL}$0"
		],
		"scope": "",
		"description": "This environment variable expands to the full pathname to the shell. If it is not set when the shell starts, Bash assigns to it the full pathname of the current user’s login shell."
	},
	"$SHELLOPTS": {
		"prefix": "$SHELLOPTS",
		"body": [
			"\\${SHELLOPTS}$0"
		],
		"scope": "",
		"description": "A colon-separated list of enabled shell options. Each word in the list is a valid argument for the -o option to the set builtin command (see The Set Builtin). The options appearing in SHELLOPTS are those reported as ‘on’ by ‘set -o’. If this variable is in the environment when Bash starts up, each shell option in the list will be enabled before reading any startup files. This variable is readonly."
	},
	"$SHLVL": {
		"prefix": "$SHLVL",
		"body": [
			"\\${SHLVL}$0"
		],
		"scope": "",
		"description": "Incremented by one each time a new instance of Bash is started. This is intended to be a count of how deeply your Bash shells are nested."
	},
	"$SRANDOM": {
		"prefix": "$SRANDOM",
		"body": [
			"\\${SRANDOM}$0"
		],
		"scope": "",
		"description": "This variable expands to a 32-bit pseudo-random number each time it is referenced. The random number generator is not linear on systems that support /dev/urandom or arc4random, so each returned number has no relationship to the numbers preceding it. The random number generator cannot be seeded, so assignments to this variable have no effect. If SRANDOM is unset, it loses its special properties, even if it is subsequently reset."
	},
	"$TIMEFORMAT": {
		"prefix": "$TIMEFORMAT",
		"body": [
			"\\${TIMEFORMAT}$0"
		],
		"scope": "",
		"description": "The value of this parameter is used as a format string specifying how the timing information for pipelines prefixed with the time reserved word should be displayed. The ‘%’ character introduces an escape sequence that is expanded to a time value or other information. If the value is null, no timing information is displayed. A trailing newline is added when the format string is displayed."
	},
	"$TMOUT": {
		"prefix": "$TMOUT",
		"body": [
			"\\${TMOUT}$0"
		],
		"scope": "",
		"description": "If set to a value greater than zero, TMOUT is treated as the default timeout for the read builtin (see Bash Builtin Commands). The select command (see Conditional Constructs) terminates if input does not arrive after TMOUT seconds when input is coming from a terminal. In an interactive shell, the value is interpreted as the number of seconds to wait for a line of input after issuing the primary prompt. Bash terminates after waiting for that number of seconds if a complete line of input does not arrive."
	},
	"$TMPDIR": {
		"prefix": "$TMPDIR",
		"body": [
			"\\${TMPDIR}$0"
		],
		"scope": "",
		"description": "If set, Bash uses its value as the name of a directory in which Bash creates temporary files for the shell’s use."
	},
	"$UID": {
		"prefix": "$UID",
		"body": [
			"\\${UID}$0"
		],
		"scope": "",
		"description": "The numeric real user id of the current user. This variable is readonly."
	},
	"$BASH": {
		"prefix": "$BASH",
		"description": "The full pathname used to execute the current instance of Bash. ",
		"scope": "",
		"body": [
			"\\${BASH}$0"
		]
	},
	"$_": {
		"prefix": "$_",
		"description": "",
		"scope": "",
		"body": [
			"\\${_}$0"
		]
	},
	"$CDPATH": {
		"prefix": "$CDPATH",
		"description": "A colon-separated list of directories used as a search path for the cd builtin command.",
		"scope": "",
		"body": [
			"\\${CDPATH}$0"
		]
	},
	"$PS2": {
		"prefix": "$PS2",
		"description": "The secondary prompt string. The default value is ‘> ’. PS2 is expanded in the same way as PS1 before being displayed.",
		"scope": "",
		"body": [
			"\\${PS2}$0"
		]
	},
	"$PS1": {
		"prefix": "$PS1",
		"description": "The primary prompt string. The default value is ‘\\s-\\v\\${ ’}. See Controlling the Prompt, for the complete list of escape sequences that are expanded before PS1 is displayed. ",
		"scope": "",
		"body": [
			"\\${PS1}$0"
		]
	},
	"$PATH": {
		"prefix": "$PATH",
		"description": "A colon-separated list of directories in which the shell looks for commands. A zero-length (null) directory name in the value of PATH indicates the current directory. A null directory name may appear as two adjacent colons, or as an initial or trailing colon. ",
		"scope": "",
		"body": [
			"\\${PATH}$0"
		]
	},
	"$OPTIND": {
		"prefix": "$OPTIND",
		"description": "The index of the last option argument processed by the getopts builtin. ",
		"scope": "",
		"body": [
			"\\${OPTIND}$0"
		]
	},
	"$OPTARG": {
		"prefix": "$OPTARG",
		"description": "The value of the last option argument processed by the getopts builtin.",
		"scope": "",
		"body": [
			"\\${OPTARG}$0"
		]
	},
	"$MAILPATH": {
		"prefix": "$MAILPATH",
		"description": "A colon-separated list of filenames which the shell periodically checks for new mail. Each list entry can specify the message that is printed when new mail arrives in the mail file by separating the filename from the message with a ‘?’. When used in the text of the message, $_ expands to the name of the current mail file.",
		"scope": "",
		"body": [
			"\\${MAILPATH}$0"
		]
	},
	"$MAIL": {
		"prefix": "$MAIL",
		"description": "If this parameter is set to a filename or directory name and the MAILPATH variable is not set, Bash informs the user of the arrival of mail in the specified file or Maildir-format directory.",
		"scope": "",
		"body": [
			"\\${MAIL}$0"
		]
	},
	"$IFS": {
		"prefix": "$IFS",
		"description": "A list of characters that separate fields; used when the shell splits words as part of expansion. ",
		"scope": "",
		"body": [
			"\\${IFS}$0"
		]
	},
	"$HOME": {
		"prefix": "$HOME",
		"description": "The current user’s home directory; the default for the cd builtin command. The value of this variable is also used by tilde expansion.",
		"scope": "",
		"body": [
			"\\${HOME}$0"
		]
	}
}
```

**Error** output:

```log
INFO     Generating documentation for the core functions only.
INFO     Found 137 functions with documentation.
INFO     The documentation has been generated in ⌜/tmp/valet.d/d1-1/lib-valet.md⌝.
INFO     The prototype script has been generated in ⌜/tmp/valet.d/d1-1/lib-valet⌝.
INFO     The vscode snippets have been generated in ⌜/tmp/valet.d/d1-1/valet.code-snippets⌝.
```

