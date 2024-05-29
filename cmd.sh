#!/usr/bin/env sh

set -e

statusCode=$(curl \
    --silent \
    --output /pullRequest.json \
    --write-out "%{http_code}" \
    --user "${loginUsername}:${loginPassword}" \
    -X POST "https://api.github.com/repos/${owner}/${repo}/pulls" \
    -d @/request.json)

if test "$statusCode" -ne 201; then
cat /pullRequest.json
exit 1
fi
