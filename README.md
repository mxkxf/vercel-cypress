# vercel-cypress

GitHub action which allows you to run Cypress tests against a Vercel preview deployment.

## Prerequesites

This guide assumes you have set up the [Vercel GitHub integration](https://vercel.com/docs/concepts/git/vercel-for-github).

To use this action you will need to first generate a [Vercel token](https://vercel.com/account/tokens).

Then you can either store this with your account or repository's [secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets).

## Usage

The following action will wait for the Vercel deployment to finish, then run Cypress but override the URL provided to Cypress' config to the latest Vercel deployment URL.

```yml
name: my-action

on: deployment

jobs:
  regression:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - uses: actions/vercel-cypress@v1
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          team: your-team-name
          options: "--browser chrome --spec cypress/e2e/base/*"
```
