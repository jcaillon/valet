#!/usr/bin/env bash
# shellcheck source=../../../libraries.d/main
source "$(valet --source)"
include benchmark

# rename all original yaml functions with original_ prefix
source ./yaml-parsing-original
include bash string
bash::getBuiltinOutput declare -F
string::split REPLY $'\n\r'
for func in "${REPLY_ARRAY[@]}"; do
  func="${func#declare -f }"
  if [[ ${func} == "yaml"* ]]; then
    # redefine the function with a different name
    newFuncName="original_${func}"
    bash::getBuiltinOutput declare -f "${func}"
    REPLY="${REPLY#*$'\n'}"
    REPLY="${REPLY#*$'\n'}"
    REPLY="${REPLY//"yaml::"/"original_yaml::"}"
    REPLY="${REPLY//"yaml_"/"original_yaml_"}"
    eval "function ${newFuncName}() { ${REPLY}"
  fi
done

include yaml fs

fs::listFiles "${GLOBAL_INSTALLATION_DIRECTORY}/tests.d/lib-yaml/resources/ok"
FILES=("${REPLY_ARRAY[@]}")

function new() {
  for file in "${FILES[@]}"; do
    yaml::parseFile "${file}"
  done
}

function original() {
  for file in "${FILES[@]}"; do
    original_yaml::parseFile "${file}"
  done
}
benchmark::run new original
