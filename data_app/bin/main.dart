import 'package:data_app/data_app.dart';

Future main() async {
  /// Создаем экземпляр приложения Aqueduct из [DataAppChannel]
  final app = Application<DataAppChannel>()
      /// копирум настройки из файла config.yaml и назначаем порт 8888
      ..options.configurationFilePath = "config.yaml"
      ..options.port = 8888;

  /// Здесь узнаем сколько ядер у процессора системы и
  final count = Platform.numberOfProcessors ~/ 2;
  /// запускаем приложение в нескольких экземплярах, число которых 
  /// вдвое меньше числа ядер процессора, но не менее чем 1.
  await app.start(numberOfInstances: count > 0 ? count : 1);

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}

