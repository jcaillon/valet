---
title: 🔧 Valet configuration
cascade:
  type: docs
weight: 15
url: /docs/configuration
---

Valet is configurable through environment variables.

There are several ways to make that configuration (and thus the Valet variables) permanent:

- Define variables in your `~/.bashrc` script which is sourced when starting bash.
- Other methods: `/etc/environment`, `~/.profile` or `~/.bash_profile`

In Valet, you can also set variables in special bash scripts which are sourced when the program starts. These scripts are:

- `~/.config/valet/config`: the Valet configuration file (this is the recommended way to configure Valet itself).
- `~/.config/valet/startup`: a custom script that is itself sourced by `~/.config/valet/config` which can be used to define or manipulate variables on startup.
- `./.env`: a `.env` in the current directory.

## 📄 Valet configuration file

Use the `valet self config` command to open the YAML configuration file.

{{< callout type="info" >}}
This will also create the file if it does not exist.
Check `valet self config --help` for more options regarding the configuration.
{{< /callout >}}

We give below the default content of the configuration file, which contains comments for each config variable.

{{% content "/static/config.md" %}}

{{< cards >}}
  {{< card icon="arrow-circle-left" link="../usage" title="Usage" >}}
  {{< card icon="arrow-circle-right" link="../new-commands" title="New commands" >}}
{{< /cards >}}
