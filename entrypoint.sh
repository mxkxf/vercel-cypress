#!/bin/sh -l

echo "GITHUB_ACTION_REF: $GITHUB_ACTION_REF"
echo "TOKEN: $1"
echo "REPO: $2"
echo "https://api.vercel.com/v5/deployments?meta-githubRepo=${2}"
DEPLOYMENT_URL=$(curl -H "Content-type: application/json" -H "Authorization: Bearer $1" "https://api.vercel.com/v5/deployments?meta-githubRepo=${2}" | jq -r '.deployments[0].url')
npx cypress run --config baseUrl="https://$DEPLOYMENT_URL"
