import 'package:auth_app/auth_app.dart';
import 'package:auth_app/controller/routes.dart';
import 'package:auth_app/di/di_container.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class AuthAppChannel extends ApplicationChannel {
  /// Метод подготовки. Выполняется до запуска.
  @override
  Future prepare() async {
    await initDi();
  }

  /// Настройка маршрутизатора приложения
  @override
  Controller get entryPoint => Routes.createRouter();
}