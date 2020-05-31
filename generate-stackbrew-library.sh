#!/usr/bin/env bash
set -Eeuo pipefail

cat <<-EOH
Maintainers: Joel Llacer <z0beat@gmail.com> (@zer0beat)
GitRepo: https://github.com/zer0beat/atlas-for-docker.git

Tags: 2.0.0-stretch
SharedTags: 2.0.0
Architectures: amd64
GitCommit: $(git log -1 --format='format:%H' HEAD -- ./2.0/stretch/Dockerfile)
Directory: 2.0/stretch
EOH
