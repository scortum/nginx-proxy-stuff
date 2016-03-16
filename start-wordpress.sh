#!/bin/sh -x

docker run -d  \
           --name wordpress   \
           --link mariadb:mysql  \
           -p 8080:80  \
           wordpress


echo checkout https://hub.docker.com/_/wordpress/

cat <<EOF

Full command line example:

docker run -e WORDPRESS_DB_PASSWORD=password -d --name wordpress --link wordpressdb:mysql -p 8080:80 -v "/opt/wordpress":/var/www/html -v "/opt/wordpress_config/uploads.ini:/usr/local/etc/php/conf.d/uploads.ini" wordpress

The contents of /opt/wordpress_config/uploads.ini should contain:

file_uploads = On
memory_limit = 256M
upload_max_filesize = 256M
post_max_size = 300M
max_execution_time = 600

EOF
