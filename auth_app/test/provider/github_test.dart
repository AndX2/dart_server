import 'package:auth_app/provider/github/github_access_token_response.dart';
import 'package:test/test.dart';

void main() {
  parseAccessTokenResponse();
}

void parseAccessTokenResponse() {
  test('Парсинг ответа github с токеном пользователя', () {
    const response =
        'access_token=5be09a9a86aa49aec196a8950147054ee794640c&scope=&token_type=bearer';
    final token = GithubAccessTokenResponse.fromJson(response).transform();
    expect(token == '5be09a9a86aa49aec196a8950147054ee794640c', true);
  });
}
