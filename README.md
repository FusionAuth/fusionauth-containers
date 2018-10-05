## Containers! Containers! Containers!

### Docker



#### Docker Compose

See [docker-compose.yml](https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth/docker-compose.yml)

Review our [Docker Install Guide](https://fusionauth.io/docs/v1/tech/installation-guide/docker) for additional assistance.

Fast path docker-compose
```bash
curl -o docker-compose.yml https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth/docker-compose.yml && docker-compose up
``` 

#### Docker Images

Docker images are available on [Docker Hub](https://hub.docker.com/u/fusionauth/)

FusionAuth App Only
```bash
docker pull fusionauth/fusionauth-app
```

FusionAuth Search Only
```bash
docker pull fusionauth/fusionauth-search
```