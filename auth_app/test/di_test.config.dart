// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:auth_app/controller/actuator_controller.dart';
import 'package:auth_app/repository/credential/credential_repository.dart';
import 'package:auth_app/service/cred_service.dart';
import 'package:auth_app/service/db_helper.dart';
import 'package:dio/dio.dart';
import 'package:auth_app/repository/env/env_repository.dart';
import 'package:auth_app/service/env_service.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:auth_app/repository/jwt_generator.dart';
import 'package:auth_app/repository/login/login_repository.dart';
import 'package:auth_app/service/login_service.dart';
import 'package:auth_app/service/oauth_provider_factory.dart';
import 'package:auth_app/repository/http_client.dart';
import 'package:auth_app/controller/routes.dart';
import 'package:auth_app/auth_app.dart';
import 'package:auth_app/repository/state_generator.dart';

import 'mock/login_service_mock.dart';
import 'mock/provider_factory.dart';

/// Environment names
const _test = 'test';
const _prod = 'prod';

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
  final registerRouter = _$RegisterRouter();
  gh.factory<ActuatorController>(() => ActuatorController());
  gh.factory<Dio>(() => registerHttpClient.createhttpClient());
  gh.factory<EnvironmentRepository>(() => EnvironmentRepository());
  gh.factory<JwtGenerator>(() => JwtGenerator());
  gh.factory<ManagedContext>(
      () => dbHelper.managedContext(get<EnvironmentService>()));
  gh.factory<StateGenerator>(() => StateGenerator());
  gh.factory<CredentialRepository>(
      () => CredentialRepository(get<ManagedContext>(), get<StateGenerator>()));
  gh.factory<LoginRepository>(() => LoginRepository(get<ManagedContext>()));
  gh.factory<OauthProviderFactory>(
      () => OauthProviderFactoryMock(get<LoginService>()),
      registerFor: {_test});
  gh.factory<OauthProviderFactory>(
      () =>
          OauthProviderFactory(get<EnvironmentService>(), get<LoginService>()),
      registerFor: {_prod});
  gh.factory<Router>(
      () => registerRouter.createRouter(get<OauthProviderFactory>()));

  // Eager singletons must be registered in the right order
  gh.singleton<EnvironmentService>(
      EnvironmentService(get<EnvironmentRepository>()));
  gh.singleton<CredentionalService>(
      CredentionalService(get<EnvironmentService>()));
  gh.singleton<LoginService>(LoginServiceMock(get<StateGenerator>()),
      registerFor: {_test});
  gh.singleton<LoginService>(
      LoginService(
        get<LoginRepository>(),
        get<CredentialRepository>(),
        get<StateGenerator>(),
      ),
      registerFor: {_prod});
  return get;
}

class _$RegisterHttpClient extends RegisterHttpClient {}

class _$DbHelper extends DbHelper {}

class _$RegisterRouter extends RegisterRouter {}
