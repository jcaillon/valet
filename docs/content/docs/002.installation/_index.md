---
title: 💻 Installation
cascade:
  type: docs
weight: 2
url: /docs/installation
---

## 📦 Dependencies

- Bash version 5 or superior is required (might work with older versions but it is not guaranteed).
- From [GNU coreutils][gnu-core-utils]: it uses `rm`, `mv`, `mkdir` for all commands. It uses `chmod`, `ln` for the installation/updates. *You most likely already have all of these!*
- [curl][curl] and [tar][tar] are needed only if you want to use the self-update command.

## 🚚 Automated installation

Run the following command to install Valet:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/valet.d/commands.d/self-install.sh)"
```

{{< callout type="info" emoji="💡" >}}
Please review the [installation script](https://github.com/jcaillon/valet/blob/latest/valet.d/commands.d/self-install.sh) or the [self install command usage](https://github.com/jcaillon/valet/blob/latest/tests.d/1106-self-update/results.approved.md) to learn about the different installer options.
{{< /callout >}}

Here is an example command to install Valet with the option `--unattended`:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/valet.d/commands.d/self-install.sh)" -s --unattended
```

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

[curl]: https://curl.se/
[tar]: https://www.gnu.org/software/tar/
[latest-release]: https://github.com/jcaillon/valet/releases/latest
[gnu-core-utils]: https://www.gnu.org/software/coreutils/
