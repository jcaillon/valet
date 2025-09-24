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

❯ `benchmark::run test_function_1 test_function_2 test_function_3 --- baselineTimeInSeconds=3 maxRun=5`

**Error output**:

```text
INFO     The baseline ⌜test_function_1⌝ was initially run ⌜3⌝ times in ⌜10.000s⌝.
INFO     The function ⌜test_function_2⌝ was run ⌜3⌝ times in ⌜6.000s⌝.
INFO     The function ⌜test_function_3⌝ was run ⌜3⌝ times in ⌜8.000s⌝.
INFO     The function ⌜test_function_1⌝ was run ⌜3⌝ times in ⌜10.000s⌝.
SUCCESS  Benchmark results from fastest to slowest for 3 runs:

Function name   ░ Average time  ░ Compared to fastest
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
test_function_2 ░ 2.000s 000µs ░ N/A
test_function_3 ░ 2.666s 666µs ░ +33%
test_function_1 ░ 3.333s 333µs ░ +66%

```

