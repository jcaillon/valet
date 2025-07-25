---
title: 📗 Create a library
cascade:
  type: docs
weight: 35
url: /docs/new-libraries
---

Once you have created an extension and opened its directory, you can start creating new libraries.

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

With the example above, you will be able to source your library files with: `source gitlab` and `source git`.

## ➕ Create a command

{{% steps %}}

### 🧑‍💻 Setup your development environment

The section [working on bash][work-on-bash-scripts] will help you set up a coding environment for bash.

Open your existing extension directory or [create a new one][newExtensionsLink].

### 📄 Add a new library file

Run the command `valet self add-library mylib` to create a new library file named `lib-mylib.sh` in the `libraries.d` directory of your extension. _Replace `mylib` with the name of your command._

Alternatively, create the file manually.

### 🔤 Define new library functions

Each function that you want to expose as a library function must be named following the `mylib::myfunction` convention (where `mylib` is the name of your library, and `myfunction` the name of your function).

Moreover, each function must be commented with a strict format. Many illustrations can be found in the [extras/lib-valet][valetLibraryReference] script or in the core library scripts.

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
# - $1: **argument name** _as type_:
#       The description of the first mandatory argument.
#
#       Can also be on multiple lines, be careful of the indentation.
# - $2: optional argument name _as string_:
#       (optional) Can be set using the variable `_OPTION_OPTIONAL`.
#       This one is optional. It should not be emphasized (like the previous **argument name**).
#       The convention for optional positional arguments is to use `_OPTION_` followed by 
#       the argument name in uppercase. Then you can set `${2:-${_OPTION_OPTIONAL}}` to use it.
#       (defaults to empty string)
# - ${_OPTION_NON_POSITIONAL} _as number_:
#       (optional) This one is a pure option and should not be a positional argument.
#       (defaults 0)
# - $@: more args _as string_:
#       For functions that take an undetermined number of arguments, you can use $@.
# 
# Returns:
# 
# - $?: 0 if ok, 1 otherwise.
# - ${REPLY}: The first returned value
# - ${REPLY_ARRAY[@]}: A second returned value, as array
# 
# ```bash
# mylib::myfunction arg1 && echo "${REPLY}"
# _OPTION_NON_POSITIONAL=10 mylib::myfunction arg1 optional_arg2 && echo "${REPLY}"
# ```
# 
# > A comment on this particular function.
function mylib::myfunction() { :; }
```

### ✒️ Implement your library

Implement the body of your function.

The following recommendations are given:

- Your function should only do one thing (i.e. it should be focused on a single task).
- Your function should be, as much as possible, self sufficient (i.e. it should not rely on global variables or other functions).
- You can use other **exported** functions (such as logging functions) but do not use other private functions.

### 🛠️ Rebuild the self documentation

Once defined, run `valet self build` to let Valet find your custom libraries. Finally, you can use `valet self document` to update your libraries documentation and vscode snippets.

It will update the `lib-valet` script, `lib-valet.md` documentation and the vscode snippets.

### 🧩 Source your new library

You can now source your new library in your command files with `source mylib`.

{{< callout type="info" emoji="💡" >}}
The bash built-in `source` is overridden by a function in Valet. This allows to not source the same file twice, so you can safely call `source mylib` several times without impacting the runtime performance. If you need to use the default source keyword, use `builtin source`.
{{< /callout >}}

{{% /steps %}}

{{< cards >}}
  {{< card icon="arrow-circle-left" link="../test-commands" title="Test commands" >}}
  {{< card icon="arrow-circle-right" link="../libraries" title="Use core libraries" >}}
{{< /cards >}}

[work-on-bash-scripts]: ../work-on-bash-scripts
[valetLibraryReference]: https://github.com/jcaillon/valet/blob/latest/extras/lib-valet
[newExtensionsLink]: ../new-extensions
