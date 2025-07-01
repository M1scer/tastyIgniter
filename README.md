# TastyIgniter Docker
[![Docker Pulls](https://img.shields.io/docker/pulls/M1scer/tastyIgniter)](https://hub.docker.com/r/M1scer/tastyIgniter/)
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/M1scer/tastyIgniter/latest)](https://hub.docker.com/r/M1scer/tastyIgniter/tags)

Run with docker compose for automatic database configuration

```
mkdir tastyigniter && cd tastyigniter
curl -LO https://github.com/ThisIsQasim/TastyIgniter/raw/master/docker-compose.yml
docker compose up db -d
sleep 10
docker compose up -d
docker compose exec app php artisan igniter:passwd admin
```
    
Browse to port 8001 of your docker host. The TastyIgniter setup wizard will show up. Wait for a minute for the database container to come up and then run the setup. 

## Credits
TastyIgniter: https://github.com/tastyigniter/TastyIgniter
