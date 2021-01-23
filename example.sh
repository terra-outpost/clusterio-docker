#!/bin/sh
set -e

source ./env.sh

INSTANCE_NAME="TEST_1"

docker-compose exec cluster sh -c " \
  npx clusterioctl instance create '$INSTANCE_NAME' && \
  npx clusterioctl instance assign '$INSTANCE_NAME' '$CLUSTER_NAME' && \
  npx clusterioctl instance config set '$INSTANCE_NAME' factorio.game_port 34197 && \
  npx clusterioctl instance start '$INSTANCE_NAME'"

INSTANCE_NAME="TEST_2"

docker-compose exec cluster sh -c " \
  npx clusterioctl instance create '$INSTANCE_NAME' && \
  npx clusterioctl instance assign '$INSTANCE_NAME' '$CLUSTER_NAME' && \
  npx clusterioctl instance config set '$INSTANCE_NAME' factorio.game_port 34198 && \
  npx clusterioctl instance start '$INSTANCE_NAME'"
