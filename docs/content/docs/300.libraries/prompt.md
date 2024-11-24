---
title: 📂 prompt
cascade:
  type: docs
url: /docs/libraries/prompt
---

## prompt::autocompletion

Displays an autocompletion input starting at a given location. Allows
the user to type a text in the given row betwen a starting column and
ending column (included). Longer text are shifted to fit between
the two columns.

This component is a replacement for the `read -e` command, which allows
to limit the input to a single line and to provide autocompletion.

The autocompletion box can be hidden, or displayed below/above the input text
depending on the space available on the screen.

The user can type character to filter down a list of suggestions,
navigate up and down between suggestions, insert a suggestion using
TAB or ENTER, press ESC to close the autocompletion box, and ALT+ENTER to
submit the input (or just ENTER when the box is closed).

The autocompletion box will position itself depending on the screen size
and the starting position of the text.

The multiple options allows to use this function to ask for any user input
as long as it is on a single line.

You can define several callback functions that are called on different events:

- `autocompletionOnTextUpdate`: Called when the text is updated (after each key press).

- $1: **start line** _as int_:
      The line/row at which the autocompleted text starts (this is used to
      compute how to display the box).
- $2: **start column** _as int_:
      The column at which the autocompleted text starts (this is used to
      compute how to display the box).
- $3: **stop column** _as int_:
      The column at which to stop showing the autocompleted text.
      Longer texts get shifted to display the end of the user input.
- $4: **array name** _as string_:
      The items to display (name of a global array which contains the items).
      If left empty, the autocompletion box will not be displayed. Useful to turn this into a simple prompt.
- $5: initial text _as string_:
      (optional) The initial string, which corresponds to the text already entered
      by the user at the moment the autocompletion box shows up.
      Allows to prefilter the autocompletion.
      (defaults to empty)
- $6: max lines _as int_:
      optional) The maximum number of lines/rows to use for the autocompletion box.
      (defaults to a maximized auto-computed value depending on the items and screen size)
- $7: force box below _as bool_:
      (optional) If true, the box is forced to be displayed below the input text.
      Otherwise it will depend on the space required and space available below/above.
      (defaults to false)
- $8: show prompt _as bool_:
      (optional) If true, the prompt is displayed. If false, the prompt is hidden.
      Useful to turn this into a simple multiple choice list.
      (defaults to true)
- $9: force show count _as bool_:
      (optional) If true, the count of items is always displayed.
      If false, the count is only displayed when we can'y display all the items at once.
      (defaults to false)
- $10: show left cursors _as bool_:
      (optional) If true, the left cursors are displayed (> for prompt and the > for selected item).
      Useful to display the most simple auto-completion when false.
      (defaults to true)
- $11: filters from n chars _as int_:
      (optional) The minimum number of characters to type before starting to filter the items.
      By default, the list is shown full and the user can start typing to filter.
      Put a value superior to 0 to make it behave like a standard autocompletion.
      When non-zero, the user can CTRL+SPACE to show the full list.
      (defaults to 0)
- $12: accept any value _as bool_:
      (optional) If true, the left cursors are displayed (> for prompt and the > for selected item).
      Useful to display the most simple auto-completion when false.
      (defaults to true)

Returns:

- $?:
  - 0: The user pressed ENTER to validate the text.
  - 1: The user pressed ESC to close the text box.
- `RETURNED_VALUE`: The entered value (or empty).
- `RETURNED_VALUE2`: The string displayed on the screen between the 2 columns at the
                     moment when the autocompletion was closed.

```bash
prompt::autocompletion "Select an item" item_array_name "onItemSelected" "Details"
```




> Documentation generated for the version 0.25.3 (2024-11-24).
