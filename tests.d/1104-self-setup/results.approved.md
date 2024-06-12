# Test suite 1104-self-setup

## Test script 00.self-setup

### Testing selfSetup 1

Exit code: `0`

**Standard** output:

```plaintext
→ echo nnn | selfSetup
─────────────────────────────────────
CINThis is a COLOR CHECK, this line should be COLORED (in cyan by default).CDE
CSUThis is a COLOR CHECK, this line should be COLORED (in green by default).CDE
─────────────────────────────────────
[2m   ┌─[56b─┐[0m
[2m   │[0m Do you see the colors in the color check above the line? [2m│[0m
[2m   └─[56b─┘\[0m
[1G[0J
[1F[?25l[7m   (Y)ES   [0m      (N)O   [0m[1G[0K[?25h[2m ┌─[3b─┐[0m
[2m │[0m No. [2m│[0m
[2m/└─[3b─┘[0m
─────────────────────────────────────
This is a nerd icon check, check out the next lines:
A cross within a square: IE
A warning sign: IW
A checked box: IS
An information icon: II
─────────────────────────────────────
[2m   ┌─[69b─┐[0m
[2m   │[0m Do you correctly see the nerd icons in the icon check above the line? [2m│[0m
[2m   └─[69b─┘\[0m
[1G[0J
[1F[?25l   (Y)ES   [0m   [7m   (N)O   [0m[1G[0K[?25h[2m ┌─[3b─┐[0m
[2m │[0m No. [2m│[0m
[2m/└─[3b─┘[0m
[2m   ┌─[41b─┐[0m
[2m   │[0m Do you want to enable the icons in Valet? [2m│[0m
[2m   └─[41b─┘\[0m
[1G[0J
[1F[?25l   (Y)ES   [0m   [7m   (N)O   [0m[1G[0K[?25h[2m ┌─[3b─┐[0m
[2m │[0m No. [2m│[0m
[2m/└─[3b─┘[0m
```

**Error** output:

```log
INFO     Now setting up Valet.
INFO     If you see the replacement character ? in my terminal, it means you don't have a nerd-font setup in your terminal.
You can download any font here: https://www.nerdfonts.com/font-downloads and install it.
After that, you need to setup your terminal to use this newly installed font.
You can also choose to enable the icons in Valet if you plan to install a nerd font.
INFO     Creating the valet config file ⌜/tmp/valet.d/f1-0⌝.
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
→ echo yyo | selfSetup
─────────────────────────────────────
CINThis is a COLOR CHECK, this line should be COLORED (in cyan by default).CDE
CSUThis is a COLOR CHECK, this line should be COLORED (in green by default).CDE
─────────────────────────────────────
[2m   ┌─[56b─┐[0m
[2m   │[0m Do you see the colors in the color check above the line? [2m│[0m
[2m   └─[56b─┘\[0m
[1G[0J
[1F[?25l[7m   (Y)ES   [0m      (N)O   [0m[1G[0K[?25h[2m ┌─[4b─┐[0m
[2m │[0m Yes. [2m│[0m
[2m/└─[4b─┘[0m
─────────────────────────────────────
This is a nerd icon check, check out the next lines:
A cross within a square: IE
A warning sign: IW
A checked box: IS
An information icon: II
─────────────────────────────────────
[2m   ┌─[69b─┐[0m
[2m   │[0m Do you correctly see the nerd icons in the icon check above the line? [2m│[0m
[2m   └─[69b─┘\[0m
[1G[0J
[1F[?25l[7mCUB   (Y)ES   [0m   [7mCAB   (N)O   [0m[1G[0K[?25h[2m ┌─[4b─┐[0m
[2m │[0m Yes. [2m│[0m
[2m/└─[4b─┘[0m
[2m   ┌─[32b─┐[0m
[2m   │[0m Did you read the warnings above? [2m│[0m
[2m   └─[32b─┘\[0m
[1G[0J
[1F[?25l[7mCAB   (O)K   [0m[1G[0K[?25h[2m ┌─[3b─┐[0m
[2m │[0m Ok. [2m│[0m
[2m/└─[3b─┘[0m
```

**Error** output:

```log
INFO     Now setting up Valet.
CININFO    II  CDE Creating the valet config file CHI⌜/tmp/valet.d/f1-0⌝CDE.
CWAWARNING IW  CDE The tool CHI⌜curl⌝CDE is missing. It is needed for the self update command.
CWAWARNING IW  CDE You are missing some tools, please install them to use Valet to its full potential.
You can install them using your package manager, e.g., CHI⌜sudo apt install curl⌝CDE.
You can also install them using a package manager like brew, e.g., CHI⌜brew install curl⌝CDE
CSUSUCCESS IS  CDE You are all set!
CININFO    II  CDE As a reminder, you can modify the configuration done during this set up by either:
- replaying the command CHI⌜valet self setup⌝CDE,
- running the command CHI⌜valet self config⌝CDE.
CININFO    II  CDE Run CHI⌜valet --help⌝CDE to get started.
CININFO    II  CDE You can create your own commands and have them available in valet, please check CHI⌜https://github.com/jcaillon/valet/blob/main/docs/create-new-command.md⌝CDE to do so.
```

