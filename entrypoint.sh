#!/bin/sh -l

# reference: https://vercel.com/docs/rest-api/endpoints#list-deployments

# if a team ID is passed, we filter for deployments of this team
if [[ -z "$3" ]]; then
    echo "=> checking url from latest deployment for team ${3}"
    DEPLOYMENT_URL=$(curl -X GET "https://api.vercel.com/v6/deployments?teamId=$2" -H "Authorization: Bearer $1"  | jq -r '.deployments[0].url')
else
    echo "=> checking url from latest deployment"
    DEPLOYMENT_URL=$(curl -X GET "https://api.vercel.com/v6/deployments" -H "Authorization: Bearer $1"  | jq -r '.deployments[0].url')
fi

echo "=> found deployment url: ${DEPLOYMENT_URL}"

yarn install

export CYPRESS_BASE_URL="https://${DEPLOYMENT_URL}"
npx cypress run $2