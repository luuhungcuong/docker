FROM luuhungcuong/bigdata-base

LABEL name = "hadoop-base"
LABEL version = "2.7.4"
LABEL description = "Hadoop installed"
LABEL author = "L.H.C <cuonglh.hus@gmail.com>"

USER root

# Install Hadoop
ENV HADOOP_VER 2.7.4

RUN wget -O hadoop.tar.gz https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VER/hadoop-$HADOOP_VER.tar.gz && \
	tar -xzf hadoop.tar.gz -C /usr/local/ && rm hadoop.tar.gz

RUN ln -s /usr/local/hadoop-$HADOOP_VER /usr/local/hadoop

ENV HADOOP_HOME /usr/local/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

ENV HADOOP_PREFIX $HADOOP_HOME
ENV HADOOP_COMMON_HOME $HADOOP_HOME
ENV HADOOP_HDFS_HOME $HADOOP_HOME
ENV HADOOP_MAPRED_HOME $HADOOP_HOME
ENV HADOOP_YARN_HOME $HADOOP_HOME
ENV HADOOP_CONF_DIR $HADOOP_HOME/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop

# Default Conf Files
ADD config/* $HADOOP_HOME/etc/hadoop/

RUN sed -i "/^export JAVA_HOME/ s:.*:export JAVA_HOME=${JAVA_HOME}\nexport HADOOP_HOME=${HADOOP_HOME}\nexport HADOOP_PREFIX=${HADOOP_PREFIX}:" ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh

RUN sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=$HADOOP_PREFIX/etc/hadoop/:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

WORKDIR $HADOOP_HOME

ADD bootstrap.sh /etc/bootstrap.sh

CMD ["/etc/bootstrap.sh"]
