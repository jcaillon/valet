#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-yaml
source yaml
# shellcheck source=../../libraries.d/lib-fs
source fs
# shellcheck source=../../libraries.d/lib-string
source string

function main() {
  test_yaml::parseFile
  test_yaml::parseString
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

  test::title "✅ Testing yaml::parseFile with visitor"
  test::exec yaml::parseFile "resources/ok/a-complete-example.yaml" onKeyValueFunction=yamlVisitor
}

function test_yaml::parseString() {
  test::title "✅ Testing yaml::parseFile and yaml::parseString are equal"
  local file fileContent outputFromFile outputFromString
  fs::listFiles "resources/ok"
  for file in "${REPLY_ARRAY[@]}"; do
    yaml::parseFile "${file}"
    stringifyReplyMaps
    outputFromFile="${REPLY}"

    fs::readFile "${file}"
    # shellcheck disable=SC2034
    fileContent="${REPLY}"
    yaml::parseString fileContent
    stringifyReplyMaps
    outputFromString="${REPLY}"

    if [[ ${outputFromFile} != "${outputFromString}" ]]; then
      test::fail "The output from yaml::parseFile and yaml::parse are different for file ${file@Q}:"$'\n'"outputFromFile: ${outputFromFile}"$'\n\n\n'"outputFromString: ${outputFromString}"
    fi
  done
}

function stringifyReplyMaps() {
  REPLY=""
  local varName
  for varName in REPLY_MAP REPLY_MAP2; do
    local -n associativeArrayNameRef="${varName}"
    REPLY+="${varName}=("$'\n'
    local -a keys=("${!associativeArrayNameRef[@]}")
    include array
    array::sort keys
    for key in "${keys[@]}"; do
      REPLY+="['${key}']='${associativeArrayNameRef[${key}]//\'/\'\"\'\"\'}'"$'\n'
    done
    REPLY+=")"$'\n'
  done
}

function yamlVisitor() {
  echo "${1}"
  if [[ ! -v REPLY_MAP[${1}] ]]; then
    test::fail "yamlVisitor: The key ${1@Q} is not in the REPLY_MAP associative array."
  fi
}

main
