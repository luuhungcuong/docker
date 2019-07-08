#Build image
docker build -t luuhungcuong/docker-proxy .

#Start proxy
```bash
docker service create \
--replicas 1 \
--name proxy_docker \
--network swarm-net \
-p 7001:7001 \
luuhungcuong/docker-proxy
```
#Set socks5 in proxy to socks5://127.0.0.1:7001
