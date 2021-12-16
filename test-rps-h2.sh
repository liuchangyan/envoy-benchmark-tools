#!/bin/bash

iterations="$1"

path=`dirname $0`
path=`cd "$path"; pwd`
echo $path

cd "$path"
declare rps=0
declare colum1=0
declare colum2=0
for ((i=1;i<=iterations;i++));
do
    declare sum1=0
    declare sum2=0
    let rps=$i*500
    echo "Testing envoy performance using nighthawk request per second is  "$rps" ... "
    for((j=1; j<=3; j++))
    do
	 taskset -c 60-70  ../bazel-bin/nighthawk_client --rps $rps  --connections 64  --concurrency 4 --request-body-size 200000  --max-requests-per-connection 50  --prefetch-connections -v info http://127.0.0.1:10000/  --h2 --duration 30  | grep -E  "0.75  |0.8  " | head -2 | awk '{print $3*1000000+$4*1000+$5}' | tr -d "a-zA-Z"   >>$rps.log
    done

    for ((j=1; j<=3; j++))
    do
        let colum1=$j*2-1
        let colum2=$j*2
        temp1='sed -n '$colum1'p '$rps'.log'
        temp1=$($temp1)
        echo $temp1
        let sum1+=$temp1
        temp2='sed -n '$colum2'p '$rps'.log'
        temp2=$($temp2)
        echo $temp2
        let sum2+=$temp2
    done
    let sum1=$sum1/3
    echo "$sum1" >>rps_sum1.log
    let sum2=$sum2/3
    echo "$sum2" >>rps_sum2.log
done

echo "*******************************************Testing over*************************************"
#less ../test-example/cpu_interim.log | awk '{print $9}' |  sed -e '/^$/d'  >>../test-example/cpu_memcpy_result.log

