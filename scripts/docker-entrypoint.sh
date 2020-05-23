#!/usr/bin/env bash
#
# Run the init-scripts, execute command
set -e

if [[ "$VERBOSE" == "yes" ]]; then
    set -x
fi

. /opt/scripts/run-init-scripts

exec "$@"