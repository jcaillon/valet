#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-yaml
source yaml
# shellcheck source=../../libraries.d/lib-fs
source fs

function main() {
  test_yaml::parseFile
}

function test_yaml::parseFile() {
  local file

  test::title "✅ Testing yaml::parseFile function"
  fs::listFiles "resources/ok"
  for file in "${REPLY_ARRAY[@]}"; do
    test::cat "${file}"
    test::func yaml::parseFile "${file}"
  done

  test::title "✅ Testing KO yaml::parseFile function"
  fs::listFiles "resources/ko"
  for file in "${REPLY_ARRAY[@]}"; do
    test::cat "${file}"
    test::exit yaml::parseFile "${file}"
  done

  test::title "✅ Testing yaml::parseFile with options"
  test::func yaml::parseFile "resources/ok/single-line-nested-arrays.yaml" prefixFirstDoc=true
  test::func yaml::parseFile "resources/ok/any-indent.yaml" prefixFirstDoc=true
}

main
