FROM alpine:3.8

LABEL name = "bigdata-base"
LABEL version = "1.0"
LABEL description = "Java and SSH enabled"
LABEL author = "L.H.C <cuonglh.hus@gmail.com>"

USER root

# Prerequisites
RUN apk add --no-cache openssh openssl openjdk8-jre rsync bash procps nss

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:$JAVA_HOME/bin

# Passwordless SSH
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

ADD ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

RUN echo "Port 2122" >> /etc/ssh/sshd_config

RUN passwd -u root

CMD ["/usr/sbin/sshd"]



