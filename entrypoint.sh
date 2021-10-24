#!/bin/sh -l

DEPLOYMENT_URL=$(curl -H "Content-type: application/json" -H "Authorization: Bearer $1" "https://api.vercel.com/v5/deployments?meta-githubRepo=${2}" | jq -r '.deployments[0].url')
npm ci
npx cypress run --config baseUrl="https://$DEPLOYMENT_URL"
