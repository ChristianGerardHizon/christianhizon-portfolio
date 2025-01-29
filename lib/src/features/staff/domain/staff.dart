import 'package:dart_mappable/dart_mappable.dart';

part 'staff.mapper.dart';

@MappableClass()
class Staff with StaffMappable {
  final String id;
  final String name;
  final String email;
  final String? avatar;

  final DateTime? created;
  final DateTime? updated;

  Staff({
    required this.id,
    this.name = '',
    this.email = '',
    this.created,
    this.updated,
    this.avatar,
  });

  static const fromMap = StaffMapper.fromMap;
  static const fromJson = StaffMapper.fromMap;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': created,
    };
  }

  static Staff customFromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
