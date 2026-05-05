#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-variable
source variable

function main() {
  test::setProgramElapsedFunction 0 increment=1000000 incrementIncrement=0

  test_variable::serialize
  test_variable::isCachedWithValue
  test_variable::isMissing
}

# shellcheck disable=SC2034
function test_variable::serialize() {

  local -a my_array=([0]="first" [1]=$'second\nwith new lines' [2]="third")
  local my_string=$'a\nword\tplease'
  local -i my_integer="2"
  local -A my_associative_array=([key]="value")

  test::title "✅ Testing variable::deserialize from non-existing file"
  test::func variable::deserialize non-existing

  test::title "✅ Testing variable::serialize with file name"
  test::func variable::serialize my-variables my_array my_string my_integer my_associative_array

  test::title "✅ Testing variable::serialize with file name under a folder"
  test::func variable::serialize folder/my-variables my_array my_string my_integer my_associative_array

  test::title "✅ Testing variable::deserialize with file name"
  unset -v my_array my_string my_integer my_associative_array
  test::func variable::deserialize my-variables
  variable::deserialize my-variables
  eval "${REPLY}"
  if [[ ! -v my_array || ! -v my_string || ! -v my_integer ]]; then
    test::fail "Failed to restore variables from script with file name."
  fi

  test::title "✅ Testing variable::serialize with file path"
  test::func variable::serialize "${GLOBAL_TEST_TEMP_FILE}" my_string

  test::title "✅ Testing variable::deserialize with file path"
  unset -v my_string
  test::func variable::deserialize "${GLOBAL_TEST_TEMP_FILE}"
}

function test_variable::isCachedWithValue() {
  test::title "✅ Testing variable::isCachedWithValue"

  test::func variable::isCachedWithValue VAR1 val1 VAR2 val2
  test::func variable::isCachedWithValue VAR1 val1
  test::func variable::isCachedWithValue VAR1 val2

  # shellcheck disable=SC2119
  test::func variable::clearCachedVariables
  test::func variable::isCachedWithValue VAR2 val2
  test::func variable::clearCachedVariables VAR2
  test::func variable::isCachedWithValue VAR2 val2
  test::func variable::isCachedWithValue VAR2 val2
}

function test_variable::isMissing() {
  test::title "✅ Testing variable::isMissing"

  test::func variable::isMissing
  test::exec ABC="ok"
  test::func variable::isMissing GLOBAL_TEST_TEMP_FILE dfg ABC NOP
}

main
