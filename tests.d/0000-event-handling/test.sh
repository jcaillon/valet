#!/usr/bin/env bash
valet self test-core --error
endTest "Testing valet self test-core --error" $?

valet self test-core --exit
