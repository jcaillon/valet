---
title: Valet, a zero dependency tool that helps you build fast, robust, testable and interactive CLI applications in bash.
layout: hero
keywords:
  - valet
  - bash
  - script
  - windows
  - search
  - string
  - cli
  - tui
  - alternative
  - parser
  - library
  - autocompletion
  - interactive
  - fzf
  - argument-parser
  - functions
  - menu
  - bash-script
  - bash-scripting
  - pure-bash
  - gum
  - bash-ti
  - bashly
  - options-parser
  - jcaillon
  - framework
description: With Valet, you can setup and execute tests, code interactive experiences for your users, navigate and execute your scripts (called commands) from a searchable menu interface, and more! It provides libraries of functions that can be sourced to solve standard programming needs such as string, array or file manipulation, prompting the user, and so on...
---

{{< hextra/feature-grid cols="3" >}}
  {{< hextra/feature-card
    link="#-an-interactive-menu"
    icon="shield-check"
    title="Build professional CLI tools"
    subtitle="Valet gives you the framework and functions required to **build awesome tools, effortlessly**, in bash. Get everything you expect from a good CLI software (e.g. git, docker...) in a few lines of bash code and YAML configuration."
    style="background: radial-gradient(ellipse at 50% 80%,rgba(21,19,110,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    link="#-an-interactive-menu"
    icon="terminal"
    title="Turn your scripts into commands"
    subtitle="Valet enables you to easily create **commands** that can take arguments and/or options automatically parsed by the Valet. Exceptions are gracefully handled with the error stack printed to the user."
    style="background: radial-gradient(ellipse at 50% 80%,rgba(221,210,59,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    link="#-an-interactive-menu"
    icon="cursor-click"
    title="Interactively execute your commands"
    subtitle="Find all your commands in a convenient menu with fuzzy finding capabilities. Get prompted for missing arguments or options to make your commands easy to use."
    style="background: radial-gradient(ellipse at 50% 80%,rgba(194,97,254,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    link="#-an-interactive-menu"
    icon="share"
    title="Fetch and share extensions"
    subtitle="You commands are wrapped into extensions that can easily be shared with coworkers or the internet."
    style="background: radial-gradient(ellipse at 50% 80%,rgba(142,53,74,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    link="#-an-interactive-menu"
    icon="puzzle"
    title="Libraries of pure bash functions"
    subtitle="Make your scripts more performant and write code faster by using Valet libraries for string manipulation, interactive prompt, pure bash I/O and more... You can also extend Valet by creating and sharing your own libraries!"
    style="background: radial-gradient(ellipse at 50% 80%,rgba(38,116,56,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    link="#-an-interactive-menu"
    icon="beaker"
    title="Test your commands"
    subtitle="Ever wondered how you can effectively setup unit tests for your scripts? Valet standardizes the way you test functions and commands with approval tests approach. Run them all in a single command and automate tests in CI pipelines."
    style="background: radial-gradient(ellipse at 50% 80%,rgba(0,98,98,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    link="#-an-interactive-menu"
    icon="book-open"
    title="Clear and standardized help"
    subtitle="Declare properties for your commands with YAML which are used to automatically display a user friendly documentation."
  >}}
  {{< hextra/feature-card
    link="#-an-interactive-menu"
    icon="play"
    title="Made for CI/CD automation"
    subtitle="Valet only requires bash, has advanced logging capabilities and can be entirely configured through environment variables, which makes it a great candidate as a core framework to build your CI/CD jobs."
  >}}
  {{< hextra/feature-card
    link="#-an-interactive-menu"
    icon="cube-transparent"
    title="Pure bash, zero dependencies"
    subtitle="Simply run the install script which copies Valet and you are good to go, you will only ever need bash! And thanks to bash scripting nature, you can highly customize Valet itself by re-declaring functions to your liking."
  >}}
  {{< hextra/feature-card
    link="#-an-interactive-menu"
    icon="lightning-bolt"
    title="Lighting fast on any platform"
    subtitle="Valet does not use forking which makes it super fast, even on windows Git bash."
  >}}
{{< /hextra/feature-grid >}}

---

Valet in a gist:

- In Valet, you can create new **commands** that you can invoke with `valet my-command`.
- Each command has properties that describe it (a description, a list of arguments and options, and so on...).
- Each command has an associated bash function that is called when the command is invoked and which contains your logic.
- You define commands and their functions in `.sh` files under your Valet user directory and Valet takes care of indexing your commands; which allows you to quickly find them, parse options, arguments, print their help...

## 🖥️ An interactive menu

Invoking `valet` without arguments lets you interactively search and invoke commands:

![demo-menu](/hero/demo-menu.gif)

## 📖 Clear and standardized help

With `valet command --help` or `valet help command`, you get a beautifully formatted help for your command usage:

![demo-help](/hero/demo-help.gif)

Fuzzy matching command names allow you to invoke the right command more quickly, see this example with `valet h s h`:

## 🔎 Fuzzy matching

![demo-fuzzy](/hero/demo-fuzzy.gif)

## 🧪 Test framework

Automate tests for your script with approval test approach:

![demo-tests](/hero/demo-tests.gif)

## 🐾 Logging library

Get beautiful logs fully customizable (with optional wrapping!):

![demo-logs](/hero/demo-logs.gif)

## 🪄 Auto parser

Auto parsing of arguments and options based on your command configuration:

![demo-parsing](/hero/demo-parsing.gif)

## 🧩 Libraries of function

Make your scripts more performant and write code faster by using Valet [libraries][libraries-link] for string manipulation, interactive prompt, pure bash I/O and more... Some examples:

```python {linenos=table,linenostart=1,filename="script.sh"}
myFunction() {
  source string
  MY_STRING="field1 field2 field3"
  string::getField MY_STRING 1 separator=" "
  echo "The field at index 1 is ${REPLY}"

  source interactive
  if interactive::promptYesNo "Do you want to continue?"; then echo "Yes."; else echo "No."; fi
}
```

> [!NOTE]
> This showcase was recorded with the [windows terminal][windows-terminal], [debian on WSL][debian-wsl] with zsh & [oh my zsh][oh-my-zsh]. The color scheme for the terminal is [dracula][dracula-theme] and the font is a homemade modification of windows Consolas (with ligatures + with nerd font icons).

{{< cards >}}
  {{< card icon="document-text" link="docs/introduction" title="Ready to get started?" subtitle="Check out the documentation" >}}
{{< /cards >}}

[windows-terminal]: https://github.com/microsoft/terminal
[debian-wsl]: https://wiki.debian.org/InstallingDebianOn/Microsoft/Windows/SubsystemForLinux
[oh-my-zsh]: https://ohmyz.sh/
[dracula-theme]: https://draculatheme.com/windows-terminal
[libraries-link]: docs/libraries/
