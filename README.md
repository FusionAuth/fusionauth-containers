## Containers! Containers! Containers!

FusionAuth loves containers, found an issue? Please open a bug or submit a PR.


## Credits
- [@sims-security](https://github.com/sims-security) Thank you for the proxy-docker section.
- [@ssirag](https://github.com/ssirag) Thank you for the feedback and bug reports.
- [@minyangu](https://github.com/minyangu) Thank you for [PR #3](https://github.com/FusionAuth/fusionauth-containers/pull/3) to enhance our docker-compose example.
- [János Veres](https://github.com/nadilas) Thank you for building out an example Kubernetes configuration via [PR #6](https://github.com/FusionAuth/fusionauth-containers/pull/6), this will be very valuable to the FusionAuth community.
- [@trollr](https://github.com/trollr) and the [Ninjaneers team](https://www.ninjaneers.de/) for the helm configuration and all of their contribution.
- [@vladyslav2](https://github.com/vladyslav2) for [PR #15](https://github.com/FusionAuth/fusionauth-containers/pull/15) to make the Docker Compose example work better when invoked via `bash`.
- [@drpebcak](https://github.com/drpebcak) for all of your contribution and assistance in this repo!
- [@sims-security](https://github.com/sims-security) for the proxy examples in `proxy-docker/`!
- The FusionAuth team - couldn't have done it without you!

<br>

## Contributors
- [@nadilas](https://github.com/nadilas)
- [@trollr](https://github.com/trollr)
- [@drpebcak](https://github.com/drpebcak)
- [@sims-security](https://github.com/sims-security)

https://github.com/fusionauth/fusionauth-contrib is the new repository for all contributions, including container runtimes and configs.

<br>

## Review us on G2

https://www.g2.com/products/fusionauth/take_survey

## Get Started

The best way to get started with FusionAuth is to use our [Getting Started Guide](https://fusionauth.io/docs/get-started/start-here/step-1)

## Docker

### Docker Compose

The reference [docker-compose.yml](https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/main/docker/fusionauth/docker-compose.yml) defaults to use OpenSearch as the search engine.

Review our [Docker Install Guide](https://fusionauth.io/docs/get-started/download-and-install/docker) for additional assistance.

This Docker Compose file includes a number of profiles that you can use to enable various optional services. The profiles are:

* **caddy** - This profile enables a Caddy service that is configured to proxy to FusionAuth on ports 80 and 443.
* **mailcatcher** - This profile enables Mailcatcher, which is a test SMTP server. You can configure FusionAuth to use this SMTP server during development and testing.
* **kafka** - This profile enables Kafka (and Zookeeper) which you can use Kafka to receive Webhook events.
* **cleanspeak** - This profile enables Cleanspeak, which you can use to filter usernames and profile data for profanity and other unwanted content.
* **opentelemetry** - This profile enables an OpenTelemetry Collector, which you can use to monitor FusionAuth.
* **prometheus** - This profile enables Prometheus, which can be optionally connected to OpenTelemetry. These services can be used to monitor FusionAuth.
* **alertmanager** - This profile enables AlertManager, which you can use to generate alerts for anomalies and errors from FusionAuth.

To enable a profile, you use the `--profile` switch on the command-line like this (use can use multiple instances of this switch to enable multiple profiles):

```bash
docker compose --profile caddy --profile kafka up
```

### Docker Images

Docker images are available on [Docker Hub](https://hub.docker.com/u/fusionauth/)

FusionAuth App
```bash
docker pull fusionauth/fusionauth-app:latest
```

## Kubernetes

Kubernetes is a supported platform. The supported installation method is Helm.

Review our [Kubernetes Install Guide](https://fusionauth.io/docs/v1/tech/installation-guide/kubernetes) for additional assistance.

The [FusionAuth Helm chart](https://github.com/FusionAuth/charts) is managed in a separate repository. See [README](https://github.com/FusionAuth/charts/blob/master/README.md) for more information.

## OpenShift

Please see https://github.com/fusionauth/fusionauth-contrib for openshift information.

## Helm

Please see https://fusionauth.io/docs/get-started/download-and-install/kubernetes/

## Proxy-Docker

Please see https://github.com/fusionauth/fusionauth-contrib for proxy-docker information.

## Monitoring

There is a special Docker Compose file in the directory `docker/fusionauth/monitoring` named `docker-compose.yml`. This file starts OpenTelemetry, Prometheus, and Alert Manager. This directory also contains a number of configuration files that you can use to configure these services. You can review these pages of the documentation to learn more:

* https://fusionauth.io/docs/operate/monitor/opentelemetry
* https://fusionauth.io/docs/operate/monitor/prometheus
