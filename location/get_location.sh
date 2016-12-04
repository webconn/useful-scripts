#!/bin/bash

# Location data getter using GeoIP and your system Internet connection.
# Good way to use it is to set it up as NetworkManager hook or smth like that
#
# To install GeoIP in Debian/Ubuntu, type `apt-get install geoip-bin`
#
# Author: Nikita webconn Maslov <webconn@lvk.cs.msu.su>
# MIT license, 2016

set -e


# File to write data to
FILE=$1

[ "$FILE" == "-h" ] && echo "Usage: $0 [output_file]" 1>&2 && exit 3

# Site to get your global IP address from
IP_SITE="http://ipinfo.io/ip"


# Get your global IP address
IP=`wget $IP_SITE -qO -`
# Leave if IP data is unreachable
[ $? != 0 ] && echo "Unable to fetch your global IP, maybe no Internet connection or wrong site?" 1>&2 && exit 1

# Magic to get position
POS=`geoiplookup $IP | sed 's/^.*\: //' | awk -F ', ' 'NR==2{print $6,$7}'`
# Leave if something goes wrong
[ $? != 0 ] && echo "Unable to get location from GeoIP database, maybe wrong IP format from site?" 1>&2 && exit 2

# Here we got correct coordinates - write it to file
([ "$FILE" == "" ] && echo $POS) || echo $POS > $FILE

exit 0
