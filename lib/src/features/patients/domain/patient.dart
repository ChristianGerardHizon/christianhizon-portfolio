import 'package:dart_mappable/dart_mappable.dart';

part 'patient.mapper.dart';

@MappableClass()
class Patient with PatientMappable {
  final String id;

  final String name;
  final List<String> images;

  final String? displayImage;

  final String? species;
  final String? owner;
  final String? contactNumber;
  final String? email;
  final String? address;
  final String? breed;
  final String? color;
  final String? sex;
  final DateTime? dateOfBirth;

  final DateTime? created;
  final DateTime? updated;

  Patient({
    required this.id,
    this.name = '',
    this.images = const [],
    this.owner,
    this.displayImage,
    this.species,
    this.breed,
    this.sex,
    this.color,
    this.contactNumber,
    this.email,
    this.address,
    this.dateOfBirth,
    this.created,
    this.updated,
  });

  static const fromMap = PatientMapper.fromMap;
  static const fromJson = PatientMapper.fromMap;

  Map<String,dynamic> toForm() {
    return {
      ...toMap(),
      'dateOfBirth': dateOfBirth,
      'created': created,
      'updated': created,
    };
  }

  static Patient customFromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    final dateOfBirth = raw['dateOfBirth'];
    final updatedDateOfBirth = dateOfBirth == '' ? null : dateOfBirth;
    return fromMap(
      {
        ...raw,
        'dateOfBirth': updatedDateOfBirth,
      },
    );
  }
}
