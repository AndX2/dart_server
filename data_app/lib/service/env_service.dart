import 'package:data_app/repository/env/env_repository.dart';

/// Сервис доступа к переменным окружения. Проксирует доступ
/// к словарю переменных. Защищает словарь от модификации
/// в других компонентах приложения.
class EnvironmentService {
  EnvironmentService(EnvironmentRepository environmentRepository)
      : _env = Map<String, String>.unmodifiable(
          environmentRepository.getEnvironmentMap(),
        );
  /// Защищенная от изменений копия словаря переменных
  final Map<String, String> _env;

  /// Получить словарь всех переменных
  Map<String, String> getEnvironmentMap() {
    return _env;
  }

  /// Получить переменную по ключу
  String getEnvironment(String key) {
    return _env[key];
  }
}


