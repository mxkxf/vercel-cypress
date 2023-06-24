#!/bin/sh -l

# inputs arguments
# 1 -> api token
# 2 -> project id
# 3 -> (optional) team id
# 4 -> cypress options

QUERY="projectId=$2"

if [[ -n "$3" ]]; then
    QUERY="${QUERY}&teamId=${3}"
fi

DEPLOYMENT_URL=$(curl -X GET "https://api.vercel.com/v6/deployments?${QUERY}" -H "Authorization: Bearer $1"  | jq -r '.deployments[0].url')
echo "=> found deployment url: ${DEPLOYMENT_URL}"

yarn install
export CYPRESS_BASE_URL="https://${DEPLOYMENT_URL}"
npx cypress run $4