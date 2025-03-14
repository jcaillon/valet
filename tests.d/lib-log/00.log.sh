#!/usr/bin/env bash

# shellcheck disable=SC2034
function main() {
  test_log::init
  test_log::parseLogPattern

  test::title "✅ Testing with no formatting"
  VALET_CONFIG_LOG_PATTERN="<level> <message>"
  VALET_CONFIG_LOG_FORMATTED_EXTRA_EVAL=""
  VALET_CONFIG_LOG_COLUMNS=9999
  VALET_CONFIG_LOG_DISABLE_WRAP=true
  VALET_CONFIG_LOG_DISABLE_HIGHLIGHT=true
  VALET_CONFIG_LOG_FD=2
  VALET_CONFIG_LOG_TO_DIRECTORY=""
  VALET_CONFIG_LOG_FILENAME_PATTERN=""
  test::exec log::init
  test::exec styles::init
  test_log


  test::title "✅ Testing with full formatting"
  VALET_CONFIG_ENABLE_COLORS=true
  VALET_CONFIG_ENABLE_NERDFONT_ICONS=true
  VALET_CONFIG_DISABLE_ESC_CODES=false
  VALET_CONFIG_DISABLE_TEXT_ATTRIBUTES=false
  VALET_CONFIG_LOG_PATTERN="<colorFaded>{9s} <time>{(%FT%H:%M:%S%z)T} <levelColor>{9s} <level>{9s} <icon>{9s} <message>"
  VALET_CONFIG_LOG_COLUMNS=90
  VALET_CONFIG_LOG_DISABLE_WRAP=false
  VALET_CONFIG_LOG_DISABLE_HIGHLIGHT=false
  # fix the time to a known value
  unset EPOCHSECONDS EPOCHREALTIME
  TZ=Etc/GMT+0
  EPOCHSECONDS=548902800
  EPOCHREALTIME=548902800.000000
  test::printVars VALET_CONFIG_ENABLE_COLORS VALET_CONFIG_ENABLE_NERDFONT_ICONS VALET_CONFIG_LOG_PATTERN VALET_CONFIG_LOG_COLUMNS VALET_CONFIG_LOG_DISABLE_WRAP VALET_CONFIG_LOG_DISABLE_HIGHLIGHT TZ EPOCHSECONDS EPOCHREALTIME
  test::exec log::init
  test::exec styles::init
  test_log

  rm -Rf "tmp"
}

function test_log::init() {
  test::title "✅ Testing log::init"

  GLOBAL_TEST_FORCE_FD_OPEN=true
  test::exec log::init
  test::printVars GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG GLOBAL_LOG_PRINT_STATEMENT_STANDARD GLOBAL_LOG_WRAP_PADDING

  test::exec VALET_CONFIG_LOG_DISABLE_HIGHLIGHT=true VALET_CONFIG_LOG_DISABLE_WRAP=false log::init
  test::printVars GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG GLOBAL_LOG_PRINT_STATEMENT_STANDARD GLOBAL_LOG_WRAP_PADDING

  test::exec VALET_CONFIG_LOG_FORMATTED_EXTRA_EVAL="local extra=1" log::init
  test::printVars GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG GLOBAL_LOG_PRINT_STATEMENT_STANDARD GLOBAL_LOG_WRAP_PADDING

  GLOBAL_TEST_FORCE_FD_OPEN=false

  test::exec VALET_CONFIG_LOG_FD=/file VALET_CONFIG_LOG_TO_DIRECTORY=tmp log::init
  test::printVars GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG GLOBAL_LOG_PRINT_STATEMENT_STANDARD GLOBAL_LOG_WRAP_PADDING

  test::exec VALET_CONFIG_LOG_FD=/file VALET_CONFIG_LOG_TO_DIRECTORY=tmp VALET_CONFIG_LOG_FILENAME_PATTERN="logFile=a" log::init
  test::printVars GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG GLOBAL_LOG_PRINT_STATEMENT_STANDARD GLOBAL_LOG_WRAP_PADDING

  test::exec VALET_CONFIG_LOG_PATTERN=abc VALET_CONFIG_LOG_FD=5 log::init
  test::printVars GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG GLOBAL_LOG_PRINT_STATEMENT_STANDARD GLOBAL_LOG_WRAP_PADDING
}

function test_log::parseLogPattern() {
  test::title "✅ Testing log::parseLogPattern"

  test::func log::parseLogPattern "static string"

  test::func log::parseLogPattern "static"$'\n'"string"

  test::func log::parseLogPattern "static"$'\n'"<message>"

  test::func log::parseLogPattern "<colorFaded><time><colorDefault> <levelColor><level> <icon><colorDefault> PID=<pid> SHLVL=<subshell> <function>{8s}@<source>:<line> <message>"

  test::func VALET_CONFIG_ENABLE_NERDFONT_ICONS=true log::parseLogPattern "<icon> <message>"
  test::func VALET_CONFIG_ENABLE_NERDFONT_ICONS=false log::parseLogPattern "<icon> <message>"

  test::func log::parseLogPattern "<colorFaded>{9s} <time>{(%FT%H:%M:%S%z)T} <levelColor>{9s} <level>{9s} <icon>{9s} <varCOLOR_DEBUG>{9s} <pid>{9s} <subshell>{9s} <function>{9s} <source>{9s} <line>{9s}"
}

# shellcheck disable=SC2034
function test_log() {
  test::title "✅ Testing log::printRaw"
  local _var1=hello
  local _var2=_world
  test::exec log::printRaw _var1
  test::exec log::printRaw _var2

  test::title "✅ Testing log::printString"
  test::exec log::printString 'Next up is a big line with a lot of numbers not separated by spaces. Which means they will be truncated by characters and not by word boundaries like this sentence.'

  test::title "✅ Testing log::info"
  test::exec log::info 'Next up is a big line with a lot of numbers not separated by spaces. Which means they will be truncated by characters and not by word boundaries like this sentence.' '01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567' '01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567'

  test::title "✅ Testing log::printFile"
  test::exec log::printFile file-to-read 2
  test::exec log::printFile file-to-read

  # shellcheck disable=SC2034
  local text="What is Lorem Ipsum?

Lorem Ipsum is simply dummy text of the printing and typesetting industry.
Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.
It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789

Why do we use it?

It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.
The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.
Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.
Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."

  test::title "✅ Testing log::printFileString"
  test::exec log::printFileString text 2
  test::exec log::printFileString text
}

main
