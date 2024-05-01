#!/usr/bin/env bash

function testSortCommandsAndLastChoice() {
  # overriding core::getLocalStateDirectory to return a temporary directory
  io::createTempDirectory && local localStateDirectory="${RETURNED_VALUE}"
  VALET_CONFIG_LOCAL_STATE_DIRECTORY="${localStateDirectory}"
  VALET_CONFIG_REMEMBER_LAST_CHOICES=5

  local commands="cm1  	This is command 1
cm2  	This is command 2
sub cmd1  	This is sub command 1
sub cmd2  	This is sub command 2
another3  	This is another command 3"

  # testing commands sort and that without prior choices, the order of commands is kept
  echo "→ main::sortCommands myid1 \"\${commands}\""
  main::sortCommands "myid1" "${commands}" && echo "${RETURNED_VALUE}"
  endTest "Testing main::sortCommands without prior choices, the order of commands is kept" $?

  # testing commands sort after choosing another3 then cm2
  echo "→ main::addLastChoice myid1 another3"
  echo "→ main::addLastChoice myid1 cm2"
  echo "→ main::sortCommands myid1 \"\${commands}\""
  main::addLastChoice "myid1" "another3"
  main::addLastChoice "myid1" "cm2"
  main::sortCommands "myid1" "${commands}" && echo "${RETURNED_VALUE}"
  endTest "Testing main::sortCommands after choosing another3 then cm2" $?

  # testing with VALET_CONFIG_REMEMBER_LAST_CHOICES=0
  echo "→ VALET_CONFIG_REMEMBER_LAST_CHOICES=0 main::sortCommands myid1 \"\${commands}\""
  VALET_CONFIG_REMEMBER_LAST_CHOICES=0 main::sortCommands "myid1" "${commands}" && echo "${RETURNED_VALUE}"
  endTest "Testing main::sortCommands, with VALET_CONFIG_REMEMBER_LAST_CHOICES=0 the order does not change" $?
  VALET_CONFIG_REMEMBER_LAST_CHOICES=5

  # testing commands sort for another id, the order of commands should be the initial one
  echo "→ main::sortCommands myid2 \"\${commands}\""
  main::sortCommands "myid2" "${commands}" && echo "${RETURNED_VALUE}"
  endTest "Testing main::sortCommands for another id, the order of commands should be the initial one" $?

  # testing that after adding more than x commands, we only keep the last x
  local -i i
  for i in {1..10}; do
    main::addLastChoice "myid1" "cm${i}"
  done
  io::readFile "${localStateDirectory}/last-choices-myid1" && local content="${RETURNED_VALUE}"
  echo "Content of last-choices-myid1:"
  echo "${content}"
  endTest "Testing main::addLastChoice after adding more than ${VALET_CONFIG_REMEMBER_LAST_CHOICES} commands, we only keep the last ${VALET_CONFIG_REMEMBER_LAST_CHOICES}" 0

  # testing commands that adding the same command multiple times only keeps the last one
  main::addLastChoice "myid1" "another3"
  main::addLastChoice "myid1" "another3"
  main::addLastChoice "myid1" "another3"
  io::readFile "${localStateDirectory}/last-choices-myid1" && content="${RETURNED_VALUE}"
  echo "Content of last-choices-myid1:"
  echo "${content}"
  endTest "Testing main::addLastChoice after adding the same command multiple times only keeps the last one" 0

  unset core::getLocalStateDirectory
}

function main() {
  testSortCommandsAndLastChoice
}

main
