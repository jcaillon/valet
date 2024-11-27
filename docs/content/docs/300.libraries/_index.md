---
title: 📦 Libraries
cascade:
  type: docs
weight: 300
url: /docs/libraries
---

## 🧩 Source libraries from your command function

Useful function are accessible by including a Valet library in your script or command function. For this, you need to _source_ the library that you need, e.g.:

```bash
source string
source interactive
```

All Valet functions are prefixed with the library name. E.g. the function `string::cutField` is from the `string` library. A clear error message will be output if you are trying to use a library function without sourcing the library.

{{< callout type="info" emoji="💡" >}}
The bash built-in `source` is overridden by a function in Valet. This allows to not source the same file twice, so you can safely call `source mylibrary` several times without impacting the runtime performance. If you need to use the default source keyword, use `builtin source`.
{{< /callout >}}

## 🪄 Use Valet functions directly in bash

Thanks to the `self export` command, you can export Valet functions so they are usable directly in your bash session:

```bash
eval "$(valet self export -a)"

log::info "Cool logs!"
if interactive::promptYesNo "Do you want to continue?"; then echo "Yes."; else echo "No."; fi
```

## 📗 Add a new library

You can add your own libraries as you can add new commands to extend Valet functionalities.

User libraries are read from the Valet user directory which defaults to `~/.valet.d`. They are expected to be bash scripts starting with `lib-` directly placed under a `libs.d` directory.

Here is an example content for your user directory:

{{< filetree/container >}}
  {{< filetree/folder name="~/.valet.d" >}}
    {{< filetree/folder name="libs.d" >}}
      {{< filetree/file name="lib-gitlab" >}}
      {{< filetree/file name="lib-github" >}}
    {{< /filetree/folder >}}
    {{< filetree/folder name="personal" >}}
      {{< filetree/folder name="libs.d" >}}
        {{< filetree/file name="lib-git" >}}
      {{< /filetree/folder >}}
    {{< /filetree/folder >}}
  {{< /filetree/folder >}}
{{< /filetree/container >}}

Each function that you want to expose as a library function should be commented following a strict format. Many illustrations can be found in the [extras/lib-valet][valetLibraryReference] script or in the core library scripts.

An example is given below:

```bash
# ## mylib::myfunction
# 
# A description of my function.
#
# Can be done in multiple paragraph and should be formatted as **markdown**.
#
# The following argument descriptions should be formatted precisely in order to generate
# the correct vscode snippets.
# 
# - $1: **argument name** _as type_:
#       The description of the first mandatory argument.
#
#       Can also be on multiple lines, be careful of the indentation.
# - $2: optional argument name _as string_:
#       (optional) This one is optional. It should not be emphasized (like the previous **argument name**).
#       (defaults to empty string)
# - $@: more args _as string_:
#       For functions that take an undetermined number of arguments, you can use $@.
# 
# Returns:
# 
# - $?: 0 if ok, 1 otherwise.
# - `RETURNED_VALUE`: The first returned value
# - `RETURNED_ARRAY`: A second returned value, as array
# 
# ```bash
# mylib::myfunction arg1 && echo "${RETURNED_VALUE}"
# mylib::myfunction arg1 optional_arg2 && echo "${RETURNED_VALUE}"
# ```
# 
# > A comment on this particular function.
function mylib::myfunction() { :; }
```

Once defined, run `valet self build` to let Valet find your custom libraries. Finally, you can use `valet self document` to update your libraries documentation and vscode snippets.

## 🎀 Available core libraries

For more details, please check the documentation on each library:

{{< cards >}}
  {{< card link="ansi-codes" icon="code" title="ansi-code" subtitle="This library exports variables containing ASCII escape codes, enabling interactive programs." >}}
  {{< card link="array" icon="clipboard-list" title="array" subtitle="Functions to manipulate bash arrays." >}}
  {{< card link="core" icon="star" title="core" subtitle="The core functions of Valet." >}}
  {{< card link="fsfs" icon="table" title="fsfs" subtitle="Functions to display a full screen fuzzy search, which is used for the Valet menus." >}}
  {{< card link="interactive" icon="cursor-click" title="interactive" subtitle="Functions to make your program interactive." >}}
  {{< card link="io" icon="lightning-bolt" title="io" subtitle="Functions for file manipulation, command execution..." >}}
  {{< card link="curl" icon="cloud-download" title="curl" subtitle="Wrapper functions around curl." >}}
  {{< card link="log" icon="pencil-alt" title="log" subtitle="Logging functions." >}}
  {{< card link="profiler" icon="finger-print" title="profiler" subtitle="Functions enable and disable the bash profiler." >}}
  {{< card link="string" icon="menu-alt-2" title="string" subtitle="Functions for string manipulation." >}}
  {{< card link="system" icon="desktop-computer" title="system" subtitle="Functions to get system/user information." >}}
  {{< card link="test" icon="badge-check" title="test" subtitle="Functions usable in your test scripts." >}}
{{< /cards >}}

[valetLibraryReference]: https://github.com/jcaillon/valet/blob/latest/extras/lib-valet