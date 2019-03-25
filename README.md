## Containers! Containers! Containers!

FusionAuth loves containers, found an issue? Please open a bug or submit a PR. 


## Credits
- [@ssirag](https://github.com/ssirag) Thank you for the feedback and bug reports. 
- [@minyangu](https://github.com/minyangu) Thank you for [PR #3](https://github.com/FusionAuth/fusionauth-containers/pull/3) to enhance our docker-compose example.
- [János Veres](https://github.com/nadilas) Thank you for building out an example Kubernetes configuration via [PR #6](https://github.com/FusionAuth/fusionauth-containers/pull/6), this will be very valuable to the FusionAuth community.
- The FusionAuth team - couldn't have done it without you! 

## Docker


### Docker Compose

See [docker-compose.yml](https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth/docker-compose.yml)

Review our [Docker Install Guide](https://fusionauth.io/docs/v1/tech/installation-guide/docker) for additional assistance.

```bash
curl -o docker-compose.yml https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth/docker-compose.yml
curl -o .env https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth/.env
docker-compose up
``` 

### Docker Images

Docker images are available on [Docker Hub](https://hub.docker.com/u/fusionauth/)

FusionAuth App Only
```bash
docker pull fusionauth/fusionauth-app
```

FusionAuth Search Only
```bash
docker pull fusionauth/fusionauth-search
```

## Kubernetes


### Single instance deployment


#### For Istio

```bash
kubectl apply --recursive -f kubernetes
```

#### Internal only

```bash
kubectl apply --recursive -f kubernetes/volume-claims
kubectl apply --recursive -f kubernetes/deployments
kubectl apply --recursive -f kubernetes/services
```

