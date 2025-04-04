---
title: 📂 sfzf
cascade:
  type: docs
url: /docs/libraries/sfzf
---

## sfzf::show

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

- ${RETURNED_VALUE}: The selected item value (or empty).
- ${RETURNED_VALUE2}: The selected item index (from the original array).
                     Or -1 if the user cancelled the selection

```bash
declare -g -a SELECTION_ARRAY
SELECTION_ARRAY=("blue" "red" "green" "yellow")
sfzf::show "What's your favorite color?" SELECTION_ARRAY
log::info "You selected: ⌜${RETURNED_VALUE}⌝ (index: ⌜${RETURNED_VALUE2}⌝)"
```

{{< callout type="info" >}}
Documentation generated for the version 0.29.197 (2025-03-29).
{{< /callout >}}
