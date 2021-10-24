FROM alpine:latest

RUN apk add --no-cache \
  jq \
  curl \
  nodejs \
  npm

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
