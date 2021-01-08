import 'package:auth_app/provider/oauth_provider.dart';
import 'package:auth_app/provider/vk/vk_provider.dart';
import 'package:auth_app/service/cred_service.dart';
import 'package:auth_app/service/login_service.dart';
import 'package:auth_app/service/oauth_provider_factory.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

import '../di_test.dart';

@Injectable(
  as: OauthProviderFactory,
  env: [Environment.test],
)
class OauthProviderFactoryMock implements OauthProviderFactory {
  final LoginService _loginService;
  final CredentionalService _credentionalService;

  @override
  final List<OAuthProvider> providerList = [];

  OauthProviderFactoryMock(
    this._loginService,
    this._credentionalService,
  ) {
    _init();
  }

  void _init() {
    providerList.add(
      VkAuthProvider(
        testGetIt.get<Dio>(),
        _loginService,
        _credentionalService,
        '7526022',
        '',
        VkConst.oauthUrl,
        VkConst.loginPath,
        VkConst.redirectUrl,
        VkConst.getUserPath,
        VkConst.successAuthWebRedirectUrl,
      ),
    );
  }
}
