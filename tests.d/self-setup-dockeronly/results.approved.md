# Test suite self-setup-dockeronly

## Test script 00.self-setup

### ✅ Testing valet installation

**Standard output**:

```text
================================================
valet self setup (with all default options)
================================================
INFO     The commands index does not exist ⌜/home/me/.local/share/valet/commands⌝.
Now silently building it using ⌜valet self build⌝ command.
INFO     Now setting up Valet.
   ╭─────────────────────────────────────────────────────────────────────────────────╮[0m
░──┤[0m Do you see [46mt[43mh[42mi[45ms[0m [36mt[33me[32mx[35mt[0m in colors? [86G│[0m
   ╰─────────────────────────────────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l    (Y)ES   [0m   [7m   (N)O   [0m[1G[0K[9G╭─────╮[0m
[9G│[0m No. [15G├──░[0m
[9G╰─────╯[0m
INFO     Valet can use a nerd-font to improve your terminal experience.
You can download a nerd-font here: https://www.nerdfonts.com/font-downloads.
   ╭───────────────────────────────────────────────────────╮[0m
░──┤[0m Do you correctly see the icons in this prompt?     [60G│[0m
   ╰───────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l    (Y)ES   [0m   [7m   (N)O   [0m[1G[0K[9G╭─────╮[0m
[9G│[0m No. [15G├──░[0m
[9G╰─────╯[0m
INFO     You can download any font here: https://www.nerdfonts.com/font-downloads and install it.
After that, you need to setup your terminal to use this newly installed font.
You can then run the command ⌜valet self setup⌝ again to set up the use of this font.
   ╭─────────────────────────────────────────────────────────────────────────────────────────────────╮[0m
░──┤[0m Valet comes with a showcase (command examples) that can be copied to your extensions directory  [102G│[0m
   │[0m ⌜/home/me/.valet.d/showcase.d⌝. [102G│[0m
   │[0m Do you want to copy it now? [102G│[0m
   ╰─────────────────────────────────────────────────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l [7m   (Y)ES   [0m      (N)O   [0m[1G[0K[9G╭──────╮[0m
[9G│[0m Yes. [16G├──░[0m
[9G╰──────╯[0m
SUCCESS  The showcase (command examples) has been copied to your extensions directory ⌜/home/me/.valet.d/showcase.d⌝.
   ╭────────────────────────────────────────────────────────────────────────────╮[0m
░──┤[0m Do you want to add Valet to your PATH by editing your shell startup files? [81G│[0m
   ╰────────────────────────────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l [7m   (Y)ES   [0m      (N)O   [0m[1G[0K[9G╭──────╮[0m
[9G│[0m Yes. [16G├──░[0m
[9G╰──────╯[0m
INFO     Adding directory ⌜/home/me/valet⌝ to the PATH for ⌜bash⌝ shell.
Appending to ⌜/home/me/.bashrc⌝:
export PATH="/home/me/valet:${PATH}"
INFO     Adding directory ⌜/home/me/valet⌝ to the PATH for ⌜ksh⌝ shell.
Appending to ⌜/home/me/.kshrc⌝:
export PATH="/home/me/valet:${PATH}"
INFO     Adding directory ⌜/home/me/valet⌝ to the PATH for ⌜zsh⌝ shell.
Appending to ⌜/home/me/.zshrc⌝:
export PATH="/home/me/valet:${PATH}"
INFO     Adding directory ⌜/home/me/valet⌝ to the PATH for ⌜tcsh⌝ shell.
Appending to ⌜/home/me/.tcshrc⌝:
set path = ($path '/home/me/valet')
INFO     Adding directory ⌜/home/me/valet⌝ to the PATH for ⌜csh⌝ shell.
Appending to ⌜/home/me/.cshrc⌝:
set path = ($path '/home/me/valet')
INFO     Adding directory ⌜/home/me/valet⌝ to the PATH for ⌜xonsh⌝ shell.
Appending to ⌜/home/me/.xonshrc⌝:
$PATH.append('/home/me/valet')
INFO     Adding directory ⌜/home/me/valet⌝ to the PATH for ⌜fish⌝ shell.
Appending to ⌜/home/me/.config/fish/config.fish⌝:
fish_add_path '/home/me/valet'
INFO     Adding directory ⌜/home/me/valet⌝ to the PATH for ⌜nu⌝ shell.
Appending to ⌜/home/me/.config/nushell/env.nu⌝:
$env.PATH = ($env.PATH | split row (char esep) | append "/home/me/valet")
WARNING  The directory ⌜/home/me/valet⌝ has been added to the PATH for 8 shells.
Please login again to apply the changes on your current shell if you are not using bash.
SUCCESS  Valet has been added to your PATH.
INFO     Writing the valet config file ⌜/home/me/.config/valet/config⌝.
WARNING  Valet has been added to your PATH but it will only be available in new shell sessions.
Please login again to apply the changes on your current shell or call valet directly with ⌜/home/me/valet/valet⌝.

To get started, use ⌜valet --help⌝.

================================================
> tail --lines=1 /home/me/.bashrc
export PATH="/home/me/valet:${PATH}"
> ls /home/me/.valet.d/showcase.d
commands.d
tests.d
> grep -E "(VALET_CONFIG_ENABLE_COLORS|VALET_CONFIG_ENABLE_NERDFONT_ICONS)" /home/me/.config/valet/config
VALET_CONFIG_ENABLE_COLORS=false
VALET_CONFIG_ENABLE_NERDFONT_ICONS=false
# The default pattern simply display the time, log level (with level icon if `VALET_CONFIG_ENABLE_NERDFONT_ICONS` is true) and message: `<colorFaded><time>{(%H:%M:%S)T}<colorDefault> <levelColor><level> <icon><colorDefault> <message>`

================================================
valet self setup --unattended
================================================
INFO     Now setting up Valet.
INFO     Writing the valet config file ⌜/home/me/.config/valet/config⌝.
WARNING  Valet is not in your PATH yet. You need to add ⌜/home/me/valet⌝ to your PATH or call valet directly with ⌜/home/me/valet/valet⌝.

================================================
valet self setup (with no to all prompts)
================================================
INFO     Now setting up Valet.
   ╭─────────────────────────────────────────────────────────────────────────────────╮[0m
░──┤[0m Do you see [46mt[43mh[42mi[45ms[0m [36mt[33me[32mx[35mt[0m in colors? [86G│[0m
   ╰─────────────────────────────────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l    (Y)ES   [0m   [7m   (N)O   [0m[1G[0K[9G╭─────╮[0m
[9G│[0m No. [15G├──░[0m
[9G╰─────╯[0m
INFO     Valet can use a nerd-font to improve your terminal experience.
You can download a nerd-font here: https://www.nerdfonts.com/font-downloads.
   ╭───────────────────────────────────────────────────────╮[0m
░──┤[0m Do you correctly see the icons in this prompt?     [60G│[0m
   ╰───────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l    (Y)ES   [0m   [7m   (N)O   [0m[1G[0K[9G╭─────╮[0m
[9G│[0m No. [15G├──░[0m
[9G╰─────╯[0m
INFO     You can download any font here: https://www.nerdfonts.com/font-downloads and install it.
After that, you need to setup your terminal to use this newly installed font.
You can then run the command ⌜valet self setup⌝ again to set up the use of this font.
   ╭─────────────────────────────────────────────────────────────────────────────────────────────────╮[0m
░──┤[0m Valet comes with a showcase (command examples) that can be copied to your extensions directory  [102G│[0m
   │[0m ⌜/home/me/.valet.d/showcase.d⌝. [102G│[0m
   │[0m Do you want to copy it now? [102G│[0m
   ╰─────────────────────────────────────────────────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l [7m   (Y)ES   [0m      (N)O   [0m[1G[0K[9G╭─────╮[0m
[9G│[0m No. [15G├──░[0m
[9G╰─────╯[0m
   ╭────────────────────────────────────────────────────────────────────────────╮[0m
░──┤[0m Do you want to add Valet to your PATH by editing your shell startup files? [81G│[0m
   ╰────────────────────────────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l [7m   (Y)ES   [0m      (N)O   [0m[1G[0K[9G╭─────╮[0m
[9G│[0m No. [15G├──░[0m
[9G╰─────╯[0m
INFO     Writing the valet config file ⌜/home/me/.config/valet/config⌝.
WARNING  Valet is not in your PATH yet. You need to add ⌜/home/me/valet⌝ to your PATH or call valet directly with ⌜/home/me/valet/valet⌝.

To get started, use ⌜valet --help⌝.
================================================
> ls /home/me/.valet.d

================================================
valet self setup (with yes to all prompts)
================================================
INFO     Now setting up Valet.
   ╭─────────────────────────────────────────────────────────────────────────────────╮[0m
░──┤[0m Do you see [46mt[43mh[42mi[45ms[0m [36mt[33me[32mx[35mt[0m in colors? [86G│[0m
   ╰─────────────────────────────────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l    (Y)ES   [0m   [7m   (N)O   [0m[1G[0K[9G╭──────╮[0m
[9G│[0m Yes. [16G├──░[0m
[9G╰──────╯[0m
INFO     Valet can use a nerd-font to improve your terminal experience.
You can download a nerd-font here: https://www.nerdfonts.com/font-downloads.
   [90m╭───────────────────────────────────────────────────────╮[0m
[90m░──┤[0m Do you correctly see the icons in this prompt?     [60G[90m│[0m
   [90m╰───────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l [7m[90m   (Y)ES   [0m   [7m[95m   (N)O   [0m[1G[0K[9G[90m╭──────╮[0m
[9G[90m│[0m Yes. [16G[90m├──░[0m
[9G[90m╰──────╯[0m
   [90m╭─────────────────────────────────────────────────────────────────────────────────────────────────╮[0m
[90m░──┤[0m Valet comes with a showcase (command examples) that can be copied to your extensions directory  [102G[90m│[0m
   [90m│[0m ⌜/home/me/.valet.d/showcase.d⌝. [102G[90m│[0m
   [90m│[0m Do you want to copy it now? [102G[90m│[0m
   [90m╰─────────────────────────────────────────────────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l [7m[95m   (Y)ES   [0m   [7m[90m   (N)O   [0m[1G[0K[9G[90m╭──────╮[0m
[9G[90m│[0m Yes. [16G[90m├──░[0m
[9G[90m╰──────╯[0m
SUCCESS  The showcase (command examples) has been copied to your extensions directory ⌜/home/me/.valet.d/showcase.d⌝.
   [90m╭──────────────────────────────────────────────────────────────────────────────────────╮[0m
[90m░──┤[0m Do you want to create a shim script in ⌜/home/me/.local/bin⌝ to add it to your PATH? [91G[90m│[0m
   [90m╰──────────────────────────────────────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l [7m[95m   (Y)ES   [0m   [7m[90m   (N)O   [0m[1G[0K[9G[90m╭──────╮[0m
[9G[90m│[0m Yes. [16G[90m├──░[0m
[9G[90m╰──────╯[0m
INFO     Creating a shim ⌜/home/me/.local/bin/valet⌝ → ⌜/home/me/valet/valet⌝.
SUCCESS  Shim created in ⌜/home/me/.local/bin/valet⌝.
   [90m╭────────────────────────────────────────────────────────────────────────────╮[0m
[90m░──┤[0m Do you want to add Valet to your PATH by editing your shell startup files? [81G[90m│[0m
   [90m╰────────────────────────────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l [7m[90m   (Y)ES   [0m   [7m[95m   (N)O   [0m[1G[0K[9G[90m╭──────╮[0m
[9G[90m│[0m Yes. [16G[90m├──░[0m
[9G[90m╰──────╯[0m
INFO     The directory ⌜/home/me/valet⌝ is already in the PATH for ⌜bash⌝ shell.
INFO     The directory ⌜/home/me/valet⌝ is already in the PATH for ⌜ksh⌝ shell.
INFO     The directory ⌜/home/me/valet⌝ is already in the PATH for ⌜zsh⌝ shell.
INFO     The directory ⌜/home/me/valet⌝ is already in the PATH for ⌜tcsh⌝ shell.
INFO     The directory ⌜/home/me/valet⌝ is already in the PATH for ⌜csh⌝ shell.
INFO     The directory ⌜/home/me/valet⌝ is already in the PATH for ⌜xonsh⌝ shell.
INFO     The directory ⌜/home/me/valet⌝ is already in the PATH for ⌜fish⌝ shell.
INFO     The directory ⌜/home/me/valet⌝ is already in the PATH for ⌜nu⌝ shell.
SUCCESS  Valet has been added to your PATH.
INFO     Writing the valet config file ⌜/home/me/.config/valet/config⌝.
SUCCESS  You are all set!

To get started, use ⌜valet --help⌝.

================================================
> cat /home/me/.local/bin/valet
#!/usr/bin/env bash
source '/home/me/valet/valet' "$@"
> grep -E "(VALET_CONFIG_ENABLE_COLORS|VALET_CONFIG_ENABLE_NERDFONT_ICONS)" /home/me/.config/valet/config
VALET_CONFIG_ENABLE_COLORS=true
VALET_CONFIG_ENABLE_NERDFONT_ICONS=true
# The default pattern simply display the time, log level (with level icon if `VALET_CONFIG_ENABLE_NERDFONT_ICONS` is true) and message: `<colorFaded><time>{(%H:%M:%S)T}<colorDefault> <levelColor><level> <icon><colorDefault> <message>`

================================================
valet self setup --unattended --copy-showcase --create-shim --add-to-path --setup-for-windows --global-installation
================================================
INFO     Now setting up Valet.
SUCCESS  The showcase (command examples) has been copied to your extensions directory ⌜/home/me/.valet.d/showcase.d⌝.
INFO     Creating a shim ⌜/home/me/.local/bin/valet⌝ → ⌜/home/me/valet/valet⌝.
SUCCESS  Shim created in ⌜/home/me/.local/bin/valet⌝.
INFO     The directory ⌜/home/me/valet⌝ is already in the PATH for ⌜bash⌝ shell.
INFO     The directory ⌜/home/me/valet⌝ is already in the PATH for ⌜ksh⌝ shell.
INFO     The directory ⌜/home/me/valet⌝ is already in the PATH for ⌜zsh⌝ shell.
INFO     The directory ⌜/home/me/valet⌝ is already in the PATH for ⌜tcsh⌝ shell.
INFO     The directory ⌜/home/me/valet⌝ is already in the PATH for ⌜csh⌝ shell.
INFO     The directory ⌜/home/me/valet⌝ is already in the PATH for ⌜xonsh⌝ shell.
INFO     The directory ⌜/home/me/valet⌝ is already in the PATH for ⌜fish⌝ shell.
INFO     The directory ⌜/home/me/valet⌝ is already in the PATH for ⌜nu⌝ shell.
SUCCESS  Valet has been added to your PATH.
INFO     Writing the valet config file ⌜/home/me/.config/valet/config⌝.
SUCCESS  You are all set!
Self setup tests passed.
```

