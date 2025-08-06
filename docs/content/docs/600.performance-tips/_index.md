---
title: 🐇 Performance tips
cascade:
  type: docs
weight: 600
url: /docs/performance-tips
---

To write performance script, you should:

- Try to do everything with shell builtin / keywords. You can check if a command is a shell builtin like so: `type command`, e.g. `type exec`.
- Avoid [forking](https://tldp.org/LDP/abs/html/internal.html#FORKREF), which means:
  - Avoid [subshells](https://tldp.org/LDP/abs/html/subshells.html),
  - avoid [pipes](https://tldp.org/LDP/abs/html/special-chars.html#PIPEREF) which also run as [child processes](https://tldp.org/LDP/abs/html/othertypesv.html#CHILDREF).
- If possible, prefer manipulating variables content instead of files content.
- Try to avoid here string `<<<` (AFAIK it uses a temporary file behind the scene).

{{< callout type="info" >}}
These improvements can lead to **HUGE** differences in run time. Especially in windows bash which is quite slow.

The initial version of valet was taking around 5s to parse and execute a command, and it went down to under a hundred milliseconds after refactoring.
{{< /callout >}}

The chapters below give you some tips for the common problems that you can encounter:

## Call and get the output of a function

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

Avoid code mistakes by deciding on 1 global variable for all your functions and always assign this variable in each return path of a function (otherwise you might use a value from a previous function call!). In valet, this variable is named `REPLY`.

## Passing long strings to a function

Instead of:

```bash
function myFunc() {
  echo "${1}"
}
myFunc "a very long string"
```

do:

```bash
function myFunc() {
  local -n myString="${1}"
  echo "${myString}"
}
veryLongString="a very long string"
myFunc veryLongString
```

This way, you avoid duplicating the string in memory.

## Read a whole file

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

> With this technique, the last line of the file is always read, even if it does not have a trailing newline.

In valet, you can do:

```bash
fs::readFile file
echo "${REPLY}"
```

## Read a file, line by line

This example is for the newline (`$'\n'`) delimiter which is the default delimiter of read, but you can specify any delimiter with `IFS=''` + the `-d ''` option.

Do:

```bash
while IFS=$'\n' read -rd $'\n' myString || [[ -n ${myString:-} ]]; do
  echo "${myString}"
done < file
```

> Note the `|| [[ -n ${myString:-} ]]` which allows to read the last line even if the file does not have a trailing newline.

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

## Read external output of an executable into a variable

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

In valet, you can do:

```bash
exe::invoke tput cols
myvar="${REPLY}"
```

## Loop through line or fields of the content of a variable

Instead of [here string](https://tldp.org/LDP/abs/html/x17837.html#HERESTRINGSREF):

```bash
var1="1
2
3"
while IFS=$'\n' read -r line; do
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

## Pass string to stdin of a program or function

Instead of a pipe:

```bash
echo y | doSomething
```

do:

```bash
echo y 1> myfile
doSomething <myfile
```

{{< cards >}}
  {{< card icon="arrow-circle-left" link="../bash-best-practices" title="Bash best practices" >}}
  {{< card icon="arrow-circle-right" link="../valet-internals" title="Valet internals" >}}
{{< /cards >}}
