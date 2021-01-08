import 'package:corsac_jwt/corsac_jwt.dart';

class JwtGenerator {
  final String privateKey;
  final String publicKey;
  JwtGenerator(this.privateKey, this.publicKey);

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
