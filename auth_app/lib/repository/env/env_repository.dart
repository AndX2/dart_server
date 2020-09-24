import 'dart:core';

import 'package:auth_app/auth_app.dart';
import 'package:injectable/injectable.dart';

/// Репозиторий доступа к переменным процесса приложения
@injectable
class EnvironmentRepository {
  EnvironmentRepository() : _env = Platform.environment;

  final Map<String, String> _env;

  /// Получить словарь всех переменных
  Map<String, String> getEnvironmentMap() {
    return _env;
  }
}
