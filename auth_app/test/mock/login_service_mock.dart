import 'dart:async';

import 'package:auth_app/domain/user.dart';
import 'package:auth_app/domain/user_auth_stamp.dart';
import 'package:auth_app/domain/state.dart';
import 'package:auth_app/provider/oauth_provider.dart';
import 'package:auth_app/repository/state_generator.dart';
import 'package:auth_app/service/login_service.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: LoginService, env: [Environment.test])
class LoginServiceMock implements LoginService {
  final StateGenerator _stateGenerator;

  LoginServiceMock(this._stateGenerator);

  final List<State> _stateList = <State>[];
  final List<UserAuthStamp> _savedAuthStampList = <UserAuthStamp>[];

  @override
  Future<String> generateLoginState() async {
    final value = _stateGenerator.cryptoUuid;
    _stateList.add(
      State()
        ..value = value
        ..created = DateTime.now(),
    );
    return value;
  }

  @override
  Future<UserAuthStamp> saveAuthStamp(UserAuthStamp stamp) async {
    stamp.id = '123456';
    _savedAuthStampList.add(stamp);
    return stamp;
  }

  @override
  Future<State> validateState(String state) async {
    _stateList.add(
      State()
        ..value = '72929426-8dfe-4a99-a081-583d1eb42226'
        ..created = DateTime.now(),
    );
    final expect = _stateList.firstWhere((item) => item.value == state);
    if (expect == null) {
      throw Exception();
    }
    return expect;
  }

  @override
  Future<User> getUserAuthStamp(
    OAuthProvider provider,
    String code,
    String state,
  ) async {
    return User()
      ..id = 54321
      ..created = DateTime.now();
  }
}
