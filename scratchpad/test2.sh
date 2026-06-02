#!/usr/bin/env bash
# shellcheck disable=SC1090
# source "$(valet --source)"
# include benchmark progress bash time

function fs::getAbsolutePath() {
  local path="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}"
  path="${path%/}"

  if [[ ${path} == '~'* ]]; then
    # if path starts with ~, we replace it with the home directory
    path="${HOME}${path:1}"
  elif [[ ${path} == "." || ${path} == "" ]]; then
    REPLY="${PWD}"
    return 0
  elif [[ ${path} == ".." ]] && builtin pushd "${PWD}/.." &>/dev/null; then
    REPLY="${PWD}"
    builtin popd &>/dev/null || core::fail "Failed to popd back to the previous directory."
    return 0
  elif [[ ${path} != *"/"* ]]; then
    # case of a simple file name
    REPLY="${PWD}/${path}"
    return 0
  fi

  # store the base name
  local baseName="${path##*/}"
  path="${path%/*}"

  if [[ -z ${path} ]]; then
    # if the path is empty, it means that the path was "/basename"
    REPLY="/${baseName}"
    return 0
  fi

  # if not an absolute path, we prepend the current directory to the path
  if [[ ${path} != "/"* ]]; then
    path="${PWD}/${path}"
  fi

  # shortcut if the path exists
  if builtin pushd "${path}" &>/dev/null; then
    REPLY="${PWD%/}/${baseName}"
    builtin popd &>/dev/null || core::fail "Failed to popd back to the previous directory."
    return 0
  fi

  # loop through each path part and build the absolute path
  local -
  set -o noglob
  local part IFS=$'/'
  REPLY=""
  for part in ${path}; do
    case "${part}" in
    "" | ".")
      continue
      ;;
    "..")
      REPLY="${REPLY%/*}"
      ;;
    *)
      REPLY="${REPLY}/${part}"
      ;;
    esac
  done

  REPLY="${REPLY}/${baseName}"
}

function test() {
  local REPLY
  fs::getAbsolutePath "${1}"
  echo "Absolute path of ⌜${1}⌝: ${REPLY}"
}

test /app
