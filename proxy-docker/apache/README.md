## FusionAuth with Apache

### Docker Compose

Simple configuration to get up and running with FusionAuth using Apache as a reverse proxy service.

```bash
curl -o docker-compose.yml https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth/docker-compose.yml
curl -o .env https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth/.env
curl -o httpd.conf https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/proxy-docker/apache/httpd.conf
curl -o docker-compose.override.yml https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/proxy-docker/apache/docker-compose.override.yml

docker-compose up
```