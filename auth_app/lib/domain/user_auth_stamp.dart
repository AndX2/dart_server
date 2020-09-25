import 'package:auth_app/auth_app.dart';

class UserAuthStamp extends ManagedObject<_UserAuthStamp>
    implements _UserAuthStamp {
  @override
  void willInsert() {
    created = DateTime.now();
    super.willInsert();
  }
}

/// Данные об аутентифиациии пользователя через сторонний сервис
@Table(name: 'user_auth_stamp')
class _UserAuthStamp {
  @primaryKey
  int key;

  /// Провайдер аутентификации пользователя
  @Column()
  String provider;

  /// ID пользователя в системе провайдера
  @Column()
  String id;

  /// Токен доступа к данным о пользователе
  @Column()
  String accessToken;

  /// Идентификатор сессии авторизации
  @Column()
  String state;

  /// Дата и время создания
  @Column()
  DateTime created;
}
