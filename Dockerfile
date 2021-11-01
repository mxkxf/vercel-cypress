FROM ubuntu:latest

# https://docs.cypress.io/guides/continuous-integration/introduction#Machine-requirements
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y \ 
  curl jq \
  libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
