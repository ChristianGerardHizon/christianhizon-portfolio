// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'prescription_search.dart';

class PrescriptionItemSearchMapper
    extends ClassMapperBase<PrescriptionItemSearch> {
  PrescriptionItemSearchMapper._();

  static PrescriptionItemSearchMapper? _instance;
  static PrescriptionItemSearchMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PrescriptionItemSearchMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PrescriptionItemSearch';

  static String? _$treatment(PrescriptionItemSearch v) => v.treatment;
  static const Field<PrescriptionItemSearch, String> _f$treatment =
      Field('treatment', _$treatment);
  static String? _$diagnosis(PrescriptionItemSearch v) => v.diagnosis;
  static const Field<PrescriptionItemSearch, String> _f$diagnosis =
      Field('diagnosis', _$diagnosis);

  @override
  final MappableFields<PrescriptionItemSearch> fields = const {
    #treatment: _f$treatment,
    #diagnosis: _f$diagnosis,
  };

  static PrescriptionItemSearch _instantiate(DecodingData data) {
    return PrescriptionItemSearch(
        treatment: data.dec(_f$treatment), diagnosis: data.dec(_f$diagnosis));
  }

  @override
  final Function instantiate = _instantiate;

  static PrescriptionItemSearch fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PrescriptionItemSearch>(map);
  }

  static PrescriptionItemSearch fromJson(String json) {
    return ensureInitialized().decodeJson<PrescriptionItemSearch>(json);
  }
}

mixin PrescriptionItemSearchMappable {
  String toJson() {
    return PrescriptionItemSearchMapper.ensureInitialized()
        .encodeJson<PrescriptionItemSearch>(this as PrescriptionItemSearch);
  }

  Map<String, dynamic> toMap() {
    return PrescriptionItemSearchMapper.ensureInitialized()
        .encodeMap<PrescriptionItemSearch>(this as PrescriptionItemSearch);
  }

  PrescriptionItemSearchCopyWith<PrescriptionItemSearch, PrescriptionItemSearch,
          PrescriptionItemSearch>
      get copyWith => _PrescriptionItemSearchCopyWithImpl(
          this as PrescriptionItemSearch, $identity, $identity);
  @override
  String toString() {
    return PrescriptionItemSearchMapper.ensureInitialized()
        .stringifyValue(this as PrescriptionItemSearch);
  }

  @override
  bool operator ==(Object other) {
    return PrescriptionItemSearchMapper.ensureInitialized()
        .equalsValue(this as PrescriptionItemSearch, other);
  }

  @override
  int get hashCode {
    return PrescriptionItemSearchMapper.ensureInitialized()
        .hashValue(this as PrescriptionItemSearch);
  }
}

extension PrescriptionItemSearchValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PrescriptionItemSearch, $Out> {
  PrescriptionItemSearchCopyWith<$R, PrescriptionItemSearch, $Out>
      get $asPrescriptionItemSearch =>
          $base.as((v, t, t2) => _PrescriptionItemSearchCopyWithImpl(v, t, t2));
}

abstract class PrescriptionItemSearchCopyWith<
    $R,
    $In extends PrescriptionItemSearch,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? treatment, String? diagnosis});
  PrescriptionItemSearchCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PrescriptionItemSearchCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PrescriptionItemSearch, $Out>
    implements
        PrescriptionItemSearchCopyWith<$R, PrescriptionItemSearch, $Out> {
  _PrescriptionItemSearchCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PrescriptionItemSearch> $mapper =
      PrescriptionItemSearchMapper.ensureInitialized();
  @override
  $R call({Object? treatment = $none, Object? diagnosis = $none}) =>
      $apply(FieldCopyWithData({
        if (treatment != $none) #treatment: treatment,
        if (diagnosis != $none) #diagnosis: diagnosis
      }));
  @override
  PrescriptionItemSearch $make(CopyWithData data) => PrescriptionItemSearch(
      treatment: data.get(#treatment, or: $value.treatment),
      diagnosis: data.get(#diagnosis, or: $value.diagnosis));

  @override
  PrescriptionItemSearchCopyWith<$R2, PrescriptionItemSearch, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PrescriptionItemSearchCopyWithImpl($value, $cast, t);
}
