# vercel-cypress

GitHub action which allows you to run Cypress tests against a Vercel preview 
deployment.

## Prerequisites

- [Vercel GitHub integration](https://vercel.com/docs/concepts/git/vercel-for-github).
- [Vercel API token](https://vercel.com/account/tokens) which should be stored 
  as an [encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- You need the project ID (which can be found in the "Project Settings" on vercel)
- If your project belongs to a team, you need the team ID as well

Make sure that the API token has the right access scope and that your team id is
correct. You can do this with the following check; the output should be a large
json payload.

```sh
# reference: https://vercel.com/docs/rest-api/endpoints#list-deployments
export TOKEN=YOUR_VERCEL_API_TOKEN

export PROJECT_ID=YOUR_PROJECT_ID
curl -X GET "https://api.vercel.com/v6/deployments?projectId=${PROJECT_ID}" \
  -H "Authorization: Bearer ${TOKEN}"

# for team projects
export TEAM_ID=YOUR_TEAM_ID
curl -X GET "https://api.vercel.com/v6/deployments?projectId=${PROJECT_ID}&teamId=${TEAM_ID}" \
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
          # required: project id
          project-id: your-project-id
          # required if the project is from a team
          team-id: your-team-id
          # optional: parameters that are passed to 'npx cypress run <options>'
          options: "--browser chrome --spec cypress/e2e/base/*"
```
