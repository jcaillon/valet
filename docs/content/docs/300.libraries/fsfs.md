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

- $1: The prompt to display to the user (e.g. Please pick an item).
- $2: The items to display.
- $3: (optional) The function to call when an item is selected
  (this parameter can be left empty to hide the preview right pane):
  - the 1st param is the current item
  - 2nd param is the item number;
  - 3rd is the current panel width;
  - it should return the details of the item in the RETURNED_VALUE variable.
- $4: (optional) the title of the preview right pane (if any)

Returns:

- `RETURNED_VALUE`: The selected item value (or empty).
- `RETURNED_VALUE2`: The selected item index (from the original array).
                     Or -1 if the user cancelled the selection

```bash
fsfs::itemSelector "Select an item" item_array_name "onItemSelected" "Details"
```




> Documentation generated for the version 0.17.112 (2024-06-06).
