import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/core/models/pb_record.dart';

part 'system_version.mapper.dart';

@MappableClass()
class SystemVersion extends PbRecord with SystemVersionMappable {
  final num buildNumber;
  final String mobileUrl;

  SystemVersion({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    super.isDeleted = false,
    super.created,
    super.updated,
    required this.buildNumber,
    required this.mobileUrl,
  });

  static fromMap(Map<String, dynamic> raw) {
    return SystemVersionMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = SystemVersionMapper.fromJson;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': updated,
    };
  }
}
