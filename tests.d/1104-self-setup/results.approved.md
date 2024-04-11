# Test suite 1104-self-setup

## Test script 00.self-setup

### Testing selfSetup 1

Exit code: `0`

**Standard** output:

```plaintext
→ echo nny | selfSetup
─────────────────────────────────────
[0;36mThis is a COLOR CHECK, this line should be COLORED (in cyan by default).[0m
[0;32mThis is a COLOR CHECK, this line should be COLORED (in green by default).[0m
─────────────────────────────────────
[2m   ┌─[56b─┐[0m
[2m   │[0m Do you see the colors in the color check above the line? [2m│[0m
[2m   └─[56b─┘\[0m
[?25l[1m[7m[35m   (Y)ES   [0m   [1m[7m   (N)O   [0m[1G[0K[?25h[2m ┌─[3b─┐[0m
[2m │[0m No. [2m│[0m
[2m/└─[3b─┘[0m
─────────────────────────────────────
This is a nerd icon check, check out the next lines:
A cross within a square: 
A warning sign: 
A checked box: 
An information icon: 
─────────────────────────────────────
[2m   ┌─[69b─┐[0m
[2m   │[0m Do you correctly see the nerd icons in the icon check above the line? [2m│[0m
[2m   └─[69b─┘\[0m
[?25l[1m[7m[35m   (Y)ES   [0m   [1m[7m   (N)O   [0m[1G[0K[?25h[2m ┌─[3b─┐[0m
[2m │[0m No. [2m│[0m
[2m/└─[3b─┘[0m
[2m   ┌─[42b─┐[0m
[2m   │[0m Do you want to disable the icons in Valet? [2m│[0m
[2m   └─[42b─┘\[0m
[?25l[1m[7m[35m   (Y)ES   [0m   [1m[7m   (N)O   [0m[1G[0K[?25h[2m ┌─[4b─┐[0m
[2m │[0m Yes. [2m│[0m
[2m/└─[4b─┘[0m
```

**Error** output:

```log
INFO     Now setting up Valet.
INFO     If you see the replacement character ? in my terminal, it means you don't have a nerd-font setup in your terminal.
You can download any font here: https://www.nerdfonts.com/font-downloads and install it.
After that, you need to setup your terminal to use this newly installed font.
You can also choose to disable the icons in Valet if you don't want to install a font.
INFO     Creating the valet config file ⌜/tmp/valet.d/f801-0⌝.
SUCCESS  You are all set!
INFO     As a reminder, you can modify the configuration done during this set up by either:
- replaying the command ⌜valet self setup⌝,
- running the command ⌜valet self config⌝.
INFO     Run ⌜valet --help⌝ to get started.
INFO     You can create your own commands and have them available in valet, please check ⌜https://github.com/jcaillon/valet/blob/main/docs/create-new-command.md⌝ to do so.
```

### Testing selfSetup 2

Exit code: `0`

**Standard** output:

```plaintext
→ echo nny | selfSetup
─────────────────────────────────────
[0;36mThis is a COLOR CHECK, this line should be COLORED (in cyan by default).[0m
[0;32mThis is a COLOR CHECK, this line should be COLORED (in green by default).[0m
─────────────────────────────────────
[2m   ┌─[56b─┐[0m
[2m   │[0m Do you see the colors in the color check above the line? [2m│[0m
[2m   └─[56b─┘\[0m
[?25l[1m[7m[35m   (Y)ES   [0m   [1m[7m   (N)O   [0m[1G[0K[?25h[2m ┌─[4b─┐[0m
[2m │[0m Yes. [2m│[0m
[2m/└─[4b─┘[0m
─────────────────────────────────────
This is a nerd icon check, check out the next lines:
A cross within a square: 
A warning sign: 
A checked box: 
An information icon: 
─────────────────────────────────────
[2m   ┌─[69b─┐[0m
[2m   │[0m Do you correctly see the nerd icons in the icon check above the line? [2m│[0m
[2m   └─[69b─┘\[0m
[?25l[1m[7m[35m   (Y)ES   [0m   [1m[7m   (N)O   [0m[1G[0K[?25h[2m ┌─[4b─┐[0m
[2m │[0m Yes. [2m│[0m
[2m/└─[4b─┘[0m
```

**Error** output:

```log
INFO     Now setting up Valet.
[0;36mINFO    [0m Creating the valet config file [1;35m⌜/tmp/valet.d/f801-0⌝[0m.
[0;32mSUCCESS [0m You are all set!
[0;36mINFO    [0m As a reminder, you can modify the configuration done during this set up by either:
- replaying the command [1;35m⌜valet self setup⌝[0m,
- running the command [1;35m⌜valet self config⌝[0m.
[0;36mINFO    [0m Run [1;35m⌜valet --help⌝[0m to get started.
[0;36mINFO    [0m You can create your own commands and have them available in valet, please check [1;35m⌜https://github.com/jcaillon/valet/blob/main/docs/create-new-command.md⌝[0m to do so.
```

