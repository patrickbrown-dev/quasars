# Quasars

A lobste.rs-like for Astronomy, Meteorology, and Atmospheric Sciences.

## First Time Setup

Instrument some docker magicks:

```
docker volume create --name=postgres-volume
docker-compose build
docker-compose up -d
docker-compose run web rake db:create
docker-compose run web rake db:migrate
```

Then navigate your browser to `localhost:3000`.