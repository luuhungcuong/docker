FROM luuhungcuong/bigdata-base

#Install spark
RUN wget http://apache.mirror.anlx.net/spark/spark-2.3.3/spark-2.3.3-bin-hadoop2.7.tgz
RUN tar -xzf spark-2.3.3-bin-hadoop2.7.tgz && \
    mv spark-2.3.3-bin-hadoop2.7 /spark && \
    rm spark-2.3.3-bin-hadoop2.7.tgz


COPY bootstrap.sh /bootstrap.sh

RUN chmod 700 /bootstrap.sh
CMD ["/bootstrap.sh"]

