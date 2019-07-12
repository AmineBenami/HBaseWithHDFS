#!/bin/bash
. "./Utils.sh"
. "./Init.sh"
wait_until_one_namenode_start
wait_until_one_server_start "hmaster"
hbase regionserver start &
tail -f /dev/null
