import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di_test.config.dart';

/// Экземпляр DI контейнера
final GetIt testGetIt = GetIt.instance;

@InjectableInit(
  generateForDir: ['lib', 'test'],
)
Future initTestDi() async => $initGetIt(
      testGetIt,
      environmentFilter: NoEnvOrContains(Environment.test),
    );
