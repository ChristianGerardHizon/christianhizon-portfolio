import 'package:dart_mappable/dart_mappable.dart';

class DateTimeHook extends MappingHook {
  const DateTimeHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is String) {
      return DateTime.tryParse(value);
    }
    return value;
  }
}
