import 'dart:async';
import 'package:auth_app/auth_app.dart';
import 'package:auth_app/domain/user_auth_stamp.dart';
import 'package:aqueduct/src/http/response.dart';
import 'package:auth_app/provider/oauth_provider.dart';
import 'package:auth_app/provider/vk/vk_user_auth_stamp_response.dart';
import 'package:auth_app/service/env_service.dart';
import 'package:dio/dio.dart' hide Response;
import 'package:injectable/injectable.dart';

const _partnerIdEnvKey = 'VK_PARTNER_ID';
const _partnerSecretEnvKey = 'VK_PARTNER_SECRET';
const _oauthUrl = 'https://oauth.vk.com';
const _loginPath = '/authorize';
const _redirectUrl = 'http://dartservice.ru/auth/vk/redirect';
const _getUserPath = '/access_token';
const _successAuthWebRedirectUrl =
    'http://dartservice.ru/#/vk/auth?result=true';

@injectable
class VkAuthProvider implements OAuthProvider {
  final EnvironmentService _environmentService;
  final Dio _httpClient;

  VkAuthProvider(
    this._environmentService,
    this._httpClient,
  );

  @override
  Future<UserAuthStamp> getUserAuthStamp(String code, String state) async {
    const url = '$_oauthUrl$_getUserPath';
    final authStamp = await _httpClient
        .get(url,
            queryParameters: {
              'client_id': partnerId,
              'client_secret': partnerSecret,
              'redirect_uri': serviceRedirectUrl,
              'code': code,
            },
            options: Options(responseType: ResponseType.json))
        .then(
          (response) =>
              VkUserAuthStampResponse.fromJson(response.data).transform(),
        );
    return authStamp
      ..provider = name
      ..state = state;
  }

  @override
  String getloginUrl(String state) => Uri.http(
        _oauthUrl,
        _loginPath,
        {
          'redirect_uri': serviceRedirectUrl,
          'scope': 'email',
          'response_type': 'code',
          'v': '5.122',
          'state': state
        },
      ).toString();

  @override
  String get name => 'VK';

  @override
  String get partnerId => _environmentService.getEnvironment(partnerIdEnvKey);

  @override
  String get partnerIdEnvKey => _partnerIdEnvKey;

  @override
  String get partnerSecret =>
      _environmentService.getEnvironment(partnerSecretEnvKey);

  @override
  String get partnerSecretEnvKey => _partnerSecretEnvKey;

  @override
  @Operation.get('vk/redirect')
  Future<Response> redirectHandler(Request request) async {
    final params = request.raw.uri.queryParameters;
    final state = params['state'];
    final code = params['code'];
    //TODO: проверить state по базе на предмет истечения срока действия или
    //уже использован
    if (state.isEmpty) {
      return Response.notFound();
    }
    final userStamp = await getUserAuthStamp(code, state);
    //TODO: сохранить авторизацию пользователя
    return Response.accepted();
  }

  @override
  String get serviceRedirectUrl => _redirectUrl;

  @override
  String get successClientRedirectUrl => _successAuthWebRedirectUrl;
}
