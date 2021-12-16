#!/bin/bash

iterations="$1"

path=`dirname $0`
path=`cd "$path"; pwd`
# echo $path

cd "$path"
declare conn=0

# mkdir nhp-data
# mkdir -p nhp-data/d80

for ((i=2;i<=iterations;i++));
do
    declare sum=0
    let conn=2**$i
    echo "Testing envoy performance using nighthawk connections  is  "$conn" ... "
    for((j=1; j<=10; j++))
    do
	  taskset -c 60-70  ../bazel-bin/nighthawk_client --rps 500  --connections $conn  --concurrency 4 --request-body-size 8192 --max-requests-per-connection 50  --prefetch-connections -v info http://127.0.0.1:10000/ --h2 --duration 30  | grep  "0.75 " | head -1 | awk '{print $4*1000+$5}' | tr -d "a-zA-Z"  >>$conn.log
    done

    # cd envoy-benchmark
    for((j=1; j<=10; j++))
    do
         temp='sed -n '$j'p '$conn'.log'
	 temp=$($temp)
	 echo $temp
	 let sum+=$temp
    done
    let sum=$sum/10
    echo "$sum" >>conn_sum.log

done


