import 'dart:core';

import 'package:data_app/data_app.dart';

/// Репозиторий доступа к переменным процесса приложения
class EnvironmentRepository {
  EnvironmentRepository() : _env = Platform.environment;

  final Map<String, String> _env;

  /// Получить словарь всех переменных
  Map<String, String> getEnvironmentMap() {
    return _env;
  }
}
