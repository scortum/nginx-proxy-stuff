#!/bin/sh -x

BASE_DIR=/data/wordpress-lineli

if [ ! -d ${BASE_DIR} ]; then
    echo please create:
    echo ${BASE_DIR}/wordpress
    echo ${BASE_DIR}/wordpress_config
    exit -1
fi


cat > /data/wordpress-lineli/wordpress_config/uploads.ini <<EOF
file_uploads = On
memory_limit = 256M
upload_max_filesize = 256M
post_max_size = 300M
max_execution_time = 600
EOF



if [ ! -f /data/maria/line-password.txt ]; then
    echo "File not found!"
    date +%s | sha256sum | base64 | head -c 10 > /data/maria/line-password.txt
fi

PASSWORD=`cat /data/maria/line-password.txt`

docker stop wordpress
docker rm wordpress
docker run -d  \
           --name wordpress   \
           --link mariadb:mysql  \
           -e WORDPRESS_DB_USER=lineli  \
           -e WORDPRESS_DB_PASSWORD=${PASSWORD}  \
           -e WORDPRESS_DB_NAME=lineli   \
           -e VIRTUAL_HOST=lineli.de  \
           -v ${BASE_DIR}/wordpress:/var/www/html   \
           -v ${BASE_DIR}/wordpress_config/uploads.ini:/usr/local/etc/php/conf.d/uploads.ini   \
           wordpress


