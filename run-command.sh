#! /bin/bash

# install docker & docker-compose on Ubuntu 16.04 xenial

echo "starting install"
apt-get update
apt-get install -y apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
#echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-cache policy docker-engine
echo "installing kernel updates"
apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
#reboot
apt-get update
echo "installing docker"
apt-get install -y docker-engine
echo "adding devops to docker group"
useradd -d /home/devops -s /bin/bash -m devops
usermod -a -G docker devops
echo "installing docker-compose"
curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
echo "done"

# install keys and launch docker compose
docker volume create --name concourse-db
docker volume create --name concourse-web-keys
docker volume create --name concourse-worker-keys
DOCKERHOST=127.0.0.1 docker-compose up -d
