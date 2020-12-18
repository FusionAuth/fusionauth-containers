## FusionAuth with Apache

### Docker Compose

Simple configuration to get up and running with FusionAuth using Apache as a reverse proxy service.

```bash
curl -o docker-compose.yml https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth-apache/postgresql/docker-compose.yml
curl -o .env https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth-apache/postgresql/.env
curl -o httpd.conf https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth-apache/postgresql/httpd.conf

docker-compose up
```