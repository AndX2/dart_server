import 'package:auth_app/repository/state_generator.dart';
import 'package:benchmark_harness/benchmark_harness.dart';

void main() {
  UuidGenerateBenchmark.main();
}

class UuidGenerateBenchmark extends BenchmarkBase {
  final uuid = StateGenerator();
  final count = 30000;
  final listId1 = <String>[];

  UuidGenerateBenchmark() : super("UuidGenerate");

  static void main() {
    UuidGenerateBenchmark().report();
  }

  // Not measured setup code executed prior to the benchmark runs.
  @override
  void setup() {}

  @override
  void warmup() {
    super.warmup();
    run();
  }

  // The benchmark code.
  @override
  void run() {
    // listId.add(uuid.cryptoUuid);
    listId1.add(uuid.uuid);
  }

  @override
  void exercise() {
    int i = 0;
    while (i <= count) {
      i++;
      run();
    }
  }

  // Not measures teardown code executed after the benchark runs.
  @override
  void teardown() {
    print('generate ${listId1.length} uuid');
    print('0: ${listId1.first}, last: ${listId1.last}');
  }
}
