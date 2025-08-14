---
title: 📗 Create a library
cascade:
  type: docs
weight: 35
url: /docs/new-libraries
---

Once you have [created an extension][newExtensionsLink] and moved to its directory, you can start creating new libraries.

## 📂 Library files location

Library directories are found and indexed by Valet during the build process. Libraries are expected to be bash scripts prefixed with `lib-` directly placed under a `libraries.d` directory.

Here is an example content for your user directory:

{{< filetree/container >}}
  {{< filetree/folder name="~/.valet.d" >}}
    {{< filetree/folder name="my-extension" >}}
      {{< filetree/folder name="libraries.d" >}}
        {{< filetree/file name="lib-gitlab" >}}
        {{< filetree/file name="lib-git" >}}
      {{< /filetree/folder >}}
    {{< /filetree/folder >}}
  {{< /filetree/folder >}}
{{< /filetree/container >}}

With the example above, you will be able to source your library files from any command script using:

```bash
source gitlab
# or
include git
```

## ➕ Create a command

{{% steps %}}

### 🧑‍💻 Setup your development environment

The section [working on bash][work-on-bash-scripts] will help you set up a coding environment for bash.

Open your existing extension directory or [create a new one][newExtensionsLink].

### 📄 Add a new library file

Run the following command to create a new library file named `lib-mylib.sh` in the `libraries.d` directory of your extension:

_Replace `mylib` with the name of your command._

```bash
valet self add-library mylib
```

Alternatively, create the file manually.

### 🔤 Define new library functions

Each function that you want to expose as a library function must be named following the `mylib::myfunction` convention (where `mylib` is the name of your library, and `myfunction` the name of your function).

Moreover, each function must be commented with a strict format if you want Valet to auto document them and generate vscode snippets. Many illustrations can be found in the [extras/lib-valet][valetLibraryReference] script or in the core library scripts.

You can define multiple functions in a single library file.

An example is given below for a `mylib` library and a `myfunction` function:

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
# - $1: **first argument** _as string_:
#       description of the first argument
# - $@: more args _as string_:
#       For functions that take an undetermined number of arguments, you can use $@.
# - ${myOption} _as bool_:
#       (optional) Description of the option.
#       This describes an optional parameter passed as a shell parameter (e.g. `myOption=true`).
#       (defaults to false)
# 
# Returns:
# 
# - $?: 0 if ok, 1 otherwise.
# - ${REPLY}: The first returned value
# - ${REPLY_ARRAY[@]}: A second returned value, as array
# 
# ```bash
# # Example of usage
# mylib::myfunction arg1 && echo "${REPLY}"
# nonPositional=10 mylib::myfunction arg1 optional_arg2 && echo "${REPLY}"
# ```
# 
# > A comment on this particular function.
function mylib::myfunction() { :; }
```

### ✒️ Implement your library

Please find these dedicated pages to help you write better bash functions:

{{< cards >}}
  {{< card icon="fast-forward" link="../performance-tips" title="Performance tips" tag="reference" tagType="info" >}}
  {{< card icon="book-open" link="../bash-best-practices" title="Bash best practices" tag="reference" tagType="info" >}}
{{< /cards >}}

> [!IMPORTANT]
> You must follow the best practices given in this documentation if you want your library functions to be consistent with the standard Valet functions.

### 🛠️ Rebuild the self documentation

Once defined, run the following command to let Valet find your custom libraries:

```bash
valet self build
```

Finally, you can use the following command to update your libraries documentation and vscode snippets:

```bash
valet self document
```

It will update the `lib-valet` script, the `lib-valet.md` documentation and the vscode snippets.

### 🧩 Source your new library

You can now source your new library in your command files with `source mylib`.

> [!IMPORTANT]
> The bash built-in `source` is [overridden by a function in Valet](../libraries/core/#source). This allows to not source the same file twice, so you can safely call `source mylib` several times without impacting the runtime performance.
>
> If you need to use the default source keyword, use `builtin source`.

{{% /steps %}}

[work-on-bash-scripts]: ../work-on-bash-scripts
[valetLibraryReference]: https://github.com/jcaillon/valet/blob/latest/extras/lib-valet
[newExtensionsLink]: ../new-extensions

{{< main-section-end >}}
