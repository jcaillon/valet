---
title: 📂 progress
cascade:
  type: docs
url: /docs/libraries/progress
---

## progress::start

Shows a spinner / progress animation with configurable output including a progress bar.

The animation will be displayed until progress::stop is called
or if the max number of frames is reached.

Outputs to stderr.
This will run in the background and will not block the main thread.
The main thread can continue to output logs while this animation is running.

- $1: template _as string_:
      (optional) Can be set using the variable `_OPTION_TEMPLATE`.
      The template to display. The template can contain the following placeholders:
      - `<spinner>`: the spinner animation
      - `<percent>`: the percentage of the progress bar
      - `<bar>`: the progress bar
      - `<message>`: the message to display
      - #TODO: add `<cGradient>` and `<cDefault>`: colors the bar with a gradient (if colors enabled)
      (defaults to VALET_CONFIG_PROGRESS_DEFAULT_TEMPLATE or "<spinner> <percent> ░<bar>░ <message>")
- $2: bar size _as int_:
      (optional) Can be set using the variable `_OPTION_BAR_SIZE`.
      The maximum width of the progress bar.
      (defaults to VALET_CONFIG_PROGRESS_BAR_DEFAULT_SIZE or 20)
- $3: frame delay _as int_:
      (optional) Can be set using the variable `_OPTION_FRAME_DELAY`.
      The time in milliseconds between each frame of the spinner.
      (defaults to VALET_CONFIG_PROGRESS_DEFAULT_ANIMATION_DELAY or 200)
- ${_OPTION_MAX_FRAMES} _as int_:
      (optional) The maximum number of frames to display.
      (defaults to 9223372036854775807)
- ${_OPTION_SPINNER} _as string_:
      (optional) The spinner to display (each character is a frame).
      Examples:
      - ◐◓◑◒
      - ▖▘▝▗
      - ⣾⣽⣻⢿⡿⣟⣯⣷
      - ⢄⢂⢁⡁⡈⡐⡠
      - ◡⊙◠
      - ▌▀▐▄
      - ⠄⠆⠇⠋⠙⠸⠰⠠⠰⠸⠙⠋⠇⠆
      (defaults to VALET_CONFIG_SPINNER_CHARACTERS or "⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏")
- ${_OPTION_DEFAULT_PERCENTAGE} _as int_:
      (optional) The default percentage to start with.
      (defaults to 0)
- ${_OPTION_DEFAULT_MESSAGE} _as int_:
      (optional) The default message to start with.
      (defaults to "")

```bash
progress::start "<spinner>" "" 100
wait 4
progress::stop

_OPTION_SPINNER="⢄⢂⢁⡁⡈⡐⡠" progress::start "<spinner> <percent> ░<bar>░ <message>" 30
IDX=0
while [[ ${IDX} -le 50 ]]; do
  progress::update $((IDX * 2)) "Doing something ${IDX}/50..."
  IDX=$((IDX + 1))
  sleep 0.1
done
```

> Important: all progress functions will only work if called from the same shell
> that started the progress bar.

## progress::stop

Stop the progress bar.

```bash
progress::stop
```

## progress::update

Update the progress bar with a new percentage and message.

The animation can be started with progress::start for more options.
The animation will stop if the updated percentage is 100.

- $1: **percent** _as int_:
      the percentage of the progress bar (0 to 100)
- $2: message _as string_:
      (optional) the message to display

```bash
progress::update 50 "Doing something..."
```

{{< callout type="info" >}}
Documentation generated for the version 0.29.197 (2025-03-29).
{{< /callout >}}
