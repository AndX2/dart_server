import 'package:data_app/controller/routes.dart';
import 'package:data_app/data_app.dart';
import 'package:data_app/di/di_container.dart';
import 'package:data_app/service/env_service.dart';

/// Контроллер сетевого доступа к служебным данным о работе приложения
class ActuatorController extends ResourceController {
  ActuatorController() : _environmentService = getIt.get<EnvironmentService>();

  final EnvironmentService _environmentService;

  /// Получить значение переменной окружения по ключу
  /// Данный метод будет выполнен для GET запроса только
  /// при наличии параметра в path запроса после '/actuator/'
  @Operation.get(Routes.actuatorParam)
  Future<Response> getEnvParam(
    /// Сопоставим параметр из запроса с локальной переменной param
    @Bind.path(Routes.actuatorParam) String param,
  ) async {
    /// Извлекаем переменную из сервиса по ключу
    final value = _environmentService.getEnvironment(param);
    /// Проверяем, что такая переменная существует
    if (value == null) {
      /// Если нет - устанавливаем код ответа в 404 (не найдено)
      return Response.notFound();
    }
    /// Установим код ответа в 200 (Ok), а в тело ответа
    /// значение запрашиваемой переменной
    return Response.ok(_environmentService.getEnvironment(param));
  }

  /// Получить значения всех переменных окружения по запросу GET
  /// Этот метод важно расположить последним, как более общий
  /// чем getEnvParam. Таким образом он будет выполняться только
  /// если в пути запроса нет сегмента после '/actuator/'
  @Operation.get()
  Future<Response> getEnvParams() async {
    return Response.ok(_environmentService.getEnvironmentMap());
  }
}


