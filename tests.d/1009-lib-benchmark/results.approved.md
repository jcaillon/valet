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
INFO     Running the baseline ⌜test_function_X⌝ for ⌜Xs⌝.
INFO     The baseline ⌜test_function_X⌝ was initially run ⌜X⌝ times in ⌜XX.XXXs⌝.
INFO     The function ⌜test_function_X⌝ was run ⌜X⌝ times in ⌜XX.XXXs⌝.
SUCCESS  Benchmark results from fastest to slowest:

Function name ░ Average time  ░ Compared to fastest
░[XXb
test_function_X ░ XX.XXXs XXXµs ░ N/A

INFO     Running the baseline ⌜test_function_X⌝ for ⌜Xs⌝.
INFO     The baseline ⌜test_function_X⌝ was initially run ⌜X⌝ times in ⌜XX.XXXs⌝.
INFO     The function ⌜test_function_X⌝ was run ⌜X⌝ times in ⌜XX.XXXs⌝.
INFO     The function ⌜test_function_X⌝ was run ⌜X⌝ times in ⌜XX.XXXs⌝.
INFO     The function ⌜test_function_X⌝ was run ⌜X⌝ times in ⌜XX.XXXs⌝.
SUCCESS  Benchmark results from fastest to slowest:

Function name   ░ Average time  ░ Compared to fastest
░[XXb
test_function_X ░ XX.XXXs XXXµs ░ N/A
test_function_X ░ XX.XXXs XXXµs ░ +XXX%
test_function_X ░ XX.XXXs XXXµs ░ +XXX%

```

