import 'package:dart_mappable/dart_mappable.dart';

class PbEmptyHook extends MappingHook {
  const PbEmptyHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is String) {
      if (value.isEmpty) return null;
      return value;
    }
    return value;
  }
}
