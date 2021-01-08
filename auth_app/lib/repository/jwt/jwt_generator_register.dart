import 'package:auth_app/di/di_container.dart';
import 'package:auth_app/repository/jwt/jwt_generator.dart';
import 'package:auth_app/service/env_service.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterJwtGenerator {
  JwtGenerator createGenerator(EnvironmentService environmentService) {
    final privateKey = environmentService.getEnvironment('PRIVATE_KEY');
    final publicKey = environmentService.getEnvironment('PUBLIC_KEY');
    return JwtGenerator(privateKey, publicKey);
  }
}
