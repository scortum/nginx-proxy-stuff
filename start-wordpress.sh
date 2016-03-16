#!/bin/sh -x

docker run -d  \
           --name wordpress   \
           --link mariadb:mysql  \
           -p 8080:80  \
           wordpress

