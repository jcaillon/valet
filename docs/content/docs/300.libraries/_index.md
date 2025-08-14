---
title: 📦 Use standard libraries
cascade:
  type: docs
weight: 300
url: /docs/libraries
---

## 🧩 Standard libraries

Valet comes with standard libraries that declare many useful functions to use in your commands and scripts.

To use a standard function, you need to `source` the library that declares it.

E.g. if you need `string::getField` and `interactive::promptYesNo`, do:

```bash
source string
source interactive
```

Alternatively, if you have several libraries to source, you can use the `include` command with a list of libraries:

```bash
include string interactive
```

All Valet functions are prefixed with the library name. E.g. the function `string::getField` is from the `string` library. A clear error message will be displayed if you are trying to use a library function without sourcing the library.

> [!IMPORTANT]
> The bash built-in `source` is [overridden by a function in Valet](../libraries/core/#source). This allows to not source the same file twice, so you can safely call `source mylib` several times without impacting the runtime performance.
>
> If you need to use the default source keyword, use `builtin source`.

## 👔 About library functions

The functions in Valet are implemented for a good compromise between performance and readability. They generally define clear local variables for the inputs as it makes the code more understandable. However, they do not implement input validation (beside checking if the mandatory arguments are given), it is your responsibility to ensure that the inputs are correct.

Functions return values using global variables (see [performance tips](../performance-tips) and [bash best practices](../bash-best-practices) for an explanation). Depending on the type and number of returned values, they will named as such:

- `${REPLY}`
- `${REPLY2}`
- `${REPLY3}`
- `${REPLY_ARRAY[@]}`
- `${REPLY_ARRAY2[@]}`
- `${REPLY_ASSOCIATIVE_ARRAY[@]}`

This ensures consistency across all functions. The trade off is that you must pay attention to how you use these variables. Calling two functions that are using the same `REPLY` will overwrite the value of the first function, so you will want to assign it to another variable because calling the second function.

{{% details title="Advanced syntax for REPLY assignment" closed="true" %}}

When you want to set a returned value to a particular variable and want to avoid copying the returned value as such `myVar="${REPLY}"`, you can use something like this:

```bash
declare MY_STRING='kebab-case' MY_OUTPUT
declare -n REPLY=MY_OUTPUT # make REPLY reference MY_OUTPUT
string::convertKebabCaseToCamelCase MY_STRING # the function writes to REPLY, which points to MY_OUTPUT
declare +n REPLY=value # we remove the reference and set another value
echo "MY_OUTPUT: ⌜${MY_OUTPUT}⌝" # will output 'kebabCase'
echo "REPLY: ⌜${REPLY}⌝" # will output 'value'
```

{{% /details %}}

A lot of functions will accept options in addition to mandatory arguments. Options are passed using the shell parameter syntax `option=value` and must always come after any positional arguments.

E.g., to use the `separator` option of the `string::getField` function:

```bash
string::getField MY_STRING 1 separator=" "
```

For functions that accept a undetermined number of positional argument, options must be passed after the `---` separator to differentiate them from the arguments:

```bash
curl::request https://example.com -X POST -H 'Authorization: token' --- failOnError=true
```

> [!NOTE]
> The function documentation will always specify if the --- separator is required. Assume that it is not required otherwise.

## 🪄 Using functions outside Valet

You can use Valet functions in your own scripts by sourcing the Valet library files. This allows you to leverage the powerful functions provided by Valet in your own bash scripts.

See [this section in usage](../usage/#-use-valet-library-functions-in-your-existing-scripts) for more information.

## 🎀 Available core libraries

A complete list of library functions can be generated locally in a single file using the `valet self document` command.

The documentation for functions is also available as a single page [that can be found here](../../libraries-single-page-documentation/).

<!-- https://v1.heroicons.com/ -->
You can also browse the list of available libraries and their functions here;

{{< cards >}}
  {{< card link="array" icon="table" title="array" subtitle="Manipulate bash arrays." >}}
  {{< card link="bash" icon="code" title="bash" subtitle="Extend bash capabilities." >}}
  {{< card link="benchmark" icon="trending-up" title="benchmark" subtitle="Benchmark bash functions." >}}
  {{< card link="command" icon="ticket" title="command" subtitle="Functions to be used in your commands." >}}
  {{< card link="coproc" icon="cash" title="coproc" subtitle="Functions that simplify and robustify the use of coprocesses in bashs." >}}
  {{< card link="core" icon="star" title="core" subtitle="The core functions of Valet." >}}
  {{< card link="curl" icon="cloud-download" title="curl" subtitle="Wrapper functions around curl." >}}
  {{< card link="exe" icon="star" title="exe" subtitle="Run commands and executables." >}}
  {{< card link="esc-codes" icon="annotation" title="esc-code" subtitle="Declares variables containing ASCII escape codes, enabling interactive programs." >}}
  {{< card link="fs" icon="document" title="fs" subtitle="Manipulate the files and directories." >}}
  {{< card link="http" icon="cloud-download" title="http" subtitle="Naive http implementation." >}}
  {{< card link="interactive" icon="cursor-click" title="interactive" subtitle="Make your command interactive." >}}
  {{< card link="log" icon="pencil-alt" title="log" subtitle="Logging functions." >}}
  {{< card link="profiler" icon="finger-print" title="profiler" subtitle="Enable and disable the bash profiler." >}}
  {{< card link="progress" icon="dots-horizontal" title="progress" subtitle="Display a progress bar or a spinner." >}}
  <!-- {{< card link="prompt" icon="chevron-right" title="prompt" subtitle="Prompt the user for input." >}} -->
  {{< card link="regex" icon="tag" title="regex" subtitle="Use regular expressions." >}}
  {{< card link="sfzf" icon="template" title="sfzf" subtitle="Simple fuzzy search interface, similar to fzf." >}}
  {{< card link="string" icon="scissors" title="string" subtitle="Functions for string manipulation." >}}
  {{< card link="system" icon="desktop-computer" title="system" subtitle="Functions to get system/user information." >}}
  {{< card link="terminal" icon="terminal" title="terminal" subtitle="Manipulate the terminal and its display." >}}
  {{< card link="test" icon="beaker" title="test" subtitle="Functions usable in your test scripts." >}}
  {{< card link="time" icon="clock" title="time" subtitle="Functions related to time." >}}
  {{< card link="tui" icon="view-boards" title="tui" subtitle="Functions to build a TUI application." >}}
  {{< card link="version" icon="calculator" title="version" subtitle="Compare and manipulate semantic versions." >}}
  {{< card link="windows" icon="view-grid" title="windows" subtitle="Functions specific to windows systems." >}}
{{< /cards >}}

{{< main-section-end >}}
