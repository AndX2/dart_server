import 'package:auth_app/auth_app.dart';

class State extends ManagedObject<_State> implements _State {
  @override
  void willInsert() {
    created = DateTime.now();
    super.willInsert();
  }
}

@Table(name: 'state')
class _State {
  @primaryKey
  int key;

  @Column(indexed: true)
  String value;

  @Column()
  DateTime created;
}
