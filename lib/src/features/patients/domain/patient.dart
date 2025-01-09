import 'package:dart_mappable/dart_mappable.dart';

part 'patient.mapper.dart';

@MappableClass()
class Patient with PatientMappable {
  final String id;

  final String name;
  final List<String> images;

  final String? parent;
  final String? contactNumber;
  final String? email;
  final String? address;

  final DateTime created;
  final DateTime updated;

  Patient({
    required this.id,
    this.name = '',
    this.images = const [],
    this.parent,
    this.contactNumber,
    this.email,
    this.address,
    required this.created,
    required this.updated,
  });

  static const fromMap = PatientMapper.fromMap;
  static const fromJson = PatientMapper.fromMap;
}
