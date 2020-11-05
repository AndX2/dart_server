import '../di_test.dart';
import '../harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  setUpAll(() => initTestDi());

  group(
    "vk provider group test",
    () {
      testLoginPageRedirect(harness);
      testVkSuccessRedirect(harness);
    },
  );
}

void testLoginPageRedirect(Harness harness) {
  test(
    "GET /vk/redirect accepts temp code from VK server after user login",
    () async {
      final response = expectResponse(
        await harness.agent.get(
          "/vk/redirect",
          query: {
            'code': 'da2a89ec7c84cc847c',
            'state': '72929426-8dfe-4a99-a081-583d1eb42226'
          },
        ),
        200,
        body: null,
      );
      expect(
        response.statusCode == 200,
        true,
        reason: 'statusCode: ${response.statusCode} expect 200',
      );
      print(response);
    },
  );
}

void testVkSuccessRedirect(Harness harness) {
  test(
    "GET /vk/login redirects to VK auth",
    () async {
      final response = expectResponse(
        await harness.agent.get(
          "/vk/login",
        ),
        200,
        body: null,
      );
      expect(
        response.statusCode == 200,
        true,
        reason: 'statusCode: ${response.statusCode} expect 200',
      );
      expect(
        response.headers['server'] != null &&
            response.headers['server'].toString() == '[kittenx]',
        true,
        reason:
            'header VkLoginServer: ${response.headers['server']} expect `kittenx`',
      );
      print(response);
    },
  );
}
