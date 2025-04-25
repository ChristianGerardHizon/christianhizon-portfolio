// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pocketbase_sort_value.dart';

class PocketbaseSortValueMapper extends ClassMapperBase<PocketbaseSortValue> {
  PocketbaseSortValueMapper._();

  static PocketbaseSortValueMapper? _instance;
  static PocketbaseSortValueMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PocketbaseSortValueMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PocketbaseSortValue';

  static String _$sortKey(PocketbaseSortValue v) => v.sortKey;
  static const Field<PocketbaseSortValue, String> _f$sortKey =
      Field('sortKey', _$sortKey);
  static bool _$isAsc(PocketbaseSortValue v) => v.isAsc;
  static const Field<PocketbaseSortValue, bool> _f$isAsc =
      Field('isAsc', _$isAsc);

  @override
  final MappableFields<PocketbaseSortValue> fields = const {
    #sortKey: _f$sortKey,
    #isAsc: _f$isAsc,
  };

  static PocketbaseSortValue _instantiate(DecodingData data) {
    return PocketbaseSortValue(
        sortKey: data.dec(_f$sortKey), isAsc: data.dec(_f$isAsc));
  }

  @override
  final Function instantiate = _instantiate;

  static PocketbaseSortValue fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PocketbaseSortValue>(map);
  }

  static PocketbaseSortValue fromJson(String json) {
    return ensureInitialized().decodeJson<PocketbaseSortValue>(json);
  }
}

mixin PocketbaseSortValueMappable {
  String toJson() {
    return PocketbaseSortValueMapper.ensureInitialized()
        .encodeJson<PocketbaseSortValue>(this as PocketbaseSortValue);
  }

  Map<String, dynamic> toMap() {
    return PocketbaseSortValueMapper.ensureInitialized()
        .encodeMap<PocketbaseSortValue>(this as PocketbaseSortValue);
  }

  PocketbaseSortValueCopyWith<PocketbaseSortValue, PocketbaseSortValue,
      PocketbaseSortValue> get copyWith => _PocketbaseSortValueCopyWithImpl<
          PocketbaseSortValue, PocketbaseSortValue>(
      this as PocketbaseSortValue, $identity, $identity);
  @override
  String toString() {
    return PocketbaseSortValueMapper.ensureInitialized()
        .stringifyValue(this as PocketbaseSortValue);
  }

  @override
  bool operator ==(Object other) {
    return PocketbaseSortValueMapper.ensureInitialized()
        .equalsValue(this as PocketbaseSortValue, other);
  }

  @override
  int get hashCode {
    return PocketbaseSortValueMapper.ensureInitialized()
        .hashValue(this as PocketbaseSortValue);
  }
}

extension PocketbaseSortValueValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PocketbaseSortValue, $Out> {
  PocketbaseSortValueCopyWith<$R, PocketbaseSortValue, $Out>
      get $asPocketbaseSortValue => $base.as(
          (v, t, t2) => _PocketbaseSortValueCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PocketbaseSortValueCopyWith<$R, $In extends PocketbaseSortValue,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? sortKey, bool? isAsc});
  PocketbaseSortValueCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PocketbaseSortValueCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PocketbaseSortValue, $Out>
    implements PocketbaseSortValueCopyWith<$R, PocketbaseSortValue, $Out> {
  _PocketbaseSortValueCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PocketbaseSortValue> $mapper =
      PocketbaseSortValueMapper.ensureInitialized();
  @override
  $R call({String? sortKey, bool? isAsc}) => $apply(FieldCopyWithData({
        if (sortKey != null) #sortKey: sortKey,
        if (isAsc != null) #isAsc: isAsc
      }));
  @override
  PocketbaseSortValue $make(CopyWithData data) => PocketbaseSortValue(
      sortKey: data.get(#sortKey, or: $value.sortKey),
      isAsc: data.get(#isAsc, or: $value.isAsc));

  @override
  PocketbaseSortValueCopyWith<$R2, PocketbaseSortValue, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PocketbaseSortValueCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
