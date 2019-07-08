FROM alpine:3.8

LABEL name = "docker-proxy"
LABEL version = "1.0"
LABEL description = "Proxy for docker port"
LABEL author = "L.H.C <cuonglh.hus@gmail.com>"

USER root

RUN apk add --no-cache  openssh

RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa

RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

ADD bootstrap.sh /etc/bootstrap.sh

RUN passwd -u root

ENTRYPOINT ["/etc/bootstrap.sh"]
