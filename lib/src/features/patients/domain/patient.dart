import 'package:dart_mappable/dart_mappable.dart';

part 'patient.mapper.dart';

@MappableClass()
class Patient {
  final String id;

  final String name;

  Patient({required this.id, this.name = ''});

  static const fromMap = PatientMapper.fromMap;
  static const fromJson = PatientMapper.fromMap;
}
