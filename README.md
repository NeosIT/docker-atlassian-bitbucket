[![Build Status](https://img.shields.io/circleci/project/cptactionhank/docker-atlassian-bitbucket.svg)](https://circleci.com/gh/cptactionhank/docker-atlassian-bitbucket) [![Open Issues](https://img.shields.io/github/issues/cptactionhank/docker-atlassian-bitbucket.svg)](https://github.com/cptactionhank/docker-atlassian-bitbucket/issues) [![Stars on GitHub](https://img.shields.io/github/stars/cptactionhank/docker-atlassian-bitbucket.svg)](https://github.com/cptactionhank/docker-atlassian-bitbucket/stargazers) [![Forks on GitHub](https://img.shields.io/github/forks/cptactionhank/docker-atlassian-bitbucket.svg)](https://github.com/cptactionhank/docker-atlassian-bitbucket/network) [![Stars on Docker Hub](https://img.shields.io/docker/stars/cptactionhank/atlassian-bitbucket.svg)](https://hub.docker.com/r/cptactionhank/atlassian-bitbucket/) [![Pulls on Docker Hub](https://img.shields.io/docker/pulls/cptactionhank/atlassian-bitbucket.svg)](https://hub.docker.com/r/cptactionhank/atlassian-bitbucket/) [![Sponsor by PayPal](https://img.shields.io/badge/sponsor-PayPal-blue.svg)](https://paypal.me/cptactionhank/5)

# Atlassian Bitbucket Server in a Docker container

This is a containerized installation of Atlassian Bitbucket Server with Docker, and it's a match made in heaven for us all to enjoy. The aim of this image is to keep the installation as straight forward as possible, but with a few Docker related twists. You can get started by clicking the appropriate link below and reading the documentation.

* [Atlassian JIRA Core](https://cptactionhank.github.io/docker-atlassian-jira)
* [Atlassian JIRA Software](https://cptactionhank.github.io/docker-atlassian-jira-software)
* [Atlassian JIRA Service Desk](https://cptactionhank.github.io/docker-atlassian-service-desk)
* [Atlassian Confluence](https://cptactionhank.github.io/docker-atlassian-confluence)
* [Atlassian Bitbucket Server](https://cptactionhank.github.io/docker-atlassian-bitbucket)

If you want to help out, you can check out the contribution section further down.

Note: newer versions of Atlassian Bitbucket Server includes an Elastic Search service as well, that is when you are not running Bitbucket in foreground mode. To include searching capability using the Elastic Search bundled system add-on it is necessary to setup an external service for this ie. starting an additional container running Elastic Search.

## I'm in the fast lane! Get me started

To quickly get started running a Bitbucket Server instance, use the following command:
```bash
docker run --detach --publish 7990:7990 cptactionhank/atlassian-bitbucket:latest
```

Then simply navigate your preferred browser to `http://[dockerhost]:7990` and finish the configuration.

## Configuration

You can configure a small set of things by supplying the following environment variables

| Environment Variable   | Description |
| ---------------------- | ----------- |
| X_PATH                 | Sets the Tomcat connectors `path` attribute |
| X_CROWD_SSO            | Set to `true` to enable SSO via Atlassian Crowd

## How to enable SSO via Crowd

Setting X_CROWD_SSO to `true` will enable Crowd SSO in your bitbucket.properties.
You will have to put your `crowd-properties.conf` to `${BITBUCKET_HOME}/shared` and set up the user directory in Bitbucket.

See the [official Documentation](https://confluence.atlassian.com/bitbucketserver/connecting-bitbucket-server-to-crowd-776640399.html) for more information.

This image is based on https://github.com/cptactionhank/docker-atlassian-bitbucket