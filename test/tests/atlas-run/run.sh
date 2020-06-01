#!/bin/bash
set -Eeuo pipefail

if uname -a | grep Darwin &>/dev/null; then
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi

dir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

image=$1

if [[ "$image" == *-dev ]]; then
    cname="atlas-container-$RANDOM-$RANDOM"
    docker run -d --name "$cname" -p "21000:21000" "$image"
    trap "docker rm -vf $cname > /dev/null" EXIT
else
    project_directory="${dir}/../../../samples/atlas-kafka-cassandra-solr"
    ATLAS_IMAGE=$image docker-compose --project-directory $project_directory -f $project_directory/docker-compose.yml up -d
    trap "docker-compose --project-directory $project_directory -f $project_directory/docker-compose.yml down > /dev/null" EXIT
fi

# Wait until atlas is available (with timeout)
# Call to the API