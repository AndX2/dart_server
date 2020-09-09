import 'dart:async';

import 'package:data_app/domain/stub_setting.dart';
import 'package:data_app/repository/stub_setting/stub_setting_repository.dart';

/// Серсис для добавления и получения настроек страницы-заглушки
class StubSettingService {
  final StubSettingRepository _settingRepository;

  StubSettingService(this._settingRepository);

  Future<StubSetting> getSetting() async {
    final setting = await _settingRepository.getLastStubSetting();
    if (setting == null) {
      final newSetting = await addSetting(StubSetting()
        ..releaseDate = DateTime(2020, 10, 1)
        ..startDate = DateTime(2020, 7, 1));
      return newSetting;
    }
    return setting;
  }

  Future<StubSetting> addSetting(StubSetting setting) async {
    return _settingRepository.createStubSetting(setting);
  }
}
