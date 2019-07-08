#Build image
docker build -t luuhungcuong/hadoop-base:v2.7.4 .

# Deploy one Hadoop Cluster with docker
# init a docker swarm cluster and listens on localhost
docker swarm init

# create an overlay network
docker network create --driver overlay swarm-net
## Start Master
```bash
docker service create \
  --name hadoop-master \
  --hostname hadoop-master \
  --network swarm-net \
  --replicas 1 \
  --detach=true \
  --endpoint-mode dnsrr \
  --mount type=bind,source=/etc/localtime,target=/etc/localtime \
  luuhungcuong/hadoop-base:v2.7.4
```

## Start slaves

```bash
docker service create \
  --name hadoop-slave1 \
  --hostname hadoop-slave1 \
  --network swarm-net \
  --replicas 1 \
  --detach=true \
  --endpoint-mode dnsrr \
  --mount type=bind,source=/etc/localtime,target=/etc/localtime \
  luuhungcuong/hadoop-base:v2.7.4
```

```bash
docker service create \
  --name hadoop-slave2 \
  --network swarm-net \
  --hostname hadoop-slave2 \
  --replicas 1 \
  --detach=true \
  --endpoint-mode dnsrr \
  --mount type=bind,source=/etc/localtime,target=/etc/localtime \
  luuhungcuong/hadoop-base:v2.7.4
```

```bash
docker service create \
  --name hadoop-slave3 \
  --hostname hadoop-slave3 \
  --network swarm-net \
  --replicas 1 \
  --detach=true \
  --endpoint-mode dnsrr \
  --mount type=bind,source=/etc/localtime,target=/etc/localtime \
  luuhungcuong/hadoop-base:v2.7.4
```

## Init for the first time

#### format dfs first
Run these commands on the master node.
docker exec -it hadoop-master.1.$(docker service ps \
hadoop-master --no-trunc | tail -n 1 | awk '{print $1}' ) bash

```bash
# stop HDFS services
sbin/stop-dfs.sh

# format HDFS meta data
bin/hadoop namenode -format

# restart HDFS services
sbin/start-dfs.sh
```

## Run a test job
To make sure youui have successfully setup the Hadoop cluster, just run the floowing commands to see if it is executed well.

```bash
# prepare input data
bin/hadoop dfs -mkdir -p /user/root/input

# copy files to input path
bin/hadoop dfs -put etc/hadoop/* /user/root/input

# submit the job
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples*.jar grep input output 'dfs[a-z.]+'
```

## Browse the web UI
To access the web UI, deploy another (socks5) proxy to route the traffic.

Visit [hadoop-master:8088](http://hadoop-master:8088) fo YARN pages.

Visit [hadoop-master:50070](http://hadoop-master:50070) fo YARN pages.
docker service create \
--replicas 1 \
--name proxy_docker \
--network swarm-net \
-p 7001:7001 \
luuhungcuong/docker-proxy
## Custom configuration

To persist data or modify the conf files, refer to the following script.

The `/config/hadoop` path is where new conf files to be replaces, you don't have to put all the files.

```bash
docker service create \
  --name hadoop-master \
  --hostname hadoop-master \
  --network swarm-net \
  --replicas 1 \
  --detach=true \
  --endpoint-mode dnsrr \
  --mount type=bind,source=/etc/localtime,target=/etc/localtime \
  --mount type=bind,source=/data/hadoop/config,target=/config/hadoop \
  --mount type=bind,source=/data/hadoop/hdfs/master,target=/tmp/hadoop-root \
  --mount type=bind,source=/data/hadoop/logs/master,target=/usr/local/hadoop/logs \
  luuhungcuong/hadoop-base:2.7.4


  
```
