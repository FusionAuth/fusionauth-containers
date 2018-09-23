## Containers! Containers! Containers!

### Docker

https://hub.docker.com/u/fusionauth/


FusionAuth App Only
```
docker pull fusionauth/fusionauth-app
```

FusionAuth Search Only
```
docker pull fusionauth/fusionauth-search
```

`docker-compose.yml`
```yml
version: '3.3'

services:
  db:
    image: postgres:9.6
    ports:
      - 5432:5432
    volumes:
      - db_data:/var/lib/postgresql/data
    restart: always
    environment:
      PGDATA : /var/lib/postgresql/data/pgdata
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: hkaLBM3RVnyYeYeqE3WI1w2e4Avpy0Wd5O3s3_rulcA

  search:
    image: docker.elastic.co/elasticsearch/elasticsearch:6.3.1
    environment:
      - cluster.name=fusionauth
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - es_data1:/usr/share/elasticsearch/data
    ports:
      - 9200:9200
      - 9300:9300

  app:
    depends_on:
      - db
      - search
    image: fusionauth/fusionauth-app:latest
    ports:
      - 9011:9011
    volumes:
      - fa_config:/usr/local/fusionauth/config

volumes:
  db_data:
  es_data1:
  fa_config:
```