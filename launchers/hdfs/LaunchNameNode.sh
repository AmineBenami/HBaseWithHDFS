#!/bin/bash
. "./Utils.sh"
. "./Init.sh"
echo "----------------> FORMAT? ${FORMAT_NAMENODE}"
echo "----------------> FORMAT? ${HDFSDIR}"

if [ ! -z "${FORMAT_NAMENODE}" ]; then
    if [ ! -e "${HDFSDIR}/name/current/VERSION" ]; then
        . "./LaunchFormat.sh"
        echo "----------------> END FORMAT"
    fi
    echo "BEGIN FORMAT ZK"
    hdfs zkfc -formatZK -force
fi
if [ -z "${MASTER_NAMENODE}" ]; then
    wait_until_one_namenode_start
    hdfs namenode -bootstrapStandby -force
fi
wait_until_one_server_start "zookeeper"
hdfs zkfc &
hdfs namenode &
tail -f /dev/null
