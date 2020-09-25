// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../controller/actuator_controller.dart';
import '../service/db_helper.dart';
import '../repository/env/env_repository.dart';
import '../service/env_service.dart';
import '../repository/login/login_repository.dart';
import '../service/login_service.dart';
import '../auth_app.dart';
import '../repository/http_client.dart';
import '../repository/state_generator.dart';
import '../provider/vk/vk_provider.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final registerHttpClient = _$RegisterHttpClient();
  final dbHelper = _$DbHelper();
  gh.factory<ActuatorController>(() => ActuatorController());
  gh.factory<Dio>(() => registerHttpClient.createhttpClient());
  gh.factory<EnvironmentRepository>(() => EnvironmentRepository());
  gh.factory<ManagedContext>(
      () => dbHelper.managedContext(get<EnvironmentService>()));
  gh.factory<StateGenerator>(() => StateGenerator());
  gh.factory<VkAuthProvider>(
      () => VkAuthProvider(get<EnvironmentService>(), get<Dio>()));
  gh.factory<LoginRepository>(() => LoginRepository(get<ManagedContext>()));

  // Eager singletons must be registered in the right order
  gh.singleton<EnvironmentService>(
      EnvironmentService(get<EnvironmentRepository>()));
  gh.singleton<LoginService>(
      LoginService(get<LoginRepository>(), get<StateGenerator>()));
  return get;
}

class _$RegisterHttpClient extends RegisterHttpClient {}

class _$DbHelper extends DbHelper {}
