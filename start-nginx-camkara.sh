#!/bin/sh -x

docker stop nginx-camkara.de
docker rm nginx-camkara.de
docker run -d  \
           --name nginx-camkara.de   \
           -v /data/nginx-camkara.de:/usr/share/nginx/html:ro  \
           -e VIRTUAL_HOST=camkara.de,www.camkara.de   \
           nginx

