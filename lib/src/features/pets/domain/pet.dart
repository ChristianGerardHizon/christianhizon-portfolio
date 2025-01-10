import 'package:dart_mappable/dart_mappable.dart';

part 'pet.mapper.dart';

@MappableClass()
class Pet with PetMappable {
  final String id;

  final String name;
  final List<String> images;

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

  Pet({
    required this.id,
    this.name = '',
    this.images = const [],
    this.owner,
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

  static const fromMap = PetMapper.fromMap;
  static const fromJson = PetMapper.fromMap;
  
  static Pet customFromMap(Map<String, dynamic> raw) {
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
