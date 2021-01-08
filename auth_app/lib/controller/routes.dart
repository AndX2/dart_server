import 'package:auth_app/auth_app.dart';
import 'package:auth_app/controller/actuator_controller.dart';
import 'package:auth_app/controller/login_controller.dart';
import 'package:auth_app/di/di_container.dart';
import 'package:auth_app/service/oauth_provider_factory.dart';
import 'package:injectable/injectable.dart';

/// Вспомогательный класс для хранения констант маршрутизации
class Routes {
  // Маршруты приложения :$actuatorParam в [] означает, что
  // сегмент path после /actuator/ является опциональным,
  // а его значение будет интерпретировано в значение локальной переменной
  static const String actuator = '/actuator/[:$actuatorParam]';
  static const String refresh = '/refresh';

  // Параметры маршрутов
  static const String actuatorParam = 'param';
}

@module
abstract class RegisterRouter {
  Router createRouter(
    OauthProviderFactory _providerFactory,
    LoginController _loginController,
  ) {
    final router = Router();

    router
        .route(Routes.actuator)
        .linkFunction((Request request) => Response.unauthorized())
        .link(() => getIt.get<ActuatorController>());

    router.route(Routes.refresh).link(() => getIt.get<LoginController>());

    _providerFactory.providerList.forEach(
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
