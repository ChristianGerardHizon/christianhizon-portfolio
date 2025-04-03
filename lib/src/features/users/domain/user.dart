import 'package:dart_mappable/dart_mappable.dart';

part 'user.mapper.dart';

@MappableClass()
class User with UserMappable {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final bool verified;

  final DateTime? created;
  final DateTime? updated;

  final String collectionId;
  final String collectionName;
  final String domain;

  User({
    required this.domain,
    required this.collectionId,
    required this.collectionName,
    required this.id,
    this.name = '',
    this.email = '',
    this.created,
    this.updated,
    this.avatar,
    this.verified = false,
  });

  static const fromMap = UserMapper.fromMap;
  static const fromJson = UserMapper.fromMap;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': created,
    };
  }

  static User customFromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
