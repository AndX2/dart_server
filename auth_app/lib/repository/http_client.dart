import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterHttpClient {
  Dio createhttpClient() {
    final options = BaseOptions(
      connectTimeout: 1000,
      receiveTimeout: 1000,
      sendTimeout: 1000,
    );
    return Dio(options);
  }
}
