#!/bin/bash

i="$1"

# path=`dirname $0`
# path=`cd "$path"; pwd`
# echo $path
# 
# cd "$path"
set -e

ENVOY_CPU_SET=${ENVOY_CPU_SET:=8}
ENVOY_CONCURRENCY=${ENVOY_CONCURRENCY:=4}
ENVOY_BIN_BASE=/home/luyaozho/teresa/use-hugepage-envoy/base/envoy-static
ENVOY_BIN_HP=/home/luyaozho/teresa/use-hugepage-envoy/use-hp/envoy-static
ENVOY_BIN_NHP=/home/luyaozho/teresa/use-hugepage-envoy/no-use-hp/envoy-static
ENVOY_CONFIG=/home/luyaozho/teresa/use-hugepage-envoy/envoy-demo.yaml

# echo ${ENVOY_CPU_SET}
# echo ${ENVOY_BIN_BASE}
# echo "*************************************************"
# mkdir -p $BASE_DIR
# ulimit -n 1048576
if [ i == "base" ] ; then
    sudo taskset -c ${ENVOY_CPU_SET} ${ENVOY_BIN_BASE} --config-path $ENVOY_CONFIG --concurrency $ENVOY_CONCURRENCY  &
elif [ i == "hp" ] ; then
    sudo taskset -c ${ENVOY_CPU_SET} ${ENVOY_BIN_HP} --config-path $ENVOY_CONFIG --concurrency $ENVOY_CONCURRENCY  &
elif [ i == "nhp" ] ; then
    sudo taskset -c ${ENVOY_CPU_SET} ${ENVOY_BIN_NHP} --config-path $ENVOY_CONFIG --concurrency $ENVOY_CONCURRENCY  &
fi
echo "$!" > envoy.pid
echo "envoy started"

