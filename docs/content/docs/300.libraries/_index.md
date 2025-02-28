---
title: 📦 Use core libraries
cascade:
  type: docs
weight: 300
url: /docs/libraries
---

## 🧩 Source core libraries

A set of core libraries are immediately available on Valet. To use the library functions, you need to _source_ the library that you need, e.g.:

```bash
source string
source interactive
```

All Valet functions are prefixed with the library name. E.g. the function `string::cutField` is from the `string` library. A clear error message will be displayed if you are trying to use a library function without sourcing the library.

{{< callout type="info" emoji="💡" >}}
The bash built-in `source` is overridden by a function in Valet. This allows to not source the same file twice, so you can safely call `source mylibrary` several times without impacting the runtime performance. If you need to use the default source keyword, use `builtin source`.
{{< /callout >}}

## 👔 About library functions

The functions in Valet are implement for a good compromise between performance and readability. They generally define clear local variables for the inputs as they make the code more understandable. However, they do not implement input validation (beside checking if mandatory arguments are given), it is your responsibility to ensure that the inputs are correct.

Functions return values using global variables (see [performance tips](/docs/performance-tips) for an explanation). Depending on the type and number of returned values, they will named as such:

- `${RETURNED_VALUE}`
- `${RETURNED_VALUE2}`
- `${RETURNED_VALUE3}`
- `${RETURNED_ARRAY[@]}`
- `${RETURNED_ARRAY2[@]}`
- `${RETURNED_ASSOCIATIVE_ARRAY[@]}`

This ensures consistency across all functions. The trade off is that you must pay attention to how you use these variables. Calling two functions that are using the same `RETURNED_VALUE` will overwrite the value of the first function, so you will want to assign it to another variable because calling the second function.

When you want to set a returned value to a particular variable and want to avoid copying the returned value as such `myVar="${RETURNED_VALUE}"`, you can use something like this:

```bash
declare MY_STRING='kebab-case' MY_OUTPUT
declare -n RETURNED_VALUE=MY_OUTPUT # make RETURNED_VALUE reference MY_OUTPUT
string::convertKebabCaseToCamelCase MY_STRING # the function writes to RETURNED_VALUE, which points to MY_OUTPUT
declare +n RETURNED_VALUE=value # we remove the reference and set another value
echo "MY_OUTPUT: ⌜${MY_OUTPUT}⌝" # will output 'kebabCase'
echo "RETURNED_VALUE: ⌜${RETURNED_VALUE}⌝" # will output 'value'
```

## 🎀 Available core libraries

<!-- https://v1.heroicons.com/ -->
For more details, please check the documentation on each library:
{{< cards >}}
  {{< card link="array" icon="table" title="array" subtitle="Manipulate bash arrays." >}}
  {{< card link="bash" icon="code" title="bash" subtitle="Extend bash capabilities." >}}
  {{< card link="benchmark" icon="trending-up" title="benchmark" subtitle="Benchmark bash functions." >}}
  {{< card link="command" icon="ticket" title="command" subtitle="Functions to be used in your commands." >}}
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
  {{< card link="test" icon="badge-check" title="test" subtitle="Functions usable in your test scripts." >}}
  {{< card link="time" icon="clock" title="time" subtitle="Functions related to time." >}}
  {{< card link="tui" icon="terminal" title="tui" subtitle="Built terminal UI apps with these helper functions." >}}
  {{< card link="version" icon="calculator" title="version" subtitle="Compare and manipulate semantic versions." >}}
  {{< card link="windows" icon="view-grid" title="windows" subtitle="Functions specific to windows systems." >}}
{{< /cards >}}
