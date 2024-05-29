#!/usr/bin/env sh

set -e

cat > body <<EOF
{
  "title": "$title",
  "body": "$body",
  "head": "$head",
  "base": "$base"
}
EOF

statusCode=$(curl \
    --silent \
    --output response \
    --write-out "%{http_code}" \
    --user "${loginUsername}:${loginPassword}" \
    -X POST "https://api.github.com/repos/${owner}/${repo}/pulls" \
    -d @body)

echo "$statusCode"
cat response

if test "$statusCode" -ne 201; then
exit 1
fi

# Record the release ID
cat response | jq -r .id | tr -d '\n' > /id
