#!/bin/bash

# Rsync-based workspace sync for multiple working machines

set -x

# Excludes
EXCLUDES_FILE=/etc/workspace/exclude.list

# Workspace root
WS_SRC=/home/webconn/

# Workspace destination
WS_DST=workspace@cubie-server.local:

# Default workspace subdir to sync
WS_DEFAULT=Projects/

# Common RSYNC flags
RSYNC_FLAGS="-azP --progress"

# Rsync PUSH action keys
RSYNC_PUSH='--delete --delete-excluded'

# Rsync PULL action keys
RSYNC_PULL=

# Rsync CHECK action keys
RSYNC_CHECK="-v -n"

########

WS_BASE=$2

if [ -z $WS_BASE ]; then
    WS_BASE=$WS_DEFAULT
fi

case $1 in
"push")
        rsync $RSYNC_FLAGS --exclude-from $EXCLUDES_FILE $RSYNC_PUSH $WS_SRC$WS_BASE $WS_DST$WS_BASE
        ;;
"pull")
        rsync $RSYNC_FLAGS --exclude-from $EXCLUDES_FILE $RSYNC_PULL $WS_DST$WS_BASE $WS_SRC$WS_BASE
        ;;
"check")
        rsync $RSYNC_FLAGS --exclude-from $EXCLUDES_FILE $RSYNC_PULL $RSYNC_CHECK $WS_DST$WS_BASE $WS_SRC$WS_BASE
        ;;
esac

