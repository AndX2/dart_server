import 'package:auth_app/auth_app.dart';
import 'package:auth_app/domain/state.dart';
import 'package:auth_app/domain/user_auth_stamp.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginRepository {
  final ManagedContext _context;

  LoginRepository(this._context);

  Future<UserAuthStamp> addUserAuthStamp(UserAuthStamp stamp) async {
    final created = _context.insertObject<UserAuthStamp>(stamp);
    return created;
  }

  Future<UserAuthStamp> getUserAuthStampByState(String state) async {
    final query = Query<UserAuthStamp>(_context)
      ..where((item) => item.state == state);
    final stamp = query.fetchOne();
    return stamp;
  }

  Future<State> addState(State state) async {
    // final created = _context.insertObject<State>(state);
    // return created;
    return state;
  }

  Future<State> getStateByValue(String value) async {
    final query = Query<State>(_context)..where((item) => item.value == value);
    final state = await query.fetchOne();
    return state;
  }
}
