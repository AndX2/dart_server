import 'package:auth_app/auth_app.dart';
import 'package:auth_app/domain/user_auth_stamp.dart';

/// Интерфейс oAuth провайдера
abstract class OAuthProvider {
  ///providerName VK
  String get name;

  ///client_id=7526022
  String get partnerId;

  ///client_id_env_key
  String get partnerIdEnvKey;

  ///client_secret=oBin35EGNBqYmD2HsgDM
  String get partnerSecret;

  ///client_secret_env_key=oBin35EGNBqYmD2HsgDM
  String get partnerSecretEnvKey;

  ///https://oauth.vk.com/authorize?client_id=7526022&display=popup&redirect_uri=http://dartservice.ru/auth/vk/redirect&scope=email&response_type=code&v=5.122&state=72929426-8dfe-4a99-a081-583d1eb42226
  String getloginUrl(String state);

  ///redirect_uri=http://dartservice.ru/auth/vk/redirect
  String get serviceRedirectUrl;

  /// Метод контроллера, получающий редирект провайдера об успешной аутентификации клиента
  Future<Response> redirectHandler(Request request);

  /// Метод для получения данных об авторизовавшемся клиенте
  Future<UserAuthStamp> getUserAuthStamp(String code, String state);

  ///redirect_uri=http://dartservice.ru/#/vk/auth?result=true
  String get successClientRedirectUrl;
}
