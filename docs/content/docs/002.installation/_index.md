---
title: 💻 Installation
cascade:
  type: docs
weight: 2
url: /docs/installation
---

## 📦 Dependencies

- Bash version 5 or superior is required (might work with older versions but it is not guaranteed).
- From [GNU coreutils][gnu-core-utils]: it uses `rm`, `mv`, `mkdir` for all commands. It uses `cp`, `chmod`, `touch` for the installation/updates. *You most likely already have all of these!*
- [curl][curl] and [tar][tar] are needed only if you want to use the self-update command.

## 🚚 Automated installation

Run the following command to install Valet:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/valet.d/commands.d/self-install.sh)"
```

{{< callout type="info" emoji="💡" >}}
Please review the [installation script][selfInstallScriptLink] or the [self install command usage][selfInstallCommandUsageLink] to learn about the different installer options.
{{< /callout >}}

Here is an example command to install Valet with the option `--unattended`:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/valet.d/commands.d/self-install.sh)" -s --unattended
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

{{< cards >}}
  {{< card icon="arrow-circle-left" link="../introduction" title="Introduction" >}}
  {{< card icon="arrow-circle-right" link="../usage" title="Usage" >}}
{{< /cards >}}

## 🪟 Use Valet on windows

It is recommended to use Git bash, installed with [Git for Windows][git-for-windows-link] and [Windows terminal][windows-terminal-link] as your terminal program. You can also use Valet with any Linux distribution and [Windows Subsystem for Linux][wsl-installation-link] (WSL).

## 🐋 Run Valet in a container

With a container engine (such as [Docker][docker] or [Podman][podman]), you can run a containerized version of Valet as such:

```bash
docker run --rm -it ghcr.io/jcaillon/valet
```

Find the list of image tags under [Valet packages][valetImageTagsLink].

{{< callout type="info" emoji="💡" >}}
Alternatively, use `docker run --rm -it noyacode/valet` to pull and run the image stored on [DockerHub][dockerHubLink].
{{< /callout >}}

[curl]: https://curl.se/
[tar]: https://www.gnu.org/software/tar/
[latest-release]: https://github.com/jcaillon/valet/releases/latest
[gnu-core-utils]: https://www.gnu.org/software/coreutils/
[git-for-windows-link]: https://gitforwindows.org/
[wsl-installation-link]: https://learn.microsoft.com/en-us/windows/wsl/install
[windows-terminal-link]: https://github.com/microsoft/terminal
[selfInstallScriptLink]: https://github.com/jcaillon/valet/blob/latest/valet.d/commands.d/self-install.sh
[selfInstallCommandUsageLink]: https://github.com/jcaillon/valet/blob/latest/tests.d/1106-self-update/results.approved.md
[docker]: https://www.docker.com/
[podman]: https://podman.io/
[dockerHubLink]: https://hub.docker.com
[valetImageTagsLink]: https://github.com/jcaillon/valet/pkgs/container/valet