### ✅ Testing valet installation with root permission

**Standard output**:

```text
EUID: 0
================================================
valet self setup (with all default options)
================================================
INFO     The commands index does not exist ⌜/root/.local/share/valet/commands⌝.
Now silently building it using ⌜valet self build⌝ command.
INFO     Now setting up Valet.
   ╭─────────────────────────────────────────────────────────────────────────────────╮[0m
░──┤[0m Do you see [46mt[43mh[42mi[45ms[0m [36mt[33me[32mx[35mt[0m in colors? [86G│[0m
   ╰─────────────────────────────────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l    (Y)ES   [0m   [7m   (N)O   [0m[1G[0K[9G╭─────╮[0m
[9G│[0m No. [15G├──░[0m
[9G╰─────╯[0m
INFO     Valet can use a nerd-font to improve your terminal experience.
You can download a nerd-font here: https://www.nerdfonts.com/font-downloads.
   ╭───────────────────────────────────────────────────────╮[0m
░──┤[0m Do you correctly see the icons in this prompt?     [60G│[0m
   ╰───────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l    (Y)ES   [0m   [7m   (N)O   [0m[1G[0K[9G╭─────╮[0m
[9G│[0m No. [15G├──░[0m
[9G╰─────╯[0m
INFO     You can download any font here: https://www.nerdfonts.com/font-downloads and install it.
After that, you need to setup your terminal to use this newly installed font.
You can then run the command ⌜valet self setup⌝ again to set up the use of this font.
   ╭─────────────────────────────────────────────────────────────────────────────────────────────────╮[0m
░──┤[0m Valet comes with a showcase (command examples) that can be copied to your extensions directory  [102G│[0m
   │[0m ⌜/root/.valet.d/showcase.d⌝. [102G│[0m
   │[0m Do you want to copy it now? [102G│[0m
   ╰─────────────────────────────────────────────────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l [7m   (Y)ES   [0m      (N)O   [0m[1G[0K[9G╭──────╮[0m
[9G│[0m Yes. [16G├──░[0m
[9G╰──────╯[0m
SUCCESS  The showcase (command examples) has been copied to your extensions directory ⌜/root/.valet.d/showcase.d⌝.
   ╭────────────────────────────────────────────────────────────────────────────╮[0m
░──┤[0m Do you want to add Valet to your PATH by editing your shell startup files? [81G│[0m
   ╰────────────────────────────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l [7m   (Y)ES   [0m      (N)O   [0m[1G[0K[9G╭──────╮[0m
[9G│[0m Yes. [16G├──░[0m
[9G╰──────╯[0m
INFO     Adding directory ⌜/opt/valet⌝ to the PATH for ⌜bash⌝ shell.
Appending to ⌜/root/.bashrc⌝:
export PATH="/opt/valet:${PATH}"
INFO     Adding directory ⌜/opt/valet⌝ to the PATH for ⌜ksh⌝ shell.
Appending to ⌜/root/.kshrc⌝:
export PATH="/opt/valet:${PATH}"
INFO     Adding directory ⌜/opt/valet⌝ to the PATH for ⌜zsh⌝ shell.
Appending to ⌜/root/.zshrc⌝:
export PATH="/opt/valet:${PATH}"
INFO     Adding directory ⌜/opt/valet⌝ to the PATH for ⌜tcsh⌝ shell.
Appending to ⌜/root/.tcshrc⌝:
set path = ($path '/opt/valet')
INFO     Adding directory ⌜/opt/valet⌝ to the PATH for ⌜csh⌝ shell.
Appending to ⌜/root/.cshrc⌝:
set path = ($path '/opt/valet')
INFO     Adding directory ⌜/opt/valet⌝ to the PATH for ⌜xonsh⌝ shell.
Appending to ⌜/root/.xonshrc⌝:
$PATH.append('/opt/valet')
INFO     Adding directory ⌜/opt/valet⌝ to the PATH for ⌜fish⌝ shell.
Appending to ⌜/root/.config/fish/config.fish⌝:
fish_add_path '/opt/valet'
INFO     Adding directory ⌜/opt/valet⌝ to the PATH for ⌜nu⌝ shell.
Appending to ⌜/root/.config/nushell/env.nu⌝:
$env.PATH = ($env.PATH | split row (char esep) | append "/opt/valet")
WARNING  The directory ⌜/opt/valet⌝ has been added to the PATH for 8 shells.
Please login again to apply the changes on your current shell if you are not using bash.
SUCCESS  Valet has been added to your PATH.
   ╭─────────────────────────────────────────────────────────────────╮[0m
░──┤[0m Do you want to add Valet to make valet available for all users? [70G│[0m
   ╰─────────────────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l [7m   (Y)ES   [0m      (N)O   [0m[1G[0K[9G╭──────╮[0m
[9G│[0m Yes. [16G├──░[0m
[9G╰──────╯[0m
INFO     Setting read permissions for all users on Valet files and directories.
INFO     Creating a shim ⌜/usr/local/bin/valet⌝ → ⌜/opt/valet/valet⌝ to make Valet available for all users.
SUCCESS  Global installation setup complete.
INFO     Writing the valet config file ⌜/root/.config/valet/config⌝.
SUCCESS  You are all set!

To get started, use ⌜valet --help⌝.

================================================
> cat /usr/local/bin/valet
#!/usr/bin/env bash
source '/opt/valet/valet' "$@"

================================================
valet self setup --unattended --global-installation
================================================
INFO     Now setting up Valet.
INFO     Setting read permissions for all users on Valet files and directories.
INFO     Creating a shim ⌜/usr/local/bin/valet⌝ → ⌜/opt/valet/valet⌝ to make Valet available for all users.
SUCCESS  Global installation setup complete.
INFO     Writing the valet config file ⌜/root/.config/valet/config⌝.
SUCCESS  You are all set!
Self setup tests passed.
```

