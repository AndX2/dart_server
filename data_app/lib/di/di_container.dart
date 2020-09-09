import 'dart:async';
import 'package:get_it/get_it.dart';

import 'package:data_app/controller/stub_setting_controller.dart';
import 'package:data_app/data_app.dart';
import 'package:data_app/repository/stub_setting/stub_setting_repository.dart';
import 'package:data_app/service/db_helper.dart';
import 'package:data_app/service/stub_setting/stub_service.dart';
import 'package:data_app/repository/env/env_repository.dart';
import 'package:data_app/service/env_service.dart';

/// Экземпляр DI контейнера
final GetIt getIt = GetIt.instance;

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

  getIt.registerSingleton<ManagedContext>(
    _getManagedContext(),
  );

  getIt.registerFactory<DbHelper>(
    () => DbHelper(getIt.get<EnvironmentService>()),
  );

  getIt.registerFactory<StubSettingRepository>(
      () => StubSettingRepository(getIt.get<ManagedContext>()));

  getIt.registerSingleton<StubSettingService>(
      StubSettingService(getIt.get<StubSettingRepository>()));

  getIt.registerFactory<StubSettingController>(
      () => StubSettingController(getIt.get<StubSettingService>()));
}

ManagedContext _getManagedContext() {
  return DbHelper(
    getIt.get<EnvironmentService>(),
  ).managedContext;
}
