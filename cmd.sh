#!/usr/bin/env sh

set -e

statusCode=$(curl \
    --silent \
    --output /pullRequest \
    --write-out "%{http_code}" \
    --user "${loginUsername}:${loginPassword}" \
    -X POST "https://api.github.com/repos/${owner}/${repo}/pulls" \
    -d @/request.json)

if test "$statusCode" -ne 201; then
exit 1
fi
