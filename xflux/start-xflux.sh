#!/bin/bash

# Start xflux with location data from /etc/location
#
# Author: Nikita webconn Maslov <webconn@lvk.cs.msu.su>

# Very default color temp
DEFAULT_COLOR_TEMP=4000

# Kill all old xflux first
pkill -x xflux || true

# Try to get default color temperature from /etc/default/start-xflux
[ -s /etc/default/start-xflux ] && . /etc/default/start-xflux

# Try to get color as argument
[ ! -z "$1" ] && COLOR_TEMP=$1

# Desired evening color temperature
[ -z "$COLOR_TEMP" ] && echo "No color temperature selected! Using default value $DEFAULT_COLOR_TEMP K" && COLOR_TEMP=$DEFAULT_COLOR_TEMP


# Check if /etc/location exists and run xflux if yes
[ -s /etc/location ] && cat /etc/location | awk '{print "-l " $1 " -g " $2}' | xargs xflux -k $COLOR_TEMP
