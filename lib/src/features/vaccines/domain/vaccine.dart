import 'package:dart_mappable/dart_mappable.dart';

part 'vaccine.mapper.dart';

@MappableClass()
class Vaccine with VaccineMappable {
  final String id;

  final String name;
  final String? icon;

  final DateTime? created;
  final DateTime? updated;

  static const fromMap = VaccineMapper.fromMap;
  static const fromJson = VaccineMapper.fromMap;

  Vaccine({
    required this.id,
    required this.name,
    required this.icon,
    required this.created,
    required this.updated,
  });

  static Vaccine customFromMap(Map<String, dynamic> raw) {
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
