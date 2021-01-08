// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../controller/actuator_controller.dart';
import '../repository/credential/credential_repository.dart';
import '../service/cred_service.dart';
import '../service/db_helper.dart';
import '../repository/env/env_repository.dart';
import '../service/env_service.dart';
import '../repository/jwt/jwt_generator.dart';
import '../controller/login_controller.dart';
import '../repository/login/login_repository.dart';
import '../service/login_service.dart';
import '../service/oauth_provider_factory.dart';
import '../repository/http_client.dart';
import '../repository/jwt/jwt_generator_register.dart';
import '../controller/routes.dart';
import '../auth_app.dart';
import '../repository/state_generator.dart';

/// Environment names
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
  final registerJwtGenerator = _$RegisterJwtGenerator();
  final dbHelper = _$DbHelper();
  final registerRouter = _$RegisterRouter();
  gh.factory<ActuatorController>(() => ActuatorController());
  gh.factory<Dio>(() => registerHttpClient.createHttpClient());
  gh.factory<EnvironmentRepository>(() => EnvironmentRepository());
  gh.factory<JwtGenerator>(
      () => registerJwtGenerator.createGenerator(get<EnvironmentService>()));
  gh.factory<ManagedContext>(
      () => dbHelper.managedContext(get<EnvironmentService>()));
  gh.factory<StateGenerator>(() => StateGenerator());
  gh.factory<CredentialRepository>(
      () => CredentialRepository(get<ManagedContext>(), get<StateGenerator>()));
  gh.factory<LoginController>(
      () => LoginController(get<CredentionalService>()));
  gh.factory<LoginRepository>(() => LoginRepository(get<ManagedContext>()));
  gh.factory<OauthProviderFactory>(
      () => OauthProviderFactory(
            get<EnvironmentService>(),
            get<LoginService>(),
            get<CredentionalService>(),
          ),
      registerFor: {_prod});
  gh.factory<Router>(() => registerRouter.createRouter(
      get<OauthProviderFactory>(), get<LoginController>()));

  // Eager singletons must be registered in the right order
  gh.singleton<EnvironmentService>(
      EnvironmentService(get<EnvironmentRepository>()));
  gh.singleton<CredentionalService>(CredentionalService(
    get<EnvironmentService>(),
    get<CredentialRepository>(),
    get<JwtGenerator>(),
    get<StateGenerator>(),
  ));
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

class _$RegisterJwtGenerator extends RegisterJwtGenerator {}

class _$DbHelper extends DbHelper {}

class _$RegisterRouter extends RegisterRouter {}
