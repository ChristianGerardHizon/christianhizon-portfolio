import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_object.dart';

part 'treatment.mapper.dart';

@MappableClass()
class Treatment extends PbObject with TreatmentMappable {
  final String name;
  final String? icon;

  Treatment({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.name,
    this.icon,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return TreatmentMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = TreatmentMapper.fromJson;
}
