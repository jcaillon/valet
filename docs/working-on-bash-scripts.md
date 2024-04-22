# How to work on bash script

> [!INFORMATION]
> Disclaimer: This page is just one opinion. This is not the best way to work on bash scripts, this is just an explanation of how I work.

## IDE

I work with VS code on windows + WSL.

Install VS code from [here](https://code.visualstudio.com/download).

## VS code extensions

Here is a list of recommended extensions to work on bash scripts:

- [Bash IDE](https://marketplace.visualstudio.com/items?itemName=mads-hartmann.bash-ide-vscode)
- [Debug bash scripts](https://marketplace.visualstudio.com/items?itemName=rogalmic.bash-debug)
- [Shell Script Command Completion](https://marketplace.visualstudio.com/items?itemName=tetradresearch.vscode-h2o)
- [Better comments](https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments)
- [Better shellscript syntax](https://marketplace.visualstudio.com/items?itemName=jeff-hykin.better-shellscript-syntax)
- [Code spell checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)
- [EditorConfig](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)
- [Indent rainbow](https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow)
- [Format shell script](https://marketplace.visualstudio.com/items?itemName=foxundermoon.shell-format)
- [Shellcheck](https://marketplace.visualstudio.com/items?itemName=timonwong.shellcheck)
- [Snippets manager](https://marketplace.visualstudio.com/items?itemName=zjffun.snippetsmanager)
- [Snippets for bash scripts](https://marketplace.visualstudio.com/items?itemName=Remisa.shellman)
- [Snippets for shebang](https://marketplace.visualstudio.com/items?itemName=rpinski.shebang-snippets)

GitHub Copilot is of great help if you can have it.

## VS code settings

You can open your `~/.valet.d` directory as a workspace on vscode. I recommend to copy (or link) the `valet.d` directory from the Valet installation to `~/.valet.d/.valet.libs` in your workspace folder and add the following settings in your `~/.valet.d/.vscode/settings.json`:

```json
{
  // https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html
  "bashIde.globPattern": "**/@(*@(.sh|.inc|.bash|.command|core)|lib-*)",
  "bashIde.includeAllWorkspaceSymbols": true
}
```

This allows you to have autocompletion of the core and libraries functions from your command scripts.

## Where to start your bash journey

- [The official bash documentation](https://www.gnu.org/software/bash/manual/bash.html) / [Alternate view on devdocs.io](https://devdocs.io/bash/)
- [Advanced bash scripting guide](https://tldp.org/LDP/abs/html/index.html)
- [Google shell style guidelines](https://google.github.io/styleguide/shellguide.html)
- [Baeldung Linux scripting series](https://www.baeldung.com/linux/linux-scripting-series)
- [Pure bash bible](https://github.com/dylanaraps/pure-bash-bible)

## Tips for performant scripts

To write performance script, you should:

- Try to do everything with shell builtin / keywords. You can check if a command is a shell builtin like so: `type command`, e.g. `type exec`.
- Avoid [forking](https://tldp.org/LDP/abs/html/internal.html#FORKREF), which means:
  - Avoid [subshells](https://tldp.org/LDP/abs/html/subshells.html),
  - avoid [pipes](https://tldp.org/LDP/abs/html/special-chars.html#PIPEREF) which also run as [child processes](https://tldp.org/LDP/abs/html/othertypesv.html#CHILDREF).
- If possible, prefer manipulating variables content instead of files content.
- Try to avoid here string `<<<` (AFAIK it uses a temporary file behind the scene).

> This improvements can lead to **HUGE** differences in run time. Especially in windows bash which is quite slow.
>
> The initial version of valet was taking around 5s to parse and execute a command, and it went down to a under a hundred milliseconds after refactoring using the rules above.

The chapters below give you some tips for the common problems that you can encounter:

### Call and get the output of a function

Instead of (which creates a subshell):

```bash
function myFunc() {
  echo "blabla"
  return 0
}
myFuncValue="$(myFunc)"
echo "${myFuncValue}"
```

do:

```bash
function myFunc() {
  MY_GLOBAL_VAR="blabla"
  return 0
}
myFunc
echo "${MY_GLOBAL_VAR}"
```

Using a global variable seem to be a bad idea and can lead to confusion in the code if you are not rigorous. But the cost in performance of the first solution is huge (try to time these 2 codes in 1000 iterations).

Avoid code mistakes by deciding on 1 global variable for all your functions and always assign this variable in each return path of a function (otherwise you might use a value from a previous function call!).

### Read a whole file

Instead of (subshell + forking):

```bash
myString="$(cat "file")"
echo "${myString}"
```

do:

```bash
IFS='' read -r -d '' myString < file
echo "${myString}"
```

### Read a file, line by line

This example is for the newline (`$'\n'`) delimiter which is the default delimiter of read, but you can specify any delimiter with `IFS=''` + the `-d ''` option.

Do:

```bash
while read -r myString; do
  echo "${myString}"
done < file
```

Or read into an array and then loop through it:

```bash
readarray -d $'\n' fileLines < file
for myString in "${fileLines[@]}"; do
  # the difference is also that myString will end with the delimiter, so you might want to remove it
  # Alternatively, you can run readarray with -t but in that case you will not have an array element for empty lines
  echo "${myString%$'\n'}"
done
```

Both are roughly equivalent.

### Read external output of an executable into a variable

Depending on the following conditions:

- Your system has SSD.
- You are calling the executable several times.
- Or you are redirecting that already exists and will not be removed.

Then instead of:

```bash
myvar="$(tput cols 2>/dev/null)"
```

do:

```bash
tput cols 2>/dev/null 1> /tmp/file
read -r myvar < /tmp/file
```

### Loop through line or fields of the content of a variable

Instead of [here string](https://tldp.org/LDP/abs/html/x17837.html#HERESTRINGSREF):

```bash
var1="1
2
3"
while read -r line; do
  echo "${line}"
done <<< "${var1}"
```

do:

```bash
var1="1
2
3"
IFS=$'\n'
for line in ${var1}; do
  echo "${line}"
done
```

IFS can be set as a `local` variable, and it can be any character.

However, you will not go through lines that are empty. You will need to keep the `while read` if you need them.

### Pass string to stdin of a program or function

Instead of a pipe:

```bash
echo y | doSomething
```

do:

```bash
echo y 1> myfile
doSomething <myfile
```
