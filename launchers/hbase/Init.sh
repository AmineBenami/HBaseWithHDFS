sed "s/ZOOK_SERVERS/$ZOOK_SERVERS/" $HADOOP_HOME/etc/hadoop/core-site.xml.template \
| sed "s/CLUSTER_NAME/$CLUSTER_NAME/" \
| sed "s#HADOOP_HOME#$HADOOP_HOME#" \
| sed "s#HDFSDIR#$HDFSDIR#" \
> $HADOOP_HOME/etc/hadoop/core-site.xml

sed "s/ZOOK_SERVERS/$ZOOK_SERVERS/" $HADOOP_HOME/etc/hadoop/hdfs-site.xml.template \
| sed "s/CLUSTER_NAME/$CLUSTER_NAME/" \
| sed "s#HADOOP_HOME#$HADOOP_HOME#" \
| sed "s#HDFSDIR#$HDFSDIR#" \
| sed "s#JOURNALDIR#$JOURNALDIR#" \
| sed "s/NODE_NAMES/$NODE_NAMES/" \
| sed "s/JOURNALS/$JOURNALS/" \
| sed "s#HOME_GUEST#$HOME#" \
> $HADOOP_HOME/etc/hadoop/hdfs-site.xml

echo "export JAVA_HOME=$JAVA_HOME" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
sed "s/ZOOK_HOSTS/$ZOOK_HOSTS/" $HBASE_HOME/conf/hbase-site.xml.template \
| sed "s/ZOOK_PORT/$ZOOK_PORT/" \
| sed "s/CLUSTER_NAME/$CLUSTER_NAME/" \
> $HBASE_HOME/conf/hbase-site.xml
