#!/usr/bin/env bash
fd1=2

exec {FD}>&${fd1}

echo "This is a test" >&${FD}

exec {FD2}>&${FD}
exec {FD3}>&${FD}

echo "This is a test" >&${FD2}
echo "This is a test" >&${FD3}

for fd in /proc/"${BASHPID}"/fd/*; do
  listOfFds+="${fd} -> $(readlink -f "${fd}")"$'\n'
done

echo "${listOfFds}"

exec {FD4}>"tmp/file"
echo "This is a test1" >&${FD4}
echo "This is a test2" >>"tmp/file"
echo "This is a test3" >&${FD4}
echo "This is a test4" >>"tmp/file"
