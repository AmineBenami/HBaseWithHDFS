#!/bin/bash
. "./Utils.sh"
. "./Init.sh"
wait_until_one_namenode_start
hdfs datanode &
tail -f /dev/null
