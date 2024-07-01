# Test suite 1106-self-update

## Test script 01.self-release

### Testing SelfUpdate, nothing to do (already up to date)

Exit code: `0`

**Standard** output:

```plaintext
→ SelfUpdate --skip-git-update
```

**Error** output:

```log
SUCCESS  You already have the latest version.
```

