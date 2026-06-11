---
title: 📂 interactive
cascade:
  type: docs
url: /docs/libraries/interactive
---

## ⚡ interactive::confirm

Ask the user to yes or no.

- The user can switch between the two options with the arrow keys or space.
- The user can validate the choice with the enter key.
- The user can also validate immediately with the y or n key.

Dialog boxes are displayed for the question and answer.

Inputs:

- `$1`: **prompt** _as string_:

  the prompt to display

- `${default}` _as bool_:

  (optional) the default value to select

  (defaults to true)

Returns:

- `$?`:
  - 0 if the user answered yes
  - 1 otherwise
- `${REPLY}`: true or false.

Example usage:

```bash
if interactive::confirm "Do you want to continue?"; then echo "Yes."; else echo "No."; fi
```

## ⚡ interactive::confirmRaw

Ask the user to yes or no.

- The user can switch between the two options with the arrow keys or space.
- The user can validate the choice with the enter key.
- The user can also validate immediately with the y or n key.

This raw version does not display the prompt or the answer.

Inputs:

- `${default}` _as bool_:

  (optional) the default value to select

  (defaults to true)

Returns:

- `$?`:
  - 0 if the user answered yes
  - 1 otherwise
- `${REPLY}`: true or false.

Example usage:

```bash
interactive::confirmRaw "Do you want to continue?" && local answer="${REPLY}"
```

## ⚡ interactive::continue

Ask the user to press the button to continue.

Inputs:

- `$1`: **prompt** _as string_:

  the prompt to display

Returns:

- `$?`:
  - 0 if the user pressed enter
  - 1 otherwise

Example usage:

```bash
interactive::continue "Press enter to continue."
```

## ⚡ interactive::continueRaw

Ask the user to press the button to continue.

This raw version does not display the prompt or the answer.

Returns:

- `$?`:
  - 0 if the user pressed enter
  - 1 otherwise

Example usage:

```bash
interactive::continueRaw
```

## ⚡ interactive::displayAnswer

Displays an answer to a previous question.

The text is wrapped and put inside a box like so:

```text
    ╭─────╮
    │ No. ├──░
    ╰─────╯
```

Inputs:

- `$1`: **answer** _as string_:

  the answer to display

- `${width}` _as int_:

  (optional) the maximum width of the text in the dialog box

  (defaults to "${GLOBAL_COLUMNS}")

Example usage:

```bash
interactive::displayAnswer "My answer."
```

## ⚡ interactive::displayQuestion

Displays a question to the user.

The text is wrapped and put inside a box like so:

```text
   ╭────────────────────────────────╮
░──┤ Is this an important question? │
   ╰────────────────────────────────╯
```

Inputs:

- `$1`: **prompt** _as string_:

  the prompt to display

- `${width}` _as int_:

  (optional) the maximum width of the text in the dialog box

  (defaults to "${GLOBAL_COLUMNS}")

Example usage:

```bash
interactive::displayPrompt "Do you want to continue?"
```

> [!IMPORTANT]
> Documentation generated for the version 0.42.13 (2026-06-11).
