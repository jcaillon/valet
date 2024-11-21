---
title: 📂 codes
cascade:
  type: docs
url: /docs/libraries/codes
---

## ansi-codes::*

ANSI codes for text attributes, colors, cursor control, and other common escape sequences.
These codes can be used to format text in the terminal.

They are defined as variables and not as functions. Please check the content of the lib-ansi-codes to learn more:
<https://github.com/jcaillon/valet/blob/latest/valet.d/lib-ansi-codes>

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

> While it could be very handy to define a function for each of these instructions,
> it would also be slower to execute (function overhead + multiple printf calls).




> Documentation generated for the version 1.3.1 (2024-11-21).
