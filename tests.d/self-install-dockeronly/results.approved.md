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
INFO     Rebuilding the command cache.
INFO     The commands index does not exist ⌜/home/me/.local/share/valet/commands⌝.
         Now silently building it using ⌜valet self build⌝ command.
SUCCESS  The showcase (command examples) has been copied to your extensions directory ⌜/home/me/.valet.d/showcase.d⌝.
   ╭────────────────────────────────────────────────────────────────────────────╮[0m
░──┤[0m Do you want to add Valet to your PATH by editing your shell startup files? [81G│[0m
   ╰────────────────────────────────────────────────────────────────────────────╯[0m
[?25l
[1F[0J[?25l [7m   (Y)ES   [0m      (N)O   [0m[1G[0K[9G╭──────╮[0m
[9G│[0m Yes. [16G├──░[0m
[9G╰──────╯[0m
INFO     Adding directory ⌜/home/me/.local/lib/valet⌝ to the PATH for ⌜bash⌝ shell.
         Appending to ⌜/home/me/.bashrc⌝:
         export PATH="/home/me/.local/lib/valet:${PATH}"
INFO     Adding directory ⌜/home/me/.local/lib/valet⌝ to the PATH for ⌜ksh⌝ shell.
         Appending to ⌜/home/me/.kshrc⌝:
         export PATH="/home/me/.local/lib/valet:${PATH}"
INFO     Adding directory ⌜/home/me/.local/lib/valet⌝ to the PATH for ⌜zsh⌝ shell.
         Appending to ⌜/home/me/.zshrc⌝:
         export PATH="/home/me/.local/lib/valet:${PATH}"
INFO     Adding directory ⌜/home/me/.local/lib/valet⌝ to the PATH for ⌜tcsh⌝ shell.
         Appending to ⌜/home/me/.tcshrc⌝:
         set path = ($path '/home/me/.local/lib/valet')
INFO     Adding directory ⌜/home/me/.local/lib/valet⌝ to the PATH for ⌜csh⌝ shell.
         Appending to ⌜/home/me/.cshrc⌝:
         set path = ($path '/home/me/.local/lib/valet')
INFO     Adding directory ⌜/home/me/.local/lib/valet⌝ to the PATH for ⌜xonsh⌝ shell.
         Appending to ⌜/home/me/.xonshrc⌝:
         $PATH.append('/home/me/.local/lib/valet')
INFO     Adding directory ⌜/home/me/.local/lib/valet⌝ to the PATH for ⌜fish⌝ shell.
         Appending to ⌜/home/me/.config/fish/config.fish⌝:
         fish_add_path '/home/me/.local/lib/valet'
INFO     Adding directory ⌜/home/me/.local/lib/valet⌝ to the PATH for ⌜nu⌝ shell.
         Appending to ⌜/home/me/.config/nushell/env.nu⌝:
         $env.PATH = ($env.PATH | split row (char esep) | append "/home/me/.local/lib/valet")
WARNING  The directory ⌜/home/me/.local/lib/valet⌝ has been added to the PATH for 8 shells.
         Please login again to apply the changes on your current shell if you are not using bash.
SUCCESS  Valet has been added to your PATH.
INFO     Writing the valet config file ⌜/home/me/.config/valet/config⌝.
WARNING  Valet has been added to your PATH but it will only be available in new shell sessions.
         Please login again to apply the changes on your current shell or call valet directly with 
         ⌜/home/me/.local/lib/valet/valet⌝.
         
         To get started, use ⌜valet --help⌝.
Installation tests passed.
```

