#!/bin/bash
set -Eeuo pipefail

ATLANTIS_IMAGE=$1

docker run --rm $ATLANTIS_IMAGE atlas version