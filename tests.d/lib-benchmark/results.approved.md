# Test suite lib-benchmark

## Test script 00.tests

### ✅ Testing benchmark::run

❯ `declare -f test_function_1 test_function_2 test_function_3`

**Standard output**:

```text
test_function_1 () 
{ 
    :
}
test_function_2 () 
{ 
    :
}
test_function_3 () 
{ 
    :
}
```

❯ `benchmark::run test_function_1 test_function_2 test_function_3 --- baselineTime=3 maxRun=5`

**Error output**:

```text
INFO     The baseline ⌜test_function_1⌝ was initially run ⌜2⌝ times in ⌜9.000s⌝.
INFO     The function ⌜test_function_2⌝ was run ⌜2⌝ times in ⌜6.000s⌝.
INFO     The function ⌜test_function_3⌝ was run ⌜2⌝ times in ⌜8.000s⌝.
INFO     The function ⌜test_function_1⌝ was run ⌜2⌝ times in ⌜10.000s⌝.
SUCCESS  Benchmark results from fastest to slowest for 2 runs:

Function name   ░ Average time  ░ Compared to fastest
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
test_function_2 ░ 3.000s 000µs ░ N/A
test_function_3 ░ 4.000s 000µs ░ +33%
test_function_1 ░ 5.000s 000µs ░ +66%

```

