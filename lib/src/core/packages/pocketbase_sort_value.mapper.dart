// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pocketbase_sort_value.dart';

class StringMapper extends ClassMapperBase<String> {
  StringMapper._();

  static StringMapper? _instance;
  static StringMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'String';

  static String _$sortKey(String v) => v.sortKey;
  static const Field<String, String> _f$sortKey = Field('sortKey', _$sortKey);
  static bool _$isAsc(String v) => v.isAsc;
  static const Field<String, bool> _f$isAsc = Field('isAsc', _$isAsc);

  @override
  final MappableFields<String> fields = const {
    #sortKey: _f$sortKey,
    #isAsc: _f$isAsc,
  };

  static String _instantiate(DecodingData data) {
    return String(sortKey: data.dec(_f$sortKey), isAsc: data.dec(_f$isAsc));
  }

  @override
  final Function instantiate = _instantiate;

  static String fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<String>(map);
  }

  static String fromJson(String json) {
    return ensureInitialized().decodeJson<String>(json);
  }
}

mixin StringMappable {
  String toJson() {
    return StringMapper.ensureInitialized().encodeJson<String>(this as String);
  }

  Map<String, dynamic> toMap() {
    return StringMapper.ensureInitialized().encodeMap<String>(this as String);
  }

  StringCopyWith<String, String, String> get copyWith =>
      _StringCopyWithImpl<String, String>(this as String, $identity, $identity);
  @override
  String toString() {
    return StringMapper.ensureInitialized().stringifyValue(this as String);
  }

  @override
  bool operator ==(Object other) {
    return StringMapper.ensureInitialized().equalsValue(this as String, other);
  }

  @override
  int get hashCode {
    return StringMapper.ensureInitialized().hashValue(this as String);
  }
}

extension StringValueCopy<$R, $Out> on ObjectCopyWith<$R, String, $Out> {
  StringCopyWith<$R, String, $Out> get $asString =>
      $base.as((v, t, t2) => _StringCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StringCopyWith<$R, $In extends String, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? sortKey, bool? isAsc});
  StringCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StringCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, String, $Out>
    implements StringCopyWith<$R, String, $Out> {
  _StringCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<String> $mapper = StringMapper.ensureInitialized();
  @override
  $R call({String? sortKey, bool? isAsc}) => $apply(FieldCopyWithData({
        if (sortKey != null) #sortKey: sortKey,
        if (isAsc != null) #isAsc: isAsc
      }));
  @override
  String $make(CopyWithData data) => String(
      sortKey: data.get(#sortKey, or: $value.sortKey),
      isAsc: data.get(#isAsc, or: $value.isAsc));

  @override
  StringCopyWith<$R2, String, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _StringCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
