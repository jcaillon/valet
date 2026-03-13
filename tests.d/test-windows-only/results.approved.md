# Test suite test-windows-only

## Test script 00.tests

### ✅ Testing fs::createLink

❯ `fs::createLink file1 target/link1`

❯ `fs::createLink file1 target/link2 hardlink=true`

❯ `fs::createLink file2 target/link3 hardlink=true`

❯ `fs::createLink folder1 target/folder-link1`

❯ `fs::createLink folder1 target/existing-folder-link2`

Exited with code: `1`

**Error output**:

```text
FAIL     Failed to create a link to ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/test-windows-only/resources/gitignored/folder1⌝ ← ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/test-windows-only/resources/gitignored/target/existing-folder-link2⌝, the link pathname already exists.
```

❯ `fs::createLink file1 target/existing-folder-link2`

Exited with code: `1`

**Error output**:

```text
FAIL     Failed to create a link to ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/test-windows-only/resources/gitignored/file1⌝ ← ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/test-windows-only/resources/gitignored/target/existing-folder-link2⌝, the link pathname already exists.
```

❯ `fs::createLink folder1 target/existing-folder-link2 force=true`

❯ `fs::createLink folder1 target/existing-file3`

Exited with code: `1`

**Error output**:

```text
FAIL     Failed to create a link to ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/test-windows-only/resources/gitignored/folder1⌝ ← ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/test-windows-only/resources/gitignored/target/existing-file3⌝, the link pathname already exists.
```

❯ `fs::createLink file1 target/existing-file3`

Exited with code: `1`

**Error output**:

```text
FAIL     Failed to create a link to ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/test-windows-only/resources/gitignored/file1⌝ ← ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/test-windows-only/resources/gitignored/target/existing-file3⌝, the link pathname already exists.
```

❯ `fs::createLink file1 target/existing-file3 force=true`

### ✅ Testing fs::isValidLink

❯ `fs::isValidLink file1 target/link1`

❯ `fs::isValidLink file1 target/link2 hardlink=true`

❯ `fs::isValidLink folder1 target/folder-link1`

❯ `fs::isValidLink file1 target/link1 hardlink=true`

Returned code: `1`

❯ `fs::isValidLink file1 target/link2`

Returned code: `1`

❯ `fs::isValidLink file1 folder1`

Returned code: `1`

❯ `fs::isValidLink folder1 file1`

Returned code: `1`

❯ `fs::isValidLink file1 non-existing`

Returned code: `1`

❯ `fs::isValidLink file2 target/existing-file3`

Returned code: `1`

❯ `fs::isValidLink file1 target/link3 hardlink=true`

Returned code: `1`

