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

docker stop wordpress
docker rm wordpress
docker run -d  \
           --name wordpress   \
           --link mariadb:mysql  \
           -v ${BASE_DIR}/wordpress:/var/www/html   \
           -v ${BASE_DIR}/wordpress_config/uploads.ini:/usr/local/etc/php/conf.d/uploads.ini   \
           -p 8080:80  \
           wordpress



cat << EOF
Checkout https://hub.docker.com/_/wordpress/

Full command line example:
  docker run -e WORDPRESS_DB_PASSWORD=password  \
             -d  \
             --name wordpress \
             --link wordpressdb:mysql  \
             -p 8080:80   \
             -v "/opt/wordpress":/var/www/html   \
             -v "/opt/wordpress_config/uploads.ini:/usr/local/etc/php/conf.d/uploads.ini"   \
             wordpress


The contents of /opt/wordpress_config/uploads.ini should contain:
  file_uploads = On
  memory_limit = 256M
  upload_max_filesize = 256M
  post_max_size = 300M
  max_execution_time = 600
EOF
