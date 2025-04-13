// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_prescription_search.dart';

class PatientPrescriptionItemSearchMapper
    extends ClassMapperBase<PatientPrescriptionItemSearch> {
  PatientPrescriptionItemSearchMapper._();

  static PatientPrescriptionItemSearchMapper? _instance;
  static PatientPrescriptionItemSearchMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = PatientPrescriptionItemSearchMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PatientPrescriptionItemSearch';

  static String? _$treatment(PatientPrescriptionItemSearch v) => v.treatment;
  static const Field<PatientPrescriptionItemSearch, String> _f$treatment =
      Field('treatment', _$treatment);
  static String? _$diagnosis(PatientPrescriptionItemSearch v) => v.diagnosis;
  static const Field<PatientPrescriptionItemSearch, String> _f$diagnosis =
      Field('diagnosis', _$diagnosis);

  @override
  final MappableFields<PatientPrescriptionItemSearch> fields = const {
    #treatment: _f$treatment,
    #diagnosis: _f$diagnosis,
  };

  static PatientPrescriptionItemSearch _instantiate(DecodingData data) {
    return PatientPrescriptionItemSearch(
        treatment: data.dec(_f$treatment), diagnosis: data.dec(_f$diagnosis));
  }

  @override
  final Function instantiate = _instantiate;

  static PatientPrescriptionItemSearch fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientPrescriptionItemSearch>(map);
  }

  static PatientPrescriptionItemSearch fromJson(String json) {
    return ensureInitialized().decodeJson<PatientPrescriptionItemSearch>(json);
  }
}

mixin PatientPrescriptionItemSearchMappable {
  String toJson() {
    return PatientPrescriptionItemSearchMapper.ensureInitialized()
        .encodeJson<PatientPrescriptionItemSearch>(
            this as PatientPrescriptionItemSearch);
  }

  Map<String, dynamic> toMap() {
    return PatientPrescriptionItemSearchMapper.ensureInitialized()
        .encodeMap<PatientPrescriptionItemSearch>(
            this as PatientPrescriptionItemSearch);
  }

  PatientPrescriptionItemSearchCopyWith<PatientPrescriptionItemSearch,
          PatientPrescriptionItemSearch, PatientPrescriptionItemSearch>
      get copyWith => _PatientPrescriptionItemSearchCopyWithImpl<
              PatientPrescriptionItemSearch, PatientPrescriptionItemSearch>(
          this as PatientPrescriptionItemSearch, $identity, $identity);
  @override
  String toString() {
    return PatientPrescriptionItemSearchMapper.ensureInitialized()
        .stringifyValue(this as PatientPrescriptionItemSearch);
  }

  @override
  bool operator ==(Object other) {
    return PatientPrescriptionItemSearchMapper.ensureInitialized()
        .equalsValue(this as PatientPrescriptionItemSearch, other);
  }

  @override
  int get hashCode {
    return PatientPrescriptionItemSearchMapper.ensureInitialized()
        .hashValue(this as PatientPrescriptionItemSearch);
  }
}

extension PatientPrescriptionItemSearchValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientPrescriptionItemSearch, $Out> {
  PatientPrescriptionItemSearchCopyWith<$R, PatientPrescriptionItemSearch, $Out>
      get $asPatientPrescriptionItemSearch => $base.as((v, t, t2) =>
          _PatientPrescriptionItemSearchCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientPrescriptionItemSearchCopyWith<
    $R,
    $In extends PatientPrescriptionItemSearch,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? treatment, String? diagnosis});
  PatientPrescriptionItemSearchCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PatientPrescriptionItemSearchCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientPrescriptionItemSearch, $Out>
    implements
        PatientPrescriptionItemSearchCopyWith<$R, PatientPrescriptionItemSearch,
            $Out> {
  _PatientPrescriptionItemSearchCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientPrescriptionItemSearch> $mapper =
      PatientPrescriptionItemSearchMapper.ensureInitialized();
  @override
  $R call({Object? treatment = $none, Object? diagnosis = $none}) =>
      $apply(FieldCopyWithData({
        if (treatment != $none) #treatment: treatment,
        if (diagnosis != $none) #diagnosis: diagnosis
      }));
  @override
  PatientPrescriptionItemSearch $make(CopyWithData data) =>
      PatientPrescriptionItemSearch(
          treatment: data.get(#treatment, or: $value.treatment),
          diagnosis: data.get(#diagnosis, or: $value.diagnosis));

  @override
  PatientPrescriptionItemSearchCopyWith<$R2, PatientPrescriptionItemSearch,
      $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PatientPrescriptionItemSearchCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
