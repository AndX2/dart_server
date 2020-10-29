import 'dart:async';
import 'package:auth_app/di/di_container.config.dart';
import 'package:get_it/get_it.dart';

import 'package:auth_app/auth_app.dart';
import 'package:injectable/injectable.dart';

/// Экземпляр DI контейнера
final GetIt getIt = GetIt.instance;

@InjectableInit()
Future initDi() async {
  if (!getIt.isRegistered<Router>())
    await $initGetIt(
      getIt,
      environmentFilter: NoEnvOrContains(Environment.prod),
    );
  // await $initGetIt(getIt);
}
