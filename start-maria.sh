#!/bin/sh -x

if [ ! -f /data/maria/password.txt ]; then
    echo "File not found!"
    date +%s | sha256sum | base64 | head -c 10 > /data/maria/password.txt
fi

PASSWORD=`cat /data/maria/password.txt`

docker stop mariadb
docker rm mariadb
docker run -d  \
           --name mariadb  \
           -e MYSQL_ROOT_PASSWORD=${PASSWORD}  \
           -v /data/maria/data:/var/lib/mysql   \
           mariadb:10

