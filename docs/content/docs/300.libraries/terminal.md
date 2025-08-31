---
title: 📂 terminal
cascade:
  type: docs
url: /docs/libraries/terminal
---

## ⚡ terminal::clearBox

Clear a "box" in the terminal.
Will return the cursor at the current position at the end (using GLOBAL_CURSOR_LINE and GLOBAL_CURSOR_COLUMN).

Inputs:

- `${top}` _as int_:

  (optional) the top position of the box

  (defaults to 1)

- `${left}` _as int_:

  (optional) the left position of the box

  (defaults to 1)

- `${width}` _as int_:

  (optional) the width of the box

  (defaults to "${GLOBAL_COLUMNS}")

- `${height}` _as int_:

  (optional) the height of the box

  (defaults to "${GLOBAL_LINES}")

Example usage:

```bash
terminal::getCursorPosition
terminal::clearBox top=1 left=1 width=10 height=5
```

## ⚡ terminal::clearKeyPressed

This function reads all the inputs from the user, effectively discarding them.

Example usage:

```bash
terminal::clearKeyPressed
```

## ⚡ terminal::createSpace

This function creates empty lines from the current cursor position.
Then it moves back to its original line (at the column 1).
The current cursor line counts, meaning that `terminal::createSpace 1` will
not do anything but clear the current line.

This effectively creates a space in the terminal (scroll up if we are at the bottom).
It does not create more space than the number of lines in the terminal.

Inputs:

- `$1`: **number of lines** _as int_:

  the number of lines to create

Example usage:

```bash
terminal::createSpace 5
```

## ⚡ terminal::getBestAutocompleteBox

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

Inputs:

- `${top}` _as int_:

  (optional) the current line of the cursor (1 based)

  (defaults to 1)

- `${left}` _as int_:

  (optional) the current column of the cursor (1 based)

  (defaults to 1)

- `${desiredHeight}` _as int_:

  (optional) the desired height of the box

  (defaults to "${GLOBAL_LINES}")

- `${desiredWidth}` _as int_:

  (optional) the desired width of the box

  (defaults to "${GLOBAL_COLUMNS}")

- `${maxHeight}` _as int_:

  (optional) the maximum height of the box

  (defaults to "${GLOBAL_LINES}")

- `${forceBelow}` _as bool_:

  (optional) force the box to be below the current position

  (defaults to false)

- `${notOnCurrentLine}` _as bool_:

  (optional) the box will not be placed on the same line as the current position

  (defaults to true)

- `${terminalHeight}` _as int_:

  (optional) the height of the terminal

  (defaults to "${GLOBAL_LINES}")

- `${terminalWidth}` _as int_:

  (optional) the width of the terminal

  (defaults to "${GLOBAL_COLUMNS}")

Returns:

- `${REPLY}`: the top position of the box (1 based)
- `${REPLY2}`: the left position of the box (1 based)
- `${REPLY3}`: the width of the box
- `${REPLY4}`: the height of the box

Example usage:

```bash
terminal::getBestAutocompleteBox top=1 left=1 desiredHeight=10 desiredWidth=5
```

## ⚡ terminal::getCursorPosition

Get the current cursor position.

Returns:

- `GLOBAL_CURSOR_LINE`: the line number
- `GLOBAL_CURSOR_COLUMN`: the column number

Example usage:

```bash
terminal::getCursorPosition
```

## ⚡ terminal::getTerminalSize

This function exports the terminal size.

Returns:

- `GLOBAL_COLUMNS`: The number of columns in the terminal.
- `GLOBAL_LINES`: The number of lines in the terminal.

Example usage:

```bash
terminal::getTerminalSize
printf '%s\n' "The terminal has ⌜${GLOBAL_COLUMNS}⌝ columns and ⌜${GLOBAL_LINES}⌝ lines."
```

## ⚡ terminal::rebindKeymap

Rebinds all special keys to call a given callback function.
See @terminal::testWaitForKeyPress for an implementation example.

This allows to use the `-e` option with the read command and receive events for special key press.


This function should be called before using terminal::waitForKeyPress.

You can call `terminal::restoreBindings` to restore the default bindings. However, this is not
necessary as the bindings are local to the script.

Inputs:

- `$1`: **callback function** _as string_:

  The function name to call when a special key is pressed.

## ⚡ terminal::rerouteLogs

Reroute the logs to a temporary file.
The logs will be displayed when calling `terminal::restoreLogs`

Example usage:

```bash
terminal::rerouteLogs
```

## ⚡ terminal::restoreBindings

Reset the key bindings to the default ones.
To be called after `terminal::rebindKeymap`.

Example usage:

```bash
terminal::restoreBindings
```

## ⚡ terminal::restoreInterruptTrap

