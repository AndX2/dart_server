import 'package:auth_app/auth_app.dart';
import 'package:auth_app/domain/refresh_token.dart';
import 'package:auth_app/domain/user.dart';
import 'package:auth_app/domain/user_auth_stamp.dart';
import 'package:auth_app/repository/state_generator.dart';
import 'package:injectable/injectable.dart';

@injectable
class CredentialRepository {
  final ManagedContext _context;
  final StateGenerator tokenGenerator;

  CredentialRepository(
    this._context,
    this.tokenGenerator,
  );

  Future<User> getUserByProviderId(
    String provider,
    String id,
  ) async {
    final query = Query<UserAuthStamp>(_context)
      ..where((stamp) => stamp.provider).equalTo(provider)
      ..where((stamp) => stamp.id).equalTo(id);
    final stamp = await query.fetchOne();
    return stamp.user;
  }

  Future<User> createUser() async {
    final query = Query<User>(_context);
    final savedUser = await query.insert();
    return savedUser;
  }

  Future<RefreshToken> removeRefreshTokenByValue(String value) async {
    final query = Query<RefreshToken>(_context)
      ..where((token) => token.value).equalTo(value)
      ..join(object: (t) => t.user);
    final existToken = await query.fetchOne();
    await query.delete();
    return existToken;
  }

  Future<RefreshToken> saveRefreshToken(User user, String token) async {
    final query = Query<RefreshToken>(_context)
      ..values.value = token
      ..values.user.id = user.id;
    return await query.insert();
  }
}
