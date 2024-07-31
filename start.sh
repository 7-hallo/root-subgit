#!/bin/bash

# Kiểm tra nếu mạng sevenhallo chưa tồn tại, thì tạo nó
if ! docker network ls | grep -q "sevenhallo"; then
  docker network create sevenhallo
fi

# Chạy Docker Compose cho các file
docker-compose -f other/postgres/docker-compose.yml up -d

docker-compose -f other/keycloak/docker-compose.yml up -d
docker-compose -f other/nexus/docker-compose.yml up -d
docker-compose -f other/redis/docker-compose.yml up -d

echo 'Started!'