Restore the original trap for the interrupt signal (SIGINT).
To be called after terminal::setInterruptTrap.

Example usage:

```bash
terminal::restoreInterruptTrap
```

## ⚡ terminal::restoreLogs

Restore the logs to their original state.
Should be called after `terminal::rerouteLogs` and at the end of an interactive session.

Example usage:

```bash
terminal::restoreLogs
```

## ⚡ terminal::restoreSettings

Restore the terminal options to their original state.
Should be called after `terminal::setRawMode`.

Example usage:

```bash
terminal::restoreSettings
```

> Note that the bash read builtin will restore stty state as it was before entering.
> So you want to call this after all read has been finished (particularly, you want to kill
> any background process that is reading inputs before trying to restore these settings).

## ⚡ terminal::setRawMode

Put the terminal in "raw" mode.
Set options to enable a satisfying and consistent behavior for the GNU readline library.
Call `terminal::restoreSettings` to restore the original settings.

Example usage:

```bash
terminal::setRawMode
```

## ⚡ terminal::switchBackFromFullScreen

Call this function to switch back from the full screen mode.

- This function will restore the terminal state and show the cursor.
- It will also restore the key echoing.

Example usage:

```bash
terminal::switchBackFromFullScreen
```

## ⚡ terminal::switchToFullScreen

Call this function to start an interactive session in full screen mode.
This function will switch to the alternate screen, hide the cursor and clear the screen.

You should call terminal::switchBackFromFullScreen at the end of the interactive session.

Example usage:

```bash
terminal::switchToFullScreen
```

## ⚡ terminal::testWaitForChar

Wait for the user to send a character to stdin (i.e. wait for a key press)
and prints the character that bash reads.

Useful to test the `terminal::waitForChar` function and see the char sequence we
get when pressing a key in a given terminal.

See @terminal::waitForChar for more information.

Example usage:

```bash
terminal::testWaitForChar
```

## ⚡ terminal::waitForChar

Wait for a user input (single char).
You can pass additional parameters to the read command (e.g. to wait for a set amount of time).

It uses the read builtin command. This will not detect all key combinations.
The output will depend on the terminal used and the character sequences it sends on each key press.

Some special keys are translated into more readable strings:
UP, DOWN, RIGHT, LEFT, BACKSPACE, DEL, PAGE_UP, PAGE_DOWN, HOME, END, ESC, F1, ALT+?.
However, this is not at all exhaustive and will depend on the terminal used.
Use `terminal::waitForKeyPress` if you need to listen to special keys.

This simple implementation does not rely on GNU readline and does not require terminal options
to be set using `terminal::setRawMode`.


Inputs:

- `$@`: **read parameters** _as any_:

  additional parameters to pass to the read command

Returns:

- `$?`:
  - 0 if a char was retrieved
  - 1 otherwise
- `LAST_KEY_PRESSED`: the last char (key) retrieved.

Example usage:

```bash
terminal::waitForChar
terminal::waitForChar -t 0.1
```

> <https://en.wikipedia.org/wiki/ANSI_escape_code#Terminal_input_sequences>

## ⚡ terminal::waitForKeyPress

Wait for a key press (single key).
You can pass additional parameters to the read command (e.g. to wait for a set amount of time).

It uses the read builtin command with the option `-e` to use readline behind the scene.
This means we can detect more key combinations but all keys needs to be bound first...
Special keys (CTRL+, ALT+, F1-F12, arrows, etc.) are intercepted using binding.

You must call `terminal::rebindKeymap` and `terminal::setRawMode` before using this function.
You should use `tui::start` instead of using this function directly.

Inputs:

- `$@`: **read parameters** _as any_:

  additional parameters to pass to the read command

Returns:

- `$?`:
  - 0 if a key was pressed
  - 1 otherwise
- `LAST_KEY_PRESSED`: the key pressed.

Example usage:

```bash
terminal::waitForKeyPress
terminal::waitForKeyPress -t 0.1
```

> There are issues when using readline in bash:
>
> 1. if the cursor is at the end of the screen, it will make the screen scroll
>    even when nothing is read... Make sure to not position the cursor at the end of the screen.
> 2. When read is done, it will print a new line in stderr. So we redirect stderr to null.
>    This means that if you print something to stderr in a readline bound function, you will see nothing
>    As a workaround, do this in your callback function: `exec 2>&"${GLOBAL_FD_LOG}"`
> 3. Not all key combinations can be bound, like SHIFT+ENTER. This is inherent to the way terminals work,
>    they send a sequence of characters when a key is pressed and this sequence is read by readline/bash.
>    For advanced key combinations, you will need to use a terminal that allows to remap such keys
>    and send a specific sequence of characters that you can bind in bash.

> [!IMPORTANT]
> Documentation generated for the version 0.32.168 (2025-08-31).
