import 'package:auth_app/auth_app.dart';
import 'package:auth_app/domain/user.dart';

class Profile extends ManagedObject<_Profile> implements _Profile {
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

@Table(name: 'profile')
class _Profile {
  @primaryKey
  int id;

  @Column()
  String name;

  @Column(indexed: true)
  DateTime updated;

  @Relate(
    #profile,
    isRequired: true,
    onDelete: DeleteRule.cascade,
  )
  User user;
}
