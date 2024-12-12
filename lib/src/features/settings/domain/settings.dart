import 'package:dart_mappable/dart_mappable.dart';

part 'settings.mapper.dart';


@MappableClass()
class Settings with SettingsMappable {
  final String domain;

  const Settings({required this.domain});

  static const fromMap = SettingsMapper.fromMap;
  static const fromJson = SettingsMapper.fromJson;

}
