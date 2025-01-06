# Test suite 1009-lib-benchmark

## Test script 00.tests

### Testing benchmark::run function

Exit code: `0`

**Standard** output:

```plaintext
test_function_1 () 
{ 
    io::sleep 0.01
}
test_function_2 () 
{ 
    io::sleep 0.05
}
test_function_3 () 
{ 
    io::sleep 0.03
}

→ benchmark::run test_function_1 '' 1

→ benchmark::run test_function_1 test_function_2,test_function_3 3 5
```

**Error** output:

```log
INFO     Running the baseline ⌜test_function_1⌝ for ⌜1s⌝.
INFO     The baseline ⌜test_function_1⌝ was initially run ⌜53⌝ times in ⌜01.002s⌝.
INFO     The function ⌜test_function_1⌝ was run ⌜53⌝ times in ⌜00.820s⌝.
SUCCESS  Benchmark results from fastest to slowest:

Function name ░ Average time  ░ % slower than fastest
░[39b
test_function_1 ░ 00.015s 482µs ░ N/A

INFO     Running the baseline ⌜test_function_1⌝ for ⌜3s⌝.
INFO     The baseline ⌜test_function_1⌝ was initially run ⌜5⌝ times in ⌜00.077s⌝.
INFO     The function ⌜test_function_2⌝ was run ⌜5⌝ times in ⌜00.310s⌝.
INFO     The function ⌜test_function_3⌝ was run ⌜5⌝ times in ⌜00.198s⌝.
INFO     The function ⌜test_function_1⌝ was run ⌜5⌝ times in ⌜00.078s⌝.
SUCCESS  Benchmark results from fastest to slowest:

Function name   ░ Average time  ░ % slower than fastest
░[54b
test_function_1 ░ 00.015s 777µs ░ N/A
test_function_3 ░ 00.039s 683µs ░ 151%
test_function_2 ░ 00.062s 149µs ░ 293%

```

