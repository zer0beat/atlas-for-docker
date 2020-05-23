#!/usr/bin/env bash

HOST=$(echo $ZK_HOST | awk -F'/' '{ print $1 }')
NODE=$(echo $ZK_HOST | awk -F'/' '{ print "/"$2 }')

if ! solr zk ls $NODE -z $HOST; then
    echo "Creating zk root $NODE on $HOST"
    solr zk mkroot $NODE -z $HOST
fi