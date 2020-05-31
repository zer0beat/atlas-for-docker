#!/bin/sh

image="$1"

apk update &> /dev/null
apk add bash docker-compose &> /dev/null
./run-tests.sh "$image"