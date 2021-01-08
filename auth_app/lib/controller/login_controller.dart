import 'package:auth_app/auth_app.dart';
import 'package:auth_app/service/cred_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginController extends ResourceController {
  final CredentionalService _credentionalService;

  LoginController(this._credentionalService);

  @Operation.post()
  Future<Response> refreshToken(
    @Bind.header('csrfToken') String csrfHeader,
  ) async {
    final List<Cookie> cookies = request.raw.cookies;
    final refreshToken = cookies.firstWhere(
      (cookie) => cookie.name == 'refresh',
      orElse: () => null,
    );
    final csrfToken = cookies.firstWhere(
      (cookie) => cookie.name == 'csrf',
      orElse: () => null,
    );

    final tokenPair = await _credentionalService
        .refreshTokenPair(
          refreshToken?.value,
          csrfToken?.value,
          csrfHeader,
        )
        .catchError((e) => throw Response.unauthorized(body: e.toString()));

    final refreshCookie = Cookie('refresh', tokenPair.refreshToken.value);
    refreshCookie.httpOnly = true;
    // refreshCookie.secure = true;
    // refreshCookie.path = '/auth';
    refreshCookie.maxAge = _credentionalService.refreshTokenExpireTime;

    final csrfCookie = Cookie('csrf', _credentionalService.generateCsrf());
    csrfCookie.httpOnly = false;
    // csrfCookie.secure = true;

    return Response.ok(
      null,
      headers: {
        'Set-Cookie': [refreshCookie, csrfCookie],
        'Authorization': tokenPair.accessToken,
      },
    );
  }
}
