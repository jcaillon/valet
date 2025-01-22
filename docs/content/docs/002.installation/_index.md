---
title: 💻 Installation
cascade:
  type: docs
weight: 2
url: /docs/installation
description: Learn how to install Valet on your system.
---

## 📦 Dependencies

- Bash version 5 or superior is required (it uses bash `EPOCHREALTIME`).
- From [GNU coreutils][gnu-core-utils]: it uses `rm`, `mv`, `cp`, `mkdir` for all commands. It uses `chmod`, `touch` for the installation/updates. It falls back to using `cmp`, `diff`, `mkfifo` in some cases. *You most likely already have all of these!*
- [curl][curl] and [tar][tar] are needed only if you want to use the `self update` or `self extend` command.

## 🚚 Automated installation

Run the following command to install Valet:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/commands.d/self-install.sh)"
```

{{< callout type="info" emoji="💡" >}}
Please review the [installation script](https://github.com/jcaillon/valet/blob/latest/commands.d/self-install.sh) or the [self install command usage](https://github.com/jcaillon/valet/blob/latest/tests.d/self-update/results.approved.md) to learn about the different installer options.
{{< /callout >}}

Here is an example command to install Valet with the options `--unattended --single-user-installation` (no interactive prompt during installation and installs itself in the home directory of the user):

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/commands.d/self-install.sh)" -s --unattended --single-user-installation
```

Finally, call `valet` to get started with the example commands!

## 🪛 Manual installation

1. Download the package from the [latest release from GitHub][latest-release].
2. Extract the archive to your favorite installation directory.
3. Add this directory to your PATH so you can call `valet` from your terminal.
4. Call `valet` to get started with the example commands!

## 🔨 Manual installation from sources

1. You can clone this project or download the source from the latest release into the directory of your choice.
2. Add this directory to your PATH so you can call `valet` from your terminal.
3. Call `valet` to get started with the example commands!

## ⚙️ Extra config for your terminal

- **Nerd font**: Valet can make use of [Nerd fonts][nerdFontsLink] to display icons in the logs and interactive sessions. You can download any nerd font from [here][nerdFontsLink], install it, and configure your terminal to use that font.
- **Word separator**: Valet usually prints important values between ⌜quotes⌝ using the UTF8 top left and top right corners (respectively U+231C and U+231D). You can add these two characters as word separators in your terminal for quick double click selection: `⌜⌝`.

## 🪟 Use Valet on windows

It is recommended to use Git bash, installed with [Git for Windows][git-for-windows-link] and [Windows terminal][windows-terminal-link] as your terminal program. You can also use Valet with any Linux distribution and [Windows Subsystem for Linux][wsl-installation-link] (WSL).

## 🐋 Run Valet in a container

With a container engine (such as [Docker][docker] or [Podman][podman]), you can run a containerized version of Valet:

```bash
docker run --rm -it ghcr.io/jcaillon/valet
```

Find the list of image tags under [Valet packages][valetImageTagsLink].

{{< callout type="info" emoji="💡" >}}
Alternatively, use `docker run --rm -it noyacode/valet` to pull and run the image stored on [DockerHub](https://hub.docker.com).
{{< /callout >}}

{{< cards >}}
  {{< card icon="arrow-circle-left" link="../introduction" title="What is Valet?" >}}
  {{< card icon="arrow-circle-right" link="../usage" title="Learn how to use Valet" >}}
{{< /cards >}}

[curl]: https://curl.se/
[tar]: https://www.gnu.org/software/tar/
[latest-release]: https://github.com/jcaillon/valet/releases/latest
[gnu-core-utils]: https://www.gnu.org/software/coreutils/
[git-for-windows-link]: https://gitforwindows.org/
[wsl-installation-link]: https://learn.microsoft.com/en-us/windows/wsl/install
[windows-terminal-link]: https://github.com/microsoft/terminal
[docker]: https://www.docker.com/
[podman]: https://podman.io/
[valetImageTagsLink]: https://github.com/jcaillon/valet/pkgs/container/valet
[nerdFontsLink]: https://www.nerdfonts.com/font-downloads