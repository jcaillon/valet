#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-yaml
source yaml

function main() {
  test_yaml::parseFile
}

function test_yaml::parseFile() {
  test::title "✅ Testing yaml::parseFile function"

  test::func yaml::parseFile resources/ok/arrays.yaml
  test::func yaml::parseFile resources/ok/simple.yaml
  test::func yaml::parseFile resources/ok/root-array.yaml
}

main
