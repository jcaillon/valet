#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-yaml
source yaml
# shellcheck source=../../libraries.d/lib-fs
source fs
# shellcheck source=../../libraries.d/lib-string
source string

function main() {
  test_yaml::parseFile
  test_yaml::compare
  test_yaml::writeString
}

function test_yaml::writeString() {
  test::title "✅ Testing yaml::writeString function"

  yaml::parseFile "resources/ok/write.yaml"
  yaml::writeString REPLY_MAP REPLY_MAP2
  unset -v REPLY2 REPLY3 REPLY4 REPLY_ARRAY REPLY_CODE
  test::printReplyVars
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

function test_yaml::compare() {
  test::title "✅ Testing the results of yaml::parseFile, yaml::parseString, yaml::writeString"
  local file outputFromFile outputFromString outputFromWriteString
  fs::listFiles "resources/ok"
  for file in "${REPLY_ARRAY[@]}"; do
    yaml::parseFile "${file}"
    stringifyReplyMaps
    outputFromFile="${REPLY}"

    # TODO: remove the items in the following line to actually test writeString
    if [[ ${file} =~ (flow-collections.yaml|full.yaml|json-root-object.yaml|merge-keys.yaml|tags-on-keys.yaml|tags.yaml) ]]; then
      fs::readFile "${file}"
    else
      yaml::writeString REPLY_MAP REPLY_MAP2
    fi
    outputFromWriteString="${REPLY}"

    yaml::parseString outputFromWriteString
    stringifyReplyMaps
    outputFromString="${REPLY}"

    if [[ ${outputFromFile} != "${outputFromString}" ]]; then
      test::fail "The output from yaml::writeString is:"$'\n'"${outputFromWriteString}"$'\n\n\n'"The output from yaml::parseFile and yaml::parse are different for file ${file@Q}:"$'\n'"outputFromFile:"$'\n'"${outputFromFile}"$'\n\n\n'"outputFromString:"$'\n'"${outputFromString}"
    fi
  done

  test::markdown "outputs of yaml::parseFile and yaml::parseString are equal"
  test::markdown "parsing a file, then writing it back using testing yaml::writeString, then reparsing the output yield to the same result"
}

function stringifyReplyMaps() {
  REPLY=""
  local varName quoted
  for varName in REPLY_MAP REPLY_MAP2; do
    local -n associativeArrayNameRef="${varName}"
    REPLY+="${varName}=("$'\n'
    local -a keys=("${!associativeArrayNameRef[@]}")
    include array
    array::sort keys
    for key in "${keys[@]}"; do
      printf -v quoted '%q' "${associativeArrayNameRef[${key}]}"
      REPLY+="['${key}']=${quoted}"$'\n'
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
