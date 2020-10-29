import 'package:auth_app/auth_app.dart';
import 'package:auth_app/controller/actuator_controller.dart';
import 'package:auth_app/di/di_container.dart';
import 'package:auth_app/service/oauth_provider_factory.dart';
import 'package:injectable/injectable.dart';

/// Вспомогательный класс для хранения констант маршрутизации
class Routes {
  // Маршруты приложения :$actuatorParam в [] означает, что
  // сегмент path после /actuator/ является опциональным,
  // а его значение будет интерпретировано в значение локальной переменной
  static const String actuator = '/actuator/[:$actuatorParam]';

  // Параметры маршрутов
  static const String actuatorParam = 'param';
}

@module
abstract class RegisterRouter {
  Router createRouter(OauthProviderFactory _providerService) {
    final router = Router();

    router
        .route(Routes.actuator)
        .linkFunction((Request request) => Response.unauthorized())
        .link(() => getIt.get<ActuatorController>());

    _providerService.providerList.forEach(
      (provider) {
        router
            .route('${provider.name}/login')
            .linkFunction(provider.getLoginUrl);
        router
            .route('${provider.name}/redirect')
            .linkFunction(provider.redirectHandler);
      },
    );

    return router;
  }
}
