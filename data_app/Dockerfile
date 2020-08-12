# Исходный образ для сборки
FROM google/dart:2.7

# Папка выполнения проекта внутри образа
WORKDIR /app
# Копируем файл pubspec из проекта в рабочую папку образа
ADD pubspec.* /app/

# создаем группу пользователей 'aqueduct'
# в этой группе создаем пользователя 'aqueduct'
# изменяем владельца файлов в папке /app на aqueduct
RUN groupadd -r aqueduct
RUN useradd -m -r -g aqueduct aqueduct
RUN chown -R aqueduct:aqueduct /app

# Переключаем пользователя на aqueduct, от его имени
# получаем пакеты зависимостей проекта
USER aqueduct
RUN pub get --no-precompile

# Переключаем пользователя на root
# копируем все остальные файлы проекта в папку /app образа
# изменяем владельца файлов в папке /app на aqueduct
USER root
ADD . /app
RUN chown -R aqueduct:aqueduct /app

# Переключаем пользователя на aqueduct, от его имени
# докачиваем пакеты зависимостей проекта
USER aqueduct
RUN pub get --no-precompile

