### autocanon
<!-- Нагрузочное тестирование -->
https://github.com/mcollina/autocannon#install

```
<!-- Установка -->
npm i autocannon -g
<!-- Запуск (100 соединений 60 секунд) -->
autocannon -c 100 -d 60 http://localhost:80/api/actuator
```

### Aqueduct

```
<!-- Установка -->
pub global activate aqueduct 4.0.0-b1
<!-- Удаление -->
pub global deactivate aqueduct
<!-- Создать новое приложение -->
aqueduct create data_app
<!-- Запуск JIT -->
aqueduct serve --port 8080 --isolates 2
<!-- AOT сборка -->
aqueduct build
<!-- Запуск AOT -->
data_app.aot --port 8080 --isolates 2
<!-- Создать файл миграции БД -->
aqueduct db generate
<!-- Применить файл миграции -->
docker-compose -f docker-compose.migrations.yaml --env-file=./data_app.env --compatibility up --abort-on-container-exit
```

### Запуск отладки

```
<!-- JIT -->
docker-compose -f docker-compose.old.yaml -f docker-compose.dev.yaml up --build -d
<!-- AOT -->
docker-compose -f docker-compose.yaml -f docker-compose.dev.yaml up --build -d
```

### Native builder

```
<!-- Собрать образ -->
docker build --pull --rm -f "dart2native\Dockerfile" -t aqueduct_builder:4.0.0-b1 "dart2native"
<!-- Список образов -->
docker images
<!-- Переименовать образ -->
docker image tag a365ac7f5bbb andx2/aqueduct:4.0.0-b1
<!-- Авторизоваться в DockerHub -->
docker login
<!-- Выгрузить образ в DockerHub -->
docker push andx2/aqueduct:4.0.0-b1
```

### Dev

```
<!-- Генерация графа DI контейнера -->
pub run build_runner watch --delete-conflicting-outputs
```


