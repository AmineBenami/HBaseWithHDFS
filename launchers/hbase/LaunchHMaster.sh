#!/bin/bash
. "./Utils.sh"
. "./Init.sh"
wait_until_one_namenode_start
if [ ! -z "${MASTER_HMASTER}" ]; then
    hbase master start &
else
    wait_until_one_server_start "hmaster"
    hbase master --backup start &
fi
tail -f /dev/null
