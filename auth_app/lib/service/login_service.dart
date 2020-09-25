import 'dart:async';
import 'package:auth_app/domain/state.dart';
import 'package:auth_app/repository/login/login_repository.dart';
import 'package:auth_app/repository/state_generator.dart';
import 'package:injectable/injectable.dart';

@singleton
class LoginService {
  final LoginRepository _loginRepository;
  final StateGenerator _stateGenerator;
  LoginService(
    this._loginRepository,
    this._stateGenerator,
  );

  Future<String> generateLoginState() async {
    final value = _stateGenerator.cryptoUuid;
    await _loginRepository.addState(State()..value = value);
    return value;
  }
}
