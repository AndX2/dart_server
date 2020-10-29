import 'package:auth_app/auth_app.dart';

Future main() async {
  final app = Application<AuthAppChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"))
    ..options.port = 8888;

  await app.startOnCurrentIsolate();

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
