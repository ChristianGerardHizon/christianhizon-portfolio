// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'treatment_record_search.dart';

class TreatmentRecordSearchMapper
    extends ClassMapperBase<TreatmentRecordSearch> {
  TreatmentRecordSearchMapper._();

  static TreatmentRecordSearchMapper? _instance;
  static TreatmentRecordSearchMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TreatmentRecordSearchMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TreatmentRecordSearch';

  static String? _$id(TreatmentRecordSearch v) => v.id;
  static const Field<TreatmentRecordSearch, String> _f$id = Field('id', _$id);

  @override
  final MappableFields<TreatmentRecordSearch> fields = const {
    #id: _f$id,
  };

  static TreatmentRecordSearch _instantiate(DecodingData data) {
    return TreatmentRecordSearch(id: data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static TreatmentRecordSearch fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TreatmentRecordSearch>(map);
  }

  static TreatmentRecordSearch fromJson(String json) {
    return ensureInitialized().decodeJson<TreatmentRecordSearch>(json);
  }
}

mixin TreatmentRecordSearchMappable {
  String toJson() {
    return TreatmentRecordSearchMapper.ensureInitialized()
        .encodeJson<TreatmentRecordSearch>(this as TreatmentRecordSearch);
  }

  Map<String, dynamic> toMap() {
    return TreatmentRecordSearchMapper.ensureInitialized()
        .encodeMap<TreatmentRecordSearch>(this as TreatmentRecordSearch);
  }

  TreatmentRecordSearchCopyWith<TreatmentRecordSearch, TreatmentRecordSearch,
          TreatmentRecordSearch>
      get copyWith => _TreatmentRecordSearchCopyWithImpl(
          this as TreatmentRecordSearch, $identity, $identity);
  @override
  String toString() {
    return TreatmentRecordSearchMapper.ensureInitialized()
        .stringifyValue(this as TreatmentRecordSearch);
  }

  @override
  bool operator ==(Object other) {
    return TreatmentRecordSearchMapper.ensureInitialized()
        .equalsValue(this as TreatmentRecordSearch, other);
  }

  @override
  int get hashCode {
    return TreatmentRecordSearchMapper.ensureInitialized()
        .hashValue(this as TreatmentRecordSearch);
  }
}

extension TreatmentRecordSearchValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TreatmentRecordSearch, $Out> {
  TreatmentRecordSearchCopyWith<$R, TreatmentRecordSearch, $Out>
      get $asTreatmentRecordSearch =>
          $base.as((v, t, t2) => _TreatmentRecordSearchCopyWithImpl(v, t, t2));
}

abstract class TreatmentRecordSearchCopyWith<
    $R,
    $In extends TreatmentRecordSearch,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id});
  TreatmentRecordSearchCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TreatmentRecordSearchCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TreatmentRecordSearch, $Out>
    implements TreatmentRecordSearchCopyWith<$R, TreatmentRecordSearch, $Out> {
  _TreatmentRecordSearchCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TreatmentRecordSearch> $mapper =
      TreatmentRecordSearchMapper.ensureInitialized();
  @override
  $R call({Object? id = $none}) =>
      $apply(FieldCopyWithData({if (id != $none) #id: id}));
  @override
  TreatmentRecordSearch $make(CopyWithData data) =>
      TreatmentRecordSearch(id: data.get(#id, or: $value.id));

  @override
  TreatmentRecordSearchCopyWith<$R2, TreatmentRecordSearch, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _TreatmentRecordSearchCopyWithImpl($value, $cast, t);
}
