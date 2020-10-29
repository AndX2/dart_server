import 'package:auth_app/auth_app.dart';
import 'package:aqueduct_test/aqueduct_test.dart';

import '../di_test.dart';

export 'package:auth_app/auth_app.dart';
export 'package:aqueduct_test/aqueduct_test.dart';
export 'package:test/test.dart';
export 'package:aqueduct/aqueduct.dart';

class Harness extends TestHarness<AuthAppChannel> {
  @override
  Future beforeStart() async {
    await initTestDi();
  }

  @override
  Future onSetUp() async {}

  @override
  Future onTearDown() async {}
}
