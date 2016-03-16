#!/bin/bash -e

IMAGE_NAME=jwilder/nginx-proxy
VERSION=latest
DOCKER_CONTAINER_NAME=nginx-proxy


cat > /etc/default/${DOCKER_CONTAINER_NAME} << EOF
DOCKER_IMAGE=${IMAGE_NAME}:${VERSION}
DOCKER_CONTAINER_NAME=${DOCKER_CONTAINER_NAME}
EOF

cat > /lib/systemd/system/${DOCKER_CONTAINER_NAME}.service << EOF
[Unit]
Description=Nginx Proxy
Requires=docker.service
After=docker.service

[Service]
Restart=on-failure
RestartSec=10
TimeoutStartSec=0
EnvironmentFile=/etc/default/${DOCKER_CONTAINER_NAME}
ExecStartPre=-/usr/bin/docker kill \${DOCKER_CONTAINER_NAME}
ExecStartPre=-/usr/bin/docker rm \${DOCKER_CONTAINER_NAME}
ExecStartPre=/usr/bin/docker pull \${DOCKER_IMAGE}
ExecStart=/usr/bin/docker run --name \${DOCKER_CONTAINER_NAME}                           \
                              -h \${DOCKER_HOSTNAME}                                     \
                              -p 80:80                                                   \
                              -p 443:443                                                 \
                              -e DEFAULT_HOST=default.phon.name                          \
                              -v /data/scortum-letsencrypt:/data/scortum-letsencrypt:ro  \
                              -v /data/nginx-proxy/certs:/etc/nginx/certs                \
                              -v /var/run/docker.sock:/tmp/docker.sock:ro                \
                              -v /etc/localtime:/etc/localtime:ro                        \
                              \${DOCKER_IMAGE}
ExecStop=/usr/bin/docker stop --time=10 \${DOCKER_CONTAINER_NAME} 

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

