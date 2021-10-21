#!/bin/sh -l

IFS=/ read -a REPOSITORY_PARTS <<< "$GITHUB_REPOSITORY"
DEPLOYMENT_URL=$(curl -H "Content-type: application/json" -H "Authorization: Bearer $1" "https://api.vercel.com/v5/deployments?meta-githubRepo=${REPOSITORY_PARTS[1]}&meta-githubCommitRef=$GITHUB_HEAD_REF" | jq -r '.deployments[0].url')
npx cypress run --config baseUrl="https://$DEPLOYMENT_URL"
