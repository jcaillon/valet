# Test suite self-install-dockeronly

## Test script 01.install

### ✅ Testing valet installation

**Standard output**:

```text
================================================
VALET_VERSION=0.35.114 install.sh --unattended --skip-setup
================================================

  Valet installation recap:

  - Version to install:           0.35.114
  - Download URL:                 https://github.com/jcaillon/valet/releases/download/v0.35.114/valet.tar.gz
  - Installation dir:             /home/me/.local/lib/valet

01:00:00 SUCCESS  Valet has been downloaded in ⌜/home/me/.local/lib/valet⌝.
01:00:00 SUCCESS  Valet version ⌜0.35.114⌝ has been installed in ⌜/home/me/.local/lib/valet⌝.
01:00:00 WARNING  Skipping the valet self setup command as --skip-setup has been passed.
You can now run ⌜valet self setup⌝ manually to finish setting up valet.
Or add /home/me/.local/lib/valet to your PATH.

================================================
VALET_SKIP_SETUP=true install.sh --installation-directory ~/valet --version 0.35.114
================================================

  Valet installation recap:

  - Version to install:           0.35.114
  - Download URL:                 https://github.com/jcaillon/valet/releases/download/v0.35.114/valet.tar.gz
  - Installation dir:             /home/me/valet

Proceed with the installation? [Y/n] 
Yes
01:00:00 SUCCESS  Valet has been downloaded in ⌜/home/me/valet⌝.
01:00:00 SUCCESS  Valet version ⌜0.35.114⌝ has been installed in ⌜/home/me/valet⌝.
01:00:00 WARNING  Skipping the valet self setup command as --skip-setup has been passed.
You can now run ⌜valet self setup⌝ manually to finish setting up valet.
Or add /home/me/valet to your PATH.

================================================
install.sh --from-branch main
================================================

  Valet installation recap:

  - Version to install:           branch main
  - Download URL:                 https://github.com/jcaillon/valet/archive/main.tar.gz
  - Installation dir:             /home/me/.local/lib/valet

Proceed with the installation? [Y/n] 
Yes
01:00:00 SUCCESS  Valet has been downloaded in ⌜/home/me/.local/lib/valet⌝.
01:00:00 SUCCESS  Valet version ⌜branch main⌝ has been installed in ⌜/home/me/.local/lib/valet⌝.
01:00:00 INFO     Running the self setup command.
INFO     The commands index does not exist ⌜/home/me/.local/share/valet/commands⌝.
         Now silently building it using ⌜valet self build⌝ command.
INFO     Now setting up Valet.
─────────────────────────────────────
[0;36mThis is a COLOR CHECK, this line should be COLORED (in cyan by default).[0m
[0;32mThis is a COLOR CHECK, this line should be COLORED (in green by default).[0m
─────────────────────────────────────
   ╭──────────────────────────────────────────────────────────╮[0m
░──┤[0m Do you see the colors in the color check above the line? [63G│[0m
   ╰──────────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l [7m   (Y)ES   [0m      (N)O   [0m[1G[0K[9G╭──────╮[0m
[9G│[0m Yes. [16G├──░[0m
[9G╰──────╯[0m
INFO     If you see an unusual or ? character in the lines below, it means you don't have a nerd-font setup in your 
         terminal.
         You can download a nerd-font here: https://www.nerdfonts.com/font-downloads.
─────────────────────────────────────
This is a nerd icon check, check out the next lines:
A cross within a square: 
A warning sign: 
A checked box: 
An information icon: 
─────────────────────────────────────
   [90m╭─────────────────────────────────────────────────────╮[0m
[90m░──┤[0m Do you correctly see the nerd icons in lines above? [58G[90m│[0m
   [90m╰─────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l [7m[90m   (Y)ES   [0m   [7m[95m   (N)O   [0m[1G[0K[9G[90m╭─────╮[0m
[9G[90m│[0m No. [15G[90m├──░[0m
[9G[90m╰─────╯[0m
INFO     You can download any font here: https://www.nerdfonts.com/font-downloads and install it.
         After that, you need to setup your terminal to use this newly installed font.
         You can then run the command [95m⌜valet self setup⌝[39m again to set up the use of this font.
INFO     Writing the valet config file [95m⌜/home/me/.config/valet/config⌝[39m.
SUCCESS  You are all set!
Installation tests passed.
```

