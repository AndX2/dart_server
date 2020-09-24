import 'package:auth_app/domain/user_auth_stamp.dart';

/// Парсер ответа сервера - запрос получения данных о пользователе
class VkUserAuthStampResponse {
  String accessToken;
  String userId;

  VkUserAuthStampResponse.fromJson(dynamic json) {
    json = json as Map<String, dynamic>;
    accessToken = json['access_token'].toString();
    userId = json['user_id'].toString();
  }

  UserAuthStamp transform() {
    return UserAuthStamp(
      accessToken: accessToken,
      id: userId,
    );
  }
}
