// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_treatment_record_search.dart';

class PatientTreatmentRecordSearchMapper
    extends ClassMapperBase<PatientTreatmentRecordSearch> {
  PatientTreatmentRecordSearchMapper._();

  static PatientTreatmentRecordSearchMapper? _instance;
  static PatientTreatmentRecordSearchMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = PatientTreatmentRecordSearchMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PatientTreatmentRecordSearch';

  static String? _$id(PatientTreatmentRecordSearch v) => v.id;
  static const Field<PatientTreatmentRecordSearch, String> _f$id =
      Field('id', _$id, opt: true);

  @override
  final MappableFields<PatientTreatmentRecordSearch> fields = const {
    #id: _f$id,
  };

  static PatientTreatmentRecordSearch _instantiate(DecodingData data) {
    return PatientTreatmentRecordSearch(id: data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static PatientTreatmentRecordSearch fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientTreatmentRecordSearch>(map);
  }

  static PatientTreatmentRecordSearch fromJson(String json) {
    return ensureInitialized().decodeJson<PatientTreatmentRecordSearch>(json);
  }
}

mixin PatientTreatmentRecordSearchMappable {
  String toJson() {
    return PatientTreatmentRecordSearchMapper.ensureInitialized()
        .encodeJson<PatientTreatmentRecordSearch>(
            this as PatientTreatmentRecordSearch);
  }

  Map<String, dynamic> toMap() {
    return PatientTreatmentRecordSearchMapper.ensureInitialized()
        .encodeMap<PatientTreatmentRecordSearch>(
            this as PatientTreatmentRecordSearch);
  }

  PatientTreatmentRecordSearchCopyWith<PatientTreatmentRecordSearch,
          PatientTreatmentRecordSearch, PatientTreatmentRecordSearch>
      get copyWith => _PatientTreatmentRecordSearchCopyWithImpl<
              PatientTreatmentRecordSearch, PatientTreatmentRecordSearch>(
          this as PatientTreatmentRecordSearch, $identity, $identity);
  @override
  String toString() {
    return PatientTreatmentRecordSearchMapper.ensureInitialized()
        .stringifyValue(this as PatientTreatmentRecordSearch);
  }

  @override
  bool operator ==(Object other) {
    return PatientTreatmentRecordSearchMapper.ensureInitialized()
        .equalsValue(this as PatientTreatmentRecordSearch, other);
  }

  @override
  int get hashCode {
    return PatientTreatmentRecordSearchMapper.ensureInitialized()
        .hashValue(this as PatientTreatmentRecordSearch);
  }
}

extension PatientTreatmentRecordSearchValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientTreatmentRecordSearch, $Out> {
  PatientTreatmentRecordSearchCopyWith<$R, PatientTreatmentRecordSearch, $Out>
      get $asPatientTreatmentRecordSearch => $base.as((v, t, t2) =>
          _PatientTreatmentRecordSearchCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientTreatmentRecordSearchCopyWith<
    $R,
    $In extends PatientTreatmentRecordSearch,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id});
  PatientTreatmentRecordSearchCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PatientTreatmentRecordSearchCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientTreatmentRecordSearch, $Out>
    implements
        PatientTreatmentRecordSearchCopyWith<$R, PatientTreatmentRecordSearch,
            $Out> {
  _PatientTreatmentRecordSearchCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientTreatmentRecordSearch> $mapper =
      PatientTreatmentRecordSearchMapper.ensureInitialized();
  @override
  $R call({Object? id = $none}) =>
      $apply(FieldCopyWithData({if (id != $none) #id: id}));
  @override
  PatientTreatmentRecordSearch $make(CopyWithData data) =>
      PatientTreatmentRecordSearch(id: data.get(#id, or: $value.id));

  @override
  PatientTreatmentRecordSearchCopyWith<$R2, PatientTreatmentRecordSearch, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PatientTreatmentRecordSearchCopyWithImpl<$R2, $Out2>(
              $value, $cast, t);
}
