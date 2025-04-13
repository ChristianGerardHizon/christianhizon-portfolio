// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_record_search.dart';

class PatientRecordSearchMapper extends ClassMapperBase<PatientRecordSearch> {
  PatientRecordSearchMapper._();

  static PatientRecordSearchMapper? _instance;
  static PatientRecordSearchMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientRecordSearchMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PatientRecordSearch';

  static String? _$treatment(PatientRecordSearch v) => v.treatment;
  static const Field<PatientRecordSearch, String> _f$treatment =
      Field('treatment', _$treatment);
  static String? _$diagnosis(PatientRecordSearch v) => v.diagnosis;
  static const Field<PatientRecordSearch, String> _f$diagnosis =
      Field('diagnosis', _$diagnosis);

  @override
  final MappableFields<PatientRecordSearch> fields = const {
    #treatment: _f$treatment,
    #diagnosis: _f$diagnosis,
  };

  static PatientRecordSearch _instantiate(DecodingData data) {
    return PatientRecordSearch(
        treatment: data.dec(_f$treatment), diagnosis: data.dec(_f$diagnosis));
  }

  @override
  final Function instantiate = _instantiate;

  static PatientRecordSearch fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientRecordSearch>(map);
  }

  static PatientRecordSearch fromJson(String json) {
    return ensureInitialized().decodeJson<PatientRecordSearch>(json);
  }
}

mixin PatientRecordSearchMappable {
  String toJson() {
    return PatientRecordSearchMapper.ensureInitialized()
        .encodeJson<PatientRecordSearch>(this as PatientRecordSearch);
  }

  Map<String, dynamic> toMap() {
    return PatientRecordSearchMapper.ensureInitialized()
        .encodeMap<PatientRecordSearch>(this as PatientRecordSearch);
  }

  PatientRecordSearchCopyWith<PatientRecordSearch, PatientRecordSearch,
      PatientRecordSearch> get copyWith => _PatientRecordSearchCopyWithImpl<
          PatientRecordSearch, PatientRecordSearch>(
      this as PatientRecordSearch, $identity, $identity);
  @override
  String toString() {
    return PatientRecordSearchMapper.ensureInitialized()
        .stringifyValue(this as PatientRecordSearch);
  }

  @override
  bool operator ==(Object other) {
    return PatientRecordSearchMapper.ensureInitialized()
        .equalsValue(this as PatientRecordSearch, other);
  }

  @override
  int get hashCode {
    return PatientRecordSearchMapper.ensureInitialized()
        .hashValue(this as PatientRecordSearch);
  }
}

extension PatientRecordSearchValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientRecordSearch, $Out> {
  PatientRecordSearchCopyWith<$R, PatientRecordSearch, $Out>
      get $asPatientRecordSearch => $base.as(
          (v, t, t2) => _PatientRecordSearchCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientRecordSearchCopyWith<$R, $In extends PatientRecordSearch,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? treatment, String? diagnosis});
  PatientRecordSearchCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PatientRecordSearchCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientRecordSearch, $Out>
    implements PatientRecordSearchCopyWith<$R, PatientRecordSearch, $Out> {
  _PatientRecordSearchCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientRecordSearch> $mapper =
      PatientRecordSearchMapper.ensureInitialized();
  @override
  $R call({Object? treatment = $none, Object? diagnosis = $none}) =>
      $apply(FieldCopyWithData({
        if (treatment != $none) #treatment: treatment,
        if (diagnosis != $none) #diagnosis: diagnosis
      }));
  @override
  PatientRecordSearch $make(CopyWithData data) => PatientRecordSearch(
      treatment: data.get(#treatment, or: $value.treatment),
      diagnosis: data.get(#diagnosis, or: $value.diagnosis));

  @override
  PatientRecordSearchCopyWith<$R2, PatientRecordSearch, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PatientRecordSearchCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
