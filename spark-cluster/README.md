# Spark and hadoop standalone
## Deploy stack
docker stack deploy -c docker-compose-cluster.yml hadoop

## Start hadoop
docker container ls
docker exec -it {hadoop-master-container id} bash

sbin/stop-yarn.sh
sbin/stop-dfs.sh
hadoop namenode -format
sbin/start-dfs.sh
sbin/start-yarn.sh

## Seting socks5://127.0.0.1:7001 in browser
Access hadoop master and spark master:
http://hadoop-master:8088
http://spark-master:7077


## Test hadoop outside
Setting hdfs-site hadoop-master to 0.0.0.0:50070 and restart swarm
from hdfs import *

client = Client("http://hadoop-master:50070", root="/")
client.list("/user/root/output")
client.download("/user/root/output","/tmp")

import os
os.system("ls /tmp/")


# Start forwarder
docker service create \
        --name hadoop-master-forwarder \
        --constraint node.hostname==cuonglh \
        --network hadoop_net \
        --env REMOTE_HOST=hadoop-master \
        --env REMOTE_PORT=8020 \
        --env LOCAL_PORT=8020 \
        --publish mode=host,published=8020,target=8020 \
        luuhungcuong/forwader