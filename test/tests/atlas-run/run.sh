#!/bin/bash
set -Eeuo pipefail

if uname -a | grep Darwin &>/dev/null; then
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi

dir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

self="$(basename "$0")"

image=$1

project_directory="${dir}/../../../samples/atlas-kafka-cassandra-solr"

ATLAS_IMAGE=$image docker-compose --project-directory $project_directory -f $project_directory/docker-compose.yml up -d

# Wait until atlas is available (with timeout)
# Call to the API

docker-compose --project-directory $project_directory -f $project_directory/docker-compose.yml down