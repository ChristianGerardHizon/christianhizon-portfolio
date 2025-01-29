import 'package:dart_mappable/dart_mappable.dart';

part 'staff.mapper.dart';

@MappableClass()
class Staff with StaffMappable {
  final String id;
  final String name;
  final String email;

  final DateTime? created;
  final DateTime? updated;

  Staff({
    required this.id,
    this.name = '',
    this.email = '',
    this.created,
    this.updated,
  });

  static const fromMap = StaffMapper.fromMap;
  static const fromJson = StaffMapper.fromMap;

  static Staff customFromMap(Map<String, dynamic> raw) {
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
