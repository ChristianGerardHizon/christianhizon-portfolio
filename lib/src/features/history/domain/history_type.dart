import 'package:dart_mappable/dart_mappable.dart';

part 'history_type.mapper.dart';

@MappableClass()
class HistoryType with HistoryTypeMappable {
  final String id;

  final String name;
  final String? icon;

  final DateTime? created;
  final DateTime? updated;

  static const fromMap = HistoryTypeMapper.fromMap;
  static const fromJson = HistoryTypeMapper.fromMap;

  HistoryType({
    required this.id,
    required this.name,
    required this.icon,
    required this.created,
    required this.updated,
  });

  static HistoryType customFromMap(Map<String, dynamic> raw) {
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
