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

<br>

## Docker

### Docker Compose

The reference [docker-compose.yml](https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth/docker-compose.yml) defaults to use the database as the User search engine.

In order to install with Elasticsearch as the User search engine, include the reference  [docker-compose.override.yml](https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth/docker-compose.override.yml).

Review our [Docker Install Guide](https://fusionauth.io/docs/v1/tech/installation-guide/docker) for additional assistance.

```bash
curl -o docker-compose.yml https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth/docker-compose.yml
# Uncomment the following line to install and configure Elasticsearch as the User search engine
# curl -o docker-compose.override.yml https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth/docker-compose.override.yml
curl -o .env https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth/.env
docker-compose up
```

### Docker Images

Docker images are available on [Docker Hub](https://hub.docker.com/u/fusionauth/)

FusionAuth App
```bash
docker pull fusionauth/fusionauth-app:latest
```

<br>

### Community Contributed Docker Images

#### Arm64

One of our FusionAuth MVPs [@jerryhopper](https://github.com/jerryhopper) has been building FusionAuth for use on the Arm64 platform. Find the Arm64 images on [hub.docker.com/r/jerryhopper/fusionauth-app](https://hub.docker.com/r/jerryhopper/fusionauth-app) or using the following pull command.


```bash
docker pull jerryhopper/fusionauth-app:latest
```

For a walk through on running FusionAuth on Arm64, review the following article provided by [@jerryhopper](https://github.com/jerryhopper).
-  https://blog.jerryhopper.com/2020/06/15/fusionauth-on-arm64/

#### Multi-Architecture Builds

https://github.com/jerryhopper/fusionauth-app-multiarch

## Kubernetes

### Notice
The Kubernetes portion of this repository is community maintained; and is provided to assist in your deployment and management of FusionAuth. Use of this software is not covered under the FusionAuth license agreement and is provided "as is" without warranty.  https://fusionauth.io/license

```
kubernetes
├── *
├── README.md
```

See the [Kubernetes README](https://github.com/FusionAuth/fusionauth-containers/tree/master/kubernetes)

<br>

## Helm

### Notice
The Helm repository is community maintained; and is provided to assist in your deployment and management of FusionAuth. Use of this software is not covered under the FusionAuth license agreement and is provided "as is" without warranty.  https://fusionauth.io/license

The [FusionAuth Helm chart](https://github.com/FusionAuth/charts) is managed in a separate repository. See [README](https://github.com/FusionAuth/charts/blob/master/README.md) for more informations.

<br>

## OpenShift

### Notice
The OpenShift portion of this repository is community maintained; and is provided to assist in your deployment and management of FusionAuth. Use of this software is not covered under the FusionAuth license agreement and is provided "as is" without warranty.  https://fusionauth.io/license

```
openshift
├── *
├── README.md
```

See the [OpenShift README](https://github.com/FusionAuth/fusionauth-containers/tree/master/openshift)

<br>

## Proxy-Docker

### Notice
The Proxy-Docker portion of this repository is community maintained; and is provided to assist in your deployment and management of FusionAuth. Use of this software is not covered under the FusionAuth license agreement and is provided "as is" without warranty.  https://fusionauth.io/license

```
proxy-docker
├── *
├── README.md
```

See the [Proxy-Docker README](https://github.com/FusionAuth/fusionauth-containers/tree/master/proxy-docker)
