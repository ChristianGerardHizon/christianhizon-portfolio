// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_record_form_controller.dart';

class PatientRecordFormStateMapper
    extends ClassMapperBase<PatientRecordFormState> {
  PatientRecordFormStateMapper._();

  static PatientRecordFormStateMapper? _instance;
  static PatientRecordFormStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientRecordFormStateMapper._());
      PatientRecordMapper.ensureInitialized();
      PatientMapper.ensureInitialized();
      BranchMapper.ensureInitialized();
      AuthDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PatientRecordFormState';

  static PatientRecord? _$patientRecord(PatientRecordFormState v) =>
      v.patientRecord;
  static const Field<PatientRecordFormState, PatientRecord> _f$patientRecord =
      Field('patientRecord', _$patientRecord);
  static Patient _$patient(PatientRecordFormState v) => v.patient;
  static const Field<PatientRecordFormState, Patient> _f$patient =
      Field('patient', _$patient);
  static List<Branch> _$branches(PatientRecordFormState v) => v.branches;
  static const Field<PatientRecordFormState, List<Branch>> _f$branches =
      Field('branches', _$branches, opt: true, def: const []);
  static AuthData _$auth(PatientRecordFormState v) => v.auth;
  static const Field<PatientRecordFormState, AuthData> _f$auth =
      Field('auth', _$auth);

  @override
  final MappableFields<PatientRecordFormState> fields = const {
    #patientRecord: _f$patientRecord,
    #patient: _f$patient,
    #branches: _f$branches,
    #auth: _f$auth,
  };

  static PatientRecordFormState _instantiate(DecodingData data) {
    return PatientRecordFormState(
        patientRecord: data.dec(_f$patientRecord),
        patient: data.dec(_f$patient),
        branches: data.dec(_f$branches),
        auth: data.dec(_f$auth));
  }

  @override
  final Function instantiate = _instantiate;

  static PatientRecordFormState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientRecordFormState>(map);
  }

  static PatientRecordFormState fromJson(String json) {
    return ensureInitialized().decodeJson<PatientRecordFormState>(json);
  }
}

mixin PatientRecordFormStateMappable {
  String toJson() {
    return PatientRecordFormStateMapper.ensureInitialized()
        .encodeJson<PatientRecordFormState>(this as PatientRecordFormState);
  }

  Map<String, dynamic> toMap() {
    return PatientRecordFormStateMapper.ensureInitialized()
        .encodeMap<PatientRecordFormState>(this as PatientRecordFormState);
  }

  PatientRecordFormStateCopyWith<PatientRecordFormState, PatientRecordFormState,
          PatientRecordFormState>
      get copyWith => _PatientRecordFormStateCopyWithImpl<
              PatientRecordFormState, PatientRecordFormState>(
          this as PatientRecordFormState, $identity, $identity);
  @override
  String toString() {
    return PatientRecordFormStateMapper.ensureInitialized()
        .stringifyValue(this as PatientRecordFormState);
  }

  @override
  bool operator ==(Object other) {
    return PatientRecordFormStateMapper.ensureInitialized()
        .equalsValue(this as PatientRecordFormState, other);
  }

  @override
  int get hashCode {
    return PatientRecordFormStateMapper.ensureInitialized()
        .hashValue(this as PatientRecordFormState);
  }
}

extension PatientRecordFormStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientRecordFormState, $Out> {
  PatientRecordFormStateCopyWith<$R, PatientRecordFormState, $Out>
      get $asPatientRecordFormState => $base.as((v, t, t2) =>
          _PatientRecordFormStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientRecordFormStateCopyWith<
    $R,
    $In extends PatientRecordFormState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  PatientRecordCopyWith<$R, PatientRecord, PatientRecord>? get patientRecord;
  PatientCopyWith<$R, Patient, Patient> get patient;
  ListCopyWith<$R, Branch, BranchCopyWith<$R, Branch, Branch>> get branches;
  $R call(
      {PatientRecord? patientRecord,
      Patient? patient,
      List<Branch>? branches,
      AuthData? auth});
  PatientRecordFormStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PatientRecordFormStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientRecordFormState, $Out>
    implements
        PatientRecordFormStateCopyWith<$R, PatientRecordFormState, $Out> {
  _PatientRecordFormStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientRecordFormState> $mapper =
      PatientRecordFormStateMapper.ensureInitialized();
  @override
  PatientRecordCopyWith<$R, PatientRecord, PatientRecord>? get patientRecord =>
      $value.patientRecord?.copyWith.$chain((v) => call(patientRecord: v));
  @override
  PatientCopyWith<$R, Patient, Patient> get patient =>
      $value.patient.copyWith.$chain((v) => call(patient: v));
  @override
  ListCopyWith<$R, Branch, BranchCopyWith<$R, Branch, Branch>> get branches =>
      ListCopyWith($value.branches, (v, t) => v.copyWith.$chain(t),
          (v) => call(branches: v));
  @override
  $R call(
          {Object? patientRecord = $none,
          Patient? patient,
          List<Branch>? branches,
          AuthData? auth}) =>
      $apply(FieldCopyWithData({
        if (patientRecord != $none) #patientRecord: patientRecord,
        if (patient != null) #patient: patient,
        if (branches != null) #branches: branches,
        if (auth != null) #auth: auth
      }));
  @override
  PatientRecordFormState $make(CopyWithData data) => PatientRecordFormState(
      patientRecord: data.get(#patientRecord, or: $value.patientRecord),
      patient: data.get(#patient, or: $value.patient),
      branches: data.get(#branches, or: $value.branches),
      auth: data.get(#auth, or: $value.auth));

  @override
  PatientRecordFormStateCopyWith<$R2, PatientRecordFormState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PatientRecordFormStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
