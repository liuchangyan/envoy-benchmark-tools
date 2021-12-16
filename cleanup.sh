#!/bin/bash

path=`dirname $0`
path=`cd "$path"; pwd`
# echo $path

cd "$path"

echo "Kill envoy on this host"

sudo kill -9 `pgrep envoy`

rm envoy.log
rm envoy.pid


# echo "Kill fortio on $FORTIO_HOST"
# 
# 
# kill -9 `pgrep fortio`
