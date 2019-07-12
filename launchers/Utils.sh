#!/bin/bash
wait_until_one_namenode_start() {
    local port=9000
    local retry=20
    local sleep=3
    local atLeastOneNameNode=0
    while [ ${retry} -gt 0 ] ; do
        for namenode  in `env | awk -F '=' '{print $1}' | grep 'NN.*_HOSTNAME'`
        do
            if nc -z ${!namenode} ${port}; then
                echo "${!namenode} ${port} listening "
                atLeastOneNameNode=1
                break
            fi
        done
        if [ $atLeastOneNameNode -eq 1 ]; then
            break
        else
            retry=$((retry-1))
            sleep ${sleep}
        fi
    done
    if [ $atLeastOneNameNode -eq 0 ]; then
        echo "No namenode started!! exit :( "
        exit 1
    fi
}

wait_until_one_server_start() {
    local servers=""
    if  [ $1 == "zookeeper" ]; then
        servers=${ZOOK_SERVERS//,/$'\n'}
    elif [ $1 == "hmaster" ]; then
        servers=${HMASTER_HOSTS//,/$'\n'}
    else
        echo "$1 unknown!! exit :( "
        exit 1
    fi

    local retry=20
    local sleep=3
    local atLeastOneServer=0
    while [ ${retry} -gt 0 ] ; do
        for server  in $servers
        do
            ip=${server%%:*}
            port=${server##*:}
            if nc -z ${ip} ${port}; then
                echo "${ip} ${port} listening "
                atLeastOneServer=1
                break
            fi
        done
        if [ $atLeastOneServer -eq 1 ]; then
            break
        else
            retry=$((retry-1))
            sleep ${sleep}
        fi
    done
    if [ $atLeastOneServer -eq 0 ]; then
        echo "No $1 started!! exit :( "
        exit 1
    fi
}

