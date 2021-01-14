## FusionAuth with NGinx

### Docker Compose

Simple configuration to get up and running with FusionAuth using NGinx as a reverse proxy service.

```bash
curl -o docker-compose.yml https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth/docker-compose.yml
curl -o .env https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth/.env
curl -o http_default.conf https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/proxy-docker/nginx/http_default.conf
curl -o docker-compose.override.yml https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/proxy-docker/nginx/docker-compose.override.yml

docker-compose up
```