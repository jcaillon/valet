---
title: 📂 interactive
cascade:
  type: docs
url: /docs/libraries/interactive
---

## interactive::switchBackFromFullScreen

Call this function to switch back from the full screen mode.

- This function will restore the terminal state and show the cursor.
- It will also restore the key echoing.
- If there were error messages during the interactive session, they will be displayed at the end.

```bash
interactive::switchBackFromFullScreen
```


## interactive::displayAnswer

Displays an answer to a previous question.

The text is wrapped and put inside a box like so:

```text
 ┌────────────┐
 │ My answer. │
/└────────────┘
```

- $1: **answer** _as string_:
     the answer to display
- $2: max width _as int_:
     (optional) the maximum width of the dialog box
     (defaults to GLOBAL_COLUMNS)

```bash
interactive::displayAnswer "My answer."
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


## interactive::getCursorPosition

Get the current cursor position.

Returns:

- `CURSOR_LINE`: the line number
- `CURSOR_COLUMN`: the column number

```bash
interactive::getCursorPosition
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


## interactive::testKeys

Wait for a user input and prints the character that bash sees.
Useful to program key bindings.

```bash
interactive::testKeys
```


## interactive::displayDialogBox

Displays a dialog box with a speaker and a text.

- $1: **speaker** _as string_:
     the speaker (system or user)
- $2: **text** _as string_:
     the text to display
- $3: max width _as int_:
     (optional) the maximum width of the dialog box
     (defaults to GLOBAL_COLUMNS)

```bash
interactive::displayDialogBox "system" "This is a system message."
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


## interactive::displayQuestion

Displays a question to the user.

The text is wrapped and put inside a box like so:

```text
  ┌────────────┐
  │ My prompt. │
  └────────────┘\
```

- $1: **prompt** _as string_:
     the prompt to display
- $2: max width _as int_:
     (optional) the maximum width of the dialog box
     (defaults to GLOBAL_COLUMNS)

```bash
interactive::displayPrompt "Do you want to continue?"
```


## interactive::waitForKey

Wait for a user input (single key).
You can pass additional parameters to the read command (e.g. to wait for a set amount of time).

Some special keys are translated into more readable strings:
UP, DOWN, RIGHT, LEFT, BACKSPACE, DEL, PAGE_UP, PAGE_DOWN, HOME, END, ESC, F1-F12, ALT+...

- $@: **read parameters** _as any_:
     additional parameters to pass to the read command

Returns:

- $?:
  - 0 if a key was pressed
  - 1 otherwise
- `LAST_KEY_PRESSED`: the key pressed.

```bash
interactive::waitForKey
interactive::waitForKey -t 0.1
```

> <https://en.wikipedia.org/wiki/ANSI_escape_code#Terminal_input_sequences>


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




> Documentation generated for the version 0.18.87 (2024-06-16).
