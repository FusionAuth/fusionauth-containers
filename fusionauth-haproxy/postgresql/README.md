## FusionAuth with HAProxy

### Docker Compose

Simple configuration to get up and running with FusionAuth using HAProxy as a reverse proxy service.

```bash
curl -o docker-compose.yml https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth-haproxy/postgresql/docker-compose.yml
curl -o Dockerfile https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth-haproxy/postgresql/Dockerfile
curl -o .env https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth-haproxy/postgresql/.env
curl -o haproxy.cfg https://raw.githubusercontent.com/FusionAuth/fusionauth-containers/master/docker/fusionauth-haproxy/postgresql/haproxy.cfg

docker-compose up
docker build -t haproxy .
docker run -d --name haproxy haproxy
# To publish proxy port on host run the following command instead
# docker run -d --name haproxy -p 80:80 haproxy
```