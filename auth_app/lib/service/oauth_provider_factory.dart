import 'package:auth_app/di/di_container.dart';
import 'package:auth_app/provider/oauth_provider.dart';
import 'package:auth_app/provider/vk/vk_provider.dart';
import 'package:auth_app/service/env_service.dart';
import 'package:auth_app/service/login_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

class VkConst {
  static const partnerIdEnvKey = 'VK_PARTNER_ID';
  static const partnerSecretEnvKey = 'VK_PARTNER_SECRET';
  static const oauthUrl = 'oauth.vk.com';
  static const loginPath = '/authorize';
  static const redirectUrl = 'http://dartservice.ru/auth/vk/redirect';
  static const getUserPath = '/access_token';
  static const successAuthWebRedirectUrl =
      'http://dartservice.ru/#/vk/auth?result=true';
}

@Injectable(env: [Environment.prod])
class OauthProviderFactory {
  final EnvironmentService _environmentService;
  final LoginService _loginService;

  final List<OAuthProvider> providerList = [];

  OauthProviderFactory(
    this._environmentService,
    this._loginService,
  ) {
    _init();
  }

  void _init() {
    providerList.add(
      VkAuthProvider(
        getIt.get<Dio>(),
        _loginService,
        _environmentService.getEnvironment(VkConst.partnerIdEnvKey),
        _environmentService.getEnvironment(VkConst.partnerSecretEnvKey),
        VkConst.oauthUrl,
        VkConst.loginPath,
        VkConst.redirectUrl,
        VkConst.getUserPath,
        VkConst.successAuthWebRedirectUrl,
      ),
    );
  }
}
