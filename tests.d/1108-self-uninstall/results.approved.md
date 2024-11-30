# Test suite 1108-self-uninstall

## Test script 01.self-uninstall

### Testing selfUninstall

Exit code: `0`

**Standard** output:

```plaintext
→ selfUninstall

→ selfUninstall --script
#!/usr/bin/env bash
# remove main installation of Valet
rm -Rf "$GLOBAL_VALET_HOME"
# remove the user configuration
rm -Rf "/c/Users/jcaillon/.config/valet"
# remove the user state
rm -Rf "/c/Users/jcaillon/.local/share/valet"
# remove the user directory
rm -Rf "/c/Users/jcaillon/.valet.d"
# remove a possible symlink
rm -f "$GLOBAL_VALET_HOME/valet" 2>/dev/null || :
echo "Valet has been uninstalled."

```

**Error** output:

```log
WARNING  To uninstall Valet, you can run the following commands:

bash -c 'eval "$(valet self uninstall --script 2>/dev/null)"'
```

