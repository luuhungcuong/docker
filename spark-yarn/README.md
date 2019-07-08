#Build image
docker build -t luuhungcuong/spark-yarn:h2.7-s2.3 .

# Deploy one Hadoop Cluster with docker
# init a docker swarm cluster and listens on localhost
docker swarm init 

docker stack depoy -c docker-compose-docker hadoop
#start hdfs
docker container ls
docker exce -it {{master-container}} bash
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
You can expose the ports in the script, but I'd rather not since the slaves shoule occupy the same ports.

To access the web UI, deploy another (socks5) proxy to route the traffic.

If you don't one, try [newnius/docker-proxy](https://hub.docker.com/r/newnius/docker-proxy/), it is rather easy to use.

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


## Test yarn mode
spark-submit --deploy-mode client \
               --class org.apache.spark.examples.SparkPi \
               $SPARK_HOME/examples/jars/spark-examples_2.11-2.2.0.jar 10