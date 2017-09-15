# README

```sh
  $ docker-compose up -d db redis
  $ docker-compose build web
  $ docker-compose run --rm web rake db:create db:migrate db:seed
  $ docker-compose up
```
Check localhost:3000

Admin: admin@test.com
Pass: 111111
