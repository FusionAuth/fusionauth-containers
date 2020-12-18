## FusionAuth with NGinx

### Docker Compose

Simple configuration to get up and running with FusionAuth using NGinx as a reverse proxy service.

```bash
curl -o docker-compose.yml https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth-nginx/postgresql/docker-compose.yml
curl -o .env https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth-nginx/postgresql/.env
curl -o http_default.conf https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth-nginx/postgresql/http_default.conf

docker-compose up
```