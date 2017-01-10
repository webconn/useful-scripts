#!/bin/bash

set -e

GOPID=$1
TEMPFILE=`tempfile`

# run strace
strace -e write -s 1024 -p $GOPID -o $TEMPFILE & STRACE_PID=$!

# TODO: wait for strace to be attached more properly
sleep 5

# send SIGQUIT to process
kill -QUIT $GOPID

# wait for strace to quit
echo "Waiting for strace to be done..."

wait $STRACE_PID

# print formatted data
cat $TEMPFILE | sed -n 's/write(2, \"\(.*\)\".*$/\1/p' | tr -d '\n' | sed 's/\\n/\n/g' | sed 's/\\t/\t/g'

# remove temp file
rm $TEMPFILE
