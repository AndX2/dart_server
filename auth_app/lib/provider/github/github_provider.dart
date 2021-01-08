import 'package:aqueduct/src/http/request.dart';
import 'package:aqueduct/src/http/response.dart';
import 'package:auth_app/auth_app.dart';
import 'package:auth_app/domain/user_auth_stamp.dart';
import 'package:auth_app/provider/github/github_access_token_response.dart';
import 'package:auth_app/provider/github/github_user_auth_stamp_response.dart';
import 'package:auth_app/provider/oauth_provider.dart';
import 'package:auth_app/service/cred_service.dart';
import 'package:auth_app/service/login_service.dart';
import 'package:dio/dio.dart' hide Response;

class GithubAuthProvider extends OAuthProvider {
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

  GithubAuthProvider(
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
  String get name => 'github';

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
  @Operation.get()
  Future<UserAuthStamp> getUserAuthStamp(String code, String state) async {
    final urlAccessToken = Uri.https(_oauthUrl, _getUserPath).toString();
    final accessToken = await _httpClient
        .post(urlAccessToken,
            queryParameters: {
              'code': code,
              'client_id': partnerId,
              'client_secret': partnerSecret,
            },
            options: Options(responseType: ResponseType.json))
        .then((response) =>
            GithubAccessTokenResponse.fromJson(response.data).transform())
        .catchError((e) {
      throw Exception(e.toString());
    });
    final urlUser = Uri.https('api.github.com', '/user').toString();
    final authStamp = await _httpClient
        .get(urlUser,
            options: Options(
                headers: {'Authorization': 'token $accessToken'},
                responseType: ResponseType.json))
        .then((response) =>
            GithubUserAuthStampResponse.fromJson(response.data).transform())
        .catchError((e) {
      throw Exception(e.toString());
    });
    authStamp.accessToken = accessToken;
    return authStamp;
  }

  @override
  Future<Response> redirectHandler(Request request) async {
    final params = request.raw.uri.queryParameters;
    final state = params['state'];
    final code = params['code'];
    await _loginService.validateState(state);
    final user =
        await _loginService.getUserAuthStamp(this, code, state).catchError((e) {
      throw Response.badRequest(body: e.toString());
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

  String _buildLoginUrl(String state) => Uri.https(
        _oauthUrl,
        _loginPath,
        {
          'client_id': partnerId,
          'redirect_uri': serviceRedirectUrl,
          'state': state
        },
      ).toString();
}
