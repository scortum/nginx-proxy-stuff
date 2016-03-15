#!/bin/sh -x

docker stop nginx-proxy
docker rm nginx-proxy

docker run -d   \
           --name nginx-proxy  \
           -p 80:80  \
           -v /var/run/docker.sock:/tmp/docker.sock:ro  \
           jwilder/nginx-proxy

