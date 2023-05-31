# vercel-cypress

GitHub action which allows you to run Cypress tests against a Vercel preview 
deployment.

## Prerequisites

- [Vercel GitHub integration](https://vercel.com/docs/concepts/git/vercel-for-github).
- [Vercel API token](https://vercel.com/account/tokens) which should be stored 
  as an [encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- You Vercel team id or slug

Make sure that the API token has the right access scope and that your team id is
correct. You can do this with the following check; the output should be a large
json payload.

```sh
export TEAM_ID=YOUR_TEAM_ID
export TOKEN=YOUR_VERCEL_API_TOKEN

# reference: https://vercel.com/docs/rest-api/endpoints#list-deployments
curl -X GET "https://api.vercel.com/v6/deployments?teamId=${TEAM_ID}" \
  -H "Authorization: Bearer ${TOKEN}"
```

## Usage

The following action will wait for the Vercel deployment to finish, then run 
Cypress but override the URL provided to Cypress' config to the latest Vercel 
deployment URL.

```yml
name: my-action

# (only) run after a successful deployment
on: deployment

jobs:
  regression:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - uses: actions/vercel-cypress@v1
        with:
          # required: vercel API token
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          # required: vercel team name / slug
          team: your-team-name
          # optional: parameters that are passed to 'npx cypress run <options>'
          options: "--browser chrome --spec cypress/e2e/base/*"
```
