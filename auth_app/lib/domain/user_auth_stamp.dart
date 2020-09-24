import 'package:auth_app/provider/oauth_provider.dart';

/// Данные об аутентифиациии пользователя через сторонний сервис
class UserAuthStamp {
  /// Провайдер аутентификации пользователя
  final String provider;

  /// ID пользователя в системе провайдера
  final String id;

  /// Токен доступа к данным о пользователе
  final String accessToken;

  /// Идентификатор сессии авторизации
  final String state;

  UserAuthStamp({
    this.provider,
    this.id,
    this.accessToken,
    this.state,
  });

  UserAuthStamp copyWith({
    final String provider,
    String id,
    String accessToken,
    String state,
  }) {
    return UserAuthStamp(
      provider: provider ?? this.provider,
      id: id ?? this.id,
      accessToken: accessToken ?? this.accessToken,
      state: state ?? this.state,
    );
  }
}
