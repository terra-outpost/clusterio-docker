#!/bin/sh

case $MODE in
  "init")
    npx clusteriomaster config set master.http_port $WEB_PORT
    npx clusteriomaster config set master.external_address $WEB_ADDR
    npx clusteriomaster bootstrap create-admin $ADMIN
    npx clusteriomaster bootstrap create-ctl-config $ADMIN
    npx clusteriomaster run &
    npx clusterioctl slave create-config --generate-token --name $CLUSTER_NAME
    pkill node
    mkdir -p /config/database
    cp -r /clusterio/config*.json /config
    cp -r /clusterio/database/* /config/database
    exit 0
    ;;
  "admin")
    npx clusteriomaster bootstrap create-admin $ADMIN
    npx clusteriomaster bootstrap create-ctl-config $ADMIN
esac

ln -s /config/config-master.json /clusterio/config-master.json
ln -s /config/config-control.json /clusterio/config-control.json
ln -s /config/config-slave.json /clusterio/config-slave.json
ln -s /config/database/ /clusterio/database
exec "$@"
