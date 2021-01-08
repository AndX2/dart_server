import 'dart:async';
import 'package:auth_app/auth_app.dart';
import 'package:auth_app/domain/user_auth_stamp.dart';
import 'package:aqueduct/src/http/response.dart';
import 'package:auth_app/provider/oauth_provider.dart';
import 'package:auth_app/provider/vk/vk_user_auth_stamp_response.dart';
import 'package:auth_app/service/cred_service.dart';
import 'package:auth_app/service/login_service.dart';
import 'package:dio/dio.dart' hide Response;

class VkAuthProvider implements OAuthProvider {
  final Dio _httpClient;
  final LoginService _loginService;
  final CredentionalService _credentionalService;
  final String _partnerId;
  final String _partnerSecret;
  final String _oauthUrl;
  final String _loginPath;
  final String _redirectUrl;
  final String _getUserPath;
  final String _successAuthWebRedirectUrl;

  VkAuthProvider(
    this._httpClient,
    this._loginService,
    this._credentionalService,
    this._partnerId,
    this._partnerSecret,
    this._oauthUrl,
    this._loginPath,
    this._redirectUrl,
    this._getUserPath,
    this._successAuthWebRedirectUrl,
  );

  @override
  String get name => 'vk';

  @override
  String get partnerId => _partnerId;

  @override
  String get partnerSecret => _partnerSecret;

  @override
  String get serviceRedirectUrl => _redirectUrl;

  @override
  String get successClientRedirectUrl => _successAuthWebRedirectUrl;

  @override
  @Operation.get()
  Future<Response> redirectHandler(Request request) async {
    final params = request.raw.uri.queryParameters;
    final state = params['state'];
    final code = params['code'];
    await _loginService.validateState(state);
    final user =
        await _loginService.getUserAuthStamp(this, code, state).catchError((e) {
      throw Exception(e.toString());
    });

    final tokenPair = await _credentionalService.createTokenPair(user);

    final refreshCookie = Cookie('refresh', tokenPair.refreshToken.value);
    refreshCookie.httpOnly = true;
    // refreshCookie.secure = true;
    refreshCookie.path = '/auth';
    refreshCookie.maxAge = _credentionalService.refreshTokenExpireTime;

    final csrfCookie = Cookie('csrf', _credentionalService.generateCsrf());
    csrfCookie.httpOnly = false;
    // csrfCookie.secure = true;

    return Response(
      303,
      {
        'Location': successClientRedirectUrl,
        'Set-Cookie': [refreshCookie, csrfCookie],
        'Authorization': tokenPair.accessToken,
      },
      null,
    );
  }

  @override
  @Operation.get()
  Future<Response> getLoginUrl(Request request) async {
    final state = await _loginService.generateLoginState();
    final loginUrl = _buildLoginUrl(state);
    return Response(
      303,
      {'Location': loginUrl},
      null,
    );
  }

  @override
  Future<UserAuthStamp> getUserAuthStamp(String code, String state) async {
    final url = Uri.https(_oauthUrl, _getUserPath).toString();
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
        )
        .catchError((e) {
      throw Exception(e.toString());
    });
    ;
    return authStamp
      ..provider = name
      ..state = state;
  }

  String _buildLoginUrl(String state) => Uri.https(
        _oauthUrl,
        _loginPath,
        {
          'client_id': partnerId,
          'display': 'popup',
          'redirect_uri': serviceRedirectUrl,
          'scope': 'email',
          'response_type': 'code',
          'v': '5.122',
          'state': state
        },
      ).toString();
}
