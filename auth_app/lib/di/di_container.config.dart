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
import '../repository/http_client.dart';
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
  gh.factory<ActuatorController>(() => ActuatorController());
  gh.factory<Dio>(() => registerHttpClient.createhttpClient());
  gh.factory<EnvironmentRepository>(() => EnvironmentRepository());
  gh.factory<VkAuthProvider>(
      () => VkAuthProvider(get<EnvironmentService>(), get<Dio>()));

  // Eager singletons must be registered in the right order
  gh.singleton<EnvironmentService>(
      EnvironmentService(get<EnvironmentRepository>()));
  gh.singleton<DbHelper>(DbHelper(get<EnvironmentService>()));
  return get;
}

class _$RegisterHttpClient extends RegisterHttpClient {}
