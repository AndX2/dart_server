import 'package:auth_app/auth_app.dart';
import 'package:auth_app/domain/profile.dart';
import 'package:auth_app/domain/refresh_token.dart';
import 'package:auth_app/domain/user_auth_stamp.dart';
import 'package:auth_app/repository/state_generator.dart';
import 'package:auth_app/di/di_container.dart';

class User extends ManagedObject<_User> implements _User {
  final _generator = getIt.get<StateGenerator>();

  @override
  void willInsert() {
    extId = _generator();
    created = DateTime.now();
    super.willInsert();
  }

  @override
  void willUpdate() {
    updated = DateTime.now();
    super.willUpdate();
  }

  @override
  Map<String, dynamic> asMap() {
    return super.asMap()..remove('id');
  }
}

@Table(name: 'table_user')
class _User {
  @primaryKey
  int id;

  @Column(indexed: true)
  String extId;

  @Column(indexed: true)
  DateTime created;

  @Column(indexed: true)
  DateTime updated;

  ManagedSet<UserAuthStamp> stampList;

  ManagedSet<RefreshToken> tokenList;

  Profile profile;
}
