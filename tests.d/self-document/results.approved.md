# Test suite self-document

## Test script 01.self-document

### Testing selfDocument



Exit code: `0`

**Standard output**:

```text
→ selfDocument --output /tmp/valet.d/d1-2 --core-only

→ head --lines 40 /tmp/valet.d/d1-2/lib-valet.md
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

→ head --lines 40 /tmp/valet.d/d1-2/lib-valet
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

→ head --lines 40 /tmp/valet.d/d1-2/valet.code-snippets
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
```

**Error output**:

```text
INFO     Generating documentation for the core functions only.
INFO     Found 159 functions with documentation.
INFO     The documentation has been generated in ⌜/tmp/valet.d/d1-2/lib-valet.md⌝.
INFO     The prototype script has been generated in ⌜/tmp/valet.d/d1-2/lib-valet⌝.
INFO     The vscode snippets have been generated in ⌜/tmp/valet.d/d1-2/valet.code-snippets⌝.
```

