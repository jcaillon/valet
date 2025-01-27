# Test suite self-setup

## Test script 00.self-setup

### ✅ Testing self setup command

❯ `rm -f "${VALET_CONFIG_FILE}"`

❯ `echo nn | selfSetup`

**Standard output**:

```text
─────────────────────────────────────
CINThis is a COLOR CHECK, this line should be COLORED (in cyan by default).CDE
CSUThis is a COLOR CHECK, this line should be COLORED (in green by default).CDE
─────────────────────────────────────
[2m   ┌─[56b─┐[0m
[2m░──┤[0m Do you see the colors in the color check above the line? [63G[2m│[0m
[2m   └─[56b─┘[0m
[?25l[1G[0J[1S[1F[?25h[?25l[7m   (Y)ES   [0m      (N)O   [0m[1G[0K[?25h[2m[9G┌─[3b─┐[0m
[2m[9G│[0m No. [15G[2m├──░[0m
[2m[9G└─[3b─┘[0m
─────────────────────────────────────
This is a nerd icon check, check out the next lines:
A cross within a square: IE
A warning sign: IW
A checked box: IS
An information icon: II
─────────────────────────────────────
[2m   ┌─[69b─┐[0m
[2m░──┤[0m Do you correctly see the nerd icons in the icon check above the line? [76G[2m│[0m
[2m   └─[69b─┘[0m
[?25l[1G[0J[1S[1F[?25h[?25l   (Y)ES   [0m   [7m   (N)O   [0m[1G[0K[?25h[2m[9G┌─[3b─┐[0m
[2m[9G│[0m No. [15G[2m├──░[0m
[2m[9G└─[3b─┘[0m
```

**Error output**:

```text
INFO     Now setting up Valet.
INFO     If you see the replacement character ? in my terminal, it means you don't have a nerd-font setup in your terminal.
You can download any font here: https://www.nerdfonts.com/font-downloads and install it.
After that, you need to setup your terminal to use this newly installed font.
You can run the command ⌜valet self setup⌝ again after that.
INFO     Creating the valet config file ⌜/tmp/valet-temp⌝.
SUCCESS  You are all set!
INFO     As a reminder, you can modify the configuration done during this set up by either:
- replaying the command ⌜valet self setup⌝,
- running the command ⌜valet self config⌝.
INFO     Run ⌜valet --help⌝ to get started.
INFO     You can create your own commands and have them available in valet, please check https://jcaillon.github.io/valet/docs/new-commands/ to do so.
```

```text
VALET_CONFIG_ENABLE_COLORS='false'
VALET_CONFIG_ENABLE_NERDFONT_ICONS='false'
```

❯ `fs::head /tmp/valet-temp 3`

**Standard output**:

```text
#!/usr/bin/env bash
# description: This script declares global variables used to configure Valet
# shellcheck disable=SC2034
```

❯ `rm -f "${VALET_CONFIG_FILE}"`

**Standard output**:

```text
→ echo yy | selfSetup
─────────────────────────────────────
CINThis is a COLOR CHECK, this line should be COLORED (in cyan by default).CDE
CSUThis is a COLOR CHECK, this line should be COLORED (in green by default).CDE
─────────────────────────────────────
[2m   ┌─[56b─┐[0m
[2m░──┤[0m Do you see the colors in the color check above the line? [63G[2m│[0m
[2m   └─[56b─┘[0m
[?25l[1G[0J[1S[1F[?25h[?25l[7m   (Y)ES   [0m      (N)O   [0m[1G[0K[?25h[2m[9G┌─[4b─┐[0m
[2m[9G│[0m Yes. [16G[2m├──░[0m
[2m[9G└─[4b─┘[0m
─────────────────────────────────────
This is a nerd icon check, check out the next lines:
A cross within a square: IE
A warning sign: IW
A checked box: IS
An information icon: II
─────────────────────────────────────
[2m   ┌─[69b─┐[0m
[2m░──┤[0m Do you correctly see the nerd icons in the icon check above the line? [76G[2m│[0m
[2m   └─[69b─┘[0m
[?25l[1G[0J[1S[1F[?25h[?25l[7mCUB   (Y)ES   [0m   [7mCAB   (N)O   [0m[1G[0K[?25h[2m[9G┌─[4b─┐[0m
[2m[9G│[0m Yes. [16G[2m├──░[0m
[2m[9G└─[4b─┘[0m
```

**Error output**:

```text
INFO     Now setting up Valet.
CININFO    II  CDE Creating the valet config file CHI⌜/tmp/valet-temp⌝CDE.
CSUSUCCESS IS  CDE You are all set!
CININFO    II  CDE As a reminder, you can modify the configuration done during this set up by either:
- replaying the command CHI⌜valet self setup⌝CDE,
- running the command CHI⌜valet self config⌝CDE.
CININFO    II  CDE Run CHI⌜valet --help⌝CDE to get started.
CININFO    II  CDE You can create your own commands and have them available in valet, please check https://jcaillon.github.io/valet/docs/new-commands/ to do so.
```

```text
VALET_CONFIG_ENABLE_COLORS='true'
VALET_CONFIG_ENABLE_NERDFONT_ICONS='true'
```

❯ `fs::head /tmp/valet-temp 3`

**Standard output**:

```text
#!/usr/bin/env bash
# description: This script declares global variables used to configure Valet
# shellcheck disable=SC2034
```

