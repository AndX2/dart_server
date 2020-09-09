# Исходный образ для сборки
FROM ubuntu:20.10

# Под рутовым пользователем установим необходимые зависимости
USER root
# Обновляем установленные пакеты
RUN apt-get update
# Устанавливаем необходимые утилиты для добавления репозитория dart-sdk
RUN apt-get install apt-transport-https
RUN apt-get update
RUN apt-get install -y gnupg2
RUN apt-get install -y wget
# Устанавливаем ключ для репозитория
RUN sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
# И сам репозиторий
RUN sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
RUN apt-get update
# Устанавливаем dart-sdk версии 2.7.+
RUN apt-get install dart=2.7.*
# Добавляем директорию с бинарниками dart и pub в переменный окружения
ENV DART_SDK /usr/lib/dart
ENV PATH $DART_SDK/bin:/root/.pub-cache/bin:$PATH

# Устанавливаем Aqueduct CLI
RUN pub global activate aqueduct 4.0.0-b1

