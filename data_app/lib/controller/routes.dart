import 'package:data_app/controller/actuator_controller.dart';
import 'package:data_app/controller/stub_setting_controller.dart';
import 'package:data_app/data_app.dart';
import 'package:data_app/di/di_container.dart';

/// Вспомогательный класс для хранения констант маршрутизации
class Routes {
  // Маршруты приложения :$actuatorParam в [] означает, что
  // сегмент path после /actuator/ является опциональным,
  // а его значение будет интерпретировано в значение локальной переменной
  static const String actuator = '/actuator/[:$actuatorParam]';
  static const String stubSetting = '/stub_setting';

  // Параметры маршрутов
  static const String actuatorParam = 'param';

  /// Создание и инициализация маршрутизатора
  static Router createRouter() {
    final router = Router();
    router.route(actuator).link(() => ActuatorController());
    router.route(stubSetting).link(() => getIt.get<StubSettingController>());
    return router;
  }
}
