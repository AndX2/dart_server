import 'package:auth_app/auth_app.dart';
import 'package:auth_app/service/env_service.dart';
import 'package:injectable/injectable.dart';

/// Класс для подключения к базе данных, используя переменные
/// окружения
@module
abstract class DbHelper {
  /// Возвращает объект контекста соединения с БД
  /// на котором выполняются запросы
  ManagedContext managedContext(EnvironmentService environmentService) {
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final _env = environmentService.getEnvironmentMap();
    final psc = PostgreSQLPersistentStore.fromConnectionInfo(
      _env['POSTGRES_USER'],
      _env['POSTGRES_PASSWORD'],
      _env['DB_HOST'],
      int.tryParse(_env['DB_PORT'] ?? '5432'),
      _env['POSTGRES_DB'],
    );

    return ManagedContext(dataModel, psc);
  }
}
