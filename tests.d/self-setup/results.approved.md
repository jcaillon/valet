# Test suite self-setup

## Test script 00.self-setup

### ✅ Testing self setup command

❯ `rm -f "${VALET_CONFIG_FILE}"`

❯ `echo nn | selfSetup`

**Standard output**:

```text
─────────────────────────────────────
[0;36mThis is a COLOR CHECK, this line should be COLORED (in cyan by default).[0m
[0;32mThis is a COLOR CHECK, this line should be COLORED (in green by default).[0m
─────────────────────────────────────
─────────────────────────────────────
This is a nerd icon check, check out the next lines:
A cross within a square: 
A warning sign: 
A checked box: 
An information icon: 
─────────────────────────────────────
```

**Error output**:

```text
INFO     Now setting up Valet.
   ╭──────────────────────────────────────────────────────────╮
░──┤ Do you see the colors in the color check above the line? 63│
   ╰──────────────────────────────────────────────────────────╯
111    (Y)ES         (N)O   19╭─────╮
9│ No. 15├──░
9╰─────╯
   ┌───────────────────────────────────────────────────────────────────────┐
░──┤ Do you correctly see the nerd icons in the icon check above the line? 76│
   └───────────────────────────────────────────────────────────────────────┘
111    (Y)ES         (N)O   19┌─────┐
9│ No. 15├──░
9└─────┘
INFO     If you see the replacement character ? in my terminal, it means you don't have a nerd-font setup in your terminal.
You can download any font here: https://www.nerdfonts.com/font-downloads and install it.
After that, you need to setup your terminal to use this newly installed font.
You can run the command ⌜valet self setup⌝ again after that.
INFO     Writing the valet config file ⌜/tmp/valet-temp⌝.
SUCCESS  You are all set!
```

```text
VALET_CONFIG_ENABLE_COLORS='false'
VALET_CONFIG_ENABLE_NERDFONT_ICONS='false'
```

❯ `fs::head /tmp/valet-temp 3`

**Standard output**:

```text
#!/usr/bin/env bash
# The config script for Valet.
# shellcheck disable=SC2034
```

❯ `rm -f "${VALET_CONFIG_FILE}"`

**Standard output**:

```text
→ echo yy | selfSetup
─────────────────────────────────────
[0;36mThis is a COLOR CHECK, this line should be COLORED (in cyan by default).[0m
[0;32mThis is a COLOR CHECK, this line should be COLORED (in green by default).[0m
─────────────────────────────────────
─────────────────────────────────────
This is a nerd icon check, check out the next lines:
A cross within a square: 
A warning sign: 
A checked box: 
An information icon: 
─────────────────────────────────────
```

**Error output**:

```text
INFO     Now setting up Valet.
   ┌──────────────────────────────────────────────────────────┐
░──┤ Do you see the colors in the color check above the line? 63│
   └──────────────────────────────────────────────────────────┘
111    (Y)ES         (N)O   19┌──────┐
9│ Yes. 16├──░
9└──────┘
   ┌───────────────────────────────────────────────────────────────────────┐
░──┤ Do you correctly see the nerd icons in the icon check above the line? 76│
   └───────────────────────────────────────────────────────────────────────┘
111    (Y)ES         (N)O   19┌──────┐
9│ Yes. 16├──░
9└──────┘
INFO     Writing the valet config file ⌜/tmp/valet-temp⌝.
SUCCESS  You are all set!
```

```text
VALET_CONFIG_ENABLE_COLORS='true'
VALET_CONFIG_ENABLE_NERDFONT_ICONS='true'
```

❯ `fs::head /tmp/valet-temp 3`

**Standard output**:

```text
#!/usr/bin/env bash
# The config script for Valet.
# shellcheck disable=SC2034
```

