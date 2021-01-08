import 'package:auth_app/auth_app.dart';
import 'package:dotenv/dotenv.dart' as dotenv;

Future main() async {
  dotenv.load('../env/auth_app.env');
  dotenv.env['DB_PORT'] = '5433';
  dotenv.env['DB_HOST'] = 'localhost';
  dotenv.env['POSTGRES_DB'] = 'auth_app';
  final app = Application<AuthAppChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"))
    ..options.port = 8888;

  await app.startOnCurrentIsolate();

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
