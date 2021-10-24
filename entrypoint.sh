#!/bin/sh -l

echo "GITHUB_REPOSITORY: $GITHUB_REPOSITORY"
echo "GITHUB_REF: $GITHUB_REF"
echo "TOKEN: $1"
DEPLOYMENT_URL=$(curl -H "Content-type: application/json" -H "Authorization: Bearer $1" "https://api.vercel.com/v5/deployments?meta-githubRepo=${GITHUB_REPOSITORY}" | jq -r '.deployments[0].url')
npx cypress run --config baseUrl="https://$DEPLOYMENT_URL"
