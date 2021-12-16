#!/bin/bash

path=`dirname $0`
path=`cd "$path"; pwd`
echo $path

cd "$path"


./test-conn-percentile.sh $it
./test-tlb.sh $it











