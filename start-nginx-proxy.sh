#!/bin/sh -x

docker stop nginx-proxy
docker rm nginx-proxy

docker run -d   \
           --name nginx-proxy  \
           -p 80:80  \
           -p 443:443  \
           -e DEFAULT_HOST=default.phon.name  \
           -v /data/scortum-letsencrypt:/data/scortum-letsencrypt:ro  \
           -v /data/nginx-proxy/certs:/etc/nginx/certs  \
           -v /var/run/docker.sock:/tmp/docker.sock:ro  \
           jwilder/nginx-proxy

