---
title: 📂 progress
cascade:
  type: docs
url: /docs/libraries/progress
---

## ⚡ progress::start

Shows a spinner / progress animation with configurable output including a progress bar.

The animation will be displayed until progress::stop is called
or if the max number of frames is reached.

Outputs to stderr.
This will run in the background and will not block the main thread.
The main thread can continue to output logs while this animation is running.

Inputs:

- `$1{template}` _as string_:

  (optional) The template to display. The template can contain the following placeholders:

  - `<spinner>`: the spinner animation
  - `<percent>`: the percentage of the progress bar
  - `<bar>`: the progress bar
  - `<message>`: the message to display
  - #TODO: add `<cGradient>` and `<cDefault>`: colors the bar with a gradient (if colors enabled)

  The default template is defined by the environment variable `VALET_CONFIG_PROGRESS_DEFAULT_TEMPLATE`.

  (defaults to "<spinner> <percent> ░<bar>░ <message>")

- `${size}` _as int_:

  (optional) The maximum width of the progress bar.
  The default size is defined by the environment variable `VALET_CONFIG_PROGRESS_BAR_DEFAULT_SIZE`.

  (defaults to 20)

- `${frameDelay}` _as int_:

  (optional) The time in milliseconds between each frame of the spinner.
  The default frame delay is defined by the environment variable `VALET_CONFIG_PROGRESS_DEFAULT_ANIMATION_DELAY`.

  (defaults to 200)

- `${maxFrames}` _as int_:

  (optional) The maximum number of frames to display.

  (defaults to 9223372036854775807)

- `${spinnerFrames}` _as string_:

  (optional) The spinner to display (each character is a frame).
  Examples:

  - ◐◓◑◒
  - ▖▘▝▗
  - ⣾⣽⣻⢿⡿⣟⣯⣷
  - ⢄⢂⢁⡁⡈⡐⡠
  - ◡⊙◠
  - ▌▀▐▄
  - ⠄⠆⠇⠋⠙⠸⠰⠠⠰⠸⠙⠋⠇⠆

  The default spinner is defined by the environment variable `VALET_CONFIG_SPINNER_CHARACTERS`.

  (defaults to "⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏")

- `${percentage}` _as int_:

  (optional) The default percentage to start with.

  (defaults to 0)

- `${message}` _as string_:

  (optional) The default message to start with.

  (defaults to "")

Example usage:

```bash
progress::start template="<spinner>" "" 100
wait 4
progress::stop

progress::start template="<spinner> <percent> ░<bar>░ <message>" size=30 spinnerFrames="⢄⢂⢁⡁⡈⡐⡠"
IDX=0
while [[ ${IDX} -le 50 ]]; do
  progress::update $((IDX * 2)) "Doing something ${IDX}/50..."
  IDX=$((IDX + 1))
  sleep 0.1
done
progress::stop
```

> Important: all progress functions will only work if called from the same shell
> that started the progress bar.

## ⚡ progress::stop

Stop the progress bar.

Example usage:

```bash
progress::stop
```

## ⚡ progress::update

Update the progress bar with a new percentage and message.

The animation can be started with progress::start for more options.
The animation will stop if the updated percentage is 100.

Inputs:

- `$1`: **percent** _as int_:

  the percentage of the progress bar (0 to 100)

- `$2`: message _as string_:

  (optional) the message to display

Example usage:

```bash
progress::update 50 "Doing something..."
```

> [!IMPORTANT]
> Documentation generated for the version 0.31.272 (2025-08-26).
