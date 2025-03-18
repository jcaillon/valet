---
title: 📂 codes
cascade:
  type: docs
url: /docs/libraries/codes
---

## esc-codes::*

ANSI codes for text attributes, colors, cursor control, and other common escape sequences.
These codes can be used to format text in the terminal.

These codes were selected because they are widely supported by terminals and they
probably will cover all use cases. It is also advised to stick to the 4-bit colors
which allows your application to adopt the color scheme of the terminal.

They are defined as variables and not as functions. Please check the content of the esc-codes to learn more:
<https://github.com/jcaillon/valet/blob/latest/libraries.d/esc-codes>

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

> Documentation generated for the version 0.28.3846 (2025-03-18).
