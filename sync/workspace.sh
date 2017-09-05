#!/bin/bash

# Rsync-based workspace sync for multiple working machines

# Excludes
EXCLUDES_FILE=/etc/workspace/exclude.list

# Workspace source
WS_SRC=/home/webconn/Projects/

# Workspace destination
WS_DST=workspace@cubie-server.local:Projects/

# Common RSYNC flags
RSYNC_FLAGS="-azP --delete --delete-excluded --progress"

# Rsync PUSH action keys
RSYNC_PUSH=

# Rsync PULL action keys
RSYNC_PULL=

# Rsync CHECK action keys
RSYNC_CHECK="-v -n"

########

case $1 in
"push")
        rsync $RSYNC_FLAGS --exclude-from $EXCLUDES_FILE $RSYNC_PUSH $WS_SRC $WS_DST
        ;;
"pull")
        rsync $RSYNC_FLAGS --exclude-from $EXCLUDES_FILE $RSYNC_PULL $WS_DST $WS_SRC
        ;;
"check")
        rsync $RSYNC_FLAGS --exclude-from $EXCLUDES_FILE $RSYNC_PULL $RSYNC_CHECK $WS_DST $WS_SRC
        ;;
esac

