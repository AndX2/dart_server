import 'package:auth_app/domain/refresh_token.dart';
import 'package:auth_app/domain/user.dart';
import 'package:auth_app/repository/credential/credential_repository.dart';
import 'package:auth_app/repository/jwt/jwt_generator.dart';
import 'package:auth_app/repository/state_generator.dart';
import 'package:auth_app/service/env_service.dart';
import 'package:injectable/injectable.dart';

const _badCsrfDelay = Duration(seconds: 5);
const _badRefreshDelay = Duration(seconds: 5);
const _refreshTokenLifeTime = Duration(days: 90);

@singleton
class CredentionalService {
  final EnvironmentService _environmentService;
  final CredentialRepository _credentialRepository;
  final JwtGenerator _jwtGenerator;
  final StateGenerator _stateGenerator;

  CredentionalService(
    this._environmentService,
    this._credentialRepository,
    this._jwtGenerator,
    this._stateGenerator,
  );

  Future<TokenPair> createTokenPair(User user) async {
    final refreshTokenValue = _stateGenerator.cryptoUuid;
    final refresh =
        await _credentialRepository.saveRefreshToken(user, refreshTokenValue);
    final jwtExpire = Duration(
        seconds: int.parse(
            _environmentService.getEnvironment('JWT_EXPIRE') ?? '3600'));
    final jwt = _jwtGenerator.createJwts(user.extId, jwtExpire);
    return TokenPair(refresh, jwt);
  }

  Future<TokenPair> refreshTokenPair(
    String refresh,
    String csrf,
    String csrfHeader,
  ) async {
    if (refresh == null || csrf == null || csrfHeader == null) {
      await Future.delayed(_badCsrfDelay);
      throw Exception('Отсутствует необходимый токен');
    }
    if (csrf != csrfHeader) {
      await Future.delayed(_badCsrfDelay);
      throw Exception('Несоответствие CSRF токена');
    }
    final existRefresh = await _credentialRepository
        .removeRefreshTokenByValue(refresh)
        .catchError((e) {
      throw Exception('Refresh токен не найден');
    });
    if (existRefresh == null) {
      await Future.delayed(_badRefreshDelay);
      throw Exception('Refresh токен не найден');
    }
    final refreshIsActive =
        existRefresh.created.add(_refreshTokenLifeTime).isAfter(DateTime.now());
    if (!refreshIsActive) {
      throw Exception('Срок действия Refresh токена истек');
    }
    final tokenPair = createTokenPair(existRefresh.user);
    return tokenPair;
  }

  String generateCsrf() {
    return _stateGenerator.cryptoUuid;
  }

  int get refreshTokenExpireTime => int.parse(
      _environmentService.getEnvironment('REFRESH_EXPIRE') ?? '7700000');
}
