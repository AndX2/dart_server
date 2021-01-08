import 'package:auth_app/domain/user_auth_stamp.dart';

/// Парсер ответа сервера - запрос получения данных о пользователе
class GithubUserAuthStampResponse {
  String userId;

  GithubUserAuthStampResponse.fromJson(dynamic json) {
    json = json as Map<String, dynamic>;
    userId = json['id'].toString();
  }

  UserAuthStamp transform() {
    return UserAuthStamp()..id = userId;
  }
}
