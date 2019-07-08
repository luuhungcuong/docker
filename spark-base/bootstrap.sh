#!/bin/sh

# replace config
: ${EXTRA_CONF_DIR:=/config/spark}

if [ -d "$EXTRA_CONF_DIR" ]; then
	cp $EXTRA_CONF_DIR/* $/spark/conf/
fi

#start ssh 
/usr/sbin/sshd

#Start node
: ${SPARK_MASTER_NOTE:=spark-master}

if [ "$SPARK_NODE_TYPE" == "MASTER" ]
then
   /spark/bin/spark-class org.apache.spark.deploy.master.Master -h 0.0.0.0
else
    /spark/bin/spark-class org.apache.spark.deploy.worker.Worker spark://$SPARK_MASTER_NOTE:7077
fi