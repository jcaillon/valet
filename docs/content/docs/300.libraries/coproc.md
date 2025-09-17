---
title: 📂 coproc
cascade:
  type: docs
url: /docs/libraries/coproc
---

## ⚡ coproc::isRunning

This function checks if a coproc is running.

Inputs:

- `$1`: **coproc variable name** _as string_:

  The variable name to use for the coproc.

Returns:

- `$?`:
  - 0 if the coproc is running
  - 1 if it is not

Example usage:

```bash
if coproc::isRunning "myCoproc"; then
  echo "The coproc is running."
fi
```

## ⚡ coproc::kill

This function kills a coproc.

Inputs:

- `$1`: **coproc variable name** _as string_:

  The variable name to use for the coproc.

Example usage:

```bash
coproc::kill "myCoproc"
```

## ⚡ coproc::receiveMessage

This function receives a message from a given coproc.

Inputs:

- `$1`: **coproc variable name** _as string_:

  The variable name to use for the coproc.

Returns:

- `$?`:
  - 0 if a message was received successfully.
  - 1 if the coproc is not running or no message could be received.
- `${REPLY}`: The received message.

Example usage:

```bash
if coproc::receiveMessage "myCoproc"; then
  echo "Received message: ${REPLY}"
fi
```

## ⚡ coproc::run

This function runs commands in a coproc.
Each command can be set to ":" in order to do nothing.
It returns the file descriptors/PID of the coproc and defines functions to easily
interact with the coproc.

Inputs:

- `$1`: **coproc variable name** _as string_:

  The variable name to use for the coproc.
  It will be used to store the coproc file descriptors and PID.
  <coproc_variable_name>[0] will be the input pipe file descriptor,
  <coproc_variable_name>[1] will be the output pipe file descriptor,
  <coproc_variable_name>_PID will be the PID of the coproc.

- `${initCommand}` _as string_:

  (optional) The command (will be evaluated) to run at the start of the coproc.
  Can exit to stop the coproc.
  Set to ":" to do nothing.

  (defaults to ":")

- `${loopCommand}` _as string_:

  (optional) The command (will be evaluated) to run in the coproc loop.
  Can exit to stop the coproc, can break or continue the loop.
  Set to ":" to do nothing.

  (defaults to ":")

- `${onMessageCommand}` _as string_:

  (optional) The command (will be evaluated) to run in the coproc loop when a message
  is received from the main thread.
  The command can expect to use the variable REPLY which contains
  the message (string) received from the main thread.
  The command can send messages to the main thread using the syntax
  printf "%s\0" "message"
  Can exit to stop the coproc, can break or continue the loop.
  Set to an empty string to not run any command on message.

  (defaults to "")

- `${endCommand}` _as string_:

  (optional) The command (will be evaluated) to run at the end of the coproc.
  Set to ":" to do nothing.

  (defaults to ":")

- `${waitForReadiness}` _as bool_:

  (optional) If true, the main thread will wait for the coproc to be ready
  before returning from this function (readiness is achieved after executing
  the init command in the coproc).

  (defaults to false)

- `${keepOnlyLastMessage}` _as bool_:

  (optional) If true, the coproc will only keep the last message received
  from the main thread to evaluate the on message command.

  (defaults to false)

- `${redirectLogsToFile}` _as string_:

  (optional) The path to a file where the logs of the coproc will be redirected.

  (defaults to "")

Returns:

- `${REPLY}`: The PID of the coproc.

Example usage:

```bash
waitForReadiness=true coproc::run "_MY_COPROC" initCommand loopCommand onMessageCommand
```

## ⚡ coproc::runInParallel

This function runs a list of commands in parallel with a maximum number of parallel coprocs.

Inputs:

- `$1`: **job commands array name** _as string_:

  The name of the array containing the commands to run.
  Each command string will be evaluated in a subshell.
  Each command should explicitly exit with a non-zero code if it fails and with zero if it succeeds.

- `${maxInParallel}` _as int_:

  (optional) The maximum number of parallel coprocs to run.

  (defaults to 8)

- `${completedCallback}` _as string_:

  (optional) The name of the function to call when a coproc is completed (successfully or not).
  The function will receive the following arguments:
  - $1 the coproc index
  - $2 the coproc exit code
  - $3 the percentage of coprocs already completed
  - $4 the path of the file containing the accumulated logs of the coproc
  If the function sets REPLY to 1, the script will exit early. Otherwise it should set REPLY to 0.
  Set to an empty string to not call any callback function.

  (defaults to "")

- `${redirectLogs}` _as bool_:

  (optional) Redirect the logs of the coproc instead of printing them in the current file descriptor.
  The accumulated logs of the coproc will be available in the completed callback function.

  (defaults to false)

- `${printRedirectedLogs}` _as bool_:

  (optional) This option allows to automatically redirect the logs of the coproc to a file and
  print the accumulated logs of a coproc when it is completed (successfully or not).

  (defaults to false)

- `${simulateSequentialRun}` _as bool_:

  (optional) If true, this will:
  - redirect the logs of each task to a file
  - at the end of all execution, print the logs of each task, in natural order (not as they finish)
  - exit at the first error, showing the logs of the task in error
  Tasks will run as if they are called in a for loop; except they actually run in parallel.

  (defaults to false)

- `${coprocNamePrefix}` _as string_:

  (optional) The prefix to use for the coproc variable names.
  This is useful to avoid conflicts with other coproc variables.

  (defaults to "_COPROC_PARALLEL_")

Returns:

- `${REPLY}`: The number of jobs that did not completed (i.e. not executed until the end, successfully or not)
- `${REPLY2}`: The number of successfully completed jobs.
- `${REPLY_ARRAY[@]}`: an array containing the exit codes of the jobs.

Example usage:

```bash
declare -a jobCommands=("sleep 1" "sleep 2" "sleep 3")
coproc::runInParallel jobCommands maxParallelCoprocs=2
```
TODO: implement unit tests for this function

## ⚡ coproc::sendMessage

This function sends a message to a given coproc.

Inputs:

- `$1`: **coproc variable name** _as string_:

  The variable name to use for the coproc.

- `$2`: **message** _as string_:

  The message to send to the coproc.

Returns:

- `$?`:
  - 0 if the message was sent successfully.
  - 1 if the coproc is not running or the message could not be sent.

Example usage:

```bash
coproc::sendMessage "myCoproc" "Hello, coproc!"
```

> This printf call can cause the whole shell to exit with code 141 if there is an issue with the coproc.
> You will want to run this in a subshell to avoid exiting the main shell if your coproc is unstable.

## ⚡ coproc::wait

This function waits for a coproc to finish.

Inputs:

- `$1`: **coproc variable name** _as string_:

  The variable name to use for the coproc.

Returns:
- `${REPLY_CODE}`: The exit status of the coproc (or -1 if the coproc is not running).

Example usage:

```bash
coproc::wait "myCoproc"
```

> [!IMPORTANT]
> Documentation generated for the version 0.34.68 (2025-09-17).
