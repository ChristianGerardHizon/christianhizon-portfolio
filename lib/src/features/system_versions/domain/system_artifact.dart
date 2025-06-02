import 'package:dart_mappable/dart_mappable.dart';

part 'system_artifact.mapper.dart';

@MappableClass()
class SystemArtifact with SystemArtifactMappable {
  SystemArtifact({
    required this.name,
    required this.url,
    required this.type,
     this.version,
     this.versionCode,
  });

  final String name;
  final String url;
  final String type;
  final String? version;
  final String? versionCode;

  static fromMap(Map<String, dynamic> raw) {
    return SystemArtifactMapper.fromMap({
      ...raw,
    });
  }

  String get display {
    if (version == null || versionCode == null) {
      return name;
    }
    return '$name - $version+$versionCode';
  }

  static const fromJson = SystemArtifactMapper.fromJson;
}
