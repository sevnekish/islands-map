## Project setup

### System dependencies

* postgresql 11.1

### Configuration
* Rename and fill with real data .env.tt to .env
* create empty .env if you do not need any additional configuration

## Getting Started

1\. Stop postgres services to have free ports and run

2\. Run docker
```ShellSession
$ docker-compose up
```
There are containers for postgresql, rails server

Of course, if you prefer system programs - you can use them.
You can use only some services with docker. Just run
```ShellSession
$ docker-compose up service1 service2
```
i.e.
```ShellSession
$ docker-compose up postgres
```
3\. Create db and run migrations in web container
```ShellSession
$ docker exec <web container name> rake db:create db:migrate
```