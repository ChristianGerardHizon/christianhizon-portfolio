import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/core/models/pb_record.dart';

part 'system_artifact.mapper.dart';

@MappableClass()
class SystemArtifact with SystemArtifactMappable {
  SystemArtifact({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  static fromMap(Map<String, dynamic> raw) {
    return SystemArtifactMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = SystemArtifactMapper.fromJson;
}
