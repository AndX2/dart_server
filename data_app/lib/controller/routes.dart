import 'package:data_app/controller/actuator_controller.dart';
import 'package:data_app/data_app.dart';

/// Вспомогательный класс для хранения констант маршрутизации
class Routes {
  // Маршруты приложения :$actuatorParam в [] означает, что
  // сегмент path после /actuator/ является опциональным,
  // а его значение будет интерпретировано в значение локальной переменной
  static const String actuator = '/actuator/[:$actuatorParam]';
  // ...

  // Параметры маршрутов
  static const String actuatorParam = 'param';
  // ...

  /// Создание и инициализация маршрутизатора
  static Router createRouter() {
    final router = Router();
    router.route(actuator).link(() => ActuatorController());
    return router;
  }
}
