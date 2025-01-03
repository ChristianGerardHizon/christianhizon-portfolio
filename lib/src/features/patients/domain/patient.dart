import 'package:dart_mappable/dart_mappable.dart';

part 'patient.mapper.dart';

@MappableClass()
class Patient with PatientMappable {
  final String id;

  final String name;
  final DateTime created;
  final DateTime updated;

  Patient({
    required this.id,
    this.name = '',
    required this.created,
    required this.updated,
  });

  static const fromMap = PatientMapper.fromMap;
  static const fromJson = PatientMapper.fromMap;
}
