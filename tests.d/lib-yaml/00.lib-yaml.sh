#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-yaml
source yaml

function main() {
  test_yaml::parseFile
}

function test_yaml::parseFile() {
  test::title "✅ Testing yaml::parseFile function"

  test::func yaml::parseFile resources/arrays.yaml
  test::func yaml::parseFile resources/simple.yaml
  test::func yaml::parseFile resources/root-array.yaml
}

main
