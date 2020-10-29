import 'package:auth_app/auth_app.dart';
import 'package:auth_app/domain/user_auth_stamp.dart';

/// Интерфейс oAuth провайдера
abstract class OAuthProvider {
  ///providerName VK
  String get name;

  ///client_id=7526022
  String get partnerId;

  ///client_secret=oBin35EGNBqYmD2HsgDM
  String get partnerSecret;

  ///redirect_uri=http://dartservice.ru/auth/vk/redirect
  String get serviceRedirectUrl;

  /// Метод контроллера, получающий редирект провайдера об успешной аутентификации клиента
  Future<Response> redirectHandler(Request request);

  /// Метод контроллера, получающий редирект провайдера об успешной аутентификации клиента
  Future<Response> getLoginUrl(Request request);

  /// Метод для получения данных об авторизовавшемся клиенте
  Future<UserAuthStamp> getUserAuthStamp(String code, String state);

  ///redirect_uri=http://dartservice.ru/#/vk/auth?result=true
  String get successClientRedirectUrl;
}
