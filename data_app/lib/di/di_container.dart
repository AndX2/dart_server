import 'dart:async';

import 'package:get_it/get_it.dart';

import 'package:data_app/repository/env/env_repository.dart';
import 'package:data_app/service/env_service.dart';

/// Экземпляр DI контейнера
final getIt = GetIt.instance;

/// Инициализация DI контейнера
Future initDi() async {
  /// Регистрация фабрики [EnvironmentRepository]
  getIt.registerFactory<EnvironmentRepository>(
    () => EnvironmentRepository(),
  );
  /// Регистрация "ленивого" singleton [EnvironmentService], экземпляр
  /// сервиса будет создан только после того, как он будет запрошен
  /// каким-либо компонентом
  getIt.registerLazySingleton<EnvironmentService>(
    () => EnvironmentService(getIt.get<EnvironmentRepository>()),
  );
}

