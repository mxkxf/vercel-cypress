#!/bin/sh -l

# reference: https://vercel.com/docs/rest-api/endpoints#list-deployments
echo "=> checking url from latest deployment for team ${2}"
DEPLOYMENT_URL=$(curl -X GET "https://api.vercel.com/v6/deployments?teamId=$2" -H "Authorization: Bearer $1"  | jq -r '.deployments[0].url')
echo "=> found deployment url: ${DEPLOYMENT_URL}"

yarn install

export CYPRESS_BASE_URL="https://${DEPLOYMENT_URL}"
npx cypress run $3