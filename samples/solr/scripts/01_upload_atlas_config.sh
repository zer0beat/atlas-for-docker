#!/usr/bin/env bash

CONF_DIR=/opt/solr/server/solr/configsets/atlas

if ! solr zk ls $NODE/configs/atlas -z $ZK_HOST; then
    echo "Uploading atlas config to $ZK_HOST"
    solr zk upconfig -d $CONF_DIR -n atlas -z $ZK_HOST
fi