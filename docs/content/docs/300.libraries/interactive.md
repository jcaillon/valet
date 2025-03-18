---
title: 📂 interactive
cascade:
  type: docs
url: /docs/libraries/interactive
---

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

## interactive::displayAnswer

Displays an answer to a previous question.

The text is wrapped and put inside a box like so:

```text
    ╭─────╮
    │ No. ├──░
    ╰─────╯
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
   ╭────────────────────────────────╮
░──┤ Is this an important question? │
   ╰────────────────────────────────╯
```

- $1: **prompt** _as string_:
      the prompt to display
- $2: max width _as int_:
      (optional) the maximum width of text in the dialog box
      (defaults to GLOBAL_COLUMNS)

```bash
interactive::displayPrompt "Do you want to continue?"
```

## interactive::promptYesNo

Ask the user to yes or no.

- The user can switch between the two options with the arrow keys or space.
- The user can validate the choice with the enter key.
- The user can also validate immediately with the y or n key.

Dialog boxes are displayed for the question and answer.

- $1: **prompt** _as string_:
      the prompt to display
- $2: default _as bool_:
      (optional) the default value to select
      (defaults to true)

Returns:

- $?:
  - 0 if the user answered yes
  - 1 otherwise
- ${RETURNED_VALUE}: true or false.

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
- ${RETURNED_VALUE}: true or false.

```bash
interactive::promptYesNoRaw "Do you want to continue?" && local answer="${RETURNED_VALUE}"
```

> Documentation generated for the version 0.28.3846 (2025-03-18).
