import 'package:dart_mappable/dart_mappable.dart';

part 'treatment.mapper.dart';

@MappableClass()
class Treatment with TreatmentMappable {
  final String id;

  final String name;
  final String? icon;

  final DateTime? created;
  final DateTime? updated;

  static const fromMap = TreatmentMapper.fromMap;
  static const fromJson = TreatmentMapper.fromMap;

  Treatment({
    required this.id,
    required this.name,
    required this.icon,
    required this.created,
    required this.updated,
  });

  static Treatment customFromMap(Map<String, dynamic> raw) {
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
