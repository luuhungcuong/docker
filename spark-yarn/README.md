
# Deploy one Hadoop Cluster with docker
## Build image
docker build -t luuhungcuong/spark-yarn:h2.7-s2.3 .
## init a docker swarm cluster and listens on localhost
docker swarm init 

docker stack depoy -c docker-compose-docker hadoop
## start hdfs
```bash
# Check container list
docker container ls
# Access to hadoop-master node
docker exce -it {{master-container}} bash

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

## Test yarn mode
spark-submit --deploy-mode client \
               --class org.apache.spark.examples.SparkPi \
               $SPARK_HOME/examples/jars/spark-examples_2.11-2.2.0.jar 10