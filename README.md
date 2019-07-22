# HdfsHadoop
Setup fully distributed Hbase cluster
## prerequisites:
+ Create a new network :<br/>
`docker network create -d bridge hdfshadoop_network`<br/>
+ Create a Volume to keep data and meta-data persistant:<br/>
`docker volume create hdfs_data`<br/>
+ Launch zookeeper servers: they will be used for Hdfs and Hbase components<br/>
` docker-compose -f composers/hdfs/zookeeper.yml up -d`
### Launch Hdfs and Hbase:
**1. We have to launch Hdfs components in the order**<br/>
+ Launch journal nodes:<br/>
`docker-compose -f composers/hdfs/journalnode.yml up -d` <br/>
+ Launch name nodes:<br/>
`docker-compose -f composers/hdfs/namenodes up -d` <br/>
+ Launch data nodes:<br/>
`docker-compose -f composers/hdfs/datanodenode.yml up -d` <br/>

**2. Quick Check that namenodes are started**<br/>
`docker exec -ti NN1  hdfs getconf -confKey dfs.ha.namenodes.databootcamp`<br/>
`(shall display: n1,n2,n3,n4)`<br/>
`docker exec -ti NN1  hdfs getconf -confKey dfs.ha.namenodes.databootcamp`<br/>
`(shall display: n1,n2,n3,n4)`<br/>
`docker exec -ti NN1  hdfs haadmin -getServiceState nn1`<br/>
`(shall display: active)`<br/>
`docker exec -ti NN1  hdfs haadmin -getServiceState nn2` (same for n3 and n4)<br/>
`(shall display: standby)`<br/>

**3. Quick Check that services are started**: by executin `jps` commands on each started container <br/>

**4. We have to launch Hbase components**<br/>
`docker-compose -f composers/hbase/hbase.yml up -d`<br/>

**5. Check that all is started correctly by connecting to hbase using shell and verifying status**<br/>
```
$ docker exec -ti rs1 bash
bash-4.3$ hbase shell
HBase Shell
Use "help" to get list of supported commands.
Use "exit" to quit this interactive shell.
For Reference, please visit: http://hbase.apache.org/2.0/book.html#shell
Version 2.2.0, rUnknown, Tue Jun 11 04:30:30 UTC 2019
Took 0.0035 seconds
hbase(main):001:0> status
1 active master, 1 backup masters, 3 servers, 0 dead, 1.6667 average load
Took 0.4977 seconds
```
