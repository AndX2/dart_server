import 'package:data_app/data_app.dart';
import 'package:data_app/domain/stub_setting.dart';

/// Репозиторий настроек страницы-заглушки
class StubSettingRepository {
  final ManagedContext _context;

  StubSettingRepository(this._context);

  /// Добавить новую запись с настройками
  Future<StubSetting> createStubSetting(StubSetting setting) async {
    final created = await _context.insertObject<StubSetting>(setting);
    return created;
  }

  /// Получить актуальный (самый новый) объект настроек
  Future<StubSetting> getLastStubSetting() async {
    final query = Query<StubSetting>(_context)
      ..sortBy((item) => item.updated, QuerySortOrder.descending);
    return query.fetchOne();
  }
}
