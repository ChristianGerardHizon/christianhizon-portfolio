import 'package:dart_mappable/dart_mappable.dart';

class PbNumHook extends MappingHook {
  const PbNumHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is String) {
      if (value.isEmpty) return null;
      return num.tryParse(value);
    }
    if (value is int) return value;
    if (value is double) return value;
    return value;
  }
}
