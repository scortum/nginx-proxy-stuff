#!/bin/sh -x

NAME="nginx-default"

docker stop ${NAME}
docker rm ${NAME}
docker run -d  \
           --name ${NAME}   \
           -v /data/nginx-default:/usr/share/nginx/html:ro  \
           -e VIRTUAL_HOST=default.phon.name   \
           nginx

