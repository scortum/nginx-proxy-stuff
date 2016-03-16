#!/bin/sh -x

docker stop myadmin
docker rm myadmin
docker run -d   \
           --name myadmin   \
           --link mariadb:db  \
           -p 8081:80  \
           phpmyadmin/phpmyadmin

