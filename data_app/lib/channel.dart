import 'package:data_app/controller/routes.dart';
import 'package:data_app/di/di_container.dart';

import 'data_app.dart';

/// Экземпляр приложения
class DataAppChannel extends ApplicationChannel {
  /// Метод подготовки. Выполняется до запуска.
  @override
  Future prepare() async {
    await initDi();
  }

  /// Настройка маршрутизатора приложения
  @override
  Controller get entryPoint => Routes.createRouter();
}
