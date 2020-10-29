import 'dart:async';
import 'package:auth_app/domain/state.dart';
import 'package:auth_app/domain/user.dart';
import 'package:auth_app/domain/user_auth_stamp.dart';
import 'package:auth_app/provider/oauth_provider.dart';
import 'package:auth_app/repository/credential/credential_repository.dart';
import 'package:auth_app/repository/login/login_repository.dart';
import 'package:auth_app/repository/state_generator.dart';
import 'package:injectable/injectable.dart';

const _badStateDelay = Duration(seconds: 25);
const _stateExpireTime = Duration(hours: 1);

@Singleton(env: [Environment.prod])
class LoginService {
  final LoginRepository _loginRepository;
  final CredentialRepository _credentialRepository;
  final StateGenerator _stateGenerator;
  LoginService(
    this._loginRepository,
    this._credentialRepository,
    this._stateGenerator,
  );

  Future<String> generateLoginState() async {
    final value = _stateGenerator.cryptoUuid;
    await _loginRepository.addState(State()..value = value);
    return value;
  }

  Future<State> validateState(String state) async {
    final exist = await _loginRepository.getStateByValue(state);
    if (exist == null) {
      await Future.delayed(_badStateDelay);
      throw Exception();
    }
    final isExpired =
        exist.created.add(_stateExpireTime).isBefore(DateTime.now());
    if (isExpired) {
      await Future.delayed(_badStateDelay);
      throw Exception();
    }
    return exist;
  }

  Future<User> getUserAuthStamp(
    OAuthProvider provider,
    String code,
    String state,
  ) async {
    final stamp = await provider.getUserAuthStamp(code, state);
    final existUser = await _credentialRepository.getUserByProviderId(
      provider.name,
      stamp.id,
    );
    if (existUser != null) {
      stamp.user = existUser;
    } else {
      final newUser = await _credentialRepository.createUser();
      stamp.user = newUser;
    }
    final savedStamp = await saveAuthStamp(stamp);
    return savedStamp.user;
  }

  Future<UserAuthStamp> saveAuthStamp(UserAuthStamp stamp) async {
    return _loginRepository.addUserAuthStamp(stamp);
  }
}
