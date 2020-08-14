### autocanon

https://github.com/mcollina/autocannon#install

```
npm i autocannon -g
autocannon -c 100 https://dartservice.ru/index.html
autocannon -c 100 http://localhost:80/api/actuator
```

### run debug

```
docker-compose -f docker-compose.yaml -f docker-compose.dev.yaml up --build -d
docker-compose -f docker-compose.aot.yaml -f docker-compose.dev.yaml up --build -d
```

### Native builder

```
docker build --pull --rm -f "dart2native\Dockerfile" -t aqueduct_builder:4.0.0-b1 "dart2native"
docker images
docker image tag a365ac7f5bbb andx2/aqueduct:4.0.0-b1
docker push andx2/aqueduct:4.0.0-b1

docker-compose -f docker-compose.dev.build.yaml up
```

### Aqueduct

```
<!-- db migration -->
aqueduct db generate
docker-compose -f docker-compose.migrations.yaml --env-file=./data_app.env up --build
```
