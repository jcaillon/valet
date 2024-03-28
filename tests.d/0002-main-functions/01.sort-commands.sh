#!/usr/bin/env bash

function testSortCommandsAndLastChoice() {
  # overriding getLocalStateDirectory to return a temporary directory
  createTempDirectory && local localStateDirectory="${LAST_RETURNED_VALUE}"
  VALET_LOCAL_STATE_DIRECTORY="${localStateDirectory}"
  VALET_REMEMBER_LAST_CHOICES=5

  local commands="cm1  	This is command 1
cm2  	This is command 2
sub cmd1  	This is sub command 1
sub cmd2  	This is sub command 2
another3  	This is another command 3"

  # testing commands sort and that without prior choices, the order of commands is kept
  echo "→ sortCommands myid1 \"\${commands}\""
  sortCommands "myid1" "${commands}" && echo "${LAST_RETURNED_VALUE}"
  endTest "Testing sortCommands without prior choices, the order of commands is kept" $?

  # testing commands sort after choosing another3 then cm2
  echo "→ addLastChoice myid1 another3"
  echo "→ addLastChoice myid1 cm2"
  echo "→ sortCommands myid1 \"\${commands}\""
  addLastChoice "myid1" "another3"
  addLastChoice "myid1" "cm2"
  sortCommands "myid1" "${commands}" && echo "${LAST_RETURNED_VALUE}"
  endTest "Testing sortCommands after choosing another3 then cm2" $?

  # testing commands sort for another id, the order of commands should be the initial one
  echo "→ sortCommands myid2 \"\${commands}\""
  sortCommands "myid2" "${commands}" && echo "${LAST_RETURNED_VALUE}"
  endTest "Testing sortCommands for another id, the order of commands should be the initial one" $?

  # testing that after adding more than x commands, we only keep the last x
  local -i i
  for i in {1..10}; do
    addLastChoice "myid1" "cm${i}"
  done
  local content
  IFS= read -rd '' content < "${localStateDirectory}/last-choices-myid1" || true
  echo "Content of last-choices-myid1:"
  echo "$content"
  endTest "Testing addLastChoice after adding more than ${VALET_REMEMBER_LAST_CHOICES} commands, we only keep the last ${VALET_REMEMBER_LAST_CHOICES}" 0

  # testing commands that adding the same command multiple times only keeps the last one
  addLastChoice "myid1" "another3"
  addLastChoice "myid1" "another3"
  addLastChoice "myid1" "another3"
  IFS= read -rd '' content < "${localStateDirectory}/last-choices-myid1" || true
  echo "Content of last-choices-myid1:"
  echo "$content"
  endTest "Testing addLastChoice after adding the same command multiple times only keeps the last one" 0

  unset getLocalStateDirectory
}

function main() {
  testSortCommandsAndLastChoice
}

main
