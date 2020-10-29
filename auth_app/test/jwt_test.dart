import 'package:auth_app/repository/jwt_generator.dart';
import 'package:corsac_jwt/corsac_jwt.dart';

import 'harness/app.dart';

void main() {
  final jwtGen = JwtGenerator();

  final token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJodHRwczovL2RhcnRzZXJ2aWNlLnJ1L2F1dGgiLCJleHAiOjE2MDQwMTQ0MjUsImRhdGEiOnsidXNlciI6InF3ZXJ0MTIzNDUifX0.Kk2zENLb8OfuUkzdF4nymzyomxK9uqAM_nZ_TzC5Y1tqD1MMYZbAF50IAiESdsjkDCSsH78yZZBobOjaQwAAIP3E3XNwbq9ComTvR5ng4lwmyQk3uAE_I93cijs36E88X7pnYDfrhzbTzkrYqcMJTuHyGZ9njdRXfJ-O5OzjACOOsujJU3kMA8oqo8x6vnczaCAWK9oFejjtCRghVpqmKtiNKBTM8xU78hhqHDPsfgluuL3yaNT4sGDmaZT8mzNv4y4U2zSj4dhRCXaquo1NPLAkjtqhHawIsXIJAV-ktFV9OvrfGGYQkpToMHOfDauKFqeCGr5Z0FA_nKCja25s_w';

  createJwt(jwtGen);
  readJwt(jwtGen, token);
}

void createJwt(JwtGenerator generator) {
  test('create JWTs', () {
    final token = generator.createJwts('qwert12345', const Duration(hours: 1));
    print(token);
    expect(token != null, true);
  });
}

void readJwt(JwtGenerator generator, String token) {
  test('read JWTs', () async {
    final decoded = JWT.parse(token);
    final signer = JWTRsaSha256Signer(publicKey: JwtGenerator.publicKey);
    print(decoded);
    print(decoded.claims);
    print(DateTime.fromMillisecondsSinceEpoch(decoded.expiresAt * 1000)
        .toString());
    expect(decoded.verify(signer), true);
  });
}
