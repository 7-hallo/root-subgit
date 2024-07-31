#!/bin/bash

# Kiểm tra nếu mạng sevenhallo chưa tồn tại, thì tạo nó
if ! docker network ls | grep -q "sevenhallo"; then
  docker network create sevenhallo
fi

# Chạy Docker Compose cho các file
docker-compose -f other/postgres/docker-compose.yml up -d

# Kiểm tra tình trạng của PGDB trước khi start các services khác
until docker run --rm --network sevenhallo postgres:latest pg_isready -h postgres -U postgres; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done
echo "PostgreSQL is ready!"

docker-compose -f other/keycloak/docker-compose.yml up -d
docker-compose -f other/nexus/docker-compose.yml up -d
docker-compose -f other/redis/docker-compose.yml up -d

echo 'Started!'
