// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'header_key.dart';

class HeaderKeyMapper extends ClassMapperBase<HeaderKey> {
  HeaderKeyMapper._();

  static HeaderKeyMapper? _instance;
  static HeaderKeyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HeaderKeyMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HeaderKey';

  static String _$key(HeaderKey v) => v.key;
  static const Field<HeaderKey, String> _f$key = Field('key', _$key);
  static bool _$isAscending(HeaderKey v) => v.isAscending;
  static const Field<HeaderKey, bool> _f$isAscending =
      Field('isAscending', _$isAscending, opt: true, def: false);

  @override
  final MappableFields<HeaderKey> fields = const {
    #key: _f$key,
    #isAscending: _f$isAscending,
  };

  static HeaderKey _instantiate(DecodingData data) {
    return HeaderKey(
        key: data.dec(_f$key), isAscending: data.dec(_f$isAscending));
  }

  @override
  final Function instantiate = _instantiate;

  static HeaderKey fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HeaderKey>(map);
  }

  static HeaderKey fromJson(String json) {
    return ensureInitialized().decodeJson<HeaderKey>(json);
  }
}

mixin HeaderKeyMappable {
  String toJson() {
    return HeaderKeyMapper.ensureInitialized()
        .encodeJson<HeaderKey>(this as HeaderKey);
  }

  Map<String, dynamic> toMap() {
    return HeaderKeyMapper.ensureInitialized()
        .encodeMap<HeaderKey>(this as HeaderKey);
  }

  HeaderKeyCopyWith<HeaderKey, HeaderKey, HeaderKey> get copyWith =>
      _HeaderKeyCopyWithImpl<HeaderKey, HeaderKey>(
          this as HeaderKey, $identity, $identity);
  @override
  String toString() {
    return HeaderKeyMapper.ensureInitialized()
        .stringifyValue(this as HeaderKey);
  }

  @override
  bool operator ==(Object other) {
    return HeaderKeyMapper.ensureInitialized()
        .equalsValue(this as HeaderKey, other);
  }

  @override
  int get hashCode {
    return HeaderKeyMapper.ensureInitialized().hashValue(this as HeaderKey);
  }
}

extension HeaderKeyValueCopy<$R, $Out> on ObjectCopyWith<$R, HeaderKey, $Out> {
  HeaderKeyCopyWith<$R, HeaderKey, $Out> get $asHeaderKey =>
      $base.as((v, t, t2) => _HeaderKeyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HeaderKeyCopyWith<$R, $In extends HeaderKey, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? key, bool? isAscending});
  HeaderKeyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HeaderKeyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HeaderKey, $Out>
    implements HeaderKeyCopyWith<$R, HeaderKey, $Out> {
  _HeaderKeyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HeaderKey> $mapper =
      HeaderKeyMapper.ensureInitialized();
  @override
  $R call({String? key, bool? isAscending}) => $apply(FieldCopyWithData({
        if (key != null) #key: key,
        if (isAscending != null) #isAscending: isAscending
      }));
  @override
  HeaderKey $make(CopyWithData data) => HeaderKey(
      key: data.get(#key, or: $value.key),
      isAscending: data.get(#isAscending, or: $value.isAscending));

  @override
  HeaderKeyCopyWith<$R2, HeaderKey, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _HeaderKeyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
