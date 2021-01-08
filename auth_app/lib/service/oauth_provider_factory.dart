import 'package:auth_app/di/di_container.dart';
import 'package:auth_app/provider/github/github_provider.dart';
import 'package:auth_app/provider/oauth_provider.dart';
import 'package:auth_app/provider/vk/vk_provider.dart';
import 'package:auth_app/service/cred_service.dart';
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
      'http://dartservice.ru/#/auth/vk?result=true';
}

class GithubConst {
  static const partnerIdEnvKey = 'GITHUB_PARTNER_ID';
  static const partnerSecretEnvKey = 'GITHUB_PARTNER_SECRET';
  static const oauthUrl = 'github.com';
  static const loginPath = '/login/oauth/authorize';
  static const redirectUrl = 'http://dartservice.ru/auth/github/redirect';
  static const getUserPath = '/login/oauth/access_token';
  static const successAuthWebRedirectUrl =
      'http://dartservice.ru/#/auth/github?result=true';
}

@Injectable(env: [Environment.prod])
class OauthProviderFactory {
  final EnvironmentService _environmentService;
  final LoginService _loginService;
  final CredentionalService _credentionalService;

  final List<OAuthProvider> providerList = [];

  OauthProviderFactory(
    this._environmentService,
    this._loginService,
    this._credentionalService,
  ) {
    _init();
  }

  void _init() {
    providerList.add(
      VkAuthProvider(
        getIt.get<Dio>(),
        _loginService,
        _credentionalService,
        _environmentService.getEnvironment(VkConst.partnerIdEnvKey),
        _environmentService.getEnvironment(VkConst.partnerSecretEnvKey),
        VkConst.oauthUrl,
        VkConst.loginPath,
        VkConst.redirectUrl,
        VkConst.getUserPath,
        VkConst.successAuthWebRedirectUrl,
      ),
    );
    providerList.add(
      GithubAuthProvider(
        getIt.get<Dio>(),
        _loginService,
        _credentionalService,
        _environmentService.getEnvironment(GithubConst.partnerIdEnvKey),
        _environmentService.getEnvironment(GithubConst.partnerSecretEnvKey),
        GithubConst.oauthUrl,
        GithubConst.loginPath,
        GithubConst.redirectUrl,
        GithubConst.getUserPath,
        GithubConst.successAuthWebRedirectUrl,
      ),
    );
  }
}
