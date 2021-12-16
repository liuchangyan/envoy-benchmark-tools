#!/bin/bash
iterations="$1"




for ((i=1;i<=iterations;i++));
do
    echo "************************* "$i" ***********************************"
    echo "TEST TLB miss on envoy"
    sudo perf stat -e MEM_INST_RETIRED.ALL_LOADS,DTLB_LOAD_MISSES.WALK_COMPLETED,MEM_INST_RETIRED.ALL_STORES,DTLB_STORE_MISSES.WALK_COMPLETED,DTLB_LOAD_MISSES.WALK_COMPLETED_4K,DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M,DTLB_LOAD_MISSES.WALK_COMPLETED_1G,DTLB_STORE_MISSES.WALK_COMPLETED_4K,DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M -p `pgrep envoy` -- sleep 110

done











