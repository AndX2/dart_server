import 'package:data_app/data_app.dart';

/// Представление настроек для страницы-заглушки
/// содержит два поля Дата начала разработки и Дата релиза
/// поле updated служебное, необходимо для сохранения
/// истории изменения настроек (будем использовать последнее значение)
class StubSetting extends ManagedObject<_StubSetting> implements _StubSetting {
  /// Служебный метод, здесь можно добавить сервисные действия при
  /// вставке в таблицу нового значения
  @override
  void willInsert() {
    /// Проставим время добавления записи в БД
    updated = DateTime.now();
    super.willInsert();
  }
}

@Table(name: "stub_setting")
class _StubSetting {
  @primaryKey
  int id;

  @Column(indexed: true)
  DateTime startDate;

  @Column(indexed: true)
  DateTime releaseDate;

  @Column(indexed: true)
  DateTime updated;
}
