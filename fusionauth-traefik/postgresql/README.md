## FusionAuth with Traefik

### Docker Compose

Simple configuration to get up and running with FusionAuth using Traefik as a reverse proxy service.

```bash
curl -o docker-compose.yml https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth-traefik/postgresql/docker-compose.yml
curl -o .env https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth-traefik/postgresql/.env

docker-compose up
```