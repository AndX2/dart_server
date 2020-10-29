import 'package:auth_app/auth_app.dart';
import 'package:auth_app/domain/user.dart';

class RefreshToken extends ManagedObject<_RefreshToken>
    implements _RefreshToken {
  @override
  void willInsert() {
    created = DateTime.now();
    super.willInsert();
  }

  @override
  Map<String, dynamic> asMap() {
    return {'value': value};
  }
}

@Table(name: 'refresh_token')
class _RefreshToken {
  @primaryKey
  int id;

  @Column(indexed: true)
  String value;

  @Column(indexed: true)
  DateTime created;

  @Relate(
    #tokenList,
    isRequired: true,
    onDelete: DeleteRule.cascade,
  )
  User user;
}
