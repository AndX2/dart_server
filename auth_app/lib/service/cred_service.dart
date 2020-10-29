import 'package:auth_app/service/env_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class CredentionalService {
  final EnvironmentService _environmentService;

  CredentionalService(this._environmentService);
}
