# Test suite 1108-self-uninstall

## Test script 01.self-uninstall

### Testing selfUninstall

Exit code: `0`

**Standard** output:

```plaintext
→ selfUninstall

→ selfUninstall --script
ok
```

**Error** output:

```log
WARNING  To uninstall Valet, you can run the following commands:

bash -c 'eval "$(valet self uninstall --script 2>/dev/null)"'
```
