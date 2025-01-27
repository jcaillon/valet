# Test suite self-uninstall

## Test script 01.self-uninstall

### ✅ Testing self uninstall command

❯ `selfUninstall`

**Error output**:

```text
WARNING  To uninstall Valet, you can run the following commands:

bash -c 'eval "$(valet self uninstall --script 2>/dev/null)"'
```

❯ `exe::invoke selfUninstall --script`

The uninstallation script contains 'Valet has been uninstalled'.

