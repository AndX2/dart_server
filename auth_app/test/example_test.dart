import 'package:auth_app/repository/state_generator.dart';

import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  testActuatorReject(harness);

  group(
    "Controller test",
    () {
      testActuatorReject(harness);
    },
  );

  test(
    "UUID repeat",
    () {
      final uuid = StateGenerator();
      const count = 30000;
      final timer = Stopwatch()..start();
      final listId = List.generate(count, (index) {
        // final id = uuid.cryptoUuid;
        final id = uuid.uuid;
        return id;
      });
      timer.stop();
      print('generated $count items by ${timer.elapsed.inMilliseconds} sec');
      var repeatable = false;
      listId.forEach((element) {
        final index = listId.indexOf(element);
        final last = listId.lastIndexOf(element);
        if (index != last) repeatable = true;
      });
      print('0: ${listId[0]}, 1: ${listId[1]}');
      expect(repeatable, false, reason: 'uuid.v4() is repeatable');
    },
  );
}

void testActuatorReject(Harness harness) {
  test(
    "GET /actuator returns 401 body: null",
    () async {
      final response = expectResponse(
        await harness.agent.get(
          "/actuator",
        ),
        401,
        body: null,
        // body: {'key': 'value'},
      );
      print(response);
    },
  );
}
