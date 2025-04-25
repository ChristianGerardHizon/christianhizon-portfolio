import 'package:dart_mappable/dart_mappable.dart';

part 'header_key.mapper.dart';

@MappableClass()
class HeaderKey with HeaderKeyMappable {
  final String key;
  final bool isAscending;

  const HeaderKey({
    required this.key,
    this.isAscending = false,
  });

  /// reverse
  /// false => true
  /// true => false
  HeaderKey reverse() => HeaderKey(key: key, isAscending: !isAscending);
}
