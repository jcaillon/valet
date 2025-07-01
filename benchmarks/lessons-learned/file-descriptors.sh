#!/usr/bin/env bash
fd1=2

# new file descriptor FD that points to fd1 (2, standard error of the current shell)
exec {FD}>&${fd1}
echo "FD = ${FD}"

echo "This is a test writing to FD" >&${FD}

# we can duplicate the file descriptor FD to FD2 and FD3
exec {FD2}>&${FD}
echo "FD2 = ${FD2}"
exec {FD3}>&${FD}
echo "FD3 = ${FD3}"

echo "This is a test writing to FD2" >&${FD2}
echo "This is a test writing to FD3" >&${FD3}

# even if the variable is already set, bash will generate a new fd number so remember to close them
exec {FD3}>&${FD}
echo "FD3 = ${FD3}"

# to reassign FD3:
eval "exec ${FD3}>&\${FD}"
echo "FD3 = ${FD3}"

# close fd
exec {FD2}>&-

# to write to a file, we can use a file descriptor
exec {FD4}>"tmp/file"
echo "FD4 = ${FD4}"
echo "This is a test writing to FD4" >&${FD4}
echo "This is a test writing to FD4" >&${FD4}

# we can also "move" the file descriptor
exec {FD5}>&${fd1}-
echo "FD5 = ${FD5}"
echo "This is a test writing to FD5" >&${FD5}
echo "failing attempt" >&2 || echo "But we can no longer write to fd 2"
# if ( exec 1>&${fd1} ) 2>&-; then
if exec {test}>&${fd1}; then
  echo "this is a way to test that 2 is opened"
else
  echo "this is a way to test that 2 is closed"
fi
echo "test = ${test:-}"

# list fds
for fd in /proc/"${BASHPID}"/fd/*; do
  listOfFds+="${fd} -> $(readlink -f "${fd}")"$'\n'
done
echo "${listOfFds}"

# we can create and open a named pipe (FIFO) to read and write to it
mkfifo tmp/named_pipe 
# or
mknod tmp/named_pipe2 p

# open for reading and writing
exec {NAMED_PIPED}<>tmp/named_pipe
echo "NAMED_PIPED = ${NAMED_PIPED}"

bj() {
  for ((i = 0; i < 2; i++)); do
    sleep 1
    echo "hi ${1}" >&${NAMED_PIPED}
  done
}

bj THERE &
bj BRO &

while read -r -u ${NAMED_PIPED} -t 1.2 message; do
  echo "${message}"
done

ls -alF tmp/named_pipe 
rm tmp/named_pipe 
rm tmp/named_pipe2 

# alternatively, we can also read/write to a tcp socket
echo "Opening a TCP socket on port 34567..."
exec {NAMED_PIPED}<>/dev/tcp/127.0.0.1/34567

bj AGAIN &
bj TCP &

echo "Waiting for messages from the named pipe (or TCP socket)..."
while read -r -u ${NAMED_PIPED} -t 1.2 message; do
  echo "${message}"
done
