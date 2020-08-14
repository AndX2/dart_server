import 'package:data_app/data_app.dart';
import 'package:data_app/service/stub_setting/stub_service.dart';

/// HTTP контроллер настроек страницы-заглушки
class StubSettingController extends ResourceController {
  StubSettingController(this._settingService);

  final StubSettingService _settingService;

  @Operation.get()
  Future<Response> getSettings() async {
    final settings = await _settingService.getSetting();
    if (settings == null) {
      return Response.notFound();
    }
    return Response.ok(settings);
  }
}
