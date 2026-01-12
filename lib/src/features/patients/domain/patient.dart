/// Patient domain model.
class Patient {
  const Patient({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.ownerName,
    required this.ownerPhone,
    required this.age,
  });

  final String id;
  final String name;
  final String species;
  final String breed;
  final String ownerName;
  final String ownerPhone;
  final String age;
}
