import 'package:auth_app/auth_app.dart';

class State extends ManagedObject<_State> implements _State {
  @override
  void willInsert() {
    created = DateTime.now();
    super.willInsert();
  }
}

class _State {
  @primaryKey
  int key;

  @Column()
  String value;

  @Column()
  DateTime created;
}
