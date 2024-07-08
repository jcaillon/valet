---
title: 📂 fsfs
cascade:
  type: docs
url: /docs/libraries/fsfs
---

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
fsfs::itemSelector "Select an item" item_array_name "onItemSelected" "Details"
```




> Documentation generated for the version 0.18.426 (2024-07-08).
