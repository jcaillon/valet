---
title: Valet, a zero dependency tool that helps you build fast, robust, testable and interactive CLI applications in bash.
layout: hero
keywords:
  - valet
  - bash
  - script
  - sh
  - shell
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
  - test
  - testing
  - approval-tests
  - ci/cd
  - production
  - automation
  - robust
  - ble
  - prompt
  - list
  - autocompletion
  - framework
description: With Valet, you can setup and execute tests, code interactive experiences for your users, navigate and execute your scripts (called commands) from a searchable menu interface, and more! It provides libraries of functions that can be sourced to solve standard programming needs such as string, array or file manipulation, prompting the user, and so on...
params:
  asciinema: true
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
    link="#-create-a-command"
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
    link="./docs/new-extensions/"
    icon="share"
    title="Fetch and share extensions"
    subtitle="You commands are wrapped into extensions that can easily be shared with coworkers or the internet."
    style="background: radial-gradient(ellipse at 50% 80%,rgba(142,53,74,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    link="#-libraries-of-functions"
    icon="puzzle"
    title="Libraries of pure bash functions"
    subtitle="Make your scripts more performant and write code faster by using Valet libraries for string manipulation, interactive prompt, pure bash I/O and more... You can also extend Valet to create and share your own libraries!"
    style="background: radial-gradient(ellipse at 50% 80%,rgba(38,116,56,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    link="#-test-framework"
    icon="beaker"
    title="Test your commands"
    subtitle="Ever wondered how you can effectively setup unit tests for your scripts? Valet standardizes the way you test functions and commands with approval tests approach. Run them all in a single command and automate tests in CI pipelines."
    style="background: radial-gradient(ellipse at 50% 80%,rgba(0,98,98,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    link="#-clear-and-standardized-help"
    icon="book-open"
    title="Clear and standardized help"
    subtitle="Declare properties for your commands with YAML which are used to automatically display a user friendly documentation."
  >}}
  {{< hextra/feature-card
    link="#-advanced-logging"
    icon="play"
    title="Made for CI/CD automation"
    subtitle="Valet only requires bash, has advanced logging capabilities and can be entirely configured through environment variables, which makes it a great candidate as a core framework to build your CI/CD jobs."
  >}}
  {{< hextra/feature-card
    link="#-automatic-parsing-of-arguments-and-options"
    icon="cube-transparent"
    title="Pure bash, zero dependencies"
    subtitle="Simply run the install script which copies Valet and you are good to go, you will only ever need bash! And thanks to bash scripting nature, you can highly customize Valet itself by re-declaring functions to your liking."
  >}}
  {{< hextra/feature-card
    link="#-libraries-of-functions"
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
- Commands are packaged in **extensions** that can easily be shared and downloaded by other Valet users.

## 🖥️ An interactive menu

Calling `valet` without arguments lets you interactively search commands, read their documentation and execute them:

{{< asciicinema file="interactive-menu" >}}

## ✨ Create a command

[Command properties](./docs/command-properties/) are defined using a simple YAML syntax:

```bash {linenos=table,linenostart=1,filename="showcase-command1.sh"}
#!/usr/bin/env bash
: <<"COMMAND_YAML"
command: showcase command1
function: showcaseCommand1
shortDescription: A showcase command that uses arguments and options.
description: |-
  An example of description.

  You can put any text here, it will be wrapped to fit the terminal width.

  You can ⌜highlight⌝ some text as well.
arguments:
- name: first-arg
  description: |-
    First argument.
- name: more...
  description: |-
    Will be an an array of strings.
options:
- name: -o, --option1
  description: |-
    First option.
  noEnvironmentVariable: true
- name: -2, --this-is-option2 <level>
  description: |-
    An option with a value.
  default: two
examples:
- name: showcase command1 -o -2 value1 arg1 more1 more2
  description: |-
    Call command1 with option1, option2 and some arguments.
COMMAND_YAML
function showcaseCommand1() {
  :
}
```

## 📖 Clear and standardized help

With `valet command --help` or `valet help command`, you get a beautifully formatted help for your command:

{{< asciicinema file="show-help" >}}

## 🪄 Automatic parsing of arguments and options

Positional arguments and options are automatically parsed by Valet based on your command definition.

They are made available as local variables in your command function.

{{% details title="See the command implementation" closed="true" %}}

```bash {linenos=table,linenostart=1,filename="showcase-command1.sh"}
#!/usr/bin/env bash
: <<"COMMAND_YAML"
command: showcase command1
function: showcaseCommand1
shortDescription: A showcase command that uses arguments and options.
description: |-
  An example of description.

  You can put any text here, it will be wrapped to fit the terminal width.

  You can ⌜highlight⌝ some text as well.
arguments:
- name: first-arg
  description: |-
    First argument.
- name: more...
  description: |-
    Will be an an array of strings.
options:
- name: -o, --option1
  description: |-
    First option.
  noEnvironmentVariable: true
- name: -2, --this-is-option2 <level>
  description: |-
    An option with a value.
  default: two
examples:
- name: showcase command1 -o -2 value1 arg1 more1 more2
  description: |-
    Call command1 with option1, option2 and some arguments.
COMMAND_YAML
function showcaseCommand1() {
  command::parseArguments "$@"; eval "${REPLY}"
  command::checkParsedResults

  log::info "First argument: ${firstArg}."
  log::info "Option 1: ${option1}."
  log::info "Option 2: ${thisIsOption2}."
  log::info "More: ${more[*]}."

  # example use of a library function
  # Importing the string library (note that we could also do that at the beginning of the script)
  include string
  local myString="<b>My bold text</b>"
  string::extractBetween myString "<b>" "</b>"
  log::info "Extracted text is: ⌜${REPLY}⌝"

  echo "That's it!"
}
```

{{% /details %}}

{{< asciicinema file="parse-args" >}}

## 🐾 Advanced logging

Easily log messages and [customize their output](./docs/configuration/#-log-configuration) on the fly.

{{% details title="See the command implementation" closed="true" %}}

```bash {linenos=table,linenostart=1,filename="test-log.sh"}
#!/usr/bin/env bash
: <<"COMMAND_YAML"
command: test-log
function: testLog
shortDescription: A command that only for testing valet logging functions.
description: |-
  A command that only for testing valet logging functions.
COMMAND_YAML
function testLog() {
  log::errorTrace "This is an error trace message which is always displayed."
  log::trace "This is a trace message."
  log::debug "This is a debug message."
  log::info "This is an info message with a super long sentence. Notice how the line gets wrapped and indented correctly to increase readability."
  log::success "This is a success message."
  log::warning "This is a warning message."$'\n'"With a second line."
  log::error "This is an error message, also shows the callstack with debug level."
  if log::isDebugEnabled; then
    log::printString "The debug mode is activated!"
  fi
  if log::isTraceEnabled; then
    log::printString "The trace mode is activated!"
  fi
}
```

{{% /details %}}

{{< asciicinema file="logging" >}}

## 🧪 Test framework

[Automate tests](./docs/new-tests/) for your script using the approval tests approach for assertions:

{{< asciicinema file="tests" >}}

## 🧩 Libraries of functions

Make your scripts more performant and write code faster by using [Valet standard libraries][libraries-link] for string manipulation, interactive prompt, pure bash I/O and more...

Use one of the **{{% stats "nbFunctions" %}} functions coming in standard** with Valet! Some examples:

```bash {linenos=table,linenostart=1,filename="script.sh"}
myFunction() {
  include string interactive

  local myString="field1 field2 field3"
  string::getField myString 1 separator=" "
  echo "The field at index 1 is ${REPLY}"

  if interactive::promptYesNo "Do you want to continue?"; then 
    echo "Yes."
  else
    echo "No."
  fi
}
```

## 🚩 Getting started

{{< cards >}}
  {{< card icon="document-text" link="docs/introduction" title="Ready to get started?" subtitle="Check out the documentation" >}}
{{< /cards >}}

---

> [!NOTE]
> These demo were recorded with the [asciinema][asciinema]. The color scheme for the terminal is [dracula][dracula-theme] and the font is _JetBrainsMono Nerd Font_.

[asciinema]: https://www.asciinema.org/
[dracula-theme]: https://draculatheme.com/windows-terminal
[libraries-link]: docs/libraries/
