#!/bin/bash

# if [ -z $1 ]
# then
    # echo "Usage: make_output_folder.sh [output/some_folder]"
    # exit
# fi
data_dir=/home/luyaozho/teresa/go/bin
cd "$data_dir"

taskset -c  20-30 ./fortio server &
