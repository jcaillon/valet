# Test suite lib-assert

## Test script 00.lib-time

### ✅ Testing that assert of tests calls core::fail

❯ `assert::equals expected actual`

**Error output**:

```text
INFO     core::fail called with message: Expected value ⌜expected⌝ does not equal actual value ⌜actual⌝.
```

❯ `assert::equals expected actual`

**Error output**:

```text
INFO     test::fail called with message: Expected value ⌜expected⌝ does not equal actual value ⌜actual⌝.
```

### ✅ Testing functions of assert library

❯ `assert::equals = =`

❯ `assert::isLink /tmp/valet.d/d1-2`

**Error output**:

```text
INFO     test::fail called with message: Expected link ⌜/tmp/valet.d/d1-2⌝ does not exist or is not a symbolic link.
```

❯ `assert::isLink /tmp/valet.d/d1-2/file1`

**Error output**:

```text
INFO     test::fail called with message: Expected link ⌜/tmp/valet.d/d1-2/file1⌝ does not exist or is not a symbolic link.
```

❯ `assert::isLink /tmp/valet.d/d1-2/link-to-file1`

❯ `assert::isFile /tmp/valet.d/d1-2`

**Error output**:

```text
INFO     test::fail called with message: Expected file ⌜/tmp/valet.d/d1-2⌝ does not exist or is not a regular file.
```

❯ `assert::isFile /tmp/valet.d/d1-2/file1`

❯ `assert::isFile /tmp/valet.d/d1-2/link-to-file1`

**Error output**:

```text
INFO     test::fail called with message: Expected file ⌜/tmp/valet.d/d1-2/link-to-file1⌝ does not exist or is not a regular file.
```

❯ `assert::isDirectory /tmp/valet.d/d1-2`

❯ `assert::isDirectory /tmp/valet.d/d1-2/file1`

**Error output**:

```text
INFO     test::fail called with message: Expected directory ⌜/tmp/valet.d/d1-2/file1⌝ does not exist or is not a directory.
```

❯ `assert::isDirectory /tmp/valet.d/d1-2/link-to-file1`

**Error output**:

```text
INFO     test::fail called with message: Expected directory ⌜/tmp/valet.d/d1-2/link-to-file1⌝ does not exist or is not a directory.
```

❯ `assert::isPath /tmp/valet.d/d1-2`

❯ `assert::isPath /tmp/valet.d/d1-2/file1`

❯ `assert::isPath /tmp/valet.d/d1-2/link-to-file1`

