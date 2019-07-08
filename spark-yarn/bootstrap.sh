#!/bin/bash

: ${HADOOP_PREFIX:=/usr/local/hadoop}
: ${SPARK_PREFIX:=/usr/local/spark}

. $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

rm /tmp/*.pid

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
cd $HADOOP_PREFIX/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

## replace config
: ${EXTRA_CONF_HADOOP_DIR:=/config/hadoop}
: ${EXTRA_CONF_SPARK_DIR:=/config/spark}

if [ -d "$EXTRA_CONF_HADOOP_DIR" ]; then
	cp $EXTRA_CONF_DIR/* $HADOOP_PREFIX/etc/hadoop/
fi

if [ -d "$EXTRA_CONF_SPARK_DIR" ]; then
	cp $EXTRA_CONF_SPARK_DIR/* $SPARK_PREFIX/conf/
fi


#start ssh 
/usr/sbin/sshd

#Keep container alive
#tail -F /dev/null
while true; do sleep 1000; done
