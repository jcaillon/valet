#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$(valet --source)"
include tui

# source this file

# tui::testWaitForKeyPress
# tui::rebindKeymap for_each_key

function main() {
  # save the original bindings
  _OPTION_PATH_ONLY=true fs::createTempFile
  _INTERACTIVE_SAVED_BINDINGS_FILE="${RETURNED_VALUE}"
  bind -p >"${_INTERACTIVE_SAVED_BINDINGS_FILE}" 2>/dev/null


  # remove all existing bindings except the self-insert ones
  # (self-insert is the default binding for "normal" characters, e.g. a, b, c, 1, 2, 3, ...)
  fs::readFile "${_INTERACTIVE_SAVED_BINDINGS_FILE}"
  local bindings="${RETURNED_VALUE}"
  local IFS=$'\n'
  local line
  local key
  for line in ${bindings}; do
    if [[ ${line} == "#"* || ${line} != *"self-insert" ]]; then
      continue
    fi
    key="${line%%: *}"
    val="${key:1}"
    val="${val:0:${#val}-1}"
    case "${val}" in
      \\[0-9]*)
        eval "val=$'${val}'"
      ;;
    esac
    printf -v val "%q" "${val}"

    echo "line: ${line}"
    echo "\"${key}\": \"for_each_key ${val}\""
    bind -x "${key}: \"for_each_key ${val}\"" &>/dev/null
    key="${key//\"/}"
  done

}

main

# bind -X


function for_each_key() {
  # echo "READLINE_LINE: ${READLINE_LINE}, READLINE_POINT: ${READLINE_POINT}, READLINE_MARK: ${READLINE_MARK}"
  # echo "You pressed the key: ${1@Q}"
  # READLINE_LINE="${READLINE_LINE:0:READLINE_POINT}${1}"
  # if (( READLINE_POINT > 0 )); then
  #   READLINE_LINE+="${READLINE_LINE:READLINE_POINT}"
  # fi
  # READLINE_POINT=$((READLINE_POINT + 1))
  # READLINE_LINE="\x1b[34m${READLINE_LINE:0:READLINE_POINT}\x1b[0m"
  printf "%s" $'\r'"${ESC__FG_RED}${READLINE_LINE:0:READLINE_POINT}${ESC__FG_RESET}" 1>&2
  READLINE_LINE=""
  READLINE_POINT=0
}

function accceptLine() {
  READLINE_LINE="echo coucou"
}

bind -m emacs-standard '"a": "\065\C-r"'
bind -m emacs-standard '"\C-q": "\C-k"'
bind -x '"\C-r": for_each_key'
bind -x '"\C-k": accceptLine'
bind -x '"\C-j": accept-line'