// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'medical_record_search.dart';

class MedicalRecordSearchMapper extends ClassMapperBase<MedicalRecordSearch> {
  MedicalRecordSearchMapper._();

  static MedicalRecordSearchMapper? _instance;
  static MedicalRecordSearchMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MedicalRecordSearchMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MedicalRecordSearch';

  static String? _$treatment(MedicalRecordSearch v) => v.treatment;
  static const Field<MedicalRecordSearch, String> _f$treatment =
      Field('treatment', _$treatment);
  static String? _$diagnosis(MedicalRecordSearch v) => v.diagnosis;
  static const Field<MedicalRecordSearch, String> _f$diagnosis =
      Field('diagnosis', _$diagnosis);

  @override
  final MappableFields<MedicalRecordSearch> fields = const {
    #treatment: _f$treatment,
    #diagnosis: _f$diagnosis,
  };

  static MedicalRecordSearch _instantiate(DecodingData data) {
    return MedicalRecordSearch(
        treatment: data.dec(_f$treatment), diagnosis: data.dec(_f$diagnosis));
  }

  @override
  final Function instantiate = _instantiate;

  static MedicalRecordSearch fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MedicalRecordSearch>(map);
  }

  static MedicalRecordSearch fromJson(String json) {
    return ensureInitialized().decodeJson<MedicalRecordSearch>(json);
  }
}

mixin MedicalRecordSearchMappable {
  String toJson() {
    return MedicalRecordSearchMapper.ensureInitialized()
        .encodeJson<MedicalRecordSearch>(this as MedicalRecordSearch);
  }

  Map<String, dynamic> toMap() {
    return MedicalRecordSearchMapper.ensureInitialized()
        .encodeMap<MedicalRecordSearch>(this as MedicalRecordSearch);
  }

  MedicalRecordSearchCopyWith<MedicalRecordSearch, MedicalRecordSearch,
      MedicalRecordSearch> get copyWith => _MedicalRecordSearchCopyWithImpl<
          MedicalRecordSearch, MedicalRecordSearch>(
      this as MedicalRecordSearch, $identity, $identity);
  @override
  String toString() {
    return MedicalRecordSearchMapper.ensureInitialized()
        .stringifyValue(this as MedicalRecordSearch);
  }

  @override
  bool operator ==(Object other) {
    return MedicalRecordSearchMapper.ensureInitialized()
        .equalsValue(this as MedicalRecordSearch, other);
  }

  @override
  int get hashCode {
    return MedicalRecordSearchMapper.ensureInitialized()
        .hashValue(this as MedicalRecordSearch);
  }
}

extension MedicalRecordSearchValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MedicalRecordSearch, $Out> {
  MedicalRecordSearchCopyWith<$R, MedicalRecordSearch, $Out>
      get $asMedicalRecordSearch => $base.as(
          (v, t, t2) => _MedicalRecordSearchCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MedicalRecordSearchCopyWith<$R, $In extends MedicalRecordSearch,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? treatment, String? diagnosis});
  MedicalRecordSearchCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _MedicalRecordSearchCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MedicalRecordSearch, $Out>
    implements MedicalRecordSearchCopyWith<$R, MedicalRecordSearch, $Out> {
  _MedicalRecordSearchCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MedicalRecordSearch> $mapper =
      MedicalRecordSearchMapper.ensureInitialized();
  @override
  $R call({Object? treatment = $none, Object? diagnosis = $none}) =>
      $apply(FieldCopyWithData({
        if (treatment != $none) #treatment: treatment,
        if (diagnosis != $none) #diagnosis: diagnosis
      }));
  @override
  MedicalRecordSearch $make(CopyWithData data) => MedicalRecordSearch(
      treatment: data.get(#treatment, or: $value.treatment),
      diagnosis: data.get(#diagnosis, or: $value.diagnosis));

  @override
  MedicalRecordSearchCopyWith<$R2, MedicalRecordSearch, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _MedicalRecordSearchCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
