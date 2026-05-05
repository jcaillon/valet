#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-data
source data

function main() {
  test::setProgramElapsedFunction 0 increment=1000000 incrementIncrement=0

  test_data::serialize
}

# shellcheck disable=SC2034
function test_data::serialize() {

  local -a my_array=([0]="first" [1]=$'second\nwith new lines' [2]="third")
  local my_string=$'a\nword\tplease'
  local -i my_integer="2"
  local -A my_associative_array=([key]="value")

  test::title "✅ Testing data::deserialize from non-existing file"
  test::func data::deserialize non-existing

  test::title "✅ Testing data::serialize with file name"
  test::func data::serialize my-variables my_array my_string my_integer my_associative_array

  test::title "✅ Testing data::serialize with file name under a folder"
  test::func data::serialize folder/my-variables my_array my_string my_integer my_associative_array

  test::title "✅ Testing data::deserialize with file name"
  unset -v my_array my_string my_integer my_associative_array
  test::func data::deserialize my-variables
  data::deserialize my-variables
  eval "${REPLY}"
  if [[ ! -v my_array || ! -v my_string || ! -v my_integer ]]; then
    test::fail "Failed to restore variables from script with file name."
  fi

  test::title "✅ Testing data::serialize with file path"
  test::func data::serialize "${GLOBAL_TEST_TEMP_FILE}" my_string

  test::title "✅ Testing data::deserialize with file path"
  unset -v my_string
  test::func data::deserialize "${GLOBAL_TEST_TEMP_FILE}"
}

main
