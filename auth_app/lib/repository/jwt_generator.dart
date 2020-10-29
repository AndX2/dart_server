import 'package:corsac_jwt/corsac_jwt.dart';
import 'package:injectable/injectable.dart';

@injectable
class JwtGenerator {
  static const privateKey = '''-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEA+5dl3SpSs4hOcMJ7TybJ2EVpVWs2RyCMzzl3/X2qT0RX0HHM
4lRea/jMv2me0Q94D0Df5EmqudT2fvUPEIJ75zfAxNnYEuY2D8RRUn1P5Eo/Ohvg
IdGm0ksK6WJEHNISa3N2Wdzp9kc54dTIZ5fFJC7HwtQr7pj8+xV4WYlxReqX5LsH
5fNXsxVZcrouRntOqotUZ04LqrXZrUBQ4lMut9QsLbNojaijzdTrYlzM0wTT86/a
wF34p7wvNCU4A/uClAssyeL0Ts4iOESKFjUnyv+oa2MlqK7KplvY1C6cr6g465C2
jExRNx2JmSMNOO3F9W+aq6htCCdNtbKJa8baTwIDAQABAoIBAEwMjYv22RzPnPZU
szVPwj+Pa7GYQMXrPuT8uBp1u99OB0VIwOfBHPGCOVG6uXj0NhRWRdcZtXOKvh/O
L4mMB6vynGBkgP3lfH3zl6lZm6akEsyb1Hokh0qVyGyXeYNEtLCqLCIptsbs7MAo
s5Msuzies19fBxCOShoTeVeHRigdkfLZSKmeJwaQSCIyVfA8nrRGfXVeULMxBGu+
9Ar9qV/0jut+4DRft2tBxv/eQSxiapF2N0zDtWWw91Ulzd4blPavojVYh/c2L5ia
AI9c/L7pkN0aHQOisWz7g+9LeKvtzkFmL44cPTZOH3gcaF4i80VwFxs0eJBHb547
0B/q3YECgYEA/oFcFXEBukPmnXo9bOwoG8RJ3+sZCIoHhDlje2x4TBZJJ4eIWApb
zbx5Q/zcxosf2yfbT6RZNr1iyYo8G7XPktLyc0V282W0cL8h9SdeUxjJXzaLlb65
F4hVLFOuUT40sogX/LUpdRm1iP7wZ4jOYkMSjugTQn0PH8dM4j+loe8CgYEA/RGo
QFf13wVhQNYbUN2c8ycczzsNrKemZ3uf11Jss3fHC8ghw5SXgbIGNIskDXvFjqZy
jZqSNT72eRkb9iH1AD2CXqG4nl1nPslQKITneVVe8aIUF0UsJHrgfPYoXl6uZhDq
TgJNBcvzIbu4mTKS5pluRyPqGPwKGE2EGCwrLaECgYA0MFSwtOa0yn285zc3Ycnr
v7miaDRO8vcNnzMOOTUF7T/9EibcXutqae64CV9Ae4EB0M+BKmN8/SMHzwf6arLx
Gb7L8n+s87snr5oICpWmFpwcoTPIdj7AW52TpGlHkaj+vzekA4ZH1AjM2fJ0WLJx
pe1lTqO8a6axTo4uivytEwKBgQCo45TOxCURXozF8V2vfQaWe37NihKZLBVwsF8/
GwHyT7hl0309AjiOVJmxjT5VRUnV5p1ChWqX4Foq/Sfc/lJ8g5AyyWjlP15812sI
b5HvNpszVUBlO0O3YM3ad4j/Wd63vQgxYXW3raGn3JjYnJjPDow7K+u6GtI939WN
METsoQKBgBRxkOze+B/WWLcwT46m/UxdZ3OujAdl0X3WBpJUL/LkomIdlbzEcg93
GsrGxIAOTEXM0UlQ5aYpykpGZ7B1576KRvYpEOQ8BfCtX7g4zTDIyXvSCcNclw7G
9NBnhECchI/Yqgwk/6/2ze/DG1XoxR3412XTxDWL3vOG7fVfOTwm
-----END RSA PRIVATE KEY-----
''';
  static const publicKey = '''-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA+5dl3SpSs4hOcMJ7TybJ
2EVpVWs2RyCMzzl3/X2qT0RX0HHM4lRea/jMv2me0Q94D0Df5EmqudT2fvUPEIJ7
5zfAxNnYEuY2D8RRUn1P5Eo/OhvgIdGm0ksK6WJEHNISa3N2Wdzp9kc54dTIZ5fF
JC7HwtQr7pj8+xV4WYlxReqX5LsH5fNXsxVZcrouRntOqotUZ04LqrXZrUBQ4lMu
t9QsLbNojaijzdTrYlzM0wTT86/awF34p7wvNCU4A/uClAssyeL0Ts4iOESKFjUn
yv+oa2MlqK7KplvY1C6cr6g465C2jExRNx2JmSMNOO3F9W+aq6htCCdNtbKJa8ba
TwIDAQAB
-----END PUBLIC KEY-----''';
  String createJwts(String userExtId, Duration estimate) {
    final builder = JWTBuilder();
    final rowToken = builder
      ..issuer = 'https://dartservice.ru/auth'
      ..expiresAt = DateTime.now().add(estimate)
      ..setClaim('data', {'user': userExtId})
      ..getToken();
    final signer = JWTRsaSha256Signer(privateKey: privateKey);
    final token = rowToken.getSignedToken(signer);
    return token.toString();
  }
}
