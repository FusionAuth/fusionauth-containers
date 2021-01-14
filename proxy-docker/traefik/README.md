## FusionAuth with Traefik

### Docker Compose

Simple configuration to get up and running with FusionAuth using Traefik as a reverse proxy service.

```bash
curl -o docker-compose.yml https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth/docker-compose.yml
curl -o .env https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth/.env
curl -o docker-compose.override.yml https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/proxy-docker/traefik/docker-compose.override.yml

docker-compose up
```