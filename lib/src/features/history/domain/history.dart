import 'package:dart_mappable/dart_mappable.dart';

part 'history.mapper.dart';

@MappableClass()
class History with HistoryMappable {
  final String id;

  final String type;
  final String patient;

  final DateTime? created;
  final DateTime? updated;

  static const fromMap = HistoryMapper.fromMap;
  static const fromJson = HistoryMapper.fromMap;

  History({
    required this.id,
    required this.type,
    required this.patient,
    required this.created,
    required this.updated,
  });

  static History customFromMap(Map<String, dynamic> raw) {
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
