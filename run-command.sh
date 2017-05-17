# install keys and launch docker compose
docker volume create --name concourse-db
docker volume create --name concourse-web-keys
docker volume create --name concourse-worker-keys
DOCKERHOST=127.0.0.1 docker-compose up -d
