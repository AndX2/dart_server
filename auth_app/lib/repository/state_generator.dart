import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

@injectable
class StateGenerator {
  final _uuid = Uuid();
  final _cryptoUuid = Uuid(options: {'grng': UuidUtil.cryptoRNG});

  String get uuid => _uuid.v4();
  String get cryptoUuid => _cryptoUuid.v4();
  String call() => uuid;
}
