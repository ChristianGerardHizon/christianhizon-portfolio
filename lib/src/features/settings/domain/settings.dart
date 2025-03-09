import 'package:dart_mappable/dart_mappable.dart';

part 'settings.mapper.dart';

@MappableClass()
class Settings with SettingsMappable {
  const Settings();

  static const fromMap = SettingsMapper.fromMap;
  static const fromJson = SettingsMapper.fromJson;
}
