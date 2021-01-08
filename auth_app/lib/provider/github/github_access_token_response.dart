/// Парсер ответа сервера - запрос получения токена доступа
class GithubAccessTokenResponse {
  String accessToken;

  GithubAccessTokenResponse.fromJson(dynamic response) {
    response = (response as String)
        .split('&')
        .firstWhere((value) => value.contains('access_token'));
    accessToken = response.toString().split('=').last;
  }

  String transform() {
    return accessToken;
  }
}
