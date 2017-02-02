#!/bin/bash

set -e

if [ -z $1 ]; then
        (>&2 echo "Usage: $0 process-name")
        exit 1
fi

GOPID=`pgrep $1` || true

TEMPFILE=`tempfile`

if [ -z $GOPID ]; then
        (>&2 echo "Process $1 not found, check the name twice")
        exit 1
fi

(>&2 echo "Found $1 on $GOPID")

# run strace
strace -e write -s 1024 -p $GOPID -o $TEMPFILE & STRACE_PID=$!
(>&2 echo "Waiting for process to be attached...")

# TODO: wait for strace to be attached more properly
sleep 5

# send SIGQUIT to process
kill -QUIT $GOPID

# wait for strace to quit
(>&2 echo "Waiting for strace to be done...")

wait $STRACE_PID

# print formatted data
cat $TEMPFILE | sed -n 's/write(2, \"\(.*\)\".*$/\1/p' | tr -d '\n' | sed 's/\\n/\n/g' | sed 's/\\t/\t/g'

# remove temp file
rm $TEMPFILE
