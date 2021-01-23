#!/bin/sh
set -e

source ./env.sh

docker-compose build
docker-compose run --name $HOSTNAME \
  -e MODE=init                      \
  -e WEB_PORT=$WEB_PORT             \
  -e WEB_ADDR=$WEB_ADDR             \
  -e ADMIN=$ADMIN                   \
  -e CLUSTER_NAME=$CLUSTER_NAME     \
  master

docker rm $HOSTNAME
docker-compose up -d
