# Test suite self-config

## Test script 01.self-config

### ✅ Testing self config command

❯ `selfConfig`

**Standard output**:

```text
🙈 mocking myEditor: /tmp/valet-temp
```

**Error output**:

```text
INFO     Creating the valet config file ⌜/tmp/valet-temp⌝.
INFO     Opening the valet config file ⌜/tmp/valet-temp⌝.
```

❯ `io::head /tmp/valet-temp 3`

**Standard output**:

```text
#!/usr/bin/env bash
# description: This script declares global variables used to configure Valet
# shellcheck disable=SC2034
```

Testing selfConfig (should only open, file does not exist)

❯ `selfConfig`

**Standard output**:

```text
🙈 mocking myEditor: /tmp/valet-temp
```

**Error output**:

```text
INFO     Opening the valet config file ⌜/tmp/valet-temp⌝.
```

Testing selfConfig override no edit

❯ `selfConfig --override --no-edit`

**Error output**:

```text
INFO     Creating the valet config file ⌜/tmp/valet-temp⌝.
```

Testing to export the current values

```text
VALET_CONFIG_LOCALE='/tmp/valet-temp'
```

❯ `selfConfig --override --export-current-values`

**Standard output**:

```text
🙈 mocking myEditor: /tmp/valet-temp
```

**Error output**:

```text
INFO     Creating the valet config file ⌜/tmp/valet-temp⌝.
INFO     Opening the valet config file ⌜/tmp/valet-temp⌝.
```

The path /tmp/valet-temp is in the config file as expected.